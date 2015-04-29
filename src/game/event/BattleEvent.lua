BattleEvent = class("BattleEvent")

BattleEvent.BEFORE_BATTLE = "before_battle"

BattleEvent.BATTLE_START = "battle_start"
BattleEvent.ROUND_START = "round_start"
BattleEvent.ATTACK_START = "attack_start"
BattleEvent.ATTACK_START_BUFF = "attack_start_buff"
BattleEvent.ATTACK_VALIDATE = "attack_validate"
BattleEvent.ATTACK_START_SKILL = "attack_start_skill"
BattleEvent.ATTACK_PREPARE = "attack_prepare"
BattleEvent.DEATH_JUDGEMENT = "death_judgement"
BattleEvent.DEFENCE_BE_HIT_SKILL = "be_hit_skill"
BattleEvent.DEFENCE_BE_CRITICAL_SKILL = "defence_be_critical_skill"
BattleEvent.ATTACK_CRITICAL_SKILL = "attack_critical_skill"
BattleEvent.ATTACK_END_SKILL = "attack_end_skill"
BattleEvent.ATTACK_END = "attack_end"
BattleEvent.ROUND_END = "round_end"
BattleEvent.BATTLE_END = "battle_end"

BattleEvent.FINISH_BATTLE = "finish_battle"

BattleEvent.END_ALL_FOCUS = "end_all_focus"

BattleEvent._type = nil
BattleEvent._battleContext = nil
BattleEvent._attackContext = nil

function BattleEvent.create(type, battleContext)
    local evt = BattleEvent:new()
    evt:init(type, battleContext)
    return evt
end

function BattleEvent:init(type, battleContext)
    self._type = type
    self._battleContext = battleContext
    self._attackContext = battleContext:getAttackContext()
end

function BattleEvent:getType()
    return self._type
end

function BattleEvent:battleContext()
    return self._battleContext
end

function BattleEvent:attackContext()
    return self._attackContext
end