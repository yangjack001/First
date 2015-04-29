require("game/manager/RemoteEffectManager")
require("game/type/GroupType")
require("game/config/URLConfig")

CPSkillManager = class("CPSkillManager")

function CPSkillManager.create(battleScene)
    local manager = CPSkillManager:new()
    manager:init(battleScene)
    return manager
end

CPSkillManager._battleScene = nil

function CPSkillManager:init(battleScene)
    self._battleScene = battleScene
end

function CPSkillManager:useCPSkillManager(cpSkillInfo, playerGroup)
    SceneManager.getCurScene():getUILayer():hideHUD()
    local cpSkillInfo = cpSkillInfo
    local playerList = {}
    local listTypeids = cpSkillInfo:getPlayerTypeIds()
    local listSkillKeys = cpSkillInfo:getPlayerSkillKeys()
    local enemyGroup
    if playerGroup:getGroup() == GroupType.LEFT then
        enemyGroup = self._battleScene:getPlayerManager():getRightPlayerGroup()
    else
        enemyGroup = self._battleScene:getPlayerManager():getLeftPlayerGroup()
    end
    
    for i = 1, #listTypeids do
        local player = playerGroup:getPlayerByTypeId(listTypeids[i])
        self._battleScene:getManualSkillManager():useManualSkill(player, listSkillKeys[i], true, 255)
        table.insert(playerList,player)
    end

    local targetPlayer = enemyGroup:getTargetPlayer(cpSkillInfo:getTargetType(), playerList[1]:getPlayerInfo():getGridY())
    local remoteEffectIds = cpSkillInfo:getRemoteEffectId()
    for i = 1, #remoteEffectIds do
        self._battleScene:getRemoteEffectManager():addRemoteEffect(playerList, targetPlayer, remoteEffectIds[i], 0, 0, function()
            self._battleScene:getManualSkillManager():checkDispatcherEvt()
        end)
    end
    
    self:playerCPEffect(cpSkillInfo:getId())
end

function CPSkillManager:playerCPEffect(id)
    local url = string.gsub(URLConfig.CP_EFFECT_URL,"&",tostring(id))
    local cpEffect = cc.CSLoader:createNode(url)
    local container = SceneManager.getCurScene():getForegroundLayer()
    container:addChild(cpEffect)
    cpEffect:setPositionX(-1280)
    local actionMove = cc.MoveTo:create(0.2,cc.p(0,0))
    local delayAction = cc.DelayTime:create(0.5)
    local callback = cc.CallFunc:create(function()
        container:removeChild(cpEffect)
    end)
    local fadeOut = cc.FadeOut:create(0.4)
    
    cpEffect:runAction(cc.Sequence:create(actionMove,delayAction,fadeOut,callback))
end