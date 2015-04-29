require("game/config/BattleConfig")
require("game/type/HitAreaType")
require("game/player/components/actionscript/BaseActionScript")
require("game/event/PlayerEvent")
require("game/manager/HitManager")
require("game/manager/HitCheckManager")

HitCheckScript = class("HitCheckScript",function()
    return BaseActionScript.create()
end)

function HitCheckScript.create(player)
    local script = HitCheckScript:new()
    script:init(player)
    return script
end

HitCheckScript._player = nil

function HitCheckScript:init(player)
    self._player = player
end

function HitCheckScript:excute(hitCheckScriptArg)
    local targetPlayer = self._player:getTargetPlayer()
    HitManager.onHit(self._player, targetPlayer, hitCheckScriptArg)
    
    local evt = cc.EventCustom:new(PlayerEvent.HIT_CHECK)
    evt.player = self._player
    self._player:getEventDispatcher():dispatchEvent(evt)
end