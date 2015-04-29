require("game/ui/battle/BattleHUD")
require("game/ui/npc/NPCTalkPanel")
require("game/type/SceneLayerType")

BattleUILayer = class("BattleUILayer",function()
    return cc.Layer:create()
end)

BattleUILayer._battleScene = nil
BattleUILayer._hud = nil
BattleUILayer._npcPanel = nil
BattleUILayer._isShowing = nil

function BattleUILayer.create(battleScene)
    local layer = BattleUILayer:new()
    layer:init(battleScene)
    return layer
end

function BattleUILayer:init(battleScene)
    self._battleScene = battleScene
    
    battleScene:addChild(self,SceneLayerType.UI)
    
    self:setCascadeOpacityEnabled(true)
     
    self._isShowing = false
end

function BattleUILayer:showHUD()
    if self._hud == nil then
        self._hud = BattleHUD.create(self._battleScene)
        self._hud:retain()
    end
    
    if self._hud:getParent() == nil then
        self:addChild(self._hud)
    end
end

function BattleUILayer:hideHUD()
    if self._hud:getParent() ~= nil then
        self:removeChild(self._hud)
    end
end

function BattleUILayer:showBonusPanel()
    self:removeChild(self._hud)
    
    local panel = BattleFieldBonusPanel.create()
    self:addChild(panel)
end

function BattleUILayer:showNPCPanel(npcTalkInfo,callback)
    if self._npcPanel == nil then
        self._npcPanel = NPCTalkPanel.create(self)
        self._npcPanel:retain()
    end
    
    self._npcPanel:showPanel(npcTalkInfo,callback)
end

function BattleUILayer:onTick(t)

end

function BattleUILayer:getHUD()
    return self._hud
end

function BattleUILayer:hide()
    if not self._isShowing then
        return
    end
    
--    local fadeOutAction = cc.FadeOut:create(0.2)
--    self:runAction(fadeOutAction)
    self:setPositionY(1000)
    self._isShowing = false
end

function BattleUILayer:show()
    if self._isShowing then
        return
    end
    
--    local fadeInAction = cc.FadeIn:create(0.2)
--    self:runAction(fadeInAction)
    self:setPositionY(0)
    self._isShowing = true
end

function BattleUILayer:dispose()
    self._hud:dispose()
    self._hud:release()
    self._npcPanel:release()
end