require("game/type/GroupType")
require("game/manager/SceneManager")
require("game/battlefield/battle/context/BattleAttackContext")
require("game/event/BattleEvent")

ManualSkillManager = class("ManualSkillManager")

function ManualSkillManager.create(scene)
    local manager = ManualSkillManager:new()
    manager:init(scene)
    return manager
end

ManualSkillManager._scene = nil
ManualSkillManager._containerLayer = nil
ManualSkillManager._uiLayer = nil
ManualSkillManager._playerManager = nil
ManualSkillManager._listFocusPlayer = nil
ManualSkillManager._listUseSkillPlayer = nil

function ManualSkillManager:init(scene)
    self._scene = scene
    self._containerLayer = scene:getContainerLayer()
    self._uiLayer = scene:getUILayer()
    self._playerManager = scene:getPlayerManager()
    self._listFocusPlayer = {}
    self._listUseSkillPlayer = {}
end

function ManualSkillManager:useManualSkill(player, skillKey, hideUI, alpha)
    if #self._listFocusPlayer == 0 then
        self._playerManager:pause()
        self._containerLayer:addGrayMask(alpha)
        self._containerLayer:stopDepthSort()
    end
    
    if hideUI then
        self._uiLayer:hide()
    end
    
    table.insert(self._listFocusPlayer,player)
    table.insert(self._listUseSkillPlayer,player)
    self._containerLayer:setFocus(player)
    player:setFocus(true)
    player:useManualSkill(skillKey, self:getAttackContext(player), function()
        TableUtil.remove(self._listUseSkillPlayer,player)
        self:checkDispatcherEvt()
    end)
end

function ManualSkillManager:checkDispatcherEvt()
    if #self._listUseSkillPlayer == 0 then
        local evt = cc.EventCustom:new(BattleEvent.END_ALL_FOCUS)
        self._scene:getEventDispatcher():dispatchEvent(evt)
    end
end

function ManualSkillManager:setFocusEffect(player, time)
    ScheduleUtil:getInstance():addTimeSchedule(time,function()
        player:setFocus(false)
        TableUtil.remove(self._listFocusPlayer,player)
        if #self._listFocusPlayer == 0 then
            self:stopPause()
        end
    end)
end

function ManualSkillManager:getAttackContext(player)
    local curAttackContext = BattleAttackContext.create()
    curAttackContext:setAttPlayer(player)
    if player:getGroup() == GroupType.LEFT then
        curAttackContext:setFriendlyPlayerGroup(SceneManager.getCurScene():getPlayerManager():getLeftPlayerGroup())
        curAttackContext:setEnemyPlayerGroup(SceneManager.getCurScene():getPlayerManager():getRightPlayerGroup())
    else
        curAttackContext:setFriendlyPlayerGroup(SceneManager.getCurScene():getPlayerManager():getRightPlayerGroup())
        curAttackContext:setEnemyPlayerGroup(SceneManager.getCurScene():getPlayerManager():getLeftPlayerGroup())
    end

    return curAttackContext
end

function ManualSkillManager:stopPause()
    self._containerLayer:removeGrayMask()
    self._playerManager:resume()
    self._containerLayer:startDepthSort()
    self._uiLayer:show()
    SceneManager.getCurScene():getUILayer():showHUD()
end

function ManualSkillManager:getIsFocus()
    return #self._listUseSkillPlayer > 0
end