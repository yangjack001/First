BaseWork = class("BaseWork")

function BaseWork.create(parentWork)
    local work = BaseWork:new()
    work._parentWork = parentWork
    return work
end

BaseWork.__index = BaseWork

BaseWork._parentWork = nil
BaseWork._listSubWorks = nil
BaseWork._curWork = nil
BaseWork._curWorkIndex = 0
BaseWork._context = nil

function BaseWork:init()
end

function BaseWork:ctor()
    self._listSubWorks = {}
    self._curWorkIndex = 0
end

function BaseWork:start(context)
    self._context = context
    self._curWorkIndex = 0
    if #self._listSubWorks > 0 then
        self:nextWork()    
    end

end

function BaseWork:finish()
    self._context = nil
    if self._parentWork ~= nil then
        self._parentWork.subWorkFinish(self._parentWork)
    end
end

function BaseWork:addSubWork(work)
    table.insert(self._listSubWorks,work)
end

function BaseWork:subWorkFinish()
    if self._curWorkIndex == #self._listSubWorks then
        self:finish()
    else
        self:nextWork()
    end
end

function BaseWork:nextWork()
    self._curWorkIndex = self._curWorkIndex + 1
    self._curWork = self._listSubWorks[self._curWorkIndex]
    self._curWork:start(self._context)
end
