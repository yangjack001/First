require("game/model/info/PlayerInfo")
require("game/config/PlayerInfoConfig")

FormationDataManager = class("FormationDataManager")

FormationDataManager._myPlayerInfoList = nil

function FormationDataManager:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function FormationDataManager:getInstance()
    if self.instance == nil then
        self.instance = self:new()
        self:init()
    end
    return self.instance
end

function FormationDataManager:init()
    local myPlayerData = {{1,2,1},{2,2,2}}
--    local myPlayerData = {{1,1,1}}
    self._myPlayerInfoList = {}
    
    
    for i = 1, #myPlayerData do
        local playerId = myPlayerData[i][1]
        local player = nil
        if playerId then
            local playerInfo = PlayerInfoConfig.getPlayerInfoById(playerId):clone()
            playerInfo:setGridX(myPlayerData[i][2])
            playerInfo:setGridY(myPlayerData[i][3])
            playerInfo:setIsAuto(false)
            table.insert(self._myPlayerInfoList,playerInfo)
        end
    end
end

function FormationDataManager:getMyPlayerInfoList()
    return self._myPlayerInfoList
end
