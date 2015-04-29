require("game/type/ActionType")

HitComponent = class("HitCheckComponent")

function HitComponent.create(player)
    local component = HitComponent:new()
    component._player = player
    component:init()
    return component
end

HitComponent._player = nil

function HitComponent:init()
    
end

function HitComponent:beHit(damageResult)
    local curActionType = self._player:getCurActionInfo():getType()
    if damageResult:getIsDamageDead() then
        self._player:getSkillComponent():applyCallback()
        self._player:doDeathAction()
    elseif damageResult:getIsDoBeHitAction() or curActionType == ActionType.IDLE or curActionType == ActionType.BE_HIT then
        self._player:doBeHitAction()
    end
end

function HitComponent:hit()

end