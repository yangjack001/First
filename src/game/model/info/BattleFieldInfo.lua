require("game/model/info/BattleInfo")
BattleFieldInfo = class("BattleFieldInfo")

function BattleFieldInfo.create(id)
    local info = BattleFieldInfo:new()
    info:init(id)
    return info
end

BattleFieldInfo._id = nil
BattleFieldInfo._listBattleInfo = nil

function BattleFieldInfo:init(id)
    self._id = id
end

function BattleFieldInfo:parse(data)
    self._listBattleInfo = {}
    
    for i = 1, #data.battleList do
        local battleInfo = BattleInfo.create()
        battleInfo:parse(data.battleList[i])
        table.insert(self._listBattleInfo,battleInfo)
    end
end

function BattleFieldInfo:getId()
    return self._id
end

function BattleFieldInfo:getListBattleInfo()
    return self._listBattleInfo
end