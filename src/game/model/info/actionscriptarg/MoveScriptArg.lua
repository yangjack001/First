require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")

MoveScriptArg = class("MoveScriptArg",function()
    return BaseActionScriptArg.create()
end)

function MoveScriptArg.create()
    local arg = MoveScriptArg:new()
    arg:init()
    return arg
end

MoveScriptArg._moveX = nil
MoveScriptArg._moveY = nil
MoveScriptArg._time = nil
MoveScriptArg._positionType = nil
MoveScriptArg._targetType = nil

function MoveScriptArg:init()
    self._moveX = 0
    self._moveY = 0
    self._time = 0
    self._targetType = TargetType.SELF
    self._positionType = PositionType.RELATIVE
end

function MoveScriptArg:parse(data)
    self._startTime = data.startTime
    if data.moveX ~= nil then
        self._moveX = data.moveX
    end
    
    if data.moveY ~= nil then
        self._moveY = data.moveY
    end
    
    if data.time ~= nil then
        self._time = data.time
    end
    
    if data.targetType ~= nil then
        self._targetType = data.targetType
    end
    
    if data.positionType ~= nil then
        self._positionType = data.positionType
    end
end

function MoveScriptArg:getMoveX()
    return self._moveX
end

function MoveScriptArg:getMoveY()
    return self._moveY
end

function MoveScriptArg:getType()
    return ActionScriptType.MOVE
end

function MoveScriptArg:getTime()
    return self._time
end

function MoveScriptArg:getPositionType()
    return self._positionType
end

function MoveScriptArg:getTargetType()
    return self._targetType
end