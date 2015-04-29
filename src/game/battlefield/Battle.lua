require("game/util/workflow/BaseWork")
require("game/battlefield/battle/BattleStart")
require("game/battlefield/battle/BattleRoundLoop")
require("game/battlefield/battle/BattleEnd")
require("game/manager/SceneManager")
require("game/battlefield/script/BattleScriptManager")
require("game/event/BattleEvent")
require("game/battlefield/battle/context/BattleContext")
require("game/event/BattleEventDispatcher")

Battle = class("Battle",function()
    return BaseWork:create()
end)

Battle._battleInfo = nil
Battle._battleContext = nil
Battle._eventDispatcher = nil
Battle._battleScriptManager = nil
Battle._scene = nil

function Battle.create(battleInfo)
    local work = Battle:new()
    work:init(battleInfo)
    return work
end

function Battle:init(battleInfo)
    self._battleInfo = battleInfo
    self._eventDispatcher = BattleEventDispatcher.create()
    self._battleScriptManager = BattleScriptManager.create(self)

    self:addSubWork(BattleStart.create(self))
    self:addSubWork(BattleRoundLoop.create(self))
    self:addSubWork(BattleEnd.create(self))
    self:loadScene()
end

function Battle:loadScene()
    self._scene = SceneManager.loadBattleScene(self._battleInfo:getSceneId(), self)
    local context = BattleContext.create(self._scene)
    self._battleContext = context
    
    local listener
    local onSceneInited = function(evt)
        self._scene:getEventDispatcher():removeEventListener(listener)
        self._battleScriptManager:runScript(BattleEvent.BEFORE_BATTLE, function()
            self:start(self._battleContext)
        end)
    end
    
    listener = cc.EventListenerCustom:create(SceneEvent.ON_INITED, onSceneInited)
    self._scene:getEventDispatcher():addEventListenerWithFixedPriority(listener, 1)
end

function Battle:finish()
    print("Battle Finish")
    SceneManager.getCurScene():getUILayer():hideHUD()

    if self._battleContext:getIsBattleFailed() then
        local evt = BattleEvent.create(BattleEvent.BATTLE_END, self._context)
        self:getEventDispatcher():dispatchEvent(evt)
    else
        self._battleScriptManager:runScript(BattleEvent.FINISH_BATTLE, function()
            local evt = BattleEvent.create(BattleEvent.BATTLE_END, self._context)
            self:getEventDispatcher():dispatchEvent(evt)
        end)
    end
end

function Battle:getBattleContext()
    return self._battleContext
end

function Battle:getBattleInfo()
    return self._battleInfo
end

function Battle:getEventDispatcher()
    return self._eventDispatcher
end

function Battle:getScene()
    return self._scene
end