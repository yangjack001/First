require("game/model/info/battlescriptarg/BattleScriptArgFactory")

BattleScriptInfo = class("BattleScriptInfo")
    
function BattleScriptInfo.create(battleId)
    local info = BattleScriptInfo:new()
    info:init(battleId)
    return info
end

BattleScriptInfo._battleId = nil
BattleScriptInfo._listActScriptArg = nil

function BattleScriptInfo:init(battleId)
    self._battleId = battleId
end

function BattleScriptInfo:parse(data)
    self._listActScriptArg = {}
    
    for eventType, scripts in pairs(data) do
        local listScriptArg = {}
        for i=1,#scripts do
            local groupScript = scripts[i]
            local listGroupScript = {}
            for j=1,#groupScript do
                local scriptType = groupScript[j].type
                local scriptArg = BattleScriptArgFactory.getArgByType(scriptType)
                scriptArg:parse(groupScript[j])
                table.insert(listGroupScript,scriptArg)
            end
            table.insert(listScriptArg,listGroupScript)
        end
        
        self._listActScriptArg[eventType] = listScriptArg
    end
end

function BattleScriptInfo:getScriptsByEventType(eventType)
    return self._listActScriptArg[eventType]
end

function BattleScriptInfo:getBattleId()
    return self._battleId
end