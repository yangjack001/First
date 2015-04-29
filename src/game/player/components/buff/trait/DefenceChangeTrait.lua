require("game/player/components/buff/trait/BaseBuffTrait")

DefenceChangeTrait = class("DefenceChangeTrait", function()
    return BaseBuffTrait.create()
end)

function DefenceChangeTrait.create(player)
    local trait = DefenceChangeTrait:new()
    trait:init(player)
    return trait
end

function DefenceChangeTrait:onStart()
    self._player:getPlayerInfo():getProperty().att = self._player:getPlayerInfo():getProperty().att + 100
end