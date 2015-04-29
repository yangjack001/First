require("game/battlefield/Battle")
require("game/event/BattleEventDispatcher")
require("game/event/BattleEvent")
require("game/ui/battle/bonus/BattleFieldBonusPanel")
require("game/model/FormationDataManger")

BattleField = class("BattleField")

function BattleField.create(battleFieldInfo)
    local battleField = BattleField:new()
    battleField:init(battleFieldInfo)
    return battleField
end

BattleField._battleFieldInfo = nil
BattleField._curBattleContext = nil
BattleField._curBattleIndex = nil
BattleField._curBattle = nil
BattleField._curBattleInfo = nil

function BattleField:init(battleFieldInfo)
    self._battleFieldInfo = battleFieldInfo
end

function BattleField:startFirstBattle()
    self._curBattleIndex = 0
    FormationDataManager:getInstance():init()
    self:startNextBattle()
end

function BattleField:startNextBattle()
    self._curBattleIndex = self._curBattleIndex + 1
    self._curBattleInfo = self._battleFieldInfo:getListBattleInfo()[self._curBattleIndex]
    
    self._curBattle = Battle.create(self._curBattleInfo)
    
    local function onFinishBattle(evt)
        self._curBattle:getEventDispatcher():removeEventListener(BattleEvent.BATTLE_END, onFinishBattle)
        print("battle end")
        if self._curBattleIndex >= #self._battleFieldInfo:getListBattleInfo() then
            self:playWinAction()
            ScheduleUtil:getInstance():addTimeSchedule(1,function()
                SceneManager.getCurScene():getUILayer():showBonusPanel()
            end)
        else
            if self._curBattle:getBattleContext():getIsBattleFailed() then
                ScheduleUtil:getInstance():addTimeSchedule(1,function()
                    SceneManager.getCurScene():getUILayer():showBonusPanel()
                end)
            else
                self:startNextBattle()
            end
        end
    end

    self._curBattle:getEventDispatcher():addEventListener(BattleEvent.BATTLE_END, onFinishBattle)
end

function BattleField:playWinAction()
    local leftPlayers = self._curBattle:getBattleContext():getLeftPlayerGroup():getPlayerList()
    for i = 1,#leftPlayers do
        local player = leftPlayers[i]
        player:doAction(ActionType.WIN)
    end
end

function BattleField:getCurBattle()
    return self._curBattle
end

function BattleField:getCurBattleIndex()
    return self._curBattleIndex
end

function BattleField:getBattleCount()
    return #self._battleFieldInfo:getListBattleInfo()
end