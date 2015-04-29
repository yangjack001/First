require("game/event/PlayerEvent")
require("game/player/components/actionscript/BaseActionScript")

SkillFinishScript = class("SkillFinishScript",function()
    return BaseActionScript.create()
end)

function SkillFinishScript.create(player)
    local script = SkillFinishScript:new()
    script:init(player)
    return script
end

SkillFinishScript._player = nil


function SkillFinishScript:init(player)
    self._player = player
end

function SkillFinishScript:excute(skillFinishScriptArg)
    local evt = cc.EventCustom:new(PlayerEvent.SKILL_FINISH)
    evt.player = self._player
    print("script finish skill", self._player:getPlayerInfo():getTypeId())
    self._player:getEventDispatcher():dispatchEvent(evt)
end