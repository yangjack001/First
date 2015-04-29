require("game/util/workflow/BaseWork")

BattleRoundStart = class("BattleRoundStart", function()
    return BaseWork.create()
end)

function BattleRoundStart.create(parentWork)
    local work = BattleRoundStart:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function BattleRoundStart:init()
end

function BattleRoundStart:start()
    local mdata = getmetatable(self)
    mdata.start(self, context)
    self:finish()
end