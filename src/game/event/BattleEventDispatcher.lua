require("game/util/evt/MyEventDispatcher")
BattleEventDispatcher = class("BattleEventDispatcher",function()
    return MyEventDispatcher.create()
end)

function BattleEventDispatcher.create()
    local battle = BattleEventDispatcher:new()
    return battle
end