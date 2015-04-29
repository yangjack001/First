BattleRoundContext = class("BattleRoundContext")

function BattleRoundContext.create()
    local context = BattleRoundContext:new()
    return context
end

BattleRoundContext._roundId = nil
BattleRoundContext._curAttackContext = nil

function BattleRoundContext:setRoundId(roundId)
    self._roundId = roundId
end

function BattleRoundContext:getRoundId()
    return self._roundId
end

function BattleRoundContext:setAttackContext(attContext)
    self._curAttackContext = attContext
end

function BattleRoundContext:getAttackContext()
    return self._curAttackContext
end