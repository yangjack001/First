require("game/model/info/SceneInfo")
SceneConfig = class("SceneConfig")

SceneConfig._data = {
    [1] = {
        name = "hongmoguan1",
        background = {
            {zOrder = 1,fileUrl = "res/scene/battle/hongmoguan/hongmoguan_1_1.png", width = 1875, height=750, speed = 0},
            {zOrder = 2,fileUrl = "res/scene/battle/hongmoguan/hongmoguan_1_2.png", width = 1875, height=750, speed = 2}
        }
    },
    [2] = {
        name = "hongmoguan2",
        background = {
            {zOrder = 1,fileUrl = "res/scene/battle/hongmoguan/hongmoguan_1_1.png", width = 1875, height=750, speed = 0},
            {zOrder = 2,fileUrl = "res/scene/battle/hongmoguan/hongmoguan_1_2.png", width = 1875, height=750, speed = 2}
        }
    },
    [3] = {
        name = "hongmoguan3",
        background = {
            {zOrder = 1,fileUrl = "res/scene/battle/hongmoguan/hongmoguan_1_1.png", width = 1875, height=750, speed = 0},
            {zOrder = 2,fileUrl = "res/scene/battle/hongmoguan/hongmoguan_1_2.png", width = 1875, height=750, speed = 2}
        }
    }
}

SceneConfig._idToSceneInfo = nil
SceneConfig._nameToSceneInfo = nil

function SceneConfig.init()
    SceneConfig._idToSceneInfo = {}
    SceneConfig._nameToSceneInfo = {}
    
    for sceneId, sceneData in pairs(SceneConfig._data) do
        local sceneInfo = SceneInfo.create(sceneId)
        sceneInfo:parse(sceneData)
        SceneConfig._idToSceneInfo[sceneInfo:getId()] = sceneInfo
        SceneConfig._nameToSceneInfo[sceneInfo:getName()] = sceneInfo
    end
end

function SceneConfig.getSceneInfoById(id)
    if SceneConfig._idToSceneInfo == nil then
        SceneConfig.init()
    end
    
    if SceneConfig._idToSceneInfo[id] == nil then
        error(StringManager.getString(StringKey.SCENE_ID_ERROR, id))
    else
        return SceneConfig._idToSceneInfo[id]
    end
end

function SceneConfig.getSceneInfoByName(name)
    if SceneConfig._nameToSceneInfo == nil then
        SceneConfig.init()
    end
    
    if SceneConfig._nameToSceneInfo[name] == nil then
        error(StringManager.getString(StringKey.SCENE_NAME_ERROR, name))
    else
        return SceneConfig._nameToSceneInfo[name]
    end
end