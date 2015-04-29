require("game/event/AvatarEvent")
require("game/player/components/actionscript/BaseActionScript")

AnimationFinishScript = class("AnimationFinishScript",function()
    return BaseActionScript.create()
end)

function AnimationFinishScript.create(player)
    local script = AnimationFinishScript:new()
    script:init(player)
    return script
end

AnimationFinishScript._player = nil


function AnimationFinishScript:init(player)
    self._player = player
end

function AnimationFinishScript:excute(skillFinishScriptArg)
    local evt = cc.EventCustom:new(AvatarEvent.ANIMATION_COMPLETE)
    evt.avatar = self._player:getAvatar()
    evt.animation = self._player:getCurActionInfo():getAnimation()
    self._player:getAvatar():getEventDispatcher():dispatchEvent(evt)
end