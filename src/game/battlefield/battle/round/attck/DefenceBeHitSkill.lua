require("game/util/workflow/BaseWork")

DefenceBeHitSkill = class("DefenceBeHitSkill",function()
    return BaseWork.create()
end)

function DefenceBeHitSkill.create(parentWork)
    local work = DefenceBeHitSkill:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function DefenceBeHitSkill:init()

end

function DefenceBeHitSkill:start()
--    print("DefenceBeHitSkill start")
    self:finish()
end