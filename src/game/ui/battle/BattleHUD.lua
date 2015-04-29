require("game/manager/SceneManager")
require("game/ui/battle/hud/BattleHUDPlayerStateComponent")
require("game/ui/battle/hud/BattleHUDCPComponent")
require("game/config/CPSkillConfig")
require("game/event/HitEvent")

BattleHUD = class("BattleHUD",function()
    return cc.Layer:create()
end)

HEAD_COUNT = 5
CP_COUNT = 1

function BattleHUD.create(battleScene)
    local hud = BattleHUD:new()
    hud:init(battleScene)
    return hud
end

BattleHUD._battleScene = nil
BattleHUD._listPlayerStateComponent = nil
BattleHUD._listCPComponent = nil
BattleHUD._onHitEvent = nil
BattleHUD._txtRound = nil
BattleHUD._btnQuit = nil

function BattleHUD:init(battleScene)
    self._battleScene = battleScene
    self:initComponent()
    self:addEvent()    
end

function BattleHUD:initComponent()
    local loader = cc.CSLoader:createNode("res/ui/battlefield/hud.csb")
    self:addChild(loader)
    self._listPlayerStateComponent = {}
    self._listCPComponent = {}
    local playerManager = self._battleScene:getPlayerManager()
    local controlPlayerGroup = playerManager:getLeftPlayerGroup()
    local playerInfoList = FormationDataManager:getInstance():getMyPlayerInfoList()
    for i = 1, HEAD_COUNT do
        local headBg = loader:getChildByName("sp_head_bg_" .. tostring(i))
        headBg:setLocalZOrder(2)
        local head = loader:getChildByName("sp_head_" .. tostring(i))
        head:setLocalZOrder(3)
        local headFore = loader:getChildByName("sp_head_fore_" .. tostring(i))
        headFore:setLocalZOrder(4)
        
        local progressBg = loader:getChildByName("sp_progressBg_" .. tostring(i))
        progressBg:setLocalZOrder(5)
        local progressBBg = loader:getChildByName("sp_progress_b_bg_" .. tostring(i))
        progressBBg:setLocalZOrder(6)  
        local bloodProgress = loader:getChildByName("sp_bloodProgress_"..tostring(i))
        local energyProgress = loader:getChildByName("sp_energyProgress_"..tostring(i))

        local component = BattleHUDPlayerStateComponent.create(playerInfoList[i], head, headBg, energyProgress, bloodProgress)

        table.insert(self._listPlayerStateComponent,component)
    end
    
    local exsitCPSkillInfoList = self:getExitCPSkill(controlPlayerGroup:getPlayerList())

    for i = 1, CP_COUNT do
        local spCp = loader:getChildByName("sp_cp_" .. tostring(i))
        spCp:setLocalZOrder(10)  
        local cpComponent = BattleHUDCPComponent.create(spCp, exsitCPSkillInfoList[i], controlPlayerGroup)
        table.insert(self._listCPComponent, cpComponent)
    end
    
    self._txtRound = loader:getChildByName("txt_round")
    self._txtRound:setString(string.format("%d/%d",BattleFieldManager.getCurBattleField():getCurBattleIndex() , BattleFieldManager.getCurBattleField():getBattleCount()))
    
    local spQuit = loader:getChildByName("sp_quit")
    loader:removeChild(spQuit)
    self._btnQuit = SimpleButton.create(spQuit,function()
        SceneManager.getCurScene():getUILayer():showBonusPanel()
    end,spQuit:getPositionX(), spQuit:getPositionY())
    spQuit:setPosition(0,0)
    loader:addChild(self._btnQuit)
end

function BattleHUD:addEvent()
    self._onHitEvent = function(evt)
        self:updatePlayer(evt:getDamageResult():getAttPlayer())
        self:updatePlayer(evt:getDamageResult():getDefPlayer())
    end
    
    HitManager.getEventDispatcher():addEventListener(HitEvent.ON_HIT_FINISH, self._onHitEvent)
end

function BattleHUD:removeEvent()
    HitManager.getEventDispatcher():removeEventListener(HitEvent.ON_HIT_FINISH, self._onHitEvent)
end

function BattleHUD:getExitCPSkill(playerGroup)
    local playerTypeIds = {}
    for i = 1, #playerGroup do
        table.insert(playerTypeIds,playerGroup[i]:getPlayerInfo():getTypeId())
    end
    
    local result = {}
    
    local cpSkillInfoList = CPSkillConfig.getSkillInfoData()
    for i = 1, #cpSkillInfoList do
        local cpSkillInfo = cpSkillInfoList[i]
        if cpSkillInfo:canMatch(playerTypeIds) then
            table.insert(result, cpSkillInfo)
        end
    end
    
    return result
end

function BattleHUD:updatePlayer(player)
    for i = 1, #self._listPlayerStateComponent do
        self._listPlayerStateComponent[i]:update(player)
    end
end

function BattleHUD:dispose()
    self:removeEvent()
end