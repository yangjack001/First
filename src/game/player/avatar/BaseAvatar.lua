require("game/event/AvatarEvent")

BaseAvatar = class("BaseAvatar",function()
    return cc.Sprite:create()
end)

function BaseAvatar.create()
    local avatar = BaseAvatar:new()
    avatar:init()
    return avatar
end

BaseAvatar.__index = BaseAvatar

BaseAvatar._armature = nil
BaseAvatar._eventDispatcher = nil

function BaseAvatar:init()
    self:setCascadeOpacityEnabled(true)
end

function BaseAvatar:addAnimationEvent()
--    self._armature:registerSpineEventHandler(function (event)
--        local evt = cc.EventCustom:new(AvatarEvent.ANIMATION_COMPLETE)
--        evt.animation = event.animation
--        evt.avatar = self
--        self:getEventDispatcher():dispatchEvent(evt)
--    end, sp.EventType.ANIMATION_COMPLETE)
    
    local animationEvent = function(armature,movementType,animationName)
        if movementType == ccs.MovementEventType.complete then
--            print("动作", animationName, "结束",os.clock())
            local evt = cc.EventCustom:new(AvatarEvent.ANIMATION_COMPLETE)
            evt.animation = animationName
            evt.avatar = self
            self:getEventDispatcher():dispatchEvent(evt)  
        end
    end
    
    self._armature:getAnimation():setMovementEventCallFunc(animationEvent)
end

function BaseAvatar:setDirection(direction)
    self:setScaleX(direction)
end

function BaseAvatar:playAnimation(animationName, isLoop)
--    print("做动作", animationName,os.clock())
    if isLoop then
        self._armature:getAnimation():play(animationName, -1, 1)
    else 
        self._armature:getAnimation():play(animationName, -1, -1)
    end
end

function BaseAvatar:pauseAvatar()
    self._armature:pause()
end

function BaseAvatar:resumeAvatar()
    self._armature:resume()
end

function BaseAvatar:getArmature()
    return self._armature
end

function BaseAvatar:dispose()

end