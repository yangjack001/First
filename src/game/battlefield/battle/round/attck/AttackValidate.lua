require("game/util/workflow/BaseWork")

AttackValidate = class("AttackValidate",function()
    return BaseWork.create()
end)

function AttackValidate.create(parentWork)
    local work = AttackValidate:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackValidate:init()

end

function AttackValidate:start()
--    print("AttackValidate start")
    self:finish()
end