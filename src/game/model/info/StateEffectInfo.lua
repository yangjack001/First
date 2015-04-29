StateEffectInfo = class("StateEffectInfo")

function StateEffectInfo.create(id)
    local info = StateEffectInfo:new()
    info:init(id)
    return info
end

StateEffectInfo._id = nil
StateEffectInfo._layerType = nil

function StateEffectInfo:init(id)
    self._id = id
end

function StateEffectInfo:parse(data)
    self._layerType = data.layerType
end

function StateEffectInfo:getId()
    return self._id
end

function StateEffectInfo:getLayerType()
    return self._layerType
end