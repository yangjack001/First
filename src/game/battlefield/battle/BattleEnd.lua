require("game/util/workflow/BaseWork")

BattleEnd = class("BattleEnd", function()
    return BaseWork.create()
end)

function BattleEnd.create(parentWork)
    local work = BattleEnd:new()
    work:init(parentWork)
    return work
end

function BattleEnd:init(parentWork)
    self._parentWork = parentWork
end

function BattleEnd:start(context)
    local mdata = getmetatable(self)
    mdata.start(self, context)
    print("BattleEnd start")
    self:finish()
end