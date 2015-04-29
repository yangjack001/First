require("game/player/components/actionscript/BaseActionScript")
require("game.manager.SceneManager")
require("game/config/RemoteEffectConfig")
require("game/type/TargetType")

RemoteEffectScript = class("RemoteEffectScript", function()
    return BaseActionScript.create()
end)

function RemoteEffectScript.create(player)
    local script = RemoteEffectScript:new()
    script:init(player)
    return script
end

RemoteEffectScript._player = nil

function RemoteEffectScript:init(player)
    self._player = player
end

function RemoteEffectScript:excute(remoteEffectScriptArg)
    local positionX, positionY
    if remoteEffectScriptArg:getPositionType() == PositionType.ABSOLUTE then
        positionX = remoteEffectScriptArg:getX()
        positionY = remoteEffectScriptArg:getY()
    else
        positionX = self._player:getPositionX() + remoteEffectScriptArg:getX()
        --减1，让特效在目标前面显示
        positionY = self._player:getPositionY() - 1 + remoteEffectScriptArg:getY()
    end
    
    local targetPlayer = self._player:getTargetPlayer()
    
    local remoteEffectId = remoteEffectScriptArg:getEffectId()
    
    local remoteeffectInfo = RemoteEffectConfig.getRemoteEffectInfoById(remoteEffectId)
    
    if remoteEffectScriptArg:getTargetType() ~= TargetType.NONE then
        local attContext = self._player:getCurAttackContext()
        local enemyGroup = attContext:getEnemyPlayerGroup()
        targetPlayer = enemyGroup:getTargetPlayer(remoteEffectScriptArg:getTargetType(), self._player:getPlayerInfo():getGridY())
    end
    
    if targetPlayer == nil then
        return
    end    
           
    SceneManager.getCurScene():getRemoteEffectManager():addRemoteEffect({self._player}, targetPlayer, remoteEffectId, positionX, positionY)
end