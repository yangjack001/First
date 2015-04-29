require("game/manager/PlayerManager")
require("game/manager/RemoteEffectManager")
require("game/battlefield/Battle")
require("game/manager/ManualSkillManager")
require("game/manager/CPSkillManager")
require("game/scene/layer/ContainerLayer")
require("game/scene/layer/EffectLayer")
require("game/scene/layer/ForegroundLayer")
require("game/scene/layer/BackgroundLayer")
require("game/scene/layer/BattleUILayer")
require("game/config/BattleConfig")
require("game/battlefield/battle/context/BattleContext")
require("game/util/schedule/ScheduleUtil")
require("game/type/SceneLayerType")
require("game/config/SceneConfig")
require("game/event/SceneEvent")

local BattleScene = class("BattleScene", function()
    return cc.Scene:create()
end)

function BattleScene.createScene(id, battle)
    local scene = BattleScene:new()
    scene:init(id, battle)
    return scene
end

BattleScene._battle = nil

BattleScene._bgLayer = nil
BattleScene._containerLayer = nil
BattleScene._effectlayer = nil
BattleScene._foregroundLayer = nil
BattleScene._uiLayer = nil


BattleScene._playerManager = nil
BattleScene._remoteEffectManager = nil
BattleScene._battle = nil
BattleScene._manualSkillManager = nil
BattleScene._cpSkillManager = nil

function BattleScene:init(id, battle)
    self._battle = battle
    
    self._bgLayer = BackgroundLayer.create()
    self:addChild(self._bgLayer, SceneLayerType.BACKGROUND)
    
    self._containerLayer = ContainerLayer.create(self)
    self._containerLayer:show()
    
    self._effectlayer = EffectLayer.create()
    self:addChild(self._effectlayer, SceneLayerType.EFFECT)
    
    self._foregroundLayer = ForegroundLayer.create()
    self:addChild(self._foregroundLayer, SceneLayerType.FOREGROUND)
    
    self._uiLayer = BattleUILayer.create(self)
    self._uiLayer:show()
    
    self:initSchedule()
    
    local txtLoading = cc.Label:createWithSystemFont("Loading","黑体",40)
    self:addChild(txtLoading)
    txtLoading:setPosition(cc.p(VISIBLE_SIZE.width / 2, VISIBLE_SIZE.height / 2))
    
    ScheduleUtil:getInstance():addFrameSchedule(1,function()
        local startTime = os.clock()
        self:loadBattle(id)
        self:removeChild(txtLoading)
        ScheduleUtil:getInstance():addFrameSchedule(1,function()
            self:initMananger()
        end)
    end)
end

function BattleScene:initMananger()
    self._playerManager = PlayerManager.create(self)
    self._remoteEffectManager = RemoteEffectManager.create(self._effectlayer)
    self._cpSkillManager = CPSkillManager.create(self)
    self._manualSkillManager = ManualSkillManager.create(self)

    local evt = cc.EventCustom:new(SceneEvent.ON_INITED)
    self:getEventDispatcher():dispatchEvent(evt)  
end

function BattleScene:initSchedule()
    self:scheduleUpdateWithPriorityLua(function(t)
        ScheduleUtil:getInstance():onTick(t)
        if self._playerManager ~= nil then
            self._playerManager:onTick(t)
        end
        if self._remoteEffectManager ~= nil then
            self._remoteEffectManager:onTick(t)
        end
        self._containerLayer:onTick(t)
        self._uiLayer:onTick(t)
    end, 0) 
end

function BattleScene:loadBattle(id)
    local sceneInfo = SceneConfig.getSceneInfoById(id)
    self._bgLayer:setSubLayerInfo(sceneInfo:getListBackgroundLayer())
end

function BattleScene:getPlayerManager()
    return self._playerManager
end

function BattleScene:getRemoteEffectManager()
    return self._remoteEffectManager
end

function BattleScene:getBattle()
    return self._battle
end

function BattleScene:getCPSkillManager()
    return self._cpSkillManager
end

function BattleScene:getContainerLayer()
    return self._containerLayer
end

function BattleScene:getEffectLayer()
    return self._effectlayer
end

function BattleScene:getForegroundLayer()
    return self._foregroundLayer
end

function BattleScene:getUILayer()
    return self._uiLayer
end

function BattleScene:getIsFocus()
    return self._manualSkillManager:getIsFocus()
end

function BattleScene:getManualSkillManager()
    return self._manualSkillManager
end

function BattleScene:getBattle()
    return self._battle
end

function BattleScene:dispose()
    self._uiLayer:dispose()
end

return BattleScene