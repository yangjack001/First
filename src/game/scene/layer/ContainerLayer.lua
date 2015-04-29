require("game/config/GameConfig")
require("game/type/SceneLayerType")

ContainerLayer = class("ContainerLayer", function()
    return cc.Layer:create()
end)

function ContainerLayer.create(scene)
    local layer = ContainerLayer:new()
    layer:init(scene)
    return layer
end

ContainerLayer.GRAY_MASK_Z_INDEX = 10000

ContainerLayer._scene = nil
ContainerLayer._isDepthSortOn = nil
ContainerLayer._grayMaskLayer = nil

function ContainerLayer:init(scene)
    self._isDepthSortOn = false
    self._scene = scene
end

------ 深度排序
--@param
--@return
function ContainerLayer:depthSort()
    local listChildren = self:getChildren()
    for i = 1, self:getChildrenCount() do
        local child = listChildren[i]
        self:reorderChild(child,VISIBLE_SIZE.height - child:getPositionY())
    end
end

function ContainerLayer:onTick(t)
    if not self._isDepthSortOn then
        return
    end
    
    self:depthSort()
end

function ContainerLayer:show()
    self._scene:addChild(self,SceneLayerType.CONTAINER)
    self:startDepthSort()
end

function ContainerLayer:hide()
    self._scene:removeChild(self)
end

function ContainerLayer:stopDepthSort()
    self._isDepthSortOn = false
end

function ContainerLayer:startDepthSort()
    self._isDepthSortOn = true
end

function ContainerLayer:addGrayMask(alpha)
    self:removeGrayMask()
    self:initGrayMask(alpha)
    
    self:addChild(self._grayMaskLayer, ContainerLayer.GRAY_MASK_Z_INDEX)
end

function ContainerLayer:removeGrayMask()
    if self._grayMaskLayer ~= nil then
        self:removeChild(self._grayMaskLayer)
        self._grayMaskLayer = nil
    end
end

function ContainerLayer:initGrayMask(alpha)
    self._grayMaskLayer = cc.LayerColor:create(cc.c4b(0,0,0,alpha))
end

function ContainerLayer:setFocus(child)
    self:reorderChild(child,VISIBLE_SIZE.height - child:getPositionY() + ContainerLayer.GRAY_MASK_Z_INDEX)
end