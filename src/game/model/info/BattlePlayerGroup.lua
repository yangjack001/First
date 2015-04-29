require("game/config/BattleConfig")
require("game/type/TargetType")

BattlePlayerGroup = class("BattlePlayerGroup")

function BattlePlayerGroup.create(group)
    local list = BattlePlayerGroup:new()
    list:init()
    list._group = group
    return list
end

BattlePlayerGroup._group = nil
BattlePlayerGroup._listPlayer = nil
BattlePlayerGroup._mapPlayer = nil
BattlePlayerGroup._mapTargetTypeToCol = {
    [TargetType.ENEMY_FIRST_ROW]=1,
    [TargetType.ENEMY_SECOND_ROW]=2,
    [TargetType.ENEMY_THIRD_ROW]=3,
    [TargetType.SELF_FIRST_ROW]=1,
    [TargetType.SELF_SECOND_ROW]=2,
    [TargetType.SELF_THIRD_ROW]=3
}

function BattlePlayerGroup:init()
    self._listPlayer = {}
    self._mapPlayer = {}
    
    for i=1,BattleConfig.ROW_COUNT do
        self._mapPlayer[i] = {}
    end
end

function BattlePlayerGroup:getPlayerList()
    return self._listPlayer
end

function BattlePlayerGroup:addPlayer(player)
    table.insert(self._listPlayer,player)
    local row = player:getPlayerInfo():getGridX()
    local col = player:getPlayerInfo():getGridY()
    if self._mapPlayer[row][col] ~= nil then
        local a = a
    end
    self._mapPlayer[row][col] = player
end

function BattlePlayerGroup:removePlayer(player)
    TableUtil.remove(self._listPlayer,player)
    local row = player:getPlayerInfo():getGridX()
    local col = player:getPlayerInfo():getGridY()
    self._mapPlayer[row][col] = nil
end

function BattlePlayerGroup:getRandomPlayer()
    local random = math.random(1,#self._listPlayer)
    return self._listPlayer[random]
end

function BattlePlayerGroup:getPlayer(row, col)
    if row > BattleConfig.ROW_COUNT or col > BattleConfig.COL_COUNT then
        return nil
    end
    
    return self._mapPlayer[row][col]
end

function BattlePlayerGroup:getRandomEmptyGrid()
    local result = {}
    for i=1,BattleConfig.ROW_COUNT do
        for j=1,BattleConfig.COL_COUNT do
            if self._mapPlayer[i][j] == nil then
                table.insert(result,{i,j})
            end
        end
    end
    
    local random = math.random(1,#result)
    return result[random]
end

function BattlePlayerGroup:getPlayerByIndex(index)
    return self._listPlayer[index]
end

function BattlePlayerGroup:getPlayerByTypeId(playerTypeId)
    for i = 1, #self._listPlayer do
        if self._listPlayer[i]:getPlayerInfo():getTypeId() == playerTypeId then
            return self._listPlayer[i]
        end
    end
end

function BattlePlayerGroup:getPlayerCount()
    return #self._listPlayer
end

function BattlePlayerGroup:getGroup()
    return self._group
end

---- 首先寻找当前列，目标行，然后一次忘后一行找，最后在倒回来
function BattlePlayerGroup:getTargetPlayer(type, col)
    local aliveList = {}
    for i = 1, #self._listPlayer do
        local player = self._listPlayer[i]
        if self:validatePlayer(player) then
            table.insert(aliveList,player)
        end
    end
    if type == TargetType.ENEMY_RANDOM or type == TargetType.SELF_RANDOM then
        return aliveList[math.random(1,#aliveList)]
    elseif type== TargetType.SELF_TEAM or type == TargetType.ENEMY_TEAM then
        return aliveList
    else
        local row = self._mapTargetTypeToCol[type]
        for i=row,BattleConfig.ROW_COUNT do
            local player = self._mapPlayer[i][col]
            if self:validatePlayer(player) then
                return player
            end
            
            for j = 1,BattleConfig.COL_COUNT do
                local player = self._mapPlayer[i][j]
                if self:validatePlayer(player) then
                    return player
                end
            end
        end
        
        for i=row - 1, 1, -1 do
            local player = self._mapPlayer[i][col]
            if self:validatePlayer(player) then
                return player
            end
            
            for j=1,BattleConfig.COL_COUNT do
                local player = self._mapPlayer[i][j]
                if self:validatePlayer(player) then
                    return player
                end
            end
        end
    end
end

function BattlePlayerGroup:validatePlayer(player)
    if player == nil or player:getIsDeath() == true then
        return false
    end

    return true
end

function BattlePlayerGroup:getIsAllDeath()
    for i = 1, #self._listPlayer do
        local player = self._listPlayer[i]
        if not player:getIsDeath() then
            return false
        end
    end
    
    return true
end