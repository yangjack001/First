require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")

HitCheckScriptArg = class("HitCheckScriptArg",function()
    return BaseActionScriptArg.create()
end)

function HitCheckScriptArg.create()
    local arg = HitCheckScriptArg:new()
    return arg
end

HitCheckScriptArg._hitId = nil
HitCheckScriptArg._hitCheckType = nil
HitCheckScriptArg._isInterrupt = nil
HitCheckScriptArg._hitEffectId = nil

function HitCheckScriptArg:parse(data)
    self._startTime = data.startTime
    self._hitId = data.hitId
    self._hitCheckType = data.hitCheckType
    self._isInterrupt = data.isInterrupt
    self._hitEffectId = data.hitEffectId
end

function HitCheckScriptArg:getHitId()
    return self._hitId
end

function HitCheckScriptArg:getHitCheckType()
    return self._hitCheckType
end

function HitCheckScriptArg:getType()
    return ActionScriptType.HIT_CHECK
end

function HitCheckScriptArg:getIsInterrupt()
    return self._isInterrupt
end

function HitCheckScriptArg:getHitEffectId()
    return self._hitEffectId
end