require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")

CPUseSkillScriptArg = class("CPUseSkillScriptArg",function()
    return BaseActionScriptArg.create()
end)

function CPUseSkillScriptArg.create()
    local scriptArg = CPUseSkillScriptArg:new()
    return scriptArg
end

CPUseSkillScriptArg._playerTypeId = nil
CPUseSkillScriptArg._skillId = nil

function CPUseSkillScriptArg:parse(data)
    self._startTime = data.startTime
    self._playerTypeId = data.playerTypeId
    self._skillId = data.skillId
end

function CPUseSkillScriptArg:getPlayerTypeId()
    return self._playerTypeId
end

function CPUseSkillScriptArg:getSkillId()
    return self._skillId
end

function ActionEffectScriptArg:getType()
    return ActionScriptType.CP_USE_SKILL
end