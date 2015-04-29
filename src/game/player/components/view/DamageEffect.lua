require("game/type/ViewLayerType")
require("game/manager/AnimationManager")

DamageEffect = class("DamageEffect")

DamageEffect.DAMAGE_EFFECT_POSITION_Y = 200
DamageEffect.NUMBER_WIDTH = 22

function DamageEffect.showDamageEffect(container,damage,isCrit)
--    local lblDamage = cc.Label:createWithTTF("", "fonts/xxx.ttf", 52)
--    container:addChild(lblDamage, ViewLayerType.DAMAGE_VALUE_EFFECT)
--    lblDamage:setAnchorPoint(0.5,0.5)
--    lblDamage:setString(damage)
--    lblDamage:setOpacity(255)
--    lblDamage:setColor(cc.c3b(255,0,0))
--    lblDamage:setPositionY(DamageEffect.DAMAGE_EFFECT_POSITION_Y)
--    lblDamage:setScale(0.00001)
--    lblDamage:enableOutline(cc.c4b(0,0,0,255),1)
    
    local node = cc.Node:create()
    node:setPositionY(DamageEffect.DAMAGE_EFFECT_POSITION_Y)
    container:addChild(node, ViewLayerType.DAMAGE_VALUE_EFFECT)
    local strDamage = string.format("%d",damage)
    strDamage = strDamage:reverse()
    for i = 1, #strDamage do
        local number = strDamage:sub(i,i)
        local sp = cc.Sprite:create(string.format("ui/number/%s.png", number))
        sp:setPosition((#strDamage - 1) * DamageEffect.NUMBER_WIDTH / 2 - (i - 1) * DamageEffect.NUMBER_WIDTH,0)
        node:addChild(sp)
    end
    node:setCascadeOpacityEnabled(true)
    
    node:setScale(0.1)
    local scaleTo = cc.EaseElasticOut:create(cc.ScaleTo:create(0.4, isCrit and 1.4 or 1))
    local appear = cc.Spawn:create(cc.MoveTo:create(0.4,cc.p(0,DamageEffect.DAMAGE_EFFECT_POSITION_Y + 40)),scaleTo)
   
    local move = cc.MoveTo:create(0.8,cc.p(0,DamageEffect.DAMAGE_EFFECT_POSITION_Y + 120))
    local fadeOut = cc.FadeOut:create(0.8)
    local disappear = cc.Spawn:create(move, fadeOut)
    
    local actionCallback = cc.CallFunc:create(function()
        container:removeChild(node)
    end)
    
    if isCrit then
        node:runAction(cc.Sequence:create(appear,fadeOut,actionCallback))
    else
        node:runAction(cc.Sequence:create(appear,disappear,actionCallback))
    end
end

function DamageEffect.showHitEffect(container, id, x, y)
    if id == nil then
        return
    end
    
    local skeletion = AnimationManager.getHitEffectSkeleton(id)
    skeletion:setPosition(0, 80)
    container:addChild(skeletion, ViewLayerType.HIT_EFFECT)

    skeletion:getAnimation():gotoAndPlay(EffectActionType.END)
end