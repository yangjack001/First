EffectLayer = class("EffectLayer",function()
    return cc.Sprite:create()
end)

function EffectLayer.create()
    local layer = EffectLayer:new()
    layer:init()
    return layer
end

function EffectLayer:init()

end