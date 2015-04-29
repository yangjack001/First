require("game/model/info/SceneLayerInfo")

SceneInfo = class("SceneInfo")

function SceneInfo.create(id)
    local info = SceneInfo:new()
    info:init(id)
    return info
end

SceneInfo._id = nil
SceneInfo._name = nil
SceneInfo._listBackgroundLayer = nil


function SceneInfo:init(id)
    self._id = id
    self._listBackgroundLayer = {}
end

function SceneInfo:parse(data)
    self._name = data.name
    
    local backgroundLayerData = data.background
    if backgroundLayerData ~= nil then
        for i = 1, #backgroundLayerData do
            local layerInfo = SceneLayerInfo.create(i)
            layerInfo:parse(backgroundLayerData[i])
            table.insert(self._listBackgroundLayer,layerInfo)
        end
    end
end

function SceneInfo:getId()
    return self._id
end

function SceneInfo:getName()
    return self._name
end

function SceneInfo:getListBackgroundLayer()
    return self._listBackgroundLayer
end