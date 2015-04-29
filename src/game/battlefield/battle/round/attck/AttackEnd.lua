require("game/event/BattleEvent")
require("game/util/workflow/BaseWork")

AttackStart = class("AttackStart", function()
    return BaseWork.create()
end)

function AttackStart.create(parentWork)
    local work = AttackStart:new()
    work._parentWork = parentWork
    work:init()
    return work
end

function AttackStart:init()

end

function AttackStart:start(context)
--    print("AttackStart start")
    local mdata = getmetatable(self)
    mdata.start(self, context)
    
    local evt = BattleEvent.create(BattleEvent.ATTACK_END,self._context)
    self._context:getBattleScene():getPlayerManager():onBattleEvent(evt)    
    
    self:finish()
end