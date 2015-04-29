require("game/config/URLConfig")
require("game/event/AvatarEvent")
require("game/type/ActionType")
require("game/type/AvatarLayerType")
require("game/config/ActionEffectConfig")
require("game/manager/AnimationManager")
require("game/type/EffectActionType")
require("game/player/avatar/BaseAvatar")
require("game/config/StateEffectConfig")

PlayerAvatar = class("PlayerAvatar",function()
    local avatar = BaseAvatar.create()
    avatar.__playAnimation = avatar.playAnimation
    return avatar
end)

PlayerAvatar.STATE_EFFECT_NAME = "STATE_EFFECT_"

PlayerAvatar._effectMap = nil
PlayerAvatar._listActionEffect = nil

function PlayerAvatar.create(fileName, clothId)
    local avatar = PlayerAvatar:new()
    avatar:init(fileName, clothId)
    return avatar
end

function PlayerAvatar:init(fileName, clothId)
    local startTime = os.clock()
    self:initActionEffect()
    self:loadBody(fileName, clothId)
end

function PlayerAvatar:loadBody(fileName, clothId)
    local startTime = os.clock()
    local skeleton = AnimationManager.getPlayerBody(fileName,clothId)
    self:addChild(skeleton,AvatarLayerType.BODY)
    self._armature = skeleton
    self:addAnimationEvent()
end

function PlayerAvatar:initActionEffect()
    self._effectMap = {}
    self._listActionEffect = {}

    for i = 1, #AvatarLayerType.listEffectLayers do
        local container = cc.Sprite:create()
        local key = AvatarLayerType.listEffectLayers[i]
        self:addChild(container, key)
        self._effectMap[key] = container
    end
end

function PlayerAvatar:initBuffEffect()
    self._buffEffectMap = {}
end

function PlayerAvatar:getContainer(layerType)
    if layerType == SceneLayerType.EFFECT then
        return SceneManager.getCurScene():getEffectLayer()
    else
        return self._effectMap[layerType]
    end
end

function PlayerAvatar:addActionEffect(effectId)
    local effectInfo = ActionEffectConfig.getEffectById(effectId)
    local container = self:getContainer(effectInfo:getLayerType())
    local armatureNode = AnimationManager.getActionEffect(effectInfo:getId())
    if effectInfo:getLayerType() == SceneLayerType.EFFECT then
        table.insert(self._listActionEffect,armatureNode)
        armatureNode:setScaleX(self:getScaleX())
        armatureNode:setPosition(effectInfo:getOffsetX() + self:getParent():getPositionX(), effectInfo:getOffsetY() + self:getParent():getPositionY())
    else
        armatureNode:setPosition(effectInfo:getOffsetX(), effectInfo:getOffsetY())
    end

    armatureNode:getAnimation():gotoAndPlay(EffectActionType.START,-1,-1,1)
    container:addChild(armatureNode)
end

function PlayerAvatar:removeAllActionEffect()
    if #self._listActionEffect == 0 then
        return
    end

    local container = self:getContainer(SceneLayerType.EFFECT)

    for i = 1, #self._listActionEffect do
        container:removeChild(self._listActionEffect[i])
    end

    self._listActionEffect = {}
end

function PlayerAvatar:addStateEffect(effectId)
    local effectInfo = StateEffectConfig.getEffectById(effectId)
    local container = self:getContainer(effectInfo:getLayerType())
    local skeleton = AnimationManager.getStateEffectSkeleton(effectInfo:getId())
    container:addChild(skeleton)
    skeleton:setName(PlayerAvatar.STATE_EFFECT_NAME..effectId)

    skeleton:setAnimation(0,EffectActionType.LOOP, true)
end

function PlayerAvatar:removeStateEffect(effectId)
    local effectInfo = StateEffectConfig.getEffectById(effectId)
    local container = self:getContainer(effectInfo:getLayerType())
    local skeleton = container:getChildByName(PlayerAvatar.STATE_EFFECT_NAME..effectId)

    container:removeChild(skeleton)
end

function PlayerAvatar:playAnimation(animationName, isLoop)
    self:getContainer(AvatarLayerType.ACTION_EFFECT_FRONT):removeAllChildren()
    self:removeAllActionEffect()

    self:__playAnimation(animationName, isLoop)
end

function PlayerAvatar:moveTo(x, y, duration)
    for i = 1, #self._listActionEffect do
        local actionMove = cc.MoveTo:create(duration,cc.p(x,y))
        self._listActionEffect[i]:runAction(actionMove)
    end
end

function PlayerAvatar:pauseAvatar()
    for i = 1, #self._listActionEffect do
        local effect = self._listActionEffect[i]
        effect:pause()
    end

    self._armature:pause()
end

function PlayerAvatar:resumeAvatar()
    for i = 1, #self._listActionEffect do
        local effect = self._listActionEffect[i]
        effect:resume()
    end

    self._armature:resume()
end

function PlayerAvatar:dispose()

end