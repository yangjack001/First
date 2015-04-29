ActionScriptInfo=class("ActionScriptInfo")

function ActionScriptInfo.create()
    local info = ActionScriptInfo:new()
    return info
end

ActionScriptInfo._startTime = nil
ActionScriptInfo._type = nil
ActionScriptInfo._params = nil

function ActionScriptInfo:init()
    
end

function ActionScriptInfo:parse(data)
    self._startTime = data.startTime
    self._type = data.type
    self._params = data.params
end

function ActionScriptInfo:getType()
    return self._type
end

function ActionScriptInfo:getStartTime()
    return self._startTime
end

function ActionScriptInfo:getParams()
    return self._params
end