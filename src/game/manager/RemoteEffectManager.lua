require("game/config/RemoteEffectConfig")
require("game/util/schedule/ScheduleUtil")

RemoteEffectManager = class("RemoteEffectManager")

function RemoteEffectManager.create(container)
    local manager = RemoteEffectManager:new()
    manager:init(container)
    return manager
end

RemoteEffectManager._container = nil
RemoteEffectManager._listEffect = nil
RemoteEffectManager._callback = nil

function RemoteEffectManager:init(container)
    self._container = container 
    self._listEffect = {}
end

function RemoteEffectManager:addRemoteEffect(sourcePlyaerList, targetPlayer, remoteEffectId, x, y,callback)
    local remoteEffectInfo = RemoteEffectConfig.getRemoteEffectInfoById(remoteEffectId)
    local RemoteEffectPlayer = require("game/player/RemoteEffectPlayer")
    local remoteEffect = RemoteEffectPlayer.create(remoteEffectInfo, sourcePlyaerList)
    remoteEffect:setPosition(x, y)
    
    remoteEffect:setTargetPlayer(targetPlayer)
    remoteEffect:start(callback)
    self._container:addChild(remoteEffect)
    
    table.insert(self._listEffect, remoteEffect) 
end

function RemoteEffectManager:onTick(t)
    for i = #self._listEffect, 1, -1 do
        self._listEffect[i]:onTick(t)
    end
end

function RemoteEffectManager:removeRemoteEffect(effect)
    for i = #self._listEffect, 1, -1 do
        if effect == self._listEffect[i] then
            table.remove(self._listEffect, i)
        end
    end
    
    effect:applyCallback()
    
    ScheduleUtil:getInstance():addFrameSchedule(1, function()
        self._container:removeChild(effect)
        -- 暂时不知为毛会报错
--        effect:dispose()
    end)
end