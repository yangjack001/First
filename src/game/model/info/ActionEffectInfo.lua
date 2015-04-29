ActionEffectInfo = class("ActionEffectInfo")

function ActionEffectInfo.create(id)
    local effect = ActionEffectInfo:new()
    effect:init(id)
    return effect
end

ActionEffectInfo._id = nil
ActionEffectInfo._layerType = nil
ActionEffectInfo._offsetX = nil
ActionEffectInfo._offsetY = nil

function ActionEffectInfo:init(id)
    self._id = id
    self._offsetX = 0
    self._offsetY = 0
end

function ActionEffectInfo:parse(data)
    self._layerType = data.layerType
    
    if data.offsetX ~= nil then
        self._offsetX = data.offsetX
    end
    
    if data.offsetY ~= nil then
        self._offsetY = data.offsetY
    end
    
end

function ActionEffectInfo:getId()
    return self._id
end

function ActionEffectInfo:getOffsetX()
    return self._offsetX
end

function ActionEffectInfo:getOffsetY()
    return self._offsetY
end

function ActionEffectInfo:getLayerType()
    return self._layerType
end