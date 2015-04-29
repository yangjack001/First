NPCInfo = class("NPCInfo")

function NPCInfo.create()
    local info = NPCInfo:new()
    return info
end

NPCInfo._id = nil
NPCInfo._name = nil
NPCInfo._left = nil

function NPCInfo:parse(data)
    self._id = data.id
    self._name = data.name
    self._left = data.left
end

function NPCInfo:getId()
    return self._id
end

function NPCInfo:getName()
    return self._name
end

-- 临时用的，标志头像是面向左的还是面向右的。
function NPCInfo:getLeft()
    return self._left
end