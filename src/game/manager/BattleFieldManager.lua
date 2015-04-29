require("game/config/BattleFieldConfig")
require("game/battlefield/BattleField")

BattleFieldManager = class("BattleFieldManager")

BattleFieldManager._curBattleField = nil

function BattleFieldManager.loadBattleField(battleFieldId)
    local battleFieldInfo = BattleFieldConfig.getBattleFieldById(battleFieldId)
    local battleField = BattleField.create(battleFieldInfo)
    battleField:startFirstBattle()
    BattleFieldManager._curBattleField = battleField
end

function BattleFieldManager.getBattleEventDispatcher()
    return BattleFieldManager._curBattleField:getBattleEventDispatcher()
end

function BattleFieldManager.getCurBattleField()
    return BattleFieldManager._curBattleField
end

function BattleFieldManager.getCurBattle()
    return BattleFieldManager._curBattleField:getCurBattle()
end