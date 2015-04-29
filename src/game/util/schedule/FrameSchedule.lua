FrameSchedule = class("FrameSchedule")

function FrameSchedule.create(frameCount, callback)
    local schedule = FrameSchedule:new()
    schedule:init(frameCount,callback)
    return schedule
end

FrameSchedule._frameCount = nil
FrameSchedule._callback = nil
FrameSchedule._curFrameCount = nil
FrameSchedule._isExcuted = nil

function FrameSchedule:init(frameCount, callback)
    self._frameCount = frameCount
    self._callback = callback
    self._curFrameCount = 0
    self._isExcuted = false
end

function FrameSchedule:onTick()
    self._curFrameCount = self._curFrameCount + 1
    if self._curFrameCount >= self._frameCount and not self._isExcuted then
        self._callback()
        self._isExcuted = true
        return true
    end
    
    return false
end