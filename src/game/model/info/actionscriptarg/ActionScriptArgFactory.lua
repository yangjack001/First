require("game/model/info/actionscriptarg/ActionEffectScriptArg")
require("game/model/info/actionscriptarg/HitCheckScriptArg")
require("game/model/info/actionscriptarg/RemoteEffectScriptArg")
require("game/model/info/actionscriptarg/SkillFinishScriptArg")
require("game/model/info/actionscriptarg/AddBuffScriptArg")
require("game/model/info/actionscriptarg/AnimationFinishScriptArg")
require("game/model/info/actionscriptarg/MoveScriptArg")
require("game/model/info/actionscriptarg/CreateShadowScriptArg")
require("game/type/ActionScriptType")
require("game/language/StringManager")
require("game/language/StringKey")

ActionScriptArgFactory = class("ActionScriptArgFactory")

ActionScriptArgFactory._typeToCls = {
    [ActionScriptType.ACTION_EFFECT] = ActionEffectScriptArg,
    [ActionScriptType.REMOTE_EFFECT] = RemoteEffectScriptArg,
    [ActionScriptType.HIT_CHECK] = HitCheckScriptArg,
    [ActionScriptType.SKILL_FINISH] = SkillFinishScriptArg,
    [ActionScriptType.ADD_BUFF] = AddBuffScriptArg,
    [ActionScriptType.ANIMATION_FINISH] = AnimationFinishScriptArg,
    [ActionScriptType.MOVE] = MoveScriptArg,
    [ActionScriptType.CREATE_SHADOW] = CreateShadowScriptArg
}

function ActionScriptArgFactory.getArgByType(type)
    if ActionScriptArgFactory._typeToCls[type] ~= nil then
        return ActionScriptArgFactory._typeToCls[type].create()
    else
        error(StringManager.getString(StringKey.ACTION_SCRIPT_NONE_ERROR,type))
    end
end