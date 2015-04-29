BaseBattleScript = class("BaseBattleScript")

function BaseBattleScript.create()
    local script = BaseBattleScript:new()
    script:init()
    return script
end

BaseBattleScript._type = nil
BaseBattleScript._callback = nil

function BaseBattleScript:init()

end

function BaseBattleScript:getType()
    return self._type
end

function BaseBattleScript:excute(baseBattleScriptArg,callback)

end