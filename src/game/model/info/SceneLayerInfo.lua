SceneLayerInfo = class("SceneLayerInfo")

function SceneLayerInfo.create(id)
    local info = SceneLayerInfo:new()
    info:init(id)
    return info
end

SceneLayerInfo._id = nil
SceneLayerInfo._zOrder = nil
SceneLayerInfo._x = nil
SceneLayerInfo._y = nil
SceneLayerInfo._width = nil
SceneLayerInfo._height = nil
SceneLayerInfo._speed = nil
SceneLayerInfo._fileUrl = nil

function SceneLayerInfo:init(id)
    self._id = id
    self._x = 0
    self._y = 0
end

function SceneLayerInfo:parse(data)
    self._zOrder = data.zOrder
    self._width = data.width
    self._height = data.height
    self._fileUrl = data.fileUrl
    self._speed = data.speed
    if data.x ~= nil then
        self._x = data.x
    end
    
    if data.y ~= nil then
        self._y = data.y
    end
end

function SceneLayerInfo:getId()
    return self._id
end

function SceneLayerInfo:getZOrder()
    return self._zOrder
end

function SceneLayerInfo:getX()
    return self._x
end

function SceneLayerInfo:getY()
    return self._y
end

function SceneLayerInfo:getWidth()
    return self._width
end

function SceneLayerInfo:getHeight()
    return self._height
end

function SceneLayerInfo:getFileUrl()
    return self._fileUrl
end

function SceneLayerInfo:getSpeed()
    return self._speed
end