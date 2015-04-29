require("game/player/components/buff/trait/BaseBuffTrait")
StopUseSkillTrait = class("StopUseSkillTrait", function()
    return BaseBuffTrait.create()
end)

function StopUseSkillTrait.create(player)
    local trait = StopUseSkillTrait:new()
    trait:init(player)
    return trait
end

function StopUseSkillTrait:init(player)
    self._player = player
end

function StopUseSkillTrait:onStart()
    self._player:setIsStopUseSkill(true)
end

function StopUseSkillTrait:onStop()
    self._player:setIsStopUseSkill(false)
end

function StopUseSkillTrait:onEnd()
    self._player:setIsStopUseSkill(false)
end