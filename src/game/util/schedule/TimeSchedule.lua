TimeSchedule = class("TimeSchedule")

function TimeSchedule.create(interval,callback)
    local schedule = TimeSchedule:new()
    schedule:init(interval,callback)
    return schedule
end

TimeSchedule._startTime = nil
TimeSchedule._excuteTime = nil
TimeSchedule._isExcuted = nil
TimeSchedule._callback = nil

function TimeSchedule:init(interval,callback)
    self._startTime = os.clock()
    self._excuteTime = self._startTime + interval
    self._callback = callback
    self._isExcuted = false
end

function TimeSchedule:onTick()
    local curTime = os.clock()
    if self._excuteTime < curTime and not self._isExcuted then
        self._callback()
        self._isExcuted = true
        return true
    end
    
    return false
end