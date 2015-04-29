MyEvent = class("MyEvent")

function MyEvent.create(type)
    local event = MyEvent:new()
    event:init(type)
    return event
end
MyEvent.__index = MyEvent
MyEvent._type = nil

function MyEvent:init(type)
    self._type = type
end

function MyEvent:getType()
    return self._type
end