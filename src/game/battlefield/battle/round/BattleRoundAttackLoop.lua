require("game/util/workflow/BaseWork")
require("game/type/GroupType")
require("game/battlefield/battle/round/attck/AttackStart")
require("game/battlefield/battle/round/attck/AttackCriticalSkill")
require("game/battlefield/battle/round/attck/DeathJudgement")
require("game/battlefield/battle/round/attck/AttackEndSkill")
require("game/battlefield/battle/round/attck/AttackPrepare")
require("game/battlefield/battle/round/attck/AttackProcess")
require("game/battlefield/battle/round/attck/AttackStartBuff")
require("game/battlefield/battle/round/attck/AttackStartSkill")
require("game/battlefield/battle/round/attck/AttackValidate")
require("game/battlefield/battle/round/attck/DefenceBeCriticalSkill")
require("game/battlefield/battle/round/attck/DefenceBeHitSkill")
require("game/battlefield/battle/round/attck/AttackEnd")
require("game/battlefield/battle/context/BattleAttackContext")

BattleRoundAttackLoop = class("BattleRoundAttackLoop",function()
    return BaseWork.create()
end)

function BattleRoundAttackLoop.create(parentWork)
    local work = BattleRoundAttackLoop:new()
    work._parentWork = parentWork
    work:init()
    return work
end

------------ 当前出手的人的索引
BattleRoundAttackLoop._attackIndex = nil
BattleRoundAttackLoop._curAttackPlayer = nil
BattleRoundAttackLoop._curAttackContext = nil

function BattleRoundAttackLoop:init()

    self:addSubWork(AttackStart.create(self))
    self:addSubWork(AttackStartBuff.create(self))
    self:addSubWork(AttackValidate.create(self))
    self:addSubWork(AttackStartSkill.create(self))
    self:addSubWork(AttackPrepare.create(self))
    self:addSubWork(AttackProcess.create(self))
    self:addSubWork(DeathJudgement.create(self))
    self:addSubWork(DefenceBeHitSkill.create(self))
    self:addSubWork(DefenceBeCriticalSkill.create(self))
    self:addSubWork(AttackCriticalSkill.create(self))
    self:addSubWork(AttackEndSkill.create(self))
    self:addSubWork(AttackEnd.create(self))

    self._attackIndex = 0
end

function BattleRoundAttackLoop:start(context)
--    print("start round attack")
    --调用基类的方法
    
    
    self._attackIndex = self._attackIndex + 1
    self._curAttackPlayer = context:getPlayerList()[self._attackIndex]
    
    self._curAttackContext = BattleAttackContext.create()
    self._curAttackContext:setAttPlayer(self._curAttackPlayer)
    if self._curAttackPlayer:getGroup() == GroupType.LEFT then
        self._curAttackContext:setFriendlyPlayerGroup(context:getLeftPlayerGroup())
        self._curAttackContext:setEnemyPlayerGroup(context:getRightPlayerGroup())
    else
        self._curAttackContext:setFriendlyPlayerGroup(context:getRightPlayerGroup())
        self._curAttackContext:setEnemyPlayerGroup(context:getLeftPlayerGroup())
    end
    
    context:setAttackContext(self._curAttackContext)
    
    local mdata = getmetatable(self)
    mdata.start(self, context)
end

function BattleRoundAttackLoop:subWorkFinish()
    if self._curWorkIndex == table.maxn(self._listSubWorks) then
        print("end attack round " .. self._attackIndex)
        if self:canFinishBattle() then
            self._context:setIsFinish(true)
            self:finish(self._context)
            return
        end

        if self._attackIndex >= table.maxn(self._context:getPlayerList()) then
            self._attackIndex = 0
            self:finish()
        else

            self:start(self._context)
        end
    else
        self:nextWork()
    end
end

function BattleRoundAttackLoop:finish()
    --调用基类的方法
    local mdata = getmetatable(self)
--    print("BattleRoundAttackLoop finish")
    mdata.finish(self)
end

function BattleRoundAttackLoop:canFinishBattle()
    local leftGroup = self._context:getLeftPlayerGroup()
    if leftGroup:getIsAllDeath() then
        self._context:setIsBattleFailed(true)
    end
    local rightGroup = self._context:getRightPlayerGroup()
    return leftGroup:getIsAllDeath() or rightGroup:getIsAllDeath()
end