require("game/player/avatar/BaseAvatar")
require("game/manager/AnimationManager")

RemoteEffectAvatar = class("RemoteEffectAvatar",function()
    return BaseAvatar.create()
end)

function RemoteEffectAvatar.create(effectId)
    local avatar = RemoteEffectAvatar:new()
    avatar:init(effectId)
    return avatar
end

function RemoteEffectAvatar:init(effectId)
    self:loadBody(effectId)
    self:addAnimationEvent()
end

function RemoteEffectAvatar:loadBody(effectId)
    self._armature = AnimationManager.getRemoteEffectSkeleton(effectId)
    self:addChild(self._armature)
end

function RemoteEffectAvatar:addAnimationEvent()
    local animationEvent = function(armatureNode, movementType, movementID, isLastMovementId)
        print(armatureNode, movementType, movementID, isLastMovementId)
        if movementType == 7 then
            local evt = cc.EventCustom:new(AvatarEvent.ANIMATION_COMPLETE)
            evt.animation = movementID
            evt.avatar = self
            self:getEventDispatcher():dispatchEvent(evt)  
        end
    end

    self._armature:registerMovementEventHandler(animationEvent)
end

function RemoteEffectAvatar:playAnimation(animationName, isLoop)
    if isLoop then
        self._armature:getAnimation():gotoAndPlay(animationName,-1,-1,99999)
    else 
        self._armature:getAnimation():gotoAndPlay(animationName,-1,-1,1)
    end

end

function RemoteEffectAvatar:dispose()
    self._armature:dispose()
end