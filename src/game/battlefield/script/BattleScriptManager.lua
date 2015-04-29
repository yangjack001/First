require("game/config/BattleScriptConfig")
require("game/battlefield/script/script/BattleScriptFactory")
BattleScriptManager = class("BattleScriptManager")

function BattleScriptManager.create(battle)
    local manager = BattleScriptManager:new()
    manager:init(battle)
    return manager
end

BattleScriptManager._battle = nil
BattleScriptManager._battleScriptInfo = nil
BattleScriptManager._listScriptArg = nil
BattleScriptManager._scriptMap = nil
BattleScriptManager._callback = nil
BattleScriptManager._scriptIndex = nil

function BattleScriptManager:init(battle)
    self._battle = battle
    self._scriptMap = {}
    local battleId = battle:getBattleInfo():getId()
    self._battleScriptInfo = BattleScriptConfig.getBattleScriptById(battleId)
end

function BattleScriptManager:runScript(eventType, callback)
    self._listScriptArg = self._battleScriptInfo:getScriptsByEventType(eventType)
    
    self._callback = callback
    self._scriptIndex = 1
    self:runNextGroupScript()
end

function BattleScriptManager:runNextGroupScript()
    if self._listScriptArg == nil or self._scriptIndex > #self._listScriptArg then
        self._callback()
        return
    end

    local groupScriptArg = self._listScriptArg[self._scriptIndex]
    self._scriptIndex = self._scriptIndex + 1
    
    local totalGroupScriptArg = #groupScriptArg
    for i=1, #groupScriptArg do
        local scriptArg = groupScriptArg[i]
        local scriptType = scriptArg:getType()
        if self._scriptMap[scriptType] == nil then
            self._scriptMap[scriptType] = BattleScriptFactory.getScriptByType(scriptType)
        end

        self._scriptMap[scriptType]:excute(scriptArg, function()
            totalGroupScriptArg = totalGroupScriptArg - 1
            
            if totalGroupScriptArg <= 0 then
                self:runNextGroupScript()
            end
        end)
    end
end