require("game/manager/SceneManager")
require("game/manager/IconManager")
require("game/type/SkillKey")
require("game/util/ColorUtil")

BattleHUDPlayerStateComponent = class("BattleHUDPlayerStateComponent")

function BattleHUDPlayerStateComponent.create(playerInfo, headQuanlity, headBg, energyProgress, bloodProgress)
    local component = BattleHUDPlayerStateComponent:new()
    component:init(playerInfo, headQuanlity, headBg, energyProgress, bloodProgress)
    return component    
end

PARTICLE_NAME = "particle"

BattleHUDPlayerStateComponent._playerInfo = nil
BattleHUDPlayerStateComponent._player = nil
BattleHUDPlayerStateComponent._headQuanlity = nil
BattleHUDPlayerStateComponent._headBg = nil
BattleHUDPlayerStateComponent._energyProgressTimer = nil
BattleHUDPlayerStateComponent._bloodProgressTimer = nil
BattleHUDPlayerStateComponent._isAddEffect = nil
BattleHUDPlayerStateComponent._fullEffect = nil

function BattleHUDPlayerStateComponent:init(playerInfo, headQuanlity, headBg, energyProgress, bloodProgress)
    self._playerInfo = playerInfo
    if playerInfo ~= nil then
        self._player = SceneManager.getCurScene():getPlayerManager():getPlayerById(self._playerInfo:getId())
    end
    
    self._headQuanlity = headQuanlity
    self._headBg = headBg
    
    self:addPlayerHead()
    self:initProgress(self._player, headQuanlity, energyProgress, bloodProgress)
    self:addTouchEvent(headQuanlity)
    self:update(self._player)
end

function BattleHUDPlayerStateComponent:update(player)
    if self._player ~= player then
        return
    end

    if self._player == nil then
        self:applyHeadGray()
        return
    end

    local property = self._player:getPlayerInfo():getProperty()
    local energyPercent = property.energy * 100 / property.maxEnergy
    local bloodPercent = property.hp * 100 / property.maxHp
    local actionEnergy = cc.ProgressTo:create(0.5,energyPercent)
    local actionBlood = cc.ProgressTo:create(0.5,bloodPercent)
    self._energyProgressTimer:runAction(cc.RepeatForever:create(actionEnergy))
    self._bloodProgressTimer:runAction(cc.RepeatForever:create(actionBlood))

    if bloodPercent == 0 then
        self:applyHeadGray()
        self:removeParticle()
        return
    end

    if energyPercent >= 100 and self._isAddEffect ~= true then
        self:addParticle()
    end
end

function BattleHUDPlayerStateComponent:initProgress(player, head, energyProgress, bloodProgress)
    local container = self._headQuanlity:getParent()

    local energyProgressTimer = cc.ProgressTimer:create(energyProgress)
    energyProgressTimer:setPosition(energyProgress:getPositionX(),energyProgress:getPositionY())
    energyProgressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    energyProgressTimer:setMidpoint(cc.p(0,0))
    energyProgressTimer:setBarChangeRate(cc.p(1,0))
    container:removeChild(energyProgress)
    container:addChild(energyProgressTimer, 7)
    self._energyProgressTimer = energyProgressTimer

    local bloodProgressTimer = cc.ProgressTimer:create(bloodProgress)
    bloodProgressTimer:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    bloodProgressTimer:setPosition(bloodProgress:getPositionX(),bloodProgress:getPositionY())
    bloodProgressTimer:setMidpoint(cc.p(0,0))
    bloodProgressTimer:setBarChangeRate(cc.p(1,0))
    container:removeChild(bloodProgress)
    container:addChild(bloodProgressTimer, 8)
    self._bloodProgressTimer = bloodProgressTimer
end

function BattleHUDPlayerStateComponent:addTouchEvent(head)
    local eventListener = cc.EventListenerTouchOneByOne:create()
    eventListener:setSwallowTouches(true)

    eventListener:registerScriptHandler(function(touch, event)
        local target = event:getCurrentTarget()
        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        if cc.rectContainsPoint(rect, locationInNode) then
            if self._playerInfo == nil or self._playerInfo:getIsDeath() or not self._playerInfo:isEnergyFull() or self._player:getIsStopUseSkill()then
                return
            end
            self:removeParticle()
            self._player:getPlayerInfo():clearEnergy()
            SceneManager.getCurScene():getManualSkillManager():useManualSkill(self._player, SkillKey.SKILL_1, false, 200)
            
            self:update(self._player)
        end
    end,cc.Handler.EVENT_TOUCH_BEGAN)

    local eventDispatcher = head:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener, head)
end

function BattleHUDPlayerStateComponent:addPlayerHead()
    if self._playerInfo == nil then
        return
    end
    
    self._fullEffect = AnimationManager.getEnergyFullEffect()
    self._fullEffect:getAnimation():gotoAndPlay("loop")
    self._fullEffect:setPosition(self._headQuanlity:getPositionX(), self._headQuanlity:getPositionY() - 67)
    self._fullEffect:setLocalZOrder(0)
    self._headQuanlity:getParent():addChild(self._fullEffect)
    
    local playerTypeId = self._playerInfo:getTypeId()
    local icon = IconManager.getPlayerHead(playerTypeId)
    icon:setPosition(60,65)
    self._headQuanlity:addChild(icon)
    self:removeParticle()
end

function BattleHUDPlayerStateComponent:applyHeadGray()
    ColorUtil.applyGray(self._headQuanlity)
    local children = self._headQuanlity:getChildren()
    if children and #children > 0 then
        for _, child in ipairs(children) do
            ColorUtil.applyGray(child)
        end
    end
end

function BattleHUDPlayerStateComponent:addParticle()
    self._fullEffect:setVisible(true)
end

function BattleHUDPlayerStateComponent:removeParticle()
    self._fullEffect:setVisible(false)
end

function BattleHUDPlayerStateComponent:getPlayer()
    return self._player
end