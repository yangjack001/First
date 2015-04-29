BattleAttackContext = class("BattleAttackContext")

function BattleAttackContext.create()
    local context = BattleAttackContext:new()
    return context
end

BattleAttackContext._attPlayer = nil
BattleAttackContext._targetPlayer = nil
BattleAttackContext._attackResult = nil
BattleAttackContext._friendlyPlayerGroup = nil
BattleAttackContext._enemyPlayerGroup = nil
BattleAttackContext._skillKey = nil

function BattleAttackContext:setAttPlayer(player)
    self._attPlayer = player
end

function BattleAttackContext:getAttPlayer()
    return self._attPlayer
end

function BattleAttackContext:setAttackResult(attResult)
    self._attackResult = attResult
end

function BattleAttackContext:getAttackResult()
    return self._attackResult
end

function BattleAttackContext:setFriendlyPlayerGroup(group)
    self._friendlyPlayerGroup = group
end

function BattleAttackContext:getFriendlyPlayerGroup()
    return self._friendlyPlayerGroup
end

function BattleAttackContext:setEnemyPlayerGroup(group)
    self._enemyPlayerGroup = group
end

function BattleAttackContext:getEnemyPlayerGroup()
    return self._enemyPlayerGroup
end

function BattleAttackContext:setSkillKey(skillKey)
    self._skillKey = skillKey
end

function BattleAttackContext:getSkillKey()
    return self._skillKey
end