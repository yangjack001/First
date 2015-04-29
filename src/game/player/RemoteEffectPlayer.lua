require("game/manager/AnimationManager")
require("game/type/EffectActionType")
require("game/player/avatar/RemoteEffectAvatar")
require("game/player/components/ActionComponent")
require("game/config/RemoteEffectActionInfoConfig")
require("game/type/PlayerMoveType")
require("game/util/MathUtil")

local RemoteEffectPlayer = class("RemoteEffectPlayer", function()
    return cc.Sprite:create()
end)

function RemoteEffectPlayer.create(remoteEffectInfo, sourcePlayerList)
    local remoteEffect = RemoteEffectPlayer:new()
    remoteEffect:init(remoteEffectInfo, sourcePlayerList)
    return remoteEffect
end

RemoteEffectPlayer._remoteEffectInfo = nil
RemoteEffectPlayer._avatar = nil
RemoteEffectPlayer._sourcePlayerList = nil
RemoteEffectPlayer._targetPlayer = nil
RemoteEffectPlayer._curSkillInfo = nil
RemoteEffectPlayer._isPause = nil
RemoteEffectPlayer._isFocus = nil
RemoteEffectPlayer._actionComponent = nil
RemoteEffectPlayer._attContext = nil
RemoteEffectPlayer._callback = nil

function RemoteEffectPlayer:init(remoteEffectInfo, sourcePlayerList)
    self._remoteEffectInfo = remoteEffectInfo
    self._sourcePlayerList = sourcePlayerList
    self._attContext = self._sourcePlayerList[1]:getCurAttackContext()
    self._curSkillInfo = sourcePlayerList[1]:getSkillComponent():getCurSkillInfo()
    self._avatar = RemoteEffectAvatar.create(remoteEffectInfo:getResId())
    self._avatar:setPosition(remoteEffectInfo:getOffsetX(),remoteEffectInfo:getOffsetY())

    self:addChild(self._avatar)

    local actionInfoMap = RemoteEffectActionInfoConfig.getActionInfoMap(self._remoteEffectInfo:getId())

    self._actionComponent = ActionComponent.create(self, actionInfoMap)
end

function RemoteEffectPlayer:setTargetPlayer(targetPlayer)
    self._targetPlayer = targetPlayer
end

function RemoteEffectPlayer:getTargetPlayer()
    return self._targetPlayer
end

function RemoteEffectPlayer:start(callback)
    self._callback = callback
    if self._remoteEffectInfo:getMoveType() == PlayerMoveType.NOT_MOVE then
        self._actionComponent:doAction(EffectActionType.START, function()
            SceneManager.getCurScene():getRemoteEffectManager():removeRemoteEffect(self)
        end)
        self:showFocusPlayer(EffectActionType.START)
    elseif self._remoteEffectInfo:getMoveType() == PlayerMoveType.TRACK_CURRENT_POSITION then
        self:moveTo(self._targetPlayer:getPositionX(), self._targetPlayer:getPositionY() - 1)
    elseif self._remoteEffectInfo:getMoveType() == PlayerMoveType.TRACK_CURRENT_POSITION then
        self:moveTo(self._targetPlayer:getOriginalPositionX(), self._targetPlayer:getOriginalPositionY() - 1)
    end
end

function RemoteEffectPlayer:moveTo(x, y)
    local duration = self._remoteEffectInfo:getMoveTime()
    local actionMove = cc.MoveTo:create(duration,cc.p(x,y))
    local actionCallback = cc.CallFunc:create(function()
        if self._actionComponent:hasActionInfo(EffectActionType.END) then
            self._actionComponent:doAction(EffectActionType.END, function()
                SceneManager.getCurScene():getRemoteEffectManager():removeRemoteEffect(self)
            end)
        else 
            self._actionComponent:excuteFinalScript()
            SceneManager.getCurScene():getRemoteEffectManager():removeRemoteEffect(self)
        end
    end)

    if self:getPositionX() > x then
        self:setDirection(DirectionType.LEFT)
    elseif self:getPositionX() < x then
        self:setDirection(DirectionType.RIGHT)
    end 
    
    self._actionComponent:doAction(EffectActionType.LOOP)
    self:showFocusPlayer(EffectActionType.LOOP)
    local rotation = MathUtil.getCocosRotation(x,y,self:getPositionX(),self:getPositionY())
    self._avatar:setRotation(rotation)
    self:runAction(cc.Sequence:create(actionMove,actionCallback))
end

function RemoteEffectPlayer:showFocusPlayer(actionType)
    local playerActionInfoMap = RemoteEffectActionInfoConfig.getActionInfoMap(self._remoteEffectInfo:getId())
    local actionInfo = playerActionInfoMap:getActionInfoByType(actionType)
    if actionInfo == nil then
        return
    end
    
    local focus = function(listScript)
        local result = {}
        for i = 1, #listScript do
            local script = listScript[i]
            if script:getType() == ActionScriptType.HIT_CHECK then
                local players = HitCheckManager:getInstance():getBehitTargetList(script:getHitCheckType(),self._targetPlayer,self._attContext:getEnemyPlayerGroup())
                for j, player in pairs(players) do
                    SceneManager.getCurScene():getContainerLayer():setFocus(player)
                end
            end
        end
    end
    
    focus(actionInfo:getListScripts())
    focus(actionInfo:getFinalScripts())
end

function RemoteEffectPlayer:onTick(t)
    self._actionComponent:onTick(t)
end

function RemoteEffectPlayer:setDirection(direction)
    self._avatar:setScaleX(direction)
end

function RemoteEffectPlayer:applyCallback()
    if self._callback ~= nil then
        self._callback()
    end
end

function RemoteEffectPlayer:pausePlayer()
    self:pause()
    self._avatar:pauseAvatar()
    self._isPause = true
end

function RemoteEffectPlayer:resumePlayer()
    self:resume()
    self._avatar:resumeAvatar()
    self._isPause = false
end

function RemoteEffectPlayer:getIsPause()
    return self._isPause
end

function RemoteEffectPlayer:isFocus()
    return self._isFocus
end

function RemoteEffectPlayer:setIsFocuse(focus)
    self._isFocus = focus
end

function RemoteEffectPlayer:getAvatar()
    return self._avatar
end

function RemoteEffectPlayer:getCurAttackContext()
    return self._attContext
end

function RemoteEffectPlayer:getCurActionInfo()
    return self._actionComponent:getCurActionInfo()
end

function RemoteEffectPlayer:getPlayerInfo()
    return self._sourcePlayerList[1]:getPlayerInfo()
end

function RemoteEffectPlayer:getSkillComponent()
    return self._sourcePlayerList[1]:getSkillComponent()
end

function RemoteEffectPlayer:getCurSkillInfo()
    return self._curSkillInfo
end

function RemoteEffectPlayer:hit(damageResult)
    
end

function RemoteEffectPlayer:dispose()
    self._avatar:dispose()
end

return RemoteEffectPlayer