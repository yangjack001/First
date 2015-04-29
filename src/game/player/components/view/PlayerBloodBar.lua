require("game/type/ViewLayerType")

PlayerBloodBar = class("PlayerBloodBar", function()
    return cc.Sprite:create()
end)

BLOOD_BAR_WIDTH = 120
BLOOD_BAR_HEIGHT = 6
BLOOD_POSITION_Y = 180


PlayerBloodBar._container = nil
PlayerBloodBar._background = nil
PlayerBloodBar._midground = nil
PlayerBloodBar._foreground = nil
PlayerBloodBar._disappearAction = nil

function PlayerBloodBar.create(container)
    local bloodBar = PlayerBloodBar:new()
    bloodBar:init(container)
    return bloodBar
end

function PlayerBloodBar:init(container)
    self._container = container
    
    self:setCascadeOpacityEnabled(true)
    self._container:addChild(self, ViewLayerType.BLOOD_BAR)
    self._background = cc.Sprite:create("res/ui/progress/blood/blood_bg.png")
    self._background:setPositionY(-1)
    self:addChild(self._background)
    
    local midground = cc.Sprite:create("res/ui/progress/blood/blood_mid.png")
    local size = midground:getContentSize()
    midground:setPosition(cc.p(-size.width / 2, -size.height / 2))
    self._midground = cc.ProgressTimer:create(midground)
    self._midground:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self._midground:setBarChangeRate(cc.p(1,0))
    self._midground:setMidpoint(cc.p(0,0))
    self:addChild(self._midground)
    self._midground:setCascadeOpacityEnabled(true)
    
    local foreground = cc.Sprite:create("res/ui/progress/blood/blood_fg.png")
    local size = foreground:getContentSize()
    foreground:setCascadeOpacityEnabled(true)
    foreground:setPosition(cc.p(-size.width / 2, -size.height / 2))
    self._foreground = cc.ProgressTimer:create(foreground)
    self._foreground:setType(cc.PROGRESS_TIMER_TYPE_BAR)
    self._foreground:setBarChangeRate(cc.p(1,0))
    self._foreground:setMidpoint(cc.p(0,0))
    self:addChild(self._foreground)
    self._foreground:setCascadeOpacityEnabled(true)
    
    self:setPosition(0,BLOOD_POSITION_Y)
    self:setMidgroundPercent(100)
    self:setForegroundPercent(100)
    
    self:setAlpha(0)
end

function PlayerBloodBar:acceptDamage(damageResult)
    self:setAlpha(255)
    
    local curHp = damageResult:getDefPlayer():getPlayerInfo():getProperty().hp
    local maxHp = damageResult:getDefPlayer():getPlayerInfo():getProperty().maxHp
    local originHp = damageResult:getOriginalHp()
    
    self:setMidgroundPercent(curHp / maxHp)
    self:setForegroundPercent(curHp / maxHp)
    
    local delayAction = cc.DelayTime:create(2)
    local callbackAction = cc.CallFunc:create(function()
        self:setAlpha(0)
    end)
    
    if self._disappearAction ~= nil then
        self:stopAction(self._disappearAction)
    end
    
    self._disappearAction = cc.Sequence:create(delayAction, callbackAction)
    self:runAction(self._disappearAction)
end

function PlayerBloodBar:setAlpha(alpha)
    self._background:setOpacity(alpha)
    self._foreground:setOpacity(alpha)
    self._midground:setOpacity(alpha)
end

function PlayerBloodBar:setMidgroundPercent(percent)
    local actionEnergy = cc.ProgressTo:create(0.5,percent * 100)
    self._midground:runAction(actionEnergy)
end

function PlayerBloodBar:setForegroundPercent(percent)
    self._foreground:setPercentage(percent * 100)
end
