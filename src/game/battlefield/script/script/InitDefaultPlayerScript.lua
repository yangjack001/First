require("game/battlefield/script/script/BaseBattleScript")
InitDefaultPlayerScript = class("InitDefaultPlayerScript",function()
    return BaseBattleScript.create()
end)

function InitDefaultPlayerScript.create()
    local script = InitDefaultPlayerScript:new()
    script:init()
    return script
end

function InitDefaultPlayerScript:init()
    self._type = BattleScriptType.INIT_DEFAULT_PLAYER
end

function InitDefaultPlayerScript:excute(initDefaultPlayerScriptArg,callback)
    self._callback = callback
    
    BattleFieldManager.getCurBattle():getScene():getPlayerManager():initPlayer()
    
    self._callback()
end