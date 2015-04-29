require("game/config/SkillSequenceConfig")

AIOrderComponent = class("AIOrderComponent")

function AIOrderComponent.create(player)
    local component = AIOrderComponent:new()
    component:init(player)
    return component
end

AIOrderComponent._player = nil
AIOrderComponent._skillComponent = nil
AIOrderComponent._aotuUseSkillList = nil
AIOrderComponent._curSkillIndex = nil

function AIOrderComponent:init(player)
    self._player = player
    self._skillComponent = self._player._skillComponent
    self._aotuUseSkillList = SkillSequenceConfig.getSequence(self._player:getPlayerInfo():getTypeId())
    self._curSkillIndex = 0
end

function AIOrderComponent:autoUseSkill(attackContext,callback)
    local random2 = math.random(1,#self._aotuUseSkillList)
    
--    self._curSkillIndex = (self._curSkillIndex) % table.maxn(self._aotuUseSkillList) + 1
    self._skillComponent:useSkill(self._aotuUseSkillList[random2], attackContext, callback) 
end

function AIOrderComponent:useManualSkill(skillKey,attackContext,callback)
    print("放大招啦", self._player:getPlayerInfo():getTypeId())
    self._skillComponent:useSkill(skillKey, attackContext, callback)
end

function AIOrderComponent:reset()
    
end