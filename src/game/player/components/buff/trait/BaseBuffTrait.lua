BaseBuffTrait = class("BaseBuffTrait")

function BaseBuffTrait.create(player)
    local trait = BaseBuffTrait:new()
    trait:init(player)
    return trait
end

BaseBuffTrait._player = nil

function BaseBuffTrait:init(player)
    self._player = player
end

function BaseBuffTrait:onStart()

end

function BaseBuffTrait:onRoundStart()

end

function BaseBuffTrait:onRoundEnd()

end

-- 时间到结束
function BaseBuffTrait:onEnd()

end

-- 被动停止
function BaseBuffTrait:onStop()

end