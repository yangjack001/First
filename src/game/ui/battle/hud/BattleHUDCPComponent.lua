require("game/manager/CPSkillManager")

BattleHUDCPComponent = class("BattleHUDCPComponent")

function BattleHUDCPComponent.create(spCP, cpSkillInfo, controlPlayerGroup)
    local component = BattleHUDCPComponent:new()
    component:init(spCP, cpSkillInfo, controlPlayerGroup)
    return component
end

PARTICLE_NAME = "particle"
BattleHUDCPComponent._spCP = nil
BattleHUDCPComponent._cpSkillInfo = nil
BattleHUDCPComponent._controlPlayerGroup = nil

function BattleHUDCPComponent:init(spCP, cpSkillInfo, controlPlayerGroup)
    self._spCP = spCP
    self._cpSkillInfo = cpSkillInfo
    self._controlPlayerGroup = controlPlayerGroup
    self:addEvent()
end

function BattleHUDCPComponent:addEvent()
    if self._cpSkillInfo == nil then
--        self._spCP:setOpacity(0)
        return
    end

    local eventListener = cc.EventListenerTouchOneByOne:create()
    eventListener:setSwallowTouches(true)
    local eventDispatcher = self._spCP:getEventDispatcher()
    
    eventListener:registerScriptHandler(function(touch, event)
        local target = event:getCurrentTarget()

        local locationInNode = target:convertToNodeSpace(touch:getLocation())
        local s = target:getContentSize()
        local rect = cc.rect(0, 0, s.width, s.height)
        if cc.rectContainsPoint(rect, locationInNode) then
            self:removeParticle()
            eventDispatcher:removeEventListener(eventListener)
            
            SceneManager.getCurScene():getCPSkillManager():useCPSkillManager(self._cpSkillInfo, self._controlPlayerGroup)
        end
    end,cc.Handler.EVENT_TOUCH_BEGAN)
    
    eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener, self._spCP)
    
    self:addParticle()
end

function BattleHUDCPComponent:addParticle()
    local particle = cc.ParticleFlower:create()
    particle:setName(PARTICLE_NAME)
    particle:setPosition(100,110)
    self._spCP:addChild(particle)
end

function BattleHUDCPComponent:removeParticle()
    local child = self._spCP:getChildByName(PARTICLE_NAME)
    self._spCP:removeChild(child)
end
