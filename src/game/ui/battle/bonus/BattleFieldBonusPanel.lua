require("game/util/render/SimpleButton")

BattleFieldBonusPanel = class("BattleFieldBonusPanel",function()
    return cc.Layer:create()
end)

function BattleFieldBonusPanel.create()
    local panel = BattleFieldBonusPanel:new()
    panel:init()
    return panel
end

BattleFieldBonusPanel._btnRestart = nil
BattleFieldBonusPanel._btnBack = nil

function BattleFieldBonusPanel:init()
    local res = cc.CSLoader:createNode("res/ui/battlefield/endpanel.csb")
    local btnRestart = res:getChildByName("btn_restart")
    res:removeChild(btnRestart)
    self._btnRestart = SimpleButton.create(btnRestart, function()
        self:onClickRestart()
        end, btnRestart:getPositionX(), btnRestart:getPositionY())
    res:addChild(self._btnRestart)
    btnRestart:setPosition(0, 0)
    
    local btnBack = res:getChildByName("btn_back")
    res:removeChild(btnBack)
    self._btnBack = SimpleButton.create(btnBack, function()
        self:onClickBack()
        end, btnBack:getPositionX(), btnBack:getPositionY())
    res:addChild(self._btnBack)
    btnBack:setPosition(0, 0)
    
    self:addChild(res)
end

function BattleFieldBonusPanel:onClickRestart()
    BattleFieldManager.loadBattleField(1)
end

function BattleFieldBonusPanel:onClickBack()
    local scene = require("StartScene")
    local gameScene = scene.createScene()
    cc.Director:getInstance():replaceScene(gameScene)
end