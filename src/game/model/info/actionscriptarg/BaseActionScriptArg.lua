BaseActionScriptArg = class("BaseActionScriptArg")

function BaseActionScriptArg.create()
    local arg = BaseActionScriptArg:new()
    return arg
end

BaseActionScriptArg._startTime = nil

function BaseActionScriptArg:parse(data)
    self._startTime = data.startTime
end

function BaseActionScriptArg:getType()
    return nil
end

function BaseActionScriptArg:getStartTime()
    return self._startTime
end