require("game/model/FormationDataManger")
require("game/player/Player")
require("game/type/GroupType")
require("game/util/TableUtil")
require("game/config/BattleConfig")
require("game/model/info/BattlePlayerGroup")
require("game/config/PlayerInfoConfig")

PlayerManager = class("PlayerManager")

PlayerManager._scene = nil
PlayerManager._listPlayers = nil
PlayerManager._playerIdToPlayer = nil
PlayerManager._leftPlayerGroup = nil
PlayerManager._rightPlayerGroup = nil

function PlayerManager.create(scene)
    local manager = PlayerManager:new()
    manager:init(scene)
    return manager
end

function PlayerManager:init(scene)
    self._scene = scene
    self._listPlayers = {}
    self._playerIdToPlayer = {}
    self._leftPlayerGroup = BattlePlayerGroup.create(GroupType.LEFT)
    self._rightPlayerGroup = BattlePlayerGroup.create(GroupType.RIGHT)
end

function PlayerManager:initPlayer()
    local startTime = os.clock()

    local rightPlayerConfig = self._scene:getBattle():getBattleInfo():getPlayerConfig()
    local leftPlayerData = FormationDataManager:getInstance():getMyPlayerInfoList()
    
    for i = 1, #leftPlayerData do
        local playerInfo = leftPlayerData[i]
        local player = nil
        if not playerInfo:getIsDeath() then
            local player = self:buildPlayer(playerInfo, GroupType.LEFT)
            player:setPositionX(player:getPositionX() - 600)
        end
    end

    for i = 1, #rightPlayerConfig do
        local playerId = rightPlayerConfig[i][1]
        local gridX = rightPlayerConfig[i][2]
        local gridY = rightPlayerConfig[i][3]
        local playerInfo = PlayerInfoConfig.getPlayerInfoById(playerId):clone()
        playerInfo:setGridX(gridX)
        playerInfo:setGridY(gridY)

        local player = self:buildPlayer(playerInfo,GroupType.RIGHT)
        player:setPositionX(player:getPositionX() + 600)
    end 

    print("创建全部Player所花费的时间",os.clock() - startTime)

    self:sortPlayerBySpeed()
end

function PlayerManager:buildPlayer(playerInfo,group)
    local player = Player.create(playerInfo,group)
    self._scene:getContainerLayer():addChild(player)
    table.insert(self._listPlayers,player)
    self._playerIdToPlayer[playerInfo:getId()] = player
    
    if group == GroupType.LEFT then
        self._leftPlayerGroup:addPlayer(player)
    else
        self._rightPlayerGroup:addPlayer(player)
    end
    
    return player
end

function PlayerManager:sortPlayerBySpeed()
    TableUtil.arraySort(self._listPlayers,function(playerA, playerB)
        if playerA:getPlayerInfo():getProperty().speed < playerB:getPlayerInfo():getProperty().speed then
            return -1
        else
            return 1
        end
    end)
end

function PlayerManager:pause()
    for i = 1, #self._listPlayers do
        local player = self._listPlayers[i]
        if not player:getIsFocus() then
            player:pausePlayer()
        end
    end
end

function PlayerManager:resume()
    for i = 1, #self._listPlayers do
        local player = self._listPlayers[i]
        player:resumePlayer()
    end
end

function PlayerManager:onTick(t)
    for i = 1, #self._listPlayers do
        local player = self._listPlayers[i]
        player:onTick()
    end
end

function PlayerManager:onBattleEvent(evt)
    for i = 1, #self._listPlayers do
        local player = self._listPlayers[i]
        player:onBattleEvent(evt)
    end
end

----获取当前战场的所有单位
function PlayerManager:getPlayerList()
    return self._listPlayers
end

----获取当前战场内左边单位，返回类型为BattlePlayerGroup
function PlayerManager:getLeftPlayerGroup()
    return self._leftPlayerGroup
end

----获取当前战场内右边单位，返回类型为BattlePlayerGroup
function PlayerManager:getRightPlayerGroup()
    return self._rightPlayerGroup
end

function PlayerManager:getPlayerGroup(type)
    if type == GroupType.LEFT then
        return self._leftPlayerGroup
    else
        return self._rightPlayerGroup
    end
end
function PlayerManager:getPlayerById(id)
    return self._playerIdToPlayer[id]
end