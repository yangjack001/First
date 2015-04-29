require("game/model/info/battlescriptarg/InitDefaultPlayerScriptArg")
require("game/model/info/battlescriptarg/MovePlayerScriptArg")
require("game/model/info/battlescriptarg/ShowNPCPanelScriptArg")

BattleScriptArgFactory = class("BattleScriptArgFactory")

BattleScriptArgFactory._typeToCls = {
    [BattleScriptType.INIT_DEFAULT_PLAYER] = InitDefaultPlayerScriptArg,
    [BattleScriptType.MOVE_PLAYER] = MovePlayerScriptArg,
    [BattleScriptType.SHOW_NPC_PANEL] = ShowNPCPanelScriptArg
}

function BattleScriptArgFactory.getArgByType(type)
    if BattleScriptArgFactory._typeToCls[type] ~= nil then
        return BattleScriptArgFactory._typeToCls[type].create()
    else
        error(StringManager.getString(StringKey.BATTLE_SCRIPT_TYPE_ERROR,type))
    end
end