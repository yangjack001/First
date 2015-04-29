require("game/util/workflow/BaseWork")

AttackStartSkill = class("AttackStartSkill",function()
    return BaseWork.create()
end)

function AttackStartSkill.create(parentWork)
    local work = AttackStartSkill:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackStartSkill:init()

end

function AttackStartSkill:start()
--    print("AttackStartSkill start")
    self:finish()
end