MyEventDispatcher = class("MyEventDispatcher")

function MyEventDispatcher.create()
    local dispatcher = MyEventDispatcher:new()
    dispatcher:init()
    return dispatcher
end

MyEventDispatcher.__index = MyEventDispatcher
MyEventDispatcher._listTypeToFunc = nil

function MyEventDispatcher:init()
    self._listTypeToFunc = {}
end

function MyEventDispatcher:addEventListener(type, callbackFunc)
    local listFunc = self._listTypeToFunc[type]
    if listFunc == nil then
        listFunc = {}
        self._listTypeToFunc[type] = listFunc
    end
    
    table.insert(listFunc,callbackFunc)
end

function MyEventDispatcher:removeEventListener(type, callbackFunc)
    local listFunc = self._listTypeToFunc[type]
    if listFunc == nil then
        return
    end
    
    TableUtil.remove(listFunc, callbackFunc)
end

function MyEventDispatcher:dispatchEvent(evt)
    local type = evt:getType()
    local listFunc = self._listTypeToFunc[type]
    if listFunc == nil then
        return
    end
    
    for i = 1, #listFunc do
        listFunc[i](evt)
    end
end