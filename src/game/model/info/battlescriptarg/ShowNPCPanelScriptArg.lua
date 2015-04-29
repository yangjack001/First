require("game/model/info/battlescriptarg/BaseBattleScriptArg")
require("game/model/info/NPCTalkInfo")
require("game/type/BattleScriptType")

ShowNPCPanelScriptArg = class("ShowNPCPanelScriptArg", function()
    return BaseBattleScriptArg.create()
end)

function ShowNPCPanelScriptArg.create()
    local arg = ShowNPCPanelScriptArg:new()
    arg:init()    
    return arg
end

ShowNPCPanelScriptArg._npcTalkInfo = nil

function ShowNPCPanelScriptArg:init()

end

function ShowNPCPanelScriptArg:parse(data)
    local npcTalkInfo = NPCTalkInfo.create()
    npcTalkInfo:parse(data)
    self._npcTalkInfo = npcTalkInfo
end

function ShowNPCPanelScriptArg:getType()
    return BattleScriptType.SHOW_NPC_PANEL
end

function ShowNPCPanelScriptArg:getNPCTalkInfo()
    return self._npcTalkInfo
end