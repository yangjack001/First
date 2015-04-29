require("game/model/info/battlescriptarg/BaseBattleScriptArg")

InitDefaultPlayerScriptArg = class("InitDefaultPlayerScript", function()
    return BaseBattleScriptArg.create()
end)

function InitDefaultPlayerScriptArg.create()
    local arg = InitDefaultPlayerScriptArg:new()
    arg:init()    
    return arg
end

function InitDefaultPlayerScriptArg:init()
    
end

function InitDefaultPlayerScriptArg:getType()
    return BattleScriptType.INIT_DEFAULT_PLAYER
end