require("game/player/components/buff/Buff")
require("game/config/BuffConfig")

BuffComponent = class("BuffComponent")

function BuffComponent.create(player)
    local component = BuffComponent:new()
    component:init(player)
    return component
end

BuffComponent._player = nil
BuffComponent._listBuff = nil

function BuffComponent:init(player)
    self._player = player
    self._listBuff = {}
end

function BuffComponent:addBuff(buffId, sourcePlayer, continueRound)
    local buff = Buff.create(buffId, self._player, sourcePlayer, continueRound)
    table.insert(self._listBuff, buff)
    buff:onStart()
end

function BuffComponent:removeBuff(buffId)
    for i = #self._listBuff,1,-1 do
        local buff = self._listBuff[i]
        if buff:getBuffInfo():getId() == buffId then
            table.remove(self._listBuff,i)
        end
    end
end

function BuffComponent:onBattleEvent(evt)
    local type = evt:getType()
    if type == BattleEvent.ATTACK_END then
        local attPlayer = evt:attackContext():getAttPlayer()
        for i = #self._listBuff, 1, -1 do
            local buff = self._listBuff[i]
            if attPlayer == buff:getSourcePlayer() then
                buff:onTickRound()
                if buff:getContinueRound() <= 0 then
                    buff:onEnd()
                    table.remove(self._listBuff,i)
                end
            end
        end
    end
end