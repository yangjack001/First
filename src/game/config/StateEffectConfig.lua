require("game/type/AvatarLayerType")
require("game/model/info/StateEffectInfo")

StateEffectConfig = class("StateEffectConfig")

StateEffectConfig._data = {
    [1] = {layerType = AvatarLayerType.STATE_EFFECT_BACK}
}

StateEffectConfig._effectDefine = nil

function StateEffectConfig.init()
    StateEffectConfig._effectDefine = {}
    
    for effectId, effectData in pairs(StateEffectConfig._data) do
        local effectInfo = StateEffectInfo.create(effectId)
        effectInfo:parse(effectData)
        StateEffectConfig._effectDefine[effectId] = effectInfo
    end
end

function StateEffectConfig.getEffectById(id)
    if StateEffectConfig._effectDefine == nil then
        StateEffectConfig.init()
    end
    
    if StateEffectConfig._effectDefine[id] == nil then
        error(StringManager.getString(StringKey.STATE_EFFECT_ID_ERROR, id))
    else
        return StateEffectConfig._effectDefine[id]
    end
end