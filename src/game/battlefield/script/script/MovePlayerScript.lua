require("game/battlefield/script/script/BaseBattleScript")
MovePlayerScript = class("MovePlayerScript",function()
    return BaseBattleScript.create()
end)

function MovePlayerScript.create()
    local script = MovePlayerScript:new()
    script:init()
    return script
end

function MovePlayerScript:init()
    self._type = BattleScriptType.MOVE_PLAYER
end

function MovePlayerScript:excute(movePlayerScriptArg,callback)
    self._callback = callback
    
    local listPlayers
    if movePlayerScriptArg:getGroupType() == GroupType.LEFT then
        listPlayers = BattleFieldManager.getCurBattle():getBattleContext():getLeftPlayerGroup():getPlayerList()
    elseif movePlayerScriptArg:getGroupType() == GroupType.RIGHT then
        listPlayers = BattleFieldManager.getCurBattle():getBattleContext():getRightPlayerGroup():getPlayerList()
    end
    
    local count = 0
    local moveFunc = function(player)
        local positionType = movePlayerScriptArg:getPositionType()
        local tarX,tarY
        if positionType == PositionType.FIGHT_POSITION then
            tarX = player:getOriginalPositionX()
            tarY = player:getOriginalPositionY()
        elseif positionType == PositionType.LEAVE_POSITION then
            tarX = player:getOriginalPositionX() + 1500
            tarY = player:getOriginalPositionY()
        end
        
        player:moveTo(tarX,tarY,function()
            player:doAction(ActionType.IDLE)
            count = count -1
            if count <= 0 then
                callback()
            end
        end,movePlayerScriptArg:getTime(),true)
        count = count + 1
    end

    for i = 1,#listPlayers do
        local player = listPlayers[i]
        moveFunc(player)
    end
end