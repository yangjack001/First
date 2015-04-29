PlayerInfoConfig = {}

PlayerInfoConfig._data = {
    {playerId = 1, typeId = PlayerTypeID.MO_LI_SHA, att = 100, def = 20, hp = 6000, energy = 50, maxEnergy = 100, speed = 20},
    {playerId = 2, typeId = PlayerTypeID.LING_MENG, att = 150, def = 20, hp = 8200, energy = 100, maxEnergy = 100, speed = 20},
    
    {playerId = 3, typeId = PlayerTypeID.YAO_JING_NV_PU, att = 70, def = 20, hp = 1500, energy = 50, maxEnergy = 100, speed = 20},
    {playerId = 4, typeId = PlayerTypeID.SHI_LIU_YE, att = 180, def = 20, hp = 3000, energy = 50, maxEnergy = 100, speed = 20},
    
    {playerId = 5, typeId = PlayerTypeID.LEIMI, att = 60, def = 20, hp = 5000, energy = 50, maxEnergy = 100, speed = 20},
    {playerId = 6, typeId = PlayerTypeID.FULAN, att = 80, def = 20, hp = 6000, energy = 50, maxEnergy = 100, speed = 20},
}

PlayerInfoConfig._listPlayerInfo = nil

function PlayerInfoConfig.init()
    PlayerInfoConfig._listPlayerInfo = {}
    for i = 1, #PlayerInfoConfig._data do
        local playerInfo = PlayerInfo.create()
        playerInfo:parse(PlayerInfoConfig._data[i])
        PlayerInfoConfig._listPlayerInfo[playerInfo:getId()] = playerInfo
    end
end

function PlayerInfoConfig.getPlayerInfoById(id)
    if PlayerInfoConfig._listPlayerInfo == nil then
        PlayerInfoConfig.init()
    end
    
    if PlayerInfoConfig._listPlayerInfo[id] == nil then
        error(StringManager.getString(StringKey.PLAYER_ID_ERROR, id))
    else
        return PlayerInfoConfig._listPlayerInfo[id]
    end
end