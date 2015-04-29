require("game/util/workflow/BaseWork")

AttackEndSkill = class("AttackEndSkill",function()
    return BaseWork.create()
end)

function AttackEndSkill.create(parentWork)
    local work = AttackEndSkill:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackEndSkill:init()

end

function AttackEndSkill:start()
--    print("AttackEndSkill start")
    self:finish()
end