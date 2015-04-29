require("game/type/EffectActionType")
require("game/model/info/ActionInfoMap")
require("game/type/HitAreaType")
require("game/type/ActionScriptType")

RemoteEffectActionInfoConfig = class("RemoteEffectActionInfoConfig")

RemoteEffectActionInfoConfig._actionData = {
    [1] ={
        [EffectActionType.LOOP] = {
            isLoop = 1,
            animation="loop1",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE}
            }
        }
    },
    [2] ={
        [EffectActionType.LOOP] = {
            isLoop = 1,
            animation="loop2",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=1}
            }
        }
    },
    [3] = {
        [EffectActionType.START] = {
            animation="start",
            script={
                {startTime=1.0,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.4,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=1.8,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
                {startTime=3.0,type=ActionScriptType.HIT_CHECK,hitId=2,hitCheckType=HitAreaType.ABS_FULL_SCREEN,hitEffectId=2},
            }}
    },
    [4] ={
        [EffectActionType.LOOP] = {isLoop = 1,
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
        
    },
    [5] ={
        [EffectActionType.LOOP] = {isLoop = 1,animation="loop1",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
    },
    [6] ={
        [EffectActionType.LOOP] = {isLoop = 1,animation="loop2",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
    },
    [7] ={
        [EffectActionType.LOOP] = {isLoop = 1,animation="loop3",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
    },
    [8] ={
        [EffectActionType.LOOP] = {isLoop = 1,animation="loop4",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
    },
    [9] ={
        [EffectActionType.LOOP] = {isLoop = 1,animation="loop5",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
    },
    [10] ={
        [EffectActionType.LOOP] = {isLoop = 1,
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
    },
    [11] ={
        [EffectActionType.LOOP] = {animation="end"},
        [EffectActionType.END] = {
            script={
                {startTime=0.6,type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE},
            }
        },
    },
    [12] ={
        [EffectActionType.LOOP] = {isLoop = 1,animation="loop6",
            finalScript={
                {type=ActionScriptType.HIT_CHECK,hitId=1,hitCheckType=HitAreaType.REL_SINGLE,hitEffectId=6}
            }
        },
    },
    [13] ={
        [EffectActionType.START] = {
            script={
            }}
    }
}

RemoteEffectActionInfoConfig._allActionInfoMap = nil

function RemoteEffectActionInfoConfig.getActionInfoMap(remoteEffectId)
    if RemoteEffectActionInfoConfig._allActionInfoMap == nil then
        RemoteEffectActionInfoConfig.init()
    end

    if RemoteEffectActionInfoConfig._allActionInfoMap[remoteEffectId] ~= nil then
        return RemoteEffectActionInfoConfig._allActionInfoMap[remoteEffectId]
    else
        error(StringManager.getString(StringKey.REMOTE_EFFECT_ID_ERROR, remoteEffectId))
    end
end

function RemoteEffectActionInfoConfig.init()
    RemoteEffectActionInfoConfig._allActionInfoMap = {}

    for remoteEffectId, actionInfoMapData in pairs(RemoteEffectActionInfoConfig._actionData) do
        local actionInfoMap = ActionInfoMap.create(remoteEffectId)
        for actionType, playerActionData in pairs(actionInfoMapData) do
            local actionInfo = ActionInfo.create(actionType)
            actionInfo:parse(playerActionData)
            actionInfoMap:addActionInfo(actionInfo)
        end
        
        RemoteEffectActionInfoConfig._allActionInfoMap[remoteEffectId] = actionInfoMap
    end
end