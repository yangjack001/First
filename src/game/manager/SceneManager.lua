SceneManager = class("SceneManager")

SceneManager._battleScene = nil
SceneManager._safetyScene = nil

SceneManager._curScene = nil

function SceneManager.loadBattleScene(id, battle)
--    if SceneManager._curScene ~= nil then
--        SceneManager._curScene:dispose()
--    end
    
    local BattleScene = require("game/scene/BattleScene")
    SceneManager._curScene = BattleScene.createScene(id, battle)
    cc.Director:getInstance():replaceScene(SceneManager._curScene)
    return SceneManager._curScene
end

function SceneManager.loadSafetyScene(name)
    local SafetyScene = require("game/scene/SafetyScene")
    SceneManager._curScene = SafetyScene.createScene(name)
    cc.Director:getInstance():replaceScene(SceneManager._curScene)
end

function SceneManager.getCurScene()
    return SceneManager._curScene
end