require("game/player/components/actionscript/BaseActionScript")

CPUseSkillScript = class("CPUseSkillScript",function()
    return BaseActionScript.create()
end)

function CPUseSkillScript.create(player)
    local script = CPUseSkillScript:new()
    script:init(player)
    return script
end

CPUseSkillScript._player = nil

function CPUseSkillScript:init(player)
    self._player = player
end

function CPUseSkillScript:excute(scriptInfo)
    
end