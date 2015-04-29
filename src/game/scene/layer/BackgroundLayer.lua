require("game/scene/layer/SceneSubLayer")
BackgroundLayer = class("BackgroundLayer", function()
    return cc.Layer:create()
end)

BackgroundLayer._listLayer = nil

function BackgroundLayer.create()
    local layer = BackgroundLayer:new()
    layer:init()
    return layer
end

function BackgroundLayer:init()
    self._listLayer = {}
end

function BackgroundLayer:setSubLayerInfo(listLayerInfo)
    self:removeAllChildren()
    for i = 1, #listLayerInfo do
        local layerInfo = listLayerInfo[i]
        local subLayer = SceneSubLayer.create(layerInfo)
        self:addChild(subLayer, layerInfo:getId())
        table.insert(self._listLayer,subLayer)
    end
    
    schedule(self,function()
        self:onTick()
    end,0.05)
end

function BackgroundLayer:onTick(t)
    for i = 1, #self._listLayer do
        self._listLayer[i]:onTick(t)
    end
end