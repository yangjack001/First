ActionInfoMap = class("ActionInfoMap")

ActionInfoMap._id = nil
ActionInfoMap._typeToInfo = nil

function ActionInfoMap.create(id)
    local map = ActionInfoMap:new()
    map:init(id)
    return map
end

function ActionInfoMap:init(id)
    self._id = id
    self._typeToInfo = {}
end

function ActionInfoMap:addActionInfo(actionInfo)
    self._typeToInfo[actionInfo:getType()] = actionInfo
end

function ActionInfoMap:getActionInfoByType(actionType)
    return self._typeToInfo[actionType]
end

function ActionInfoMap:getId()
    return self._playerId
end