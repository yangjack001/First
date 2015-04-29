require("game/util/workflow/BaseWork")

AttackStartBuff = class("AttackStartBuff",function()
    return BaseWork.create()
end)

function AttackStartBuff.create(parentWork)
    local work = AttackStartBuff:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackStartBuff:init()

end

function AttackStartBuff:start()
--    print("AttackStartBuff start")
    self:finish()
end