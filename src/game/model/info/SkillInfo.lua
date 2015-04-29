SkillInfo = class("SkillInfo")

function SkillInfo.create()
    local skill = SkillInfo:new()
    skill:init()
    return skill
end

SkillInfo._key = nil

---- 攻击目标类型
SkillInfo._tarType = nil

---- 远程、近程
SkillInfo._disType = nil

---- 移动时，X方向的修正
SkillInfo._offsetX = nil

---- 移动时，Y方向的修正
SkillInfo._offsetY = nil

---- 释放时机
SkillInfo._releaseTime = nil

---- 对应的动作
SkillInfo._actionType = nil

SkillInfo._focusTime = nil

SkillInfo._damageArg = nil

function SkillInfo:init()
    self._offsetX = 0
    self._offsetY = 0
    self._focusTime = 0
end

function SkillInfo:parse(key,data)
    self._key = key
    self._tarType = data.tarType
    self._disType = data.disType
    self._actionType = data.actionType
    
    if data.offsetX ~= nil then
        self._offsetX = data.offsetX
    end
    
    if data.offsetY ~= nil then
        self._offsetY = data.offsetY
    end
    
    if data.focusTime ~= nil then
        self._focusTime = data.focusTime
    end
    
    self._damageArg = data.damageArg
end 

function SkillInfo:getKey()
    return self._key
end

function SkillInfo:getTargetType()
    return self._tarType
end

function SkillInfo:getDistanceType()
    return self._disType
end

function SkillInfo:getReleaseTime()
    return self._releaseTime
end

function SkillInfo:getActionType()
    return self._actionType
end

function SkillInfo:getOffsetX()
    return self._offsetX
end

function SkillInfo:getOffsetY()
    return self._offsetY
end

function SkillInfo:getFocusTime()
    return self._focusTime
end

function SkillInfo:getDamageArg()
    return self._damageArg
end