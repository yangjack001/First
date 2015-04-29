require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")
require("game/type/TargetType")

ActionEffectScriptArg = class("ActionEffectScriptArg",function()
    return BaseActionScriptArg.create()
end)

ActionEffectScriptArg._effectId = nil
ActionEffectScriptArg._targetType = nil

function ActionEffectScriptArg.create()
    local arg = ActionEffectScriptArg:new()
    arg:init()
    return arg
end

function ActionEffectScriptArg:init()
    self._targetType = TargetType.SELF
end

function ActionEffectScriptArg:parse(data)
    self._startTime = data.startTime
    self._effectId = data.effectId
    if data.targetType ~= nil then
        self._targetType = data.targetType
    end
end

function ActionEffectScriptArg:getEffectId()
    return self._effectId
end

function ActionEffectScriptArg:getTargetType()
    return self._targetType
end

function ActionEffectScriptArg:getType()
    return ActionScriptType.ACTION_EFFECT
end