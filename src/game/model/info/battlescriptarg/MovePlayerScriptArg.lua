require("game/model/info/battlescriptarg/BaseBattleScriptArg")
require("game/type/BattleScriptType")

MovePlayerScriptArg = class("MovePlayerScriptArg", function()
    return BaseBattleScriptArg.create()
end)

function MovePlayerScriptArg.create()
    local arg = MovePlayerScriptArg:new()
    arg:init()    
    return arg
end

MovePlayerScriptArg._groupType = nil
MovePlayerScriptArg._positionType = nil
MovePlayerScriptArg._x = nil
MovePlayerScriptArg._y = nil
MovePlayerScriptArg._time = nil

function MovePlayerScriptArg:init()

end

function MovePlayerScriptArg:parse(data)
    self._groupType = data.groupType
    self._time = data.time
    self._positionType = data.positionType
    self._x = data.x
    self._y = data.y
end

function MovePlayerScriptArg:getType()
    return BattleScriptType.MOVE_PLAYER
end

function MovePlayerScriptArg:getGroupType()
    return self._groupType
end

function MovePlayerScriptArg:getTime()
    return self._time
end

function MovePlayerScriptArg:getPositionType()
    return self._positionType
end

function MovePlayerScriptArg:getX()
    return self._x
end

function MovePlayerScriptArg:getY()
    return self._y
end