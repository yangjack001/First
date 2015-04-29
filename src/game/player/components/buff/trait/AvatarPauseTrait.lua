require("game/player/components/buff/trait/BaseBuffTrait")
AvatarPauseTrait = class("AvatarPauseTrait",function()
    return BaseBuffTrait.create()
end)

function AvatarPauseTrait.create(player)
    local trait = AvatarPauseTrait:new()
    trait:init(player)
    return trait
end

function AvatarPauseTrait:init(player)
    self._player = player
end

function AvatarPauseTrait:onStart()
    self._player:pausePlayer()
    ColorUtil.applyGray(self._player:getAvatar())
end

function AvatarPauseTrait:onStop()
    self._player:resumePlayer()
end

function AvatarPauseTrait:onEnd()
    self._player:resumePlayer()
end