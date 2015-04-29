require("game/util/schedule/FrameSchedule")
require("game/util/schedule/TimeSchedule")

ScheduleUtil = class("Schedule")

function ScheduleUtil:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function ScheduleUtil:getInstance()
    if self.instance == nil then
        self.instance = self:new()
        self:init()
    end
    return self.instance
end

ScheduleUtil._listSchedule = nil

function ScheduleUtil:init()
    self._listSchedule = {}
end

function ScheduleUtil:addFrameSchedule(frameCount, callback)
    local frameSchedule = FrameSchedule.create(frameCount,callback)
    self._listSchedule[tostring(os.clock())] = frameSchedule
end

function ScheduleUtil:addTimeSchedule(interval, callback)
    local timeSchedule = TimeSchedule.create(interval,callback)
    self._listSchedule[tostring(os.clock())] = timeSchedule
end

function ScheduleUtil:onTick(t)
    for key, mySchedule in pairs(self._listSchedule) do
        if mySchedule:onTick() then
            self._listSchedule[key] = nil
        end
    end
end