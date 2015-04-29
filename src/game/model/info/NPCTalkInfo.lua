NPCTalkInfo = class("NPCTalkInfo")

function NPCTalkInfo.create()
    local info = NPCTalkInfo:new()
    info:init()
    return info
end

NPCTalkInfo._leftId = nil
NPCTalkInfo._rightId = nil
NPCTalkInfo._speaker = nil
NPCTalkInfo._txt = nil
NPCTalkInfo._time = nil


function NPCTalkInfo:init()
    
end

function NPCTalkInfo:parse(data)
    self._leftId = data.leftId
    self._rightId = data.rightId
    self._speaker = data.speaker
    self._txt = data.txt
    self._time = data.time
end

function NPCTalkInfo:getLeftId()
    return self._leftId
end

function NPCTalkInfo:getRightId()
    return self._rightId
end

function NPCTalkInfo:getSpeaker()
    return self._speaker
end

function NPCTalkInfo:getTxt()
    return self._txt
end

function NPCTalkInfo:getTime()
    return self._time
end