require("game/player/components/actionscript/BaseActionScript")

ActionEffectScript = class("ActionEffectScript",function()
    return BaseActionScript.create()
end)

function ActionEffectScript.create(player)
    local script = ActionEffectScript:new()
    script:init(player)
    return script
end

ActionEffectScript._player = nil

function ActionEffectScript:init(player)
    self._player = player
end

function ActionEffectScript:excute(actionEffectScriptArg)
    local effectId = actionEffectScriptArg:getEffectId()
    local targetType = actionEffectScriptArg:getTargetType()
    if targetType == TargetType.SELF then
        self._player:getAvatar():addActionEffect(effectId)
    elseif targetType == TargetType.SKILL_TARGET then
        self._player:getTargetPlayer():getAvatar():addActionEffect(effectId)
    end
end