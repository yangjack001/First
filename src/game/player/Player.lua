require("game/player/components/ViewComponent")
require("game/player/components/AIOrderComponent")
require("game/player/components/ActionComponent")
require("game/player/components/SkillComponent")
require("game/player/components/MoveComponent")
require("game/player/components/HitComponent")
require("game/player/components/BuffComponent")

require("game/config/ActionInfoConfig")
require("game/type/ActionType")
require("game/type/GroupType")
require("game/type/DirectionType")
require("game/type/SkillKey")

Player = class("Player",function()
    return cc.Sprite:create()
end)

Player._playerInfo = nil
Player._group = nil
Player._viewComponent = nil
Player._moveComponent = nil
Player._aiComponent = nil
Player._skillComponent = nil
Player._actionComponent = nil
Player._hitComponent = nil
Player._buffComponent = nil

Player._isDead = nil
Player._curAttackContext = nil
Player._isPause = nil
Player._isFocus = nil
Player._isStopUseSkill = nil

function Player.create(playerInfo, group)
    local player = Player:new()
    player._group = group
    player:init(playerInfo)
    return player
end

function Player:init(playerInfo)
    self._playerInfo = playerInfo
    self._isPause = false
    self._isFocus = false
    self._isStopUseSkill = false
    self:setCascadeOpacityEnabled(true)
    
    self:initComponent()
    
    self:resetPosition()
    self:resetDirection()
    
    self:doAction(ActionType.IDLE)
end


function Player:initComponent()
    local startTime = os.clock()
    local playerActionInfoMap = ActionInfoConfig.getActionInfoMap(self._playerInfo:getTypeId())
    
    self._viewComponent = ViewComponent.create(self)
    self._moveComponent = MoveComponent.create(self)
    self._actionComponent = ActionComponent.create(self, playerActionInfoMap)
    self._skillComponent = SkillComponent.create(self)
    self._aiComponent = AIOrderComponent.create(self)
    self._hitComponent = HitComponent.create(self)
    self._buffComponent = BuffComponent.create(self)
end

function Player:autoUseSkill(attContext,callback)
    self._curAttackContext = attContext
    self._aiComponent:autoUseSkill(attContext,callback)
end

function Player:doAction(actionType,callback)
    self._actionComponent:doAction(actionType,callback)
end

function Player:useSkill(skillKey)
    self._skillComponent:useSkill(skillKey)
end

function Player:useManualSkill(skillKey, attContext, callback)
    self._curAttackContext = attContext
    self._aiComponent:useManualSkill(skillKey, attContext, callback)
end

function Player:doBeHitAction()
    self._skillComponent:doBeHitAction()
    self._actionComponent:doBeHitAction()
end

function Player:doDeathAction()
    self._actionComponent:doDeathAction()
end

function Player:hit(damageResult)
    self._hitComponent:hit()
end

function Player:beHit(damageResult)
    self:getPlayerInfo():acceptHp(damageResult)
    self._hitComponent:beHit(damageResult)
    self._viewComponent:showDamageEffect(damageResult)
end

function Player:resetDirection()
    self:setDirection(self:getGroupDirection())
end

function Player:getOriginalPositionX()
    return self._playerInfo:getX(self._group)
end

function Player:getOriginalPositionY()
    return self._playerInfo:getY(self._group)
end

function Player:resetPosition()
    self:setPosition(cc.p(self:getOriginalPositionX(),self:getOriginalPositionY()))
end

function Player:moveTo(x,y, callback, duration, isDoAction)
    self._moveComponent:moveTo(x,y,callback,duration,isDoAction)
end

function Player:cancelMove()
    self._moveComponent:cancelMove()
end

function Player:onTick()
    self._actionComponent:onTick()
    
    if not self:getIsDeath() and self._playerInfo:getIsAuto() and self._playerInfo:isEnergyFull() then
        if self._actionComponent:hasActionInfo(SkillKey.SKILL_1) then
            self:getPlayerInfo():clearEnergy()
            SceneManager.getCurScene():getManualSkillManager():useManualSkill(self, SkillKey.SKILL_1, false, 200)
        end
    end
end

function Player:onBattleEvent(evt)
    self._buffComponent:onBattleEvent(evt)
end

function Player:moveBack()
--    self._curAttackContext = nil
    self._moveComponent:moveBack()
end

function Player:isAlreadyAtOriginalPosition()
    return self._moveComponent:isAlreadyAtOriginalPosition()
end

function Player:setDirection(direction)
    self._viewComponent:setDirection(direction)
end

function Player:getGroupDirection()
    return self._moveComponent:getGroupDirection()
end

function Player:getReverseDirection()
    return self._moveComponent:getReverseDirection()
end

function Player:getPlayerInfo()
    return self._playerInfo
end

function Player:getAIComponent()
    return self._aiComponent
end

function Player:getSkillComponent()
    return self._skillComponent
end

function Player:getCurSkillInfo()
    return self._skillComponent:getCurSkillInfo()
end

function Player:getActionComponent()
    return self._actionComponent
end

function Player:getAvatar()
    return self._viewComponent:getAvatar()
end

function Player:getGroup()
    return self._group
end

function Player:getIsDeath()
    return self._playerInfo:getIsDeath()
end

function Player:pausePlayer()
    self:pause()
    self:getAvatar():pauseAvatar()
    self._isPause = true
end

function Player:resumePlayer()
    self:resume()
    self:getAvatar():resumeAvatar()
    self._isPause = false
end

function Player:getIsPause()
    return self._isPause
end

function Player:addBuff(buffId, sourcePlayer, continueRound)
    self._buffComponent:addBuff(buffId, sourcePlayer, continueRound)
end

--- 获取当前战斗的信息
function Player:getCurAttackContext()
    return self._curAttackContext
end

function Player:getTargetPlayer()
    return self._skillComponent:getTargetPlayer()
end

function Player:getIsAttack()
    return self._curAttackContext ~= nil
end

function Player:getIsFocus()
    return self._isFocus
end

function Player:setFocus(focus)
    self._isFocus = focus
    if focus == true and self._isPause then
        self:resumePlayer()
    end
end

function Player:setIsStopUseSkill(stop)
    self._isStopUseSkill = stop
end

function Player:getIsStopUseSkill()
    return self._isStopUseSkill
end

function Player:getCurActionInfo()
    return self._actionComponent:getCurActionInfo()
end

function Player:dispose()
    self._viewComponent:dispose()
end