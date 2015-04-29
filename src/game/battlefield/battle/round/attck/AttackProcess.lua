require("game/util/workflow/BaseWork")
require("game/type/ActionType")

AttackProcess = class("AttackProcess",function()
    return BaseWork.create()
end)

function AttackProcess.create(parentWork)
    local work = AttackProcess:new()
    work._parentWork = parentWork
    work:init()
    return work
end

AttackProcess._attContext = nil
AttackProcess._attPlayer = nil

function AttackProcess:init()

end

function AttackProcess:start(context)
    print("AttackProcess start   "..os.clock())
    local mdata = getmetatable(self)
    mdata.start(self, context)
    
    self._attContext = context:getAttackContext()
    self._attPlayer = self._attContext:getAttPlayer()
    
    if self._attPlayer:getIsDeath() then
        self:finish()
    else
        local onFinishSkill = function()
            --如果当前有人放大招，等他们放完大招再继续
            if context:getBattleScene():getIsFocus() then
                local listener 
                print(" 有人在放大招")
                listener = cc.EventListenerCustom:create(BattleEvent.END_ALL_FOCUS,function(evt)
                    print(" 放大招结束啦")
                    context:getBattleScene():getEventDispatcher():removeEventListener(listener)
                    self:finish()
                end)

                context:getBattleScene():getEventDispatcher():addEventListenerWithFixedPriority(listener, 1)
            else
                self:finish()
            end
        end
    
        if self._attPlayer:getIsStopUseSkill() then
            onFinishSkill()
        else
            self._attPlayer:autoUseSkill(self._attContext, onFinishSkill)
        end
    end    
end