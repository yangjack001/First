BattleInfo = class("BattleInfo")

function BattleInfo.create()
    local info = BattleInfo:new()
    info:init()
    return info
end

BattleInfo._id = nil
BattleInfo._sceneId = nil
BattleInfo._playerConfig = nil

function BattleInfo:init()

end

function BattleInfo:parse(data)
    self._id = data.id
    self._sceneId = data.sceneId
    self._playerConfig = data.playerConfig
end

function BattleInfo:getId()
    return self._id
end

function BattleInfo:getSceneId()
    return self._sceneId
end

function BattleInfo:getPlayerConfig()
    return self._playerConfig
end