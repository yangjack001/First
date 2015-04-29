require("game/util/workflow/BaseWork")
BattleStart = class("BattleStart", function()
    return BaseWork.create()
end)

function BattleStart.create(parentWork)
    local work = BattleStart:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function BattleStart:init()
end

function BattleStart:start(context)
    local mdata = getmetatable(self)
    mdata.start(self, context)
    
    SceneManager.getCurScene():getUILayer():showHUD()
    
    ScheduleUtil:getInstance():addTimeSchedule(0.2,function()
        self:finish()
    end)
end