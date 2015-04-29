SceneSubLayer = class("SceneSubLayer",function()
    return cc.Layer:create()
end)

function SceneSubLayer.create(layerInfo)
    local layer = SceneSubLayer:new()
    layer:init(layerInfo)
    return layer
end

SceneSubLayer.SPRITE_COUNT = 2
SceneSubLayer.LAYER_INIT_Y = 15
SceneSubLayer._layerInfo = nil
SceneSubLayer._listSprite = nil


function SceneSubLayer:init(layerInfo)
    self._layerInfo = layerInfo
    self._listSprite = {}
    self:loadFiles()
end

function SceneSubLayer:loadFiles()
    self._listSprite = {}
    
    local fileUrl = self._layerInfo:getFileUrl()
    local loopCount = SceneSubLayer.SPRITE_COUNT
    if self._layerInfo:getSpeed() == 0 then
        loopCount = 1
    end
    
    for i = 1, loopCount  do
        local sprite = cc.Sprite:create(fileUrl)
        sprite:setAnchorPoint(cc.p(0,0))
        sprite:setPositionX(self._layerInfo:getX() + (i - 1) * self._layerInfo:getWidth())
        sprite:setPositionY(self._layerInfo:getY() + SceneSubLayer.LAYER_INIT_Y * -1)
        self:addChild(sprite, self._layerInfo:getZOrder())
        table.insert(self._listSprite,sprite)
    end
end

function SceneSubLayer:onTick(t)
    if self._layerInfo:getSpeed() == 0 then
        return
    end
    
    
    for i = 1, #self._listSprite do
        local sprite = self._listSprite[i]
        sprite:setPositionX(sprite:getPositionX() - self._layerInfo:getSpeed())
        if sprite:getPositionX() <= self._layerInfo:getWidth() * -1 then
            sprite:setPositionX(sprite:getPositionX() + SceneSubLayer.SPRITE_COUNT * self._layerInfo:getWidth())
        end 
    end
end

function SceneSubLayer:getLayerInfo()
    return self._layerInfo
end

