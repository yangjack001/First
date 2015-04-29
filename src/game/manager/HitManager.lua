require("game/battlefield/battle/context/DamageResult")
require("game/type/HitAreaType")
require("game/manager/HitCheckManager")
require("game/event/HitEventDispatcher")

HitManager = class("HitManager")

HitManager._curHitEventDispatcher = nil

function HitManager.onHit(attPlayer, targetPlayer, hitCheckScriptArg)
--    print(tostring(attPlayer), tostring(attPlayer:getCurAttackContext()), tostring(hitCheckScriptArg))
    if attPlayer:getCurAttackContext() == nil then
        local a =  nil
    end
    local hitCheckType = hitCheckScriptArg:getHitCheckType()
    local enemyPlayerList = attPlayer:getCurAttackContext():getEnemyPlayerGroup()
    local attSkillInfo = attPlayer:getCurSkillInfo()

    local beHitTargetList = HitCheckManager:getInstance():getBehitTargetList(hitCheckType,targetPlayer,enemyPlayerList)

    for i=1,#beHitTargetList do
        local beHitPlayer = beHitTargetList[i]
        
        local damageResult = DamageResult.create()
        
        damageResult:setAttPlayer(attPlayer)
        damageResult:setDefPlayer(beHitPlayer)
        local att = attPlayer:getPlayerInfo():getProperty().att
        local hitInfo = attSkillInfo:getDamageArg()[hitCheckScriptArg:getHitId()]
        damageResult:setDamageValue(-1 * (att * hitInfo[1] / 100 + hitInfo[2]))
        damageResult:setIsCrit(math.random(1,100) < hitInfo[3])
        damageResult:setIsDoBeHitAction(hitCheckScriptArg:getIsInterrupt())
        damageResult:setHitEffectId(hitCheckScriptArg:getHitEffectId())
        damageResult:setAttSkillInfo(attPlayer:getCurSkillInfo())
        
        attPlayer:hit(damageResult)
        beHitPlayer:beHit(damageResult)
        
        local evt = HitEvent.create(HitEvent.ON_HIT_FINISH,damageResult)
        HitManager.getEventDispatcher():dispatchEvent(evt)
    end
end

function HitManager.init()
    HitManager._curHitEventDispatcher = HitEventDispatcher.create()
end

function HitManager.getEventDispatcher()
    if HitManager._curHitEventDispatcher == nil then
        HitManager.init()
    end
    
    return HitManager._curHitEventDispatcher
end

