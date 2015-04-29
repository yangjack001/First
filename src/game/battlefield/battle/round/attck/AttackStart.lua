require("game/util/workflow/BaseWork")

AttackEnd = class("AttackEnd", function()
    return BaseWork.create()
end)

function AttackEnd.create(parentWork)
    local work = AttackEnd:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackEnd:init()

end

function AttackEnd:start()
--    print("AttackEnd start")
    
    
    self:finish()
end