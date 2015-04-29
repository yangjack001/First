CreateShadowScript = class("CreateShadowScript", function()
    return BaseActionScript.create()
end)

function CreateShadowScript.create(player)
    local script = CreateShadowScript:new()
    script:init(player)
    return script
end

CreateShadowScript._player = nil

function CreateShadowScript:init(player)
    self._player = player
end

function CreateShadowScript:excute(createShodowScriptArg)
    local groupType = self._player:getGroup()
    local playerGroup = SceneManager.getCurScene():getPlayerManager():getPlayerGroup(groupType)
    if #playerGroup:getPlayerList() >= BattleConfig.ROW_COUNT * BattleConfig.COL_COUNT then
        return
    end
    local playerCount = createShodowScriptArg:getCount()
    local sourcePlayerInfo = self._player:getPlayerInfo()
    if createShodowScriptArg:getConfuse() == true then
        if math.random(1,100) > 50 then
            local originGrid = {sourcePlayerInfo:getGridX(),sourcePlayerInfo:getGridY()}
            playerGroup:removePlayer(self._player)
            self:addShadowPlayer(sourcePlayerInfo,groupType,originGrid)
            
            local grid = playerGroup:getRandomEmptyGrid()
            sourcePlayerInfo:setGridX(grid[1])
            sourcePlayerInfo:setGridY(grid[2])
            self._player:resetPosition()
            playerGroup:addPlayer(self._player)
            
            playerCount = playerCount -1
        end
    end
    
    for i=1, playerCount do
        local grid = playerGroup:getRandomEmptyGrid()
        if grid == nil then
            return
        end
        self:addShadowPlayer(sourcePlayerInfo,groupType,grid)
    end
end

function CreateShadowScript:addShadowPlayer(sourcePlayerInfo,groupType,grid)
    local playerInfo = sourcePlayerInfo:clone()
    playerInfo:setGridX(grid[1])
    playerInfo:setGridY(grid[2])
    playerInfo:setIsShodow(true)
    SceneManager.getCurScene():getPlayerManager():buildPlayer(playerInfo,groupType)
end
