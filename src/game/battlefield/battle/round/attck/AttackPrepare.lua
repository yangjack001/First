require("game/util/workflow/BaseWork")

AttackPrepare = class("AttackPrepare",function()
    return BaseWork.create()
end)

function AttackPrepare.create(parentWork)
    local work = AttackPrepare:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackPrepare:init()

end

function AttackPrepare:start()
--    print("AttackPrepare start")
    self:finish()
end