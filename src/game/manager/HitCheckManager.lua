require("game/type/HitAreaType")

HitCheckManager = class("HitCheckManager")

function HitCheckManager:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function HitCheckManager:getInstance()
    if self.instance == nil then
        self.instance = self:new()
        self:init()
    end
    return self.instance
end

HitCheckManager._mapHitCheckTypeToHandler = nil

function HitCheckManager:init()
    self._mapHitCheckTypeToHandler = {
        [HitAreaType.REL_SINGLE] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeSingleTarget(targetPlayer)
        end,
        [HitAreaType.REL_ONE_ROW] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeOneRowTarget(targetPlayer, enemyPlayerList)
        end,
        [HitAreaType.REL_TOW_ROW] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeTowRowTarget(targetPlayer, enemyPlayerList)
        end,
        [HitAreaType.REL_ONE_COL] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeOneColTarget(targetPlayer, enemyPlayerList)
        end,
        [HitAreaType.REL_CROSS] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeCrossTarget(targetPlayer, enemyPlayerList)
        end,
        [HitAreaType.ABS_RANDOM_TOW] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeCrossTarget(targetPlayer, enemyPlayerList)
        end,
        [HitAreaType.ABS_FULL_SCREEN] = function(targetPlayer,enemyPlayerList)
            return self:getAbsoluteFullScreen(targetPlayer, enemyPlayerList)
        end,
        [HitAreaType.REL_SINGLE_COL_NEXT_ONE] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeSingleColNextOneTarget(targetPlayer, enemyPlayerList)
        end,
        [HitAreaType.REL_SINGLE_COL_NEXT_TWO] = function(targetPlayer,enemyPlayerList)
            return self:getRelativeSingleColNextTwoTarget(targetPlayer, enemyPlayerList)
        end
    }
end

function HitCheckManager:getBehitTargetList(hitCheckType,targetPlayer,enemyPlayerList)
    return self._mapHitCheckTypeToHandler[hitCheckType](targetPlayer,enemyPlayerList)
end

function HitCheckManager:getRelativeSingleTarget(targetPlayer,enemyPlayerList)
    return {targetPlayer}
end

function HitCheckManager:getRelativeSingleColNextOneTarget(targetPlayer, enemyPlayerGruop)
    return {enemyPlayerGruop:getPlayer(targetPlayer:getPlayerInfo():getGridX() + 1,targetPlayer:getPlayerInfo():getGridY())}
end

function HitCheckManager:getRelativeSingleColNextTwoTarget(targetPlayer, enemyPlayerGruop)
    return {enemyPlayerGruop:getPlayer(targetPlayer:getPlayerInfo():getGridX() + 2,targetPlayer:getPlayerInfo():getGridY())}
end

function HitCheckManager:getRelativeOneRowTarget(targetPlayer,enemyPlayerList)
    local result = {}
    for j=1,BattleConfig.COL_COUNT do
        local player = enemyPlayerList:getPlayer(targetPlayer:getPlayerInfo():getGridX(),j)
        if self:validatePlayer(player) then
            table.insert(result,player)
        end
    end
    return result
end

function HitCheckManager:getRelativeTowRowTarget(targetPlayer,enemyPlayerList)
    local result = {}
    for i=targetPlayer:getPlayerInfo():getGridX(),BattleConfig.ROW_COUNT do
        for j=1,BattleConfig.COL_COUNT do
            local player = enemyPlayerList:getPlayer(i,j)
            if self:validatePlayer(player) then
                table.insert(result,player)
            end
        end
    end
    return result
end

function HitCheckManager:getRelativeOneColTarget(targetPlayer,enemyPlayerList)
    local result = {}
    for i=1,BattleConfig.ROW_COUNT do
        local player = enemyPlayerList:getPlayer(i,targetPlayer:getPlayerInfo():getGridY())
        if self:validatePlayer(player) then
            table.insert(result,player)
        end
    end
    return result
end

function HitCheckManager:getRelativeCrossTarget(targetPlayer,enemyPlayerList)
    local result = {}
    local row = targetPlayer:getPlayerInfo():getGridX()
    local col = targetPlayer:getPlayerInfo():getGridY()

    for i=row-1,row+1 do
        for j=col-1,col+1 do
            if i > 0 and j > 0 and i <= BattleConfig.ROW_COUNT and j <= BattleConfig.COL_COUNT then
                if i == row or j == col then
                    local player = enemyPlayerList:getPlayer(i,j)
                    if self:validatePlayer(player) then
                        table.insert(result,player)
                    end   
                end
            end
        end
    end

    return result
end

function HitCheckManager:getAbsoluteFullScreen(targetPlayer,enemyPlayerList)
    local result = {}
    
    if enemyPlayerList["getPlayerList"] == nil then
        local a = a
    end
    
    for i = 1, #enemyPlayerList:getPlayerList() do
        local player = enemyPlayerList:getPlayerList()[i]
        if self:validatePlayer(player) then
            table.insert(result,player)
        end   
    end
    
    return result
end

function HitCheckManager:getRandomArray(maxNum)
    local listNum = {}
    for i = 1, maxNum do
        listNum[i] = i
    end
    
    for i = 1, maxNum do
        local randomIndex = math.random(1,maxNum)
        local temp = listNum[i]
        listNum[i] = listNum[randomIndex]
        listNum[randomIndex] = temp       
    end
    
    return listNum
end

function HitCheckManager:validatePlayer(player)
    if player == nil or player:getIsDeath() == true then
        return false
    end

    return true
end
