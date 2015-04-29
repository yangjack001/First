require("game/config/BattleConfig")
require("game/type/GroupType")
require("game/model/info/PlayerProperty")
require("game/config/PlayerConfig")
require("game/manager/IDGenerator")

PlayerInfo = class("PlayerInfo")

PlayerInfo._id = nil
PlayerInfo._playerId = nil
PlayerInfo._typeId = nil
PlayerInfo._clothId = nil
PlayerInfo._gridX = nil
PlayerInfo._gridY = nil
PlayerInfo._property = nil
PlayerInfo._fileName = nil
PlayerInfo._bodyWidth = nil
PlayerInfo._infoData = nil
PlayerInfo._isShodow = nil
PlayerInfo._isAuto = nil
PlayerInfo._lastAttKey = nil

function PlayerInfo.create()
    local info = PlayerInfo:new()
    info:init()
    return info
end

function PlayerInfo:init()
    self._clothId = 1
    self._isShodow = false
    self._isAuto = true
    self._gridX = 1
    self._gridY = 1
    self._id = IDGenerator.getNewId()
end

function PlayerInfo:parse(infoData)
    self._infoData = infoData
    self._property = PlayerProperty.create()
    self._property:parse(infoData)
    self._playerId = infoData.playerId
    self._typeId = infoData.typeId
    if infoData.clothId ~= nil then
        self._clothId = infoData.clothId
    end
    
    local playerData = PlayerConfig.getPlayerDataById(self._typeId)
    self._fileName = playerData.fileName
    self._bodyWidth = playerData.bodyWidth
end

function PlayerInfo:getId()
    return self._id
end

function PlayerInfo:getPlayerId()
    return self._playerId
end

function PlayerInfo:getTypeId()
    return self._typeId
end

function PlayerInfo:getClothId()
    return self._clothId
end

function PlayerInfo:getX(group)
    if group == GroupType.RIGHT then
        return BattleConfig.rightFormationPositionConfig[self._gridX][self._gridY].x
    elseif group == GroupType.LEFT then
        return BattleConfig.leftFormationPositionConfig[self._gridX][self._gridY].x
    end
end

function PlayerInfo:getY(group)
    if group == GroupType.RIGHT then
        return BattleConfig.rightFormationPositionConfig[self._gridX][self._gridY].y
    elseif group == GroupType.LEFT then
        return BattleConfig.leftFormationPositionConfig[self._gridX][self._gridY].y
    end
end

function PlayerInfo:setGridX(gridX)
    self._gridX = gridX
end

function PlayerInfo:setGridY(gridY)
    self._gridY = gridY
end

function PlayerInfo:getGridX()
    return self._gridX
end

function PlayerInfo:getGridY()
    return self._gridY
end

function PlayerInfo:getFileName()
    return self._fileName
end

function PlayerInfo:getBodyWidth()
    return self._bodyWidth
end

function PlayerInfo:getProperty()
    return self._property
end

function PlayerInfo:getIsShodow()
    return self._isShodow
end

function PlayerInfo:setIsShodow(isShodow)
    self._isShodow = isShodow
end

function PlayerInfo:setIsAuto(isAuto)
    self._isAuto = isAuto
end

function PlayerInfo:getIsAuto()
    return self._isAuto
end

function PlayerInfo:getIsDeath()
    return self._property.hp <= 0
end

function PlayerInfo:acceptHp(damageResult)
    local originalHp = self._property.hp
    damageResult:setOriginalHp(originalHp)
    
    self._property.hp = self._property.hp + damageResult:getDamageValue()
    if self._property.hp > self._property.maxHp then
        self._property.hp = self._property.maxHp
    elseif self._property.hp < 0 then
        self._property.hp = 0
    end
    
    if originalHp > 0 and self._property.hp <= 0 then
        damageResult:setIsDamageDead(true)
    else
        damageResult:setIsDamageDead(false)
    end
    
    local attPlayerId = damageResult:getAttPlayer():getPlayerInfo():getId()
    local attSkillkey = damageResult:getAttPlayer():getSkillComponent():getCurSkillInfo():getKey()
    local attUseSkillTime = damageResult:getAttPlayer():getSkillComponent():getUseSkillTime()
    local key = attPlayerId .. "_" .. attSkillkey .. "_" .. attUseSkillTime
    if self._lastAttKey ~= key then
        self._lastAttKey = key
        self._property.energy = self._property.energy + 25
        if self._property.energy > self._property.maxEnergy then
            self._property.energy = self._property.maxEnergy
        end
    end
end

function PlayerInfo:clearLastAttackInfo()
    self._lastAttackerId = nil
    self._lastAttackSkillKey = nil
end

function PlayerInfo:clearEnergy()
    self._property.energy = 0
end

function PlayerInfo:isEnergyFull()
    return self._property.energy >= self._property.maxEnergy
end

function PlayerInfo:clone()
    local playerInfo = PlayerInfo.create()
    playerInfo:parse(self._infoData)
--    playerInfo:getProperty().hp = self:getProperty().hp
    return playerInfo
end