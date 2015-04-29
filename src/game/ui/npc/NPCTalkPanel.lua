require("game/config/NPCConfig")
NPCTalkPanel = class("NPCTalkPanel",function()
    return cc.Layer:create()
end)

function NPCTalkPanel.create(container)
    local panel = NPCTalkPanel:new()
    panel:init(container)
    return panel
end

NPCTalkPanel._npcTalkInfo = nil
NPCTalkPanel._container = nil
NPCTalkPanel._bg = nil
NPCTalkPanel._res = nil
NPCTalkPanel._spNameBg = nil
NPCTalkPanel._txtName = nil
NPCTalkPanel._txtContent = nil
NPCTalkPanel._callback = nil
NPCTalkPanel._leftFace = nil
NPCTalkPanel._rightFace = nil
NPCTalkPanel._isShowAll = nil
NPCTalkPanel._scheduler = nil
NPCTalkPanel._schedulerEntry = nil

function NPCTalkPanel:init(container)
    local bg = cc.LayerColor:create(cc.c4b(0,0,0,200))
    self:addChild(bg)
    self._bg = bg
    
    local res = cc.CSLoader:createNode("res/ui/npc/npc_talk.csb")
    self:addChild(res,3)
    self._res = res
    self._container = container
    
    self._scheduler = cc.Director:getInstance():getScheduler()
    
    self:initComponent()
    self:initEvent()
end

function NPCTalkPanel:showPanel(npcTalkInfo, callback)
    self._npcTalkInfo = npcTalkInfo
    self._callback = callback
    
    self._container:addChild(self)
    self:initData()
end

function NPCTalkPanel:initData()
    local speakerId
    if self._npcTalkInfo:getSpeaker() == GroupType.LEFT then
        speakerId = self._npcTalkInfo:getLeftId()
        self._spNameBg:setPositionX(280)
        self._txtName:setPositionX(280)
    else
        speakerId = self._npcTalkInfo:getRightId()
        self._spNameBg:setPositionX(1000)
        self._txtName:setPositionX(1000)
    end
    local npcInfo = NPCConfig.getNPCInfoById(speakerId)
    self._txtName:setString(npcInfo:getName())
    self._leftFace:removeAllChildren()
    self._rightFace:removeAllChildren()
    if self._npcTalkInfo:getLeftId() ~= 0 then
        self._leftFace:addChild(IconManager.getNPCIdFace(self._npcTalkInfo:getLeftId(),1), 1)
    end
    
    if self._npcTalkInfo:getRightId() ~= 0 then
        self._rightFace:addChild(IconManager.getNPCIdFace(self._npcTalkInfo:getRightId(),1))
    end
    
    self:initSchedulerContext()
end

function NPCTalkPanel:initSchedulerContext()
    local txtContent = self._npcTalkInfo:getTxt()
    local length = string.len(txtContent)
    local index = 0
    self._isShowAll = false
    self._schedulerEntry = self._scheduler:scheduleScriptFunc(function()
        if index >= length then
            self._isShowAll = true
            self._scheduler:unscheduleScriptEntry(self._schedulerEntry)
            self._txtContent:setString(txtContent)
            return
        end
        local curByte = string.byte(txtContent, index + 1)
        local byteCount = 1;
        if curByte>0 and curByte<=127 then
            byteCount = 1
        elseif curByte>=192 and curByte<223 then
            byteCount = 2
        elseif curByte>=224 and curByte<=239 then
            byteCount = 3
        elseif curByte>=240 and curByte<=247 then
            byteCount = 4
        end
        index = index + byteCount
        self._txtContent:setString(string.sub(txtContent,1,index))
    end,0.05, false)
end


function NPCTalkPanel:initComponent()
    self._spNameBg = self._res:getChildByName("sp_nameBg")
    self._txtName = self._res:getChildByName("txt_name")
    self._txtContent = self._res:getChildByName("txt_content")
    local leftFace = cc.Sprite:create()
    leftFace:setPosition(280,360)
    self:addChild(leftFace, 1)
    self._leftFace = leftFace
    local rightFace = cc.Sprite:create()
    rightFace:setPosition(1000,360)
    rightFace:setScaleX(-1)
    self._rightFace = rightFace
    self:addChild(rightFace, 2)
end

function NPCTalkPanel:initEvent()
    local eventListener = cc.EventListenerTouchOneByOne:create()
    eventListener:setSwallowTouches(true)

    eventListener:registerScriptHandler(function(touch, event)
        return true
    end,cc.Handler.EVENT_TOUCH_BEGAN)

    eventListener:registerScriptHandler(function(touch, event)
        if self:isTouch(touch,event) then
            if not self._isShowAll then
                self._isShowAll = true
                self._scheduler:unscheduleScriptEntry(self._schedulerEntry)
                self._txtContent:setString(self._npcTalkInfo:getTxt())
                return
            end
            if self._callback ~= nil then
                self._container:removeChild(self)
                if self._callback ~= nil then
                    self._callback()
                end
            end
        end
    end,cc.Handler.EVENT_TOUCH_ENDED)

    local eventDispatcher = self:getEventDispatcher()
    eventDispatcher:addEventListenerWithSceneGraphPriority(eventListener, self)
end

function NPCTalkPanel:isTouch(touch, event)
    local locationInNode = self:convertToNodeSpace(touch:getLocation())
    local s = self:getContentSize()
    local rect = cc.rect(0, 0, s.width, s.height)
    if cc.rectContainsPoint(rect, locationInNode) then
        return true
    end

    return false
end