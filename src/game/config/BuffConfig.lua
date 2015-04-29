require("game/model/info/BuffInfo")
require("game/type/BuffTraitID")
BuffConfig = class("BuffConfig")

BuffConfig._data = {
    [1] = {"时间静止",effectIds={},traitIds={BuffTraitID.AVATAR_PAUSE,BuffTraitID.STOP_USE_SKILL}}
}

BuffConfig._buffInfo = nil

function BuffConfig.init()
    BuffConfig._buffInfo = {}
    
    for buffId, buffData in pairs(BuffConfig._data) do
        local buffInfo = BuffInfo.create(buffId)
        buffInfo:parse(buffData)
        BuffConfig._buffInfo[buffId] = buffInfo
    end
end

function BuffConfig.getBuffInfoById(id)
    if BuffConfig._buffInfo == nil then
        BuffConfig.init()
    end
    
    if BuffConfig._buffInfo[id] == nil then
        error(StringManager.getString(StringKey.BUFF_ID_ERROR, id))
    else
        return BuffConfig._buffInfo[id]
    end
end