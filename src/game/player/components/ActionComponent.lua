require("game/config/ActionInfoConfig")
require("game/event/PlayerEvent")
require("game/type/ActionScriptType")
require("game/player/components/actionscript/SkillFinishScript")
require("game/player/components/actionscript/HitCheckScript")
require("game/player/components/actionscript/ActionEffectScript")
require("game/player/components/actionscript/RemoteEffectScript")
require("game/player/components/actionscript/CPUseSkillScript")
require("game/player/components/actionscript/AddBuffScript")
require("game/player/components/actionscript/AnimationFinishScript")
require("game/player/components/actionscript/MoveScript")
require("game/player/components/actionscript/CreateShadowScript")

ActionComponent = class("ActionComponent")

function ActionComponent.create(player, actionInfoMap)
    local component = ActionComponent:new()
    component:init(player, actionInfoMap)
    return component
end

ActionComponent._player = nil
ActionComponent._avatar = nil
ActionComponent._actionInfoMap = nil
ActionComponent._listener = nil

ActionComponent._curActionInfo = nil
ActionComponent._actionStartTime = nil
ActionComponent._lastTickTime = nil
ActionComponent._scriptMap = nil

function ActionComponent:init(player, actionInfoMap)
    self._player = player
    self._actionInfoMap = actionInfoMap
    self._avatar = self._player:getAvatar()
    self._lastTickTime = 0
    self:initScripts()
end

function ActionComponent:doAction(actionType, callback)
    local actionInfo = self._actionInfoMap:getActionInfoByType(actionType)
    local listener
    local onAnimationComplete = function(evt)
        if evt.avatar ~= self._avatar then
            return 
        end
        if evt.animation ~= actionInfo:getAnimation() then
            return
        end
        
        self._avatar:getEventDispatcher():removeEventListener(listener)
        
        local evt2 = cc.EventCustom:new(PlayerEvent.ACTION_ANIMATION_COMPLETE)
        evt2.player = self._player
        evt2.animation = evt.animation
        self._player:getEventDispatcher():dispatchEvent(evt2)
        
        if callback ~= nil then
            callback()
        end
    end
    
    listener = cc.EventListenerCustom:create(AvatarEvent.ANIMATION_COMPLETE, onAnimationComplete)
    if not actionInfo:getIsLoop() then
        self._avatar:getEventDispatcher():addEventListenerWithFixedPriority(listener, 1)
    end
    
    self._avatar:playAnimation(actionInfo:getAnimation(), actionInfo:getIsLoop())    
    
    self._curActionInfo = actionInfo
    self._actionStartTime = os.clock()
    
    self:onTick()
end

function ActionComponent:doBeHitAction()
    self:doAction(ActionType.BE_HIT,function()
        if not self._player:getIsDeath() then
            self._player:doAction(ActionType.IDLE)
        end
    end)
end

function ActionComponent:doDeathAction()
    self:doAction(ActionType.DEATH, function()
        self._player:stopAllActions()
        local fadeOutAction = cc.FadeOut:create(1)
        self._player:runAction(fadeOutAction)
    end)
end

function ActionComponent:onTick()
    if self._player:getIsPause() then
        return
    end
    
    local scripts = self._curActionInfo:getListScripts()
    local curTime = os.clock()
    for i = 1,#scripts do
        local actionScriptArg = scripts[i]
        local scriptExcuteTime = self._actionStartTime + actionScriptArg:getStartTime()
        if scriptExcuteTime <= curTime and scriptExcuteTime > self._lastTickTime then
            local type = actionScriptArg:getType()
            if self._scriptMap[type] == nil then
                self._scriptMap[type] = ActionComponent.getScriptInstanceByType(type,self._player)
            end
            
            self._scriptMap[type]:excute(actionScriptArg)
        end
    end
    self._lastTickTime = curTime
end

function ActionComponent:excuteFinalScript()
    local scripts = self._curActionInfo:getFinalScripts()
    for i = 1,#scripts do
        local actionScriptArg = scripts[i]
        local type = actionScriptArg:getType()
        if self._scriptMap[type] == nil then
            self._scriptMap[type] = ActionComponent.getScriptInstanceByType(type,self._player)
        end

        self._scriptMap[type]:excute(actionScriptArg)
    end
end

function ActionComponent:initScripts()
    self._scriptMap = {}
end

function ActionComponent:getCurActionInfo()
    return self._curActionInfo
end

function ActionComponent:hasActionInfo(actionType)
    return self._actionInfoMap:getActionInfoByType(actionType) ~= nil
end

function ActionComponent:dispose()
    
end

function ActionComponent.getScriptInstanceByType(type,player)
    if type == ActionScriptType.SKILL_FINISH then
        return SkillFinishScript.create(player)
    elseif type == ActionScriptType.HIT_CHECK then
        return HitCheckScript.create(player)
    elseif type == ActionScriptType.ACTION_EFFECT then
        return ActionEffectScript.create(player)
    elseif type == ActionScriptType.REMOTE_EFFECT then
        return RemoteEffectScript.create(player)
    elseif type == ActionScriptType.CP_USE_SKILL then
        return CPUseSkillScript.create(player)
    elseif type == ActionScriptType.ADD_BUFF then
        return AddBuffScript.create(player)
    elseif type == ActionScriptType.ANIMATION_FINISH then
        return AnimationFinishScript.create(player)
    elseif type == ActionScriptType.MOVE then
        return MoveScript.create(player)
    elseif type == ActionScriptType.CREATE_SHADOW then
        return CreateShadowScript.create(player)
    end
end