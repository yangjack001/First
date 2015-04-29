require("game/type/SkillKey")
require("game/type/ActionType")
require("game/type/SkillDistanceType")
require("game/type/TargetType")
require("game/model/info/PlayerSkillInfoMap")
require("game/model/info/SkillInfo")
require("game/type/PlayerTypeID")

SkillInfoConfig=class("SkillInfoConfig")

SkillInfoConfig._skillData = {
    [PlayerTypeID.MO_LI_SHA]= {
        [SkillKey.ATTCK]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.ATTCK,
            damageArg = {
                [1] = {50,20,50}
            }
        },
        [SkillKey.SKILL_1]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED_CUSTOM,
            actionType = ActionType.SKILL_1,
            offsetY = 360,
            offsetX = 300,
            focusTime = 3,
            damageArg = {
                [1] = {300,50,50}
            }
        },
        [SkillKey.SKILL_2]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.MELEE_COL_FRONT,
            actionType = ActionType.SKILL_2,
            offsetX = -200,
            damageArg = {
                [1] = {50,20,50}
            }
        },
        [SkillKey.SKILL_3]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.MELEE_COL_FRONT,
            actionType = ActionType.SKILL_3,
            offsetX = -100,
            damageArg = {
                [1] = {100,100,50}
            }
        },
        [SkillKey.CP_SKILL_1]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.CP_SKILL_1,
            focusTime = 1,
            damageArg = {
                [1] = {50,20,50},
                [2] = {200,20,100}
            }
        }
    },
    [PlayerTypeID.LING_MENG]= {
        [SkillKey.ATTCK]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.ATTCK,
            damageArg = {
                [1] = {20,20,50}
            }
        },
        [SkillKey.SKILL_1]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.SKILL_1,
            focusTime = 1,
            damageArg = {
                [1] = {200,200,50}
            }
        },
        [SkillKey.CP_SKILL_1]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.CP_SKILL_1,
            focusTime = 3,
            damageArg = {
                [1] = {50,20,50},
                [2] = {200,20,100}
            }
        }     
    },
    [PlayerTypeID.LEIMI]= {
        [SkillKey.ATTCK]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.MELEE,
            actionType = ActionType.ATTCK,
            damageArg = {
                [1] = {100,20,50}
            }
        },
        [SkillKey.SKILL_1]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED_CUSTOM,
            actionType = ActionType.SKILL_1,
            offsetY = 360,
            offsetX = 300,
            focusTime = 0.4,
            damageArg = {
                [1] = {300,20,50}
            }
        },
        [SkillKey.SKILL_3]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED_CUSTOM,
            actionType = ActionType.SKILL_3,
            offsetY = 360,
            offsetX = 640,
            damageArg = {
                [1] = {150,20,100}
            }
        }
    },
    [PlayerTypeID.FULAN]= {
        [SkillKey.ATTCK]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.MELEE,
            actionType = ActionType.ATTCK,
            damageArg = {
                [1] = {100,20,50}
            }
        },
        [SkillKey.SKILL_1]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.SKILL_1,
            focusTime = 1
        },
        [SkillKey.SKILL_3]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.SKILL_3,
            damageArg = {
                [1] = {150,40,100}
            }
        },
        [SkillKey.SKILL_4]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED_CUSTOM,
            actionType = ActionType.SKILL_4,
            offsetY = 360,
            offsetX = 640,
            damageArg = {
                [1] = {50,20,50}
            }
        }
    },
    [PlayerTypeID.SHI_LIU_YE]= {
        [SkillKey.ATTCK]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED,
            actionType = ActionType.ATTCK,
            damageArg = {
                [1] = {30,20,50}
            }
        },
        [SkillKey.SKILL_1]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.RANGED_CUSTOM,
            actionType = ActionType.SKILL_1,
            focusTime = 1,
            offsetY = 360,
            offsetX = 640,
            damageArg = {
                [1] = {50,20,50}
            }
        },
        [SkillKey.SKILL_2]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.MELEE,
            actionType = ActionType.SKILL_2,
            offsetX = -100,
            damageArg = {
                [1] = {200,20,100}
            }
        }
    },
    [PlayerTypeID.YAO_JING_NV_PU]= {
        [SkillKey.ATTCK]={
            tarType = TargetType.ENEMY_FIRST_ROW,
            disType = SkillDistanceType.MELEE,
            actionType = ActionType.ATTCK,
            damageArg = {
                [1] = {50,20,50}
            }
        }
    }
}

SkillInfoConfig._allPlayerSkillInfoMap = {}

function SkillInfoConfig:getPlayerSkillInfoMap(playerId)
    if self._allPlayerSkillInfoMap[playerId] ~= nil then
        return self._allPlayerSkillInfoMap[playerId]
    else
        error(StringManager.getString(StringKey.PLAYER_ID_ERROR, playerId))
    end
end

function SkillInfoConfig:init()
    for playerId, skillInfoMapData in pairs(self._skillData) do
        local playerSkillInfoMap = PlayerSkillInfoMap.create(playerId)
        for skillKey, playerSkillData in pairs(skillInfoMapData) do
            local skillInfo = SkillInfo.create()
            skillInfo:parse(skillKey,playerSkillData)
            playerSkillInfoMap:addSkillInfo(skillInfo)
        end
        self._allPlayerSkillInfoMap[playerId] = playerSkillInfoMap
    end
end

function SkillInfoConfig:new(o)
    o = o or {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function SkillInfoConfig:getInstance()
    if self.instance == nil then
        self.instance = self:new()
        self:init()
    end
    return self.instance
end