require("game/util/workflow/BaseWork")

AttackCriticalSkill = class("AttackCriticalSkill",function()
    return BaseWork.create()
end)

function AttackCriticalSkill.create(parentWork)
    local work = AttackCriticalSkill:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackCriticalSkill:init()

end

function AttackCriticalSkill:start()
--    print("AttackCriticalSkill start")
    self:finish()
end