BaseBattleScriptArg = class("BaseBattleScriptArg")

function BaseBattleScriptArg.create()
    local arg = BaseBattleScriptArg:new()
    return arg
end

BaseBattleScriptArg._startTime = nil

function BaseBattleScriptArg:parse(data)

end

function BaseBattleScriptArg:getType()
    return nil
end