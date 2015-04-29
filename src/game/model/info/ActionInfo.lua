require("game/model/info/ActionScriptInfo")
require("game/config/DefaultActionToAnimation")
require("game/model/info/actionscriptarg/ActionScriptArgFactory")

ActionInfo = class("ActionInfo")

ActionInfo._animation = nil
ActionInfo._type = nil
ActionInfo._times = nil
ActionInfo._isLoop = nil
ActionInfo._listScripts = nil
ActionInfo._listFinalScripts = nil

function ActionInfo.create(type)
    local info = ActionInfo:new()
    info:init(type)
    return info
end

function ActionInfo:init(type)
    self._type = type
end

function ActionInfo:parse(data)
    self._times = data.times
    
    if data.isLoop ~= nil then
        self._isLoop = tonumber(data.isLoop) == 1
    else
        self._isLoop = false
    end
    
    if data.animation ~= nil then
        self._animation = data.animation
    else
        self._animation = DefaultActionToAnimation[self._type]
    end
    
    self._listScripts = {}
    if data.script ~= nil then
        for key,value in pairs(data.script) do
            local type = value.type
            local scriptArg = ActionScriptArgFactory.getArgByType(type)
            scriptArg:parse(value)
            self._listScripts[key] = scriptArg
        end
    end
    
    self._listFinalScripts = {}
    if data.finalScript ~= nil then
        for key,value in pairs(data.finalScript) do
            local type = value.type
            local scriptArg = ActionScriptArgFactory.getArgByType(type)
            scriptArg:parse(value)
            self._listFinalScripts[key] = scriptArg
        end
    end
end

function ActionInfo:getType()
    return self._type
end

function ActionInfo:getAnimation()
    return self._animation
end

function ActionInfo:getIsLoop()
    return self._isLoop
end

function ActionInfo:getListScripts()
    return self._listScripts
end

-- 目前只在远程光效的地方用到
function ActionInfo:getFinalScripts()
    return self._listFinalScripts
end