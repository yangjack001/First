require("game/player/avatar/PlayerAvatar")
require("game/player/components/view/DamageEffect")
require("game/player/components/view/PlayerBloodBar")
require("game/type/ViewLayerType")

ViewComponent = class("ViewComponent")

function ViewComponent.create(player)
    local component = ViewComponent:new()
    component._player = player
    component:init()
    return component
end

ViewComponent._player = nil
ViewComponent._avatar = nil
ViewComponent._bloodBar = nil

function ViewComponent:init()
    local startTime = os.clock()
    local startTime = os.clock()
    self:initAvatar()
    self:initBloodBar()
end

function ViewComponent:initAvatar()
    local playerInfo = self._player:getPlayerInfo()
    self._avatar = PlayerAvatar.create(playerInfo:getFileName(),playerInfo:getClothId())
    self._player:addChild(self._avatar, ViewLayerType.AVATAR)
end

function ViewComponent:initBloodBar()
    self._bloodBar = PlayerBloodBar.create(self._player)
end

function ViewComponent:setDirection(direction)
    self._avatar:setDirection(direction)
end

function ViewComponent:showDamageEffect(damageResult)
    DamageEffect.showDamageEffect(self._player,damageResult:getDamageValue(),damageResult:getIsCrit())
    self._bloodBar:acceptDamage(damageResult)
    
    DamageEffect.showHitEffect(self._player,damageResult:getHitEffectId())
end

function ViewComponent:getAvatar()
    return self._avatar
end

function ViewComponent:dispose()
    self._avatar:dispose()
end