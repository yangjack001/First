CPSkillInfo = class("CPSkillInfo")

function CPSkillInfo.create(id)
    local skillInfo = CPSkillInfo:new()
    CPSkillInfo:init(id)
    return skillInfo
end

CPSkillInfo._id = nil
CPSkillInfo._playerTypeIds = nil
CPSkillInfo._playerSkillKeys = nil
CPSkillInfo._targetType = nil
CPSkillInfo._remoteEffectId = nil

function CPSkillInfo:init(id)
    self._id = id
end

function CPSkillInfo:parse(data)
    self._playerTypeIds = data.playerTypeIds
    self._playerSkillKeys = data.playerSkillKeys
    self._targetType = data.tarType
    self._remoteEffectId = data.remoteEffectId
end

function CPSkillInfo:getId()
    return self._id
end

function CPSkillInfo:getPlayerTypeIds()
    return self._playerTypeIds
end

function CPSkillInfo:getPlayerSkillKeys()
    return self._playerSkillKeys
end

function CPSkillInfo:getTargetType()
    return self._targetType
end

function CPSkillInfo:getRemoteEffectId()
    return self._remoteEffectId
end

-- 检查是否满足某个CP
function CPSkillInfo:canMatch(totalPlayerTypeIds)
    for i = 1, #self._playerTypeIds do
        local playerId = self._playerTypeIds[i]
        local isMatch = false
        
        for j = 1, #totalPlayerTypeIds do
            if playerId == totalPlayerTypeIds[j] then
                isMatch = true
            end
        end
        
        if not isMatch then
            return false
        end
    end
    
    return true
end