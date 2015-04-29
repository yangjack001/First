require("game/model/info/ActionInfo")
require("game/model/info/ActionInfoMap")
require("game/type/ActionType")
require("game/type/ActionScriptType")
require("game/type/HitAreaType")
require("game/type/TargetType")
require("game/type/PlayerTypeID")
require("game/type/PositionType")

ActionInfoConfig = class("ActionConfig")

ActionInfoConfig._actionData = {
    [PlayerTypeID.MO_LI_SHA]= {
        [ActionType.IDLE] = {isLoop=1},
        [ActionType.WALK] = {isLoop=1},
        [ActionType.WIN] = {isLoop=1},      
        [ActionType.DIZZY] = {isLoop=1},
        [ActionType.BE_HIT] = {},
        [ActionType.DEATH] = {},
        [ActionType.ATTCK]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=1},
                {startTime=0.2,type=ActionScriptType.REMOTE_EFFECT,effectId=1},
                {startTime=0.3,type=ActionScriptType.REMOTE_EFFECT,effectId=2},
                {startTime=0.8,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_1]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=3},
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=18},
                {startTime=0.8,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.0,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.2,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.4,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.6,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.7,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_2]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=6},
                {startTime=0.6,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_ONE_COL,hitEffectId=2},
                {startTime=0.8,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_ONE_COL,hitEffectId=2},
                {startTime=1.0,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_ONE_COL,hitEffectId=2},
                {startTime=1.2,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_ONE_COL,hitEffectId=2},
                {startTime=1.3,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_3]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=4},
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=5},
                {startTime=0.4,type=ActionScriptType.MOVE,moveX=900,time=0.9},
                {startTime=0.5,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=2},
                {startTime=0.7,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE_COL_NEXT_ONE,hitEffectId=2},
                {startTime=0.9,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE_COL_NEXT_TWO,hitEffectId=2},
                {startTime=1.3,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.CP_SKILL_1]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=18},
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=20},
                {startTime=4.0,type=ActionScriptType.SKILL_FINISH}
            }
        }
    },

    [PlayerTypeID.LING_MENG]= {
        [ActionType.IDLE] = {isLoop=1},
        [ActionType.WALK] = {isLoop=1},
        [ActionType.WIN] = {isLoop=1},      
        [ActionType.DIZZY] = {isLoop=1},
        [ActionType.BE_HIT] = {},
        [ActionType.DEATH] = {},
        [ActionType.ATTCK]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=15},
                {startTime=0.25,type=ActionScriptType.REMOTE_EFFECT,x=60,y=0,effectId=4},
                {startTime=0.30,type=ActionScriptType.REMOTE_EFFECT,x=-60,y=0,effectId=4},
                {startTime=0.35,type=ActionScriptType.REMOTE_EFFECT,x=-30,y=40,effectId=4},
                {startTime=0.40,type=ActionScriptType.REMOTE_EFFECT,x=30,y=40,effectId=4},
                {startTime=0.45,type=ActionScriptType.REMOTE_EFFECT,x=-30,y=-40,effectId=4},
                {startTime=0.50,type=ActionScriptType.REMOTE_EFFECT,x=30,y=-40,effectId=4},
                {startTime=1.0,type=ActionScriptType.SKILL_FINISH}
            }
        },

        [ActionType.SKILL_1]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=14},
                {startTime=1.12,type=ActionScriptType.REMOTE_EFFECT,x=60,y=120,effectId=5,tarType=TargetType.ENEMY_RANDOM},
                {startTime=1.28,type=ActionScriptType.REMOTE_EFFECT,x=20,y=140,effectId=6,tarType=TargetType.ENEMY_RANDOM},
                {startTime=1.40,type=ActionScriptType.REMOTE_EFFECT,x=-80,y=120,effectId=7,tarType=TargetType.ENEMY_RANDOM},
                {startTime=1.55,type=ActionScriptType.REMOTE_EFFECT,x=40,y=140,effectId=8,tarType=TargetType.ENEMY_RANDOM},
                {startTime=1.68,type=ActionScriptType.REMOTE_EFFECT,x=0,y=120,effectId=9,tarType=TargetType.ENEMY_RANDOM},
                {startTime=1.81,type=ActionScriptType.REMOTE_EFFECT,x=-100,y=100,effectId=12,tarType=TargetType.ENEMY_RANDOM},
                {startTime=2.0,type=ActionScriptType.SKILL_FINISH}
            }
        },

        [ActionType.CP_SKILL_1]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=18},
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=20},
                {startTime=4.0,type=ActionScriptType.SKILL_FINISH}
            }
        }
    },

    [PlayerTypeID.LEIMI]= {
        [ActionType.IDLE] = {isLoop=1},
        [ActionType.WALK] = {isLoop=1},
        [ActionType.WIN] = {isLoop=1},      
        [ActionType.DIZZY] = {isLoop=1},
        [ActionType.BE_HIT] = {},
        [ActionType.DEATH] = {},
        [ActionType.ATTCK]={
            script={
                {startTime=0.2,type=ActionScriptType.ACTION_EFFECT, effectId=8},
                {startTime=0.5,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE},
                {startTime=1.0,type=ActionScriptType.SKILL_FINISH}
            }
        },
        
        [ActionType.SKILL_1]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=18},
                {startTime=0.2,type=ActionScriptType.ACTION_EFFECT, effectId=9},
                {startTime=0.8,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=2.0,type=ActionScriptType.SKILL_FINISH}
            }
        },
        
        [ActionType.SKILL_2]={
            script={
                {startTime=0.6, type=ActionScriptType.SKILL_FINISH}
            }
        },
        
        [ActionType.SKILL_3]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=10},
                {startTime=0.5,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.0,type=ActionScriptType.SKILL_FINISH}
            }
        },
        
        [ActionType.SKILL_4]={
            script={
                {startTime=0.7,type=ActionScriptType.SKILL_FINISH}
            }
        },
        
        [ActionType.CP_SKILL_1]={
            script={
                {startTime=0.5,type=ActionScriptType.SKILL_FINISH}
            }
        },        
        [ActionType.CP_SKILL_2]={
            script={
                {startTime=0.5,type=ActionScriptType.SKILL_FINISH}
            }
        }
    },
    [PlayerTypeID.FULAN]= {
        [ActionType.IDLE] = {isLoop=1},
        [ActionType.WALK] = {isLoop=1},
        [ActionType.WIN] = {isLoop=1},      
        [ActionType.DIZZY] = {isLoop=1},
        [ActionType.BE_HIT] = {},
        [ActionType.DEATH] = {},
        [ActionType.ATTCK]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=7},
                {startTime=0.4,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=3},
                {startTime=1.0,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_1]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=18},
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=13},
                {startTime=1.6,type=ActionScriptType.CREATE_SHADOW,count=3,confuse=true},
                {startTime=2.0,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_2]={
            script={
                {startTime=0.6, type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_3]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=12},
                {startTime=1.2,type=ActionScriptType.MOVE,moveX=-200,time=0.01,targetType=TargetType.SKILL_TARGET},
                {startTime=1.4,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE},
                {startTime=2.0,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_4]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=11},
                {startTime=1.2,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.4,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.6,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.8,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=2.0,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=2.2,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=2.4,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=2.5,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.CP_SKILL_1]={
            script={
                {startTime=0.5,type=ActionScriptType.SKILL_FINISH}
            }
        },        
        [ActionType.CP_SKILL_2]={
            script={
                {startTime=0.5,type=ActionScriptType.SKILL_FINISH}
            }
        }
    },
    [PlayerTypeID.SHI_LIU_YE]= {
        [ActionType.IDLE] = {isLoop=1},
        [ActionType.WALK] = {isLoop=1},
        [ActionType.WIN] = {isLoop=1},      
        [ActionType.DIZZY] = {isLoop=1},
        [ActionType.BE_HIT] = {},
        [ActionType.DEATH] = {},
        [ActionType.ATTCK]={
            script={
                {startTime=0.2,type=ActionScriptType.REMOTE_EFFECT,x=20,y=0,effectId=10},
                {startTime=0.3,type=ActionScriptType.REMOTE_EFFECT,x=20,y=100,effectId=10},
                {startTime=0.4,type=ActionScriptType.REMOTE_EFFECT,x=20,y=0,effectId=10},
                {startTime=1.0,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_1]={
            script={
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=18},
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=16},
                {startTime=0.0,type=ActionScriptType.ACTION_EFFECT, effectId=17},
                {startTime=1.2,type=ActionScriptType.ADD_BUFF,buffId=1,continueRound=2,targetType=TargetType.ENEMY_TEAM},
                {startTime=2.3,type=ActionScriptType.SKILL_FINISH}
            }
        },
        [ActionType.SKILL_2]={
            script={
                {startTime=0.8,type=ActionScriptType.REMOTE_EFFECT,x=0,y=0,effectId=11},
                {startTime=2.3, type=ActionScriptType.SKILL_FINISH}
            }
        },
    },
    [PlayerTypeID.YAO_JING_NV_PU]= {
        [ActionType.IDLE] = {isLoop=1},
        [ActionType.WALK] = {isLoop=1},
        [ActionType.WIN] = {isLoop=1},      
        [ActionType.DIZZY] = {isLoop=1},
        [ActionType.BE_HIT] = {},
        [ActionType.DEATH] = {},
        [ActionType.ATTCK]={
            script={
                {startTime=0.6,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=3},
                {startTime=1.0,type=ActionScriptType.SKILL_FINISH}
            }
        }
    }
}

ActionInfoConfig._allActionInfoMap = nil

function ActionInfoConfig.getActionInfoMap(playerId)
    if ActionInfoConfig._allActionInfoMap == nil then
        ActionInfoConfig.init()
    end

    if ActionInfoConfig._allActionInfoMap[playerId] ~= nil then
        return ActionInfoConfig._allActionInfoMap[playerId]
    else
        error(StringManager.getString(StringKey.PLAYER_ID_ERROR, playerId))
    end
end

function ActionInfoConfig.init()
    ActionInfoConfig._allActionInfoMap = {}
    
    for playerId, actionInfoMapData in pairs(ActionInfoConfig._actionData) do
        local actionInfoMap = ActionInfoMap.create(playerId)
        for actionType, playerActionData in pairs(actionInfoMapData) do
            local actionInfo = ActionInfo.create(actionType)
            actionInfo:parse(playerActionData)
            actionInfoMap:addActionInfo(actionInfo)
        end
        ActionInfoConfig._allActionInfoMap[playerId] = actionInfoMap
    end
end