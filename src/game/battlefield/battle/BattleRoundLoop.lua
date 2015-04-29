require("game/util/workflow/BaseWork")
require("game/battlefield/battle/round/BattleRoundStart")
require("game/battlefield/battle/round/BattleRoundAttackLoop")
require("game/battlefield/battle/round/BattleRoundEnd")
require("game/battlefield/battle/context/BattleRoundContext")

BattleRoundLoop = class("BattleRoundLoop", function()
    return BaseWork.create()
end)

MAX_ROUND = 100

BattleRoundLoop._roundCount = nil
BattleRoundLoop._curRoundContext = nil

function BattleRoundLoop.create(parentWork)
    local work = BattleRoundLoop:new()
    work:init(parentWork)
    return work
end

function BattleRoundLoop:init(parentWork)
    self._parentWork = parentWork
    
    self:addSubWork(BattleRoundStart.create(self))
    self:addSubWork(BattleRoundAttackLoop.create(self))
    self:addSubWork(BattleRoundEnd.create(self))
    
    self._roundCount = 0
end

function BattleRoundLoop:start(context)
    self._roundCount = self._roundCount + 1
    
    self._curRoundContext = BattleRoundContext.create()
    self._curRoundContext:setRoundId(self._roundCount)
    context:setRoundContext(self._curRoundContext)
    
    local mdata = getmetatable(self)
    mdata.start(self, context)
end

function BattleRoundLoop:subWorkFinish()
    if self._curWorkIndex == table.maxn(self._listSubWorks) then
--        print("cur round " .. self._roundCount)
        if self._context:getIsFinish() or self._roundCount >= MAX_ROUND then
            self:finish()
        else
            self:start(self._context)
        end
    else
        self:nextWork()
    end
end

function BattleRoundLoop:finish()
    --调用基类的方法
    local mdata = getmetatable(self)
--    print("BattleRoundLoop finish")
    mdata.finish(self)
end