require("game/event/AvatarEvent")
require("game/player/components/actionscript/BaseActionScript")

MoveScript = class("MoveScript",function()
    return BaseActionScript.create()
end)

MoveScript._player = nil

function MoveScript.create(player)
    local script = MoveScript:new()
    script:init(player)
    return script
end

function MoveScript:init(player)
    self._player = player
end

function MoveScript:excute(moveScriptArg)
    local time = moveScriptArg:getTime()
    local attContext = self._player:getCurAttackContext()
    local targetX, targetY
    local positionType = moveScriptArg:getPositionType()
    if positionType == PositionType.RELATIVE then
        local targetPlayer
        if moveScriptArg:getTargetType() == TargetType.SELF then
            targetPlayer = self._player
        elseif moveScriptArg:getTargetType() == TargetType.SKILL_TARGET then
            targetPlayer = self._player:getTargetPlayer()
        else
            targetPlayer = self._player
        end
        
        targetY = targetPlayer:getPositionY() + moveScriptArg:getMoveY()
        if targetPlayer:getGroup() == GroupType.LEFT then
            targetX = targetPlayer:getPositionX() + moveScriptArg:getMoveX()
        else 
            targetX = targetPlayer:getPositionX() - moveScriptArg:getMoveX()
        end
    elseif positionType == PositionType.ABSOLUTE then
        targetX = moveScriptArg:getMoveX()
        targetY = moveScriptArg:getMoveY()
    elseif positionType == PositionType.FIGHT_POSITION then
        targetX = self._player:getOriginalPositionX()
        targetY = self._player:getOriginalPositionY()
    end
    
    self._player:moveTo(targetX, targetY, nil, time, false)
end