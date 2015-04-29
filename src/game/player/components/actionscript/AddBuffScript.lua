require("game/type/TargetType")
require("game/player/components/actionscript/BaseActionScript")

AddBuffScript = class("AddBuffScript",function()
    return BaseActionScript.create()
end)

function AddBuffScript.create(player)
    local script = AddBuffScript:new()
    script:init(player)
    return script
end

AddBuffScript._player = nil

function AddBuffScript:init(player)
    self._player = player
end

function AddBuffScript:excute(addBuffScriptArg)
    local buffId = addBuffScriptArg:getBuffId()
    local continueRound = addBuffScriptArg:getContinueRound()
    local targetType = addBuffScriptArg:getTargetType()
    local playerList = {}
    local attContext = self._player:getCurAttackContext()
    if targetType == TargetType.SELF then
        table.insert(playerList, self._player)
    elseif targetType == TargetType.SELF_TEAM then
        playerList = attContext:getFriendlyPlayerGroup():getPlayerList()
    elseif targetType == TargetType.ENEMY_TEAM then
        playerList = attContext:getEnemyPlayerGroup():getPlayerList()
    end
    
    for i = 1, #playerList do
        local player = playerList[i]
        player:addBuff(buffId, self._player, continueRound)
    end
end

