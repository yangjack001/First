require("game.config.SafeAreaConfig")
require("game/manager/PlayerManager")
require("game/scene/layer/BackgroundLayer")
require("game/scene/layer/ContainerLayer")
require("game/player/Player")

SafetyScene = class("SafeScene", function()
    return cc.Scene:create()
end)

function SafetyScene.createScene(name)
    local scene = SafetyScene:new()
    scene:init(name)
    return scene
end

SafetyScene._sceneWidth = nil
SafetyScene._sceneHeight = nil
SafetyScene._bgLayer = nil
SafetyScene._containerLayer = nil
SafetyScene._uiLayer = nil

SafetyScene._playerManager = nil

function SafetyScene:init(name)
    self._bgLayer = BackgroundLayer.createLayer()
    self:addChild(self._bgLayer)
    
    self._containerLayer = ContainerLayer.createLayer()
    self:addChild(self._containerLayer)
    
    self._uiLayer = UILayer.create()
    self:addChild(self._uiLayer)
    
    loadSafeArea(name)
    
    self._playerManager = PlayerManager.create(container)
end

function SafetyScene:loadSafeArea(safeAreaName)
    local config = safeAreaConfig[safeAreaName]
    self._sceneWidth = tonumber(config["width"])
    self._sceneHeight = tonumber(config["height"])
    self._bgLayer:changeFileName(tostring(config["fileName"]))
end

function BattleScene:getPlayerManager()
    return self._playerManager
end

function BattleScene:getContainerLayer()
    return self._containerLayer
end

function BattleScene:getUILayer()
    return self._uiLayer
end