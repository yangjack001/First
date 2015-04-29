PlayerProperty = class("PlayerProperty")

PlayerProperty.att = nil
PlayerProperty.def = nil
PlayerProperty.hp = nil
PlayerProperty.mp = nil
PlayerProperty.maxHp = nil
PlayerProperty.maxMp = nil
PlayerProperty.speed = nil
PlayerProperty.avo = nil
PlayerProperty.cri = nil

PlayerProperty.energy = nil
PlayerProperty.maxEnergy = nil

function PlayerProperty.create()
    local property = PlayerProperty:new()
    property:init()
    return property
end

function PlayerProperty:init()
    
end

function PlayerProperty:parse(data)
    self.speed = data.speed
    self.att = data.att
    self.def = data.def
    self.maxHp = data.hp
    self.hp = self.maxHp
    self.energy = data.energy
    self.maxEnergy = data.maxEnergy
end