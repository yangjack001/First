require("game/util/workflow/BaseWork")

BattleRoundEnd = class("BattleRoundEnd",function()
    return BaseWork.create()
end)

function BattleRoundEnd.create(parentWork)
    local work = BattleRoundEnd:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function BattleRoundEnd:init()
    
end

function BattleRoundEnd:start()
    print("BattleRoundEnd start")
    local mdata = getmetatable(self)
    mdata.start(self, context)
    
    self:finish()
end