require("game/config/BuffConfig")
require("game/player/components/buff/trait/BuffTraitFactory")

Buff = class("Buff")

function Buff.create(buffId, targetPlayer, sourcePlayer, continueRound)
    local buff = Buff:new()
    buff:init(buffId, targetPlayer, sourcePlayer, continueRound)
    return buff
end

Buff._targetPlayer = nil
Buff._sourcePlayer = nil
Buff._listTrait = nil
Buff._buffInfo = nil
Buff._continueRound = nil

function Buff:init(buffId, targetPlayer, sourcePlayer, continueRound)
    self._targetPlayer = targetPlayer
    self._sourcePlayer = sourcePlayer
    self._continueRound = continueRound
    
    self._buffInfo = BuffConfig.getBuffInfoById(buffId)
end

function Buff:initTrait()
    self._listTrait = {}
    local traitIds = self._buffInfo:getTraitIds()
    for i = 1, #traitIds do
        local traitId = traitIds[i]
        local trait = BuffTraitFactory.getTraitById(traitId, self._targetPlayer)
        trait:onStart()
        table.insert(self._listTrait,trait)
    end
end

function Buff:removeTrait()
    for i = 1, #self._listTrait do
        local trait = self._listTrait[i]
        trait:onEnd()
    end
end

function Buff:initEffect()
    local effectIds = self._buffInfo:getEffectIds()
    for i = 1, #effectIds do
        local effectId = effectIds[i]
        self._targetPlayer:getAvatar():addStateEffect(effectId)
    end   
end

function Buff:removeEffect()
    local effectIds = self._buffInfo:getEffectIds()
    for i = 1, #effectIds do
        local effectId = effectIds[i]
        self._targetPlayer:getAvatar():removeStateEffect(effectId)
    end   
end

function Buff:onStart()
    self:initTrait()
    self:initEffect()
end

function Buff:onEnd()
    self:onStop()
end

function Buff:onStop()
    self:removeEffect()
    self:removeTrait()
end

function Buff:onTickRound()
    self._continueRound = self._continueRound - 1
end

function Buff:setContinueRound(roundCount)
    self._continueRound = roundCount
end

function Buff:getContinueRound()
    return self._continueRound
end

function Buff:getBuffInfo()
    return self._buffInfo
end

function Buff:getTargetPlayer()
    return self._targetPlayer
end

function Buff:getSourcePlayer()
    return self._sourcePlayer
end