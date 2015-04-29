ForegroundLayer = class("ForegroundLayer",function()
    return cc.Layer:create()
end)

function ForegroundLayer.create()
    local layer = ForegroundLayer:new()
    layer:init()
    return layer
end

function ForegroundLayer:init()

end

