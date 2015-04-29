require("game/type/SkillDistanceType")
require("game/config/SkillInfoConfig")
require("game/type/GroupType")
require("game/event/PlayerEvent")
require("game/manager/ManualSkillManager")

SkillComponent = class("SkillComponent")

function SkillComponent.create(player)
    local component = SkillComponent:new()
    component._player = player
    component:init()
    return component
end

SkillComponent._player = nil
SkillComponent._targetPlayer = nil
SkillComponent._skillInfoMap = nil
SkillComponent._curSkillInfo = nil
SkillComponent._useSkillTime = nil

SkillComponent._callback = nil
SkillComponent._listenerSkillFinish = nil
SkillComponent._listenerAnimationFinish = nil

function SkillComponent:init()
    self._skillInfoMap = SkillInfoConfig:getInstance():getPlayerSkillInfoMap(self._player:getPlayerInfo():getTypeId())
    self._schedule = cc.Director:getInstance():getScheduler()
end

function SkillComponent:useSkill(skillKey, attackContext, callback)
    --如果已经在放技能了，就触发一下上个技能的结束
    self._useSkillTime = os.clock()
    self:applyCallback()
    self._player:cancelMove()
    
    self._callback = callback
    self._curSkillInfo = self._skillInfoMap:getSkillInfoByKey(skillKey)
    
    self._targetPlayer = attackContext:getEnemyPlayerGroup():getTargetPlayer(self._curSkillInfo:getTargetType(),self._player:getPlayerInfo():getGridY())
    
    if self._curSkillInfo:getFocusTime() > 0 then
        SceneManager.getCurScene():getManualSkillManager():setFocusEffect(self._player, self._curSkillInfo:getFocusTime())
        self:showFocusPlayer(attackContext)
    end
    
    if self._curSkillInfo:getDistanceType() == SkillDistanceType.MELEE then
        self:moveToTarget()
    elseif self._curSkillInfo:getDistanceType() == SkillDistanceType.RANGED then
        self:doSkillAction()
    elseif self._curSkillInfo:getDistanceType() == SkillDistanceType.MELEE_COL_FRONT then
        self:moveToColFront()
    elseif self._curSkillInfo:getDistanceType() == SkillDistanceType.RANGED_CUSTOM then
        self:moveToCustomPosition()
    end
    
    attackContext:setSkillKey(skillKey)
end

---- 移动到目标单位前方，具体位置根据双方的体积来计算
function SkillComponent:moveToTarget()
    local moveX
    if self._player:getGroup() == GroupType.LEFT then
        moveX = self._targetPlayer:getOriginalPositionX() - (self._targetPlayer:getPlayerInfo():getBodyWidth() +  self._player:getPlayerInfo():getBodyWidth()) / 2 + self._curSkillInfo:getOffsetX()
    elseif self._player:getGroup() == GroupType.RIGHT then
        moveX = self._targetPlayer:getOriginalPositionX() + (self._targetPlayer:getPlayerInfo():getBodyWidth() +  self._player:getPlayerInfo():getBodyWidth()) / 2 - self._curSkillInfo:getOffsetX()
    end
    
    --y坐标减1可以让攻击者在最前层显示
    self._player:moveTo(moveX, self._targetPlayer:getOriginalPositionY() - 1, function()
        self:doSkillAction()
    end)
end

function SkillComponent:moveToColFront()
    local moveX
    if self._player:getGroup() == GroupType.LEFT then
        moveX = BattleConfig.rightFormationPositionConfig[1][1].x - (self._player:getPlayerInfo():getBodyWidth()) / 2 + self._curSkillInfo:getOffsetX()
    elseif self._player:getGroup() == GroupType.RIGHT then
        moveX = BattleConfig.leftFormationPositionConfig[1][1].x + (self._player:getPlayerInfo():getBodyWidth()) / 2 - self._curSkillInfo:getOffsetX()
    end

    --y坐标减1可以让攻击者在最前层显示
    self._player:moveTo(moveX, self._targetPlayer:getOriginalPositionY() - 1, function()
        self:doSkillAction()
    end)
end

function SkillComponent:moveToCustomPosition()
    local moveX, moveY
    if self._player:getGroup() == GroupType.LEFT then
        moveX = self._curSkillInfo:getOffsetX()
        moveY = self._curSkillInfo:getOffsetY()
    elseif self._player:getGroup() == GroupType.RIGHT then
        moveX = GameConfig.DESIGN_WIDTH - self._curSkillInfo:getOffsetX()
        moveY = GameConfig.DESIGN_HEIGHT - self._curSkillInfo:getOffsetY()
    end
    
    self._player:setPosition(moveX,moveY)
    self:doSkillAction()
end

function SkillComponent:doSkillAction()
    self._listenerSkillFinish = cc.EventListenerCustom:create(PlayerEvent.SKILL_FINISH, function(evt)
        self:onSkillFinish(evt)
    end)
    
    self._listenerAnimationFinish = cc.EventListenerCustom:create(PlayerEvent.ACTION_ANIMATION_COMPLETE, function(evt)
        self:onAnimationFinish(evt)
    end)
    
    self._player:getEventDispatcher():addEventListenerWithFixedPriority(self._listenerSkillFinish, 1)
    self._player:getEventDispatcher():addEventListenerWithFixedPriority(self._listenerAnimationFinish, 1)
    self._player:doAction(self._curSkillInfo:getActionType())
end

---- 技能结束，开始下个回合
function SkillComponent:onSkillFinish(evt)
    if evt.player ~= self._player then
        return
    end
    
    self._player:getEventDispatcher():removeEventListener(self._listenerSkillFinish)
    self._listenerSkillFinish = nil
    self:applyCallback()
    self:checkAndGoBack()
end

function SkillComponent:applyCallback()
    if self._callback ~= nil then
        local callback = self._callback
        self._callback = nil
        callback()
    end
end

---- 动画结束，返回原来的位置
function SkillComponent:onAnimationFinish(evt)
    if evt.player ~= self._player then
        return
    end
    self._player:getEventDispatcher():removeEventListener(self._listenerAnimationFinish)
    self._listenerAnimationFinish = nil
    
    self:checkAndGoBack()
end

function SkillComponent:checkAndGoBack()
    if self._listenerAnimationFinish ~= nil then
        return
    end
    if self._listenerSkillFinish == nil then
        if self._player:isAlreadyAtOriginalPosition() then
            self._player:doAction(ActionType.IDLE)
        else
            self._player:moveBack()
        end
    end
end

--
function SkillComponent:showFocusPlayer(attackContext)
    local playerActionInfoMap = ActionInfoConfig.getActionInfoMap(self._player:getPlayerInfo():getTypeId())
    local actionInfo = playerActionInfoMap:getActionInfoByType(self._curSkillInfo:getActionType())
    local listScript = actionInfo:getListScripts()

    local result = {}
    for i = 1, #listScript do
        local script = listScript[i]
        if script:getType() == ActionScriptType.HIT_CHECK then
            local players = HitCheckManager:getInstance():getBehitTargetList(script:getHitCheckType(),self._targetPlayer,attackContext:getEnemyPlayerGroup())
            for j, player in pairs(players) do
                SceneManager.getCurScene():getContainerLayer():setFocus(player)
            end
        end
    end
end

function SkillComponent:doBeHitAction()
    self:applyCallback()
end

function SkillComponent:getTargetPlayer()
    return self._targetPlayer
end

function SkillComponent:getUseSkillTime()
    return self._useSkillTime
end

function SkillComponent:getCurSkillInfo()
    return self._curSkillInfo
end

function SkillComponent:dispose()
    
end