require("game/type/ActionScriptType")
require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/model/info/actionscriptarg/HitCheckScriptArg")
require("game/type/PositionType")

RemoteEffectScriptArg = class("RemoteEffectScriptArg",function()
    return BaseActionScriptArg.create()
end)

function RemoteEffectScriptArg.create()
    local arg = RemoteEffectScriptArg:new()
    return arg
end

RemoteEffectScriptArg._effectId = nil
RemoteEffectScriptArg._x = nil
RemoteEffectScriptArg._y = nil
RemoteEffectScriptArg._targetType = nil
RemoteEffectScriptArg._positionType = nil

function RemoteEffectScriptArg:parse(data)
    self._startTime = data.startTime
    self._effectId = data.effectId
    if data.x ~= nil then
        self._x = data.x
    else
        self._x = 0
    end
    
    if data.y ~= nil then
        self._y = data.y
    else
        self._y = 0
    end
    
    if data.tarType == nil then
        self._targetType = TargetType.NONE
    else
        self._targetType = data.tarType
    end
    
    if data.positionType == nil then
        self._positionType = PositionType.RELATIVE
    else
        self._positionType = data.positionType
    end
end

function RemoteEffectScriptArg:getEffectId()
    return self._effectId
end

function RemoteEffectScriptArg:getX()
    return self._x
end

function RemoteEffectScriptArg:getY()
    return self._y
end

function RemoteEffectScriptArg:getType()
    return ActionScriptType.REMOTE_EFFECT
end

function RemoteEffectScriptArg:getTargetType()
    return self._targetType
end

function RemoteEffectScriptArg:getPositionType()
    return self._positionType
end