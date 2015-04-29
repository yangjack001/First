require("game/model/info/actionscriptarg/BaseActionScriptArg")
require("game/type/ActionScriptType")

CreateShadowScriptArg = class("CreateShadowScriptArg",function()
    return BaseActionScriptArg.create()
end)

function CreateShadowScriptArg.create()
    local arg = CreateShadowScriptArg:new()
    arg:init()
    return arg
end

CreateShadowScriptArg._count = nil
CreateShadowScriptArg._confuse = nil

function CreateShadowScriptArg:init()
    self._count = 0
    self._confuse = false
end

function CreateShadowScriptArg:parse(data)
    self._startTime = data.startTime
    self._count = data.count
    if data.confuse ~= nil then
        self._confuse = data.confuse
    end
end

function CreateShadowScriptArg:getCount()
    return self._count
end

function CreateShadowScriptArg:getConfuse()
    return self._confuse
end

function CreateShadowScriptArg:getType()
    return ActionScriptType.CREATE_SHADOW
end