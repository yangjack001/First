require("game/type/DirectionType")
require("game/type/ActionType")

MoveComponent = class("MoveComponent")

MoveComponent._moveAction = nil

function MoveComponent.create(player)
    local component = MoveComponent:new()
    component._player = player
    return component
end

MoveComponent._player = nil

function MoveComponent:moveTo(x,y, callback, duration, isDoAction)
    duration = duration or 0.2
    if isDoAction == nil then
        isDoAction = true
    end
    if x == self._player:getPositionX() and y == self._player:getPositionY() then
        if callback ~= nil then
            callback()
            return
        end
    end
    
    local actionMove = cc.MoveTo:create(duration,cc.p(x,y))
    local actionCallback = cc.CallFunc:create(function()
        if callback ~= nil then
            callback()
        end
    end)

    if self._player:getPositionX() > x then
        self._player:setDirection(DirectionType.LEFT)
    elseif self._player:getPositionX() < x then
        self._player:setDirection(DirectionType.RIGHT)
    end 

    if isDoAction then
        self._player:doAction(ActionType.WALK)
    end
    
    if self._moveAction ~= nil then
        self._player:stopAction(self._moveAction)
    end

    self._moveAction = cc.Sequence:create(actionMove,actionCallback)
    self._player:getAvatar():moveTo(x,y, duration)
    
    self._player:runAction(self._moveAction)
end


function MoveComponent:cancelMove()
    self._player:stopAllActions()
    self._player:resetPosition()
    self._player:resetDirection()
end

function MoveComponent:moveBack()
    if self._player:getIsDeath() then
        return
    end
    
    if self:isAlreadyAtOriginalPosition() then
        return
    end
    
    self:moveTo(self._player:getOriginalPositionX(),self._player:getOriginalPositionY(),function()
        self._player:resetDirection()
        self._player:doAction(ActionType.IDLE)
    end,0.05)
end

function MoveComponent:isAlreadyAtOriginalPosition()
    return self._player:getPositionX() == self._player:getOriginalPositionX() and self._player:getPositionY() == self._player:getOriginalPositionY()
end

function MoveComponent:getGroupDirection()
    if self._player:getGroup() == GroupType.LEFT then
        return DirectionType.RIGHT
    else
        return DirectionType.LEFT
    end
end

function MoveComponent:getReverseDirection()
    if self._player:getGroup() == GroupType.LEFT then
        return DirectionType.LEFT
    else
        return DirectionType.RIGHT
    end
end

