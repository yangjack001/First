require("game/util/workflow/BaseWork")

DeathJudgement = class("DeathJudgement",function()
    return BaseWork.create()
end)

function DeathJudgement.create(parentWork)
    local work = DeathJudgement:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function DeathJudgement:init()

end

function DeathJudgement:start()
--    print("DeathJudgement start")
    self:finish()
end