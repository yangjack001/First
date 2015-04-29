PlayerSkillInfoMap = class("PlayerSkillInfoMap")

PlayerSkillInfoMap._playerId = nil
PlayerSkillInfoMap._keyToInfo = nil

function PlayerSkillInfoMap.create(playerId)
    local map = PlayerSkillInfoMap:new()
    map:init(playerId)
    return map
end

function PlayerSkillInfoMap:init(playerId)
    self._playerId = playerId
    self._keyToInfo = {}
end

function PlayerSkillInfoMap:addSkillInfo(skillInfo)
    self._keyToInfo[skillInfo:getKey()] = skillInfo
end

function PlayerSkillInfoMap:getSkillInfoByKey(skillKey)
    return self._keyToInfo[skillKey]
end

function PlayerSkillInfoMap:getPlayerId()
    return self._playerId
end