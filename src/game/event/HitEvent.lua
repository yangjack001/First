require("game/util/evt/MyEvent")
HitEvent = class("HitEvent", function()
    return MyEvent.create()
end)

HitEvent.ON_HIT_FINISH = "ON_HIT_FINISH"

HitEvent._damageResult = nil

function HitEvent.create(type, damageResult)
    local evt = HitEvent:new()
    evt:init(type, damageResult)
    return evt
end

function HitEvent:init(type, damageResult)
    self._type = type
    self._damageResult = damageResult
end

function HitEvent:getDamageResult()
    return self._damageResult
end