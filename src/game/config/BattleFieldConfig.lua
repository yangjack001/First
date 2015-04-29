require("game/model/info/BattleFieldInfo")

BattleFieldConfig = class("BattleFieldConfig")

BattleFieldConfig._data = {
    [1] = {
        battleList = {
            {
                id=1,
                sceneId=1,
                playerConfig={{5,2,2},{6,2,3}}
            },
            {
                id=2,
                sceneId=2,
                playerConfig={{3,2,1},{3,3,1},{4,3,2},{3,2,3},{3,3,3}}
            },
            {
                id=3,
                sceneId=3,
                playerConfig={{5,2,2},{6,2,3}}
            }
        }
--        battleList = {
--            {
--                id=1,
--                sceneId=1,
--                playerConfig={{1,1,1}}
--            },
--        }
    }
}

BattleFieldConfig._battleFieldData = nil

function BattleFieldConfig.init()
    BattleFieldConfig._battleFieldData = {}
    
    for battleFieldId, battleFieldData in pairs(BattleFieldConfig._data) do
        local battleFieldInfo = BattleFieldInfo.create(battleFieldId)
        battleFieldInfo:parse(battleFieldData)
        BattleFieldConfig._battleFieldData[battleFieldId] = battleFieldInfo
    end
end

function BattleFieldConfig.getBattleFieldById(id)
    if BattleFieldConfig._battleFieldData == nil then
        BattleFieldConfig.init()
    end
    
    if BattleFieldConfig._data == nil then
        error(StringManager.getString(StringKey.BATTLE_FIELD_ID_ERROR,id))
    else
        return BattleFieldConfig._battleFieldData[id]
    end
end