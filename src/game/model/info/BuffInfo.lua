BuffInfo = class("BuffInfo")

function BuffInfo.create(id)
    local define = BuffInfo:new()
    define:init(id)
    return define
end

BuffInfo._id = nil
BuffInfo._traitIds = nil
BuffInfo._effectIds = nil

function BuffInfo:init(id)
    self._id = id
end

function BuffInfo:parse(data)
    self._effectIds = data.effectIds
    self._traitIds = data.traitIds
end

function BuffInfo:getId()
    return self._id
end

function BuffInfo:getEffectIds()
    return self._effectIds
end

function BuffInfo:getTraitIds()
    return self._traitIds
end