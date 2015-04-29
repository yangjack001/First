BattleContext = class("BattleContext")

BattleContext._battleScene = nil
BattleContext._curRoundContext = nil
BattleContext._isFinish = nil
BattleContext._isBattleFailed = nil

function BattleContext.create(battleScene)
    local context = BattleContext:new()
    context._battleScene = battleScene
    return context
end

function BattleContext:getPlayerList()
    return self._battleScene:getPlayerManager():getPlayerList()
end

function BattleContext:getLeftPlayerGroup()
    return self._battleScene:getPlayerManager():getLeftPlayerGroup()
end

function BattleContext:getRightPlayerGroup()
    return self._battleScene:getPlayerManager():getRightPlayerGroup()
end

function BattleContext:setRoundContext(context)
    self._curRoundContext = context
end

function BattleContext:getRoundContext()
    return self._curRoundContext
end

function BattleContext:getAttackContext()
    return self._curRoundContext:getAttackContext()
end

function BattleContext:setAttackContext(attContext)
    self._curRoundContext:setAttackContext(attContext)
end

function BattleContext:getBattleScene()
    return self._battleScene
end

function BattleContext:setIsFinish(isFinish)
    self._isFinish = isFinish
end

function BattleContext:getIsFinish()
    return self._isFinish
end

function BattleContext:setIsBattleFailed(isBattleFailed)
    self._isBattleFailed = isBattleFailed
end

function BattleContext:getIsBattleFailed()
    return self._isBattleFailed
end