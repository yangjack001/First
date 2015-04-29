ShowNPCPanelScript = class("ShowNPCPanelScript",function()
    return BaseBattleScript.create()
end)

function ShowNPCPanelScript.create()
    local script = ShowNPCPanelScript:new()
    script:init()
    return script
end

function ShowNPCPanelScript:init()
    self._type = BattleScriptType.SHOW_NPC_PANEL
end

function ShowNPCPanelScript:excute(showNPCPanelScriptArg, callback)
    self._callback = callback

    local npcTalkInfo = showNPCPanelScriptArg:getNPCTalkInfo()
    SceneManager.getCurScene():getUILayer():showNPCPanel(npcTalkInfo, callback)
end