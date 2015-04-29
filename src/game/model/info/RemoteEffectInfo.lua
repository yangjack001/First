require("game/model/info/ActionScriptInfo")

RemoteEffectInfo = class("RemoteEffectInfo")

function RemoteEffectInfo.create(id)
    local info = RemoteEffectInfo:new()
    info:init(id)
    return info
end

RemoteEffectInfo._id = nil
RemoteEffectInfo._resId = nil
RemoteEffectInfo._moveTime = nil
RemoteEffectInfo._transferCount = nil
RemoteEffectInfo._offsetX = nil
RemoteEffectInfo._offsetY = nil
RemoteEffectInfo._moveType = nil

function RemoteEffectInfo:init(id)
    self._id = id
end

function RemoteEffectInfo:parse(data)
    if data.resId == nil then
        self._resId = self._id
    else
        self._resId = data.resId
    end
    
    self._moveTime = data.moveTime
    self._transferCount = data.transferCount
    self._offsetX = data.offsetX
    self._offsetY = data.offsetY
    self._moveType = data.moveType
end

function RemoteEffectInfo:getId()
    return self._id
end

function RemoteEffectInfo:getResId()
    return self._resId
end

function RemoteEffectInfo:getMoveTime()
    return self._moveTime
end

function RemoteEffectInfo:getTransferCount()
    return self._transferCount
end

function RemoteEffectInfo:getOffsetX()
    return self._offsetX
end

function RemoteEffectInfo:getOffsetY()
    return self._offsetY
end

function RemoteEffectInfo:getMoveType()
    return self._moveType
end