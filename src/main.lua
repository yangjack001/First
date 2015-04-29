
cc.FileUtils:getInstance():addSearchPath("src")
cc.FileUtils:getInstance():addSearchPath("assets")
cc.FileUtils:getInstance():addSearchPath("res")

-- CC_USE_DEPRECATED_API = true
require "cocos.init"
   
-- cclog
local cclog = function(...)
    print(string.format(...))
end

-- for CCLuaEngine traceback
function __G__TRACKBACK__(msg)
    cclog("----------------------------------------")
    cclog("LUA ERROR: " .. tostring(msg) .. "\n")
    cclog(debug.traceback())
    cclog("----------------------------------------")
    return msg
end

local function main()
    collectgarbage("collect")
    -- avoid memory leak
    collectgarbage("setpause", 100)
    collectgarbage("setstepmul", 5000)

    -- initialize director
    local director = cc.Director:getInstance()

    --turn on display FPS
    director:setDisplayStats(true)

    --set FPS. the default value is 1.0/60 if you don't call this
    director:setAnimationInterval(1.0 / 60)
    

    
    local winSize = cc.Director:getInstance():getWinSize()
    local visibleSize = cc.Director:getInstance():getVisibleSize()
    local frameSize = cc.Director:getInstance():getOpenGLView():getFrameSize()
    
    
    cclog("winSize.width:" .. winSize.width)
    cclog("winSize.height:" .. winSize.height)
    cclog("visibleSize.width:" .. visibleSize.width)
    cclog("visibleSize.height:" .. visibleSize.height)
    cclog("frameSize.width:" .. frameSize.width)
    cclog("frameSize.height:" .. frameSize.height)
    
    cc.Director:getInstance():getOpenGLView():setDesignResolutionSize(1280, 720, 3)
    --create scene 
    local scene = require("StartScene")
    local gameScene = scene.createScene()
    
    if cc.Director:getInstance():getRunningScene() then
        cc.Director:getInstance():replaceScene(gameScene)
    else
        cc.Director:getInstance():runWithScene(gameScene)
    end

end


local status, msg = xpcall(main, __G__TRACKBACK__)
if not status then
    error(msg)
end
