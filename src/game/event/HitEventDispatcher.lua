require("game/util/evt/MyEventDispatcher")

HitEventDispatcher = class("HitEventDispatcher", function()
    return MyEventDispatcher.create()
end)

function HitEventDispatcher.create()
    local battle = HitEventDispatcher:new()
    return battle
end