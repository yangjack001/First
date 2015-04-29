require("game/util/workflow/BaseWork")

DefenceBeCriticalSkill = class("DefenceBeCriticalSkill",function()
    return BaseWork.create()
end)

function DefenceBeCriticalSkill.create(parentWork)
    local work = DefenceBeCriticalSkill:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function DefenceBeCriticalSkill:init()

end

function DefenceBeCriticalSkill:start()
--    print("DefenceBeCriticalSkill start")
    self:finish()
end