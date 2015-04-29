require("game/type/AvatarLayerType")
require("game/type/SceneLayerType")
require("game/model/info/ActionEffectInfo")

ActionEffectConfig = class("ActionEffectConfig")

ActionEffectConfig._define = {
    [1]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [2]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [3]= {layerType=SceneLayerType.EFFECT},
    [4]= {layerType=AvatarLayerType.ACTION_EFFECT_BACK},
    [5]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [6]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [7]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [8]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [9]= {layerType=SceneLayerType.EFFECT},
    [10]= {layerType=SceneLayerType.EFFECT},
    [11]= {layerType=SceneLayerType.EFFECT},
    [12]= {layerType=SceneLayerType.EFFECT},
    [13]= {layerType=SceneLayerType.EFFECT},
    [14]= {layerType=SceneLayerType.EFFECT},
    [15]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [16]= {layerType=AvatarLayerType.ACTION_EFFECT_FRONT},
    [17]= {layerType=AvatarLayerType.ACTION_EFFECT_BACK},
    [18]= {layerType=SceneLayerType.EFFECT},
    [19]= {layerType=SceneLayerType.EFFECT,offsetX=-150,offsetY=-100},
    [20]= {layerType=SceneLayerType.EFFECT,offsetX=-150,offsetY=-100}
}

ActionEffectConfig._actionInfoData = nil

function ActionEffectConfig.init()
    ActionEffectConfig._actionInfoData = {}
    for effectId, effectData in pairs(ActionEffectConfig._define) do
        local effect = ActionEffectInfo.create(effectId)
        effect:parse(effectData)
        ActionEffectConfig._actionInfoData[effectId] = effect
    end
end

function ActionEffectConfig.getEffectById(effectId)
    if ActionEffectConfig._actionInfoData == nil then
        ActionEffectConfig.init()
    end

    if ActionEffectConfig._actionInfoData[effectId] == nil then
        error(StringManager.getString(StringKey.ACTION_EFFECT_ID_ERROR, effectId))
    else
        return ActionEffectConfig._actionInfoData[effectId]
    end
end