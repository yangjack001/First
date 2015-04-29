SimpleButton = class("SimpleButton",function()
    return cc.Sprite:create()
end)

function SimpleButton.create(normalImage, callback, x, y)
    local btn = SimpleButton:new()
    btn:init(normalImage, callback, x, y)
    return btn
end

SimpleButton._normalImage = nil
SimpleButton._callback = nil
SimpleButton._enable = nil

function SimpleButton:init(normalImage, callback, x, y)
    self._normalImage = normalImage
    self._callback = callback
    self:setPosition(cc.p(x, y))
    self._enable = true
    
    self:initView()
    self:initEvent()
end

function SimpleButton:initView()
    self:addChild(self._normalImage)
end

function SimpleButton:initEvent()
    local eventListener = cc.EventListenerTouchOneByOne:create()
    eventListener:setSwallowTouches(true)

    eventListener:registerScriptHandler(function(touch, event)
        if not self._enable then
            return false
        end
        
        if self:isTouch(touch,event) then
            self._normalImage:setScale(1.1)
            return true
        else
            return false
        end
    end,cc.Handler.EVENT_TOUCH_BEGAN)
    
    eventListener:registerScriptHandler(function(touch, event)
        if self:isTouch(touch,event) then
            if self._callback ~= nil then
                self._callback()
            end
        end
        self._normalImage:setScale(1)
    end,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener, self)
end

function SimpleButton:isTouch(touch, event)
    local locationInNode = self._normalImage:convertToNodeSpace(touch:getLocation())
    local s = self._normalImage:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    if cc.rectContainsPoint(rect, locationInNode) then
        return true
    end
    
    return false
end

function SimpleButton:setEnable(enable)
    self._enable = enable
    
    if enable then
        
    else
        
    end
end