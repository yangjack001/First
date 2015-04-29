require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")

AddBuffScriptArg = class("AddBuffScriptArg", function()
    return BaseActionScriptArg.create()
end)

function AddBuffScriptArg.create()
    local arg = AddBuffScriptArg:new()
    return arg
end

AddBuffScriptArg._buffId = nil
AddBuffScriptArg._continueRound = nil
AddBuffScriptArg._targetType = nil

function AddBuffScriptArg:parse(data)
    self._startTime = data.startTime
    self._buffId = data.buffId
    self._continueRound = data.continueRound
    self._targetType = data.targetType
end

function AddBuffScriptArg:getType()
    return ActionScriptType.ADD_BUFF
end

function AddBuffScriptArg:getBuffId()
    return self._buffId
end

function AddBuffScriptArg:getContinueRound()
    return self._continueRound
end

function AddBuffScriptArg:getTargetType()
    return self._targetType
end