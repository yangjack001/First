DamageResult = class("DamageResult")

function DamageResult.create()
    local result = DamageResult:new()
    result:init()
    return result
end

DamageResult._attPlayer = nil
DamageResult._defPlayer = nil
DamageResult._damageValue = nil
DamageResult._isCrit = nil
DamageResult._isDamageDead = nil
DamageResult._originalHp = nil
DamageResult._isDoBeHitAction = nil
DamageResult._hitEffectId = nil
DamageResult._attSkillInfo = nil

function DamageResult:init()
    
end

function DamageResult:setAttPlayer(attPlayer)
    self._attPlayer = attPlayer
end

function DamageResult:getAttPlayer()
    return self._attPlayer
end

function DamageResult:setDefPlayer(defPlayer)
    self._defPlayer = defPlayer
end

function DamageResult:getDefPlayer()
    return self._defPlayer
end

function DamageResult:setDamageValue(damageValue)
    self._damageValue = damageValue
    if self._isCrit then
        self._damageValue = self._damageValue * 2
    end
end

function DamageResult:getDamageValue()
    return self._damageValue
end

function DamageResult:setIsCrit(isCrit)
    self._isCrit = isCrit
end

function DamageResult:getIsCrit()
    return self._isCrit
end

function DamageResult:setIsDamageDead(isDamageDead)
    self._isDamageDead = isDamageDead
end

function DamageResult:getIsDamageDead()
    return self._isDamageDead
end

function DamageResult:setOriginalHp(originalHp)
    self._originalHp = originalHp
end

function DamageResult:getOriginalHp()
    return self._originalHp
end

function DamageResult:setIsDoBeHitAction(value)
    self._isDoBeHitAction = value
end

function DamageResult:getIsDoBeHitAction()
    return self._isDoBeHitAction
end

function DamageResult:setHitEffectId(id)
    self._hitEffectId = id
end

function DamageResult:getHitEffectId()
    return self._hitEffectId
end

function DamageResult:setAttSkillInfo(skillInfo)
    self._attSkillInfo = skillInfo
end

function DamageResult:getAttSkillInfo()
    return self._attSkillInfo
end