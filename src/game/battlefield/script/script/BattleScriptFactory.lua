require("game/battlefield/script/script/InitDefaultPlayerScript")
require("game/battlefield/script/script/MovePlayerScript")
require("game/battlefield/script/script/ShowNPCPanelScript")

BattleScriptFactory = class("BattleScriptFactory")

function BattleScriptFactory.getScriptByType(type)
    if type == BattleScriptType.INIT_DEFAULT_PLAYER then
        return InitDefaultPlayerScript.create()
    elseif type == BattleScriptType.MOVE_PLAYER then
        return MovePlayerScript.create()
    elseif type == BattleScriptType.SHOW_NPC_PANEL then
        return ShowNPCPanelScript.create()
    end
end