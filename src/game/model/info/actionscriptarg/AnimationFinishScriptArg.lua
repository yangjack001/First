require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")

AnimationFinishScriptArg = class("AnimationFinishScriptArg",function()
    return BaseActionScriptArg.create()
end)

function AnimationFinishScriptArg.create()
    local script = AnimationFinishScriptArg:new()
    return script
end

function AnimationFinishScriptArg:parse(data)
    self._startTime = data.startTime
end

function AnimationFinishScriptArg:getType()
    return ActionScriptType.ANIMATION_FINISH
end