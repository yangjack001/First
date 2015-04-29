require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")

SkillFinishScriptArg = class("SkillFinishScriptArg",function()
    return BaseActionScriptArg.create()
end)

function SkillFinishScriptArg.create()
    local arg = SkillFinishScriptArg:new()
    return arg
end

function SkillFinishScriptArg:parse(data)
    self._startTime = data.startTime
end

function SkillFinishScriptArg:getType()
    return ActionScriptType.SKILL_FINISH
end