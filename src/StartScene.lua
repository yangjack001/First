require("game/manager/BattleFieldManager")
require("game/config/GameConfig")
require("game/util/ColorUtil")
require("game/ui/battle/bonus/BattleFieldBonusPanel")

require("game/player/Player")
require("game/config/PlayerInfoConfig")
require("game/util/schedule/ScheduleUtil")
require("game/manager/AnimationManager")

local StartScene = class("StartScene", function()
    return cc.Scene:create()
end)

function StartScene.createScene()
    local scene = StartScene:new()
    scene:addChild(scene:createLayer())
    return scene
end

function StartScene:ctor()
    self.visibleSize = cc.Director:getInstance():getVisibleSize()
end

function StartScene:createLayer()
    local layer = cc.Layer:create()
    local menu = self:createMenu()
    layer:addChild(menu)
    
    local player1 = Player.create(PlayerInfoConfig.getPlayerInfoById(1), GroupType.LEFT)
    player1:setPosition(GameConfig.DESIGN_WIDTH / 2 - 200,450)
    local player2 = Player.create(PlayerInfoConfig.getPlayerInfoById(2), GroupType.LEFT)
    player2:setPosition(GameConfig.DESIGN_WIDTH / 2,450)
    local player3 = Player.create(PlayerInfoConfig.getPlayerInfoById(3), GroupType.LEFT)
    player3:setPosition(GameConfig.DESIGN_WIDTH / 2 + 200,450)
    
    layer:addChild(player1)
    layer:addChild(player2)
    layer:addChild(player3)
    
    return layer
end

function StartScene:createMenu()
    cc.MenuItemFont:setFontSize(40)
    local menuItemStart = cc.MenuItemFont:create("Start")
    menuItemStart:setPosition(0,20)
    menuItemStart:registerScriptTapHandler(function(sender)
        BattleFieldManager.loadBattleField(1)
    end)
    
    local menuItemExit = cc.MenuItemFont:create("Exit")
    menuItemExit:setPosition(0,-20)
    menuItemExit:registerScriptTapHandler(function(sender)
        cc.Director:getInstance():endToLua()
    end)
    local menu = cc.Menu:create(menuItemStart, menuItemExit)
    menu:alignItemsHorizontallyWithPadding(200)
    menu:setPosition(self.visibleSize.width / 2,self.visibleSize.height / 2)
    return menu
end

return StartScene