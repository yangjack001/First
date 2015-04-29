require("game/model/info/RemoteEffectInfo")
require("game/type/PlayerMoveType")

RemoteEffectConfig = class("RemoteEffectConfig")

RemoteEffectConfig._define = {
    [1] = {name="魔理沙普攻星星1",moveTime=0.3,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [2] = {name="魔理沙普攻星星2",moveTime=0.3,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [3] = {name="测试CP技能",offsetX=200,offsetY=360,moveType=PlayerMoveType.NOT_MOVE},
    [4] = {name="灵梦普攻",moveTime=0.3,transferCount=1,offsetX=0,offsetY=100,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [5] = {name="灵梦大招1",moveTime=0.6,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [6] = {name="灵梦大招2",moveTime=0.7,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [7] = {name="灵梦大招3",moveTime=0.8,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [8] = {name="灵梦大招4",moveTime=0.75,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [9] = {name="灵梦大招5",moveTime=0.85,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [10] = {name="十六夜普攻",moveTime=0.3,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [11] = {name="十六夜剑阵",moveTime=0.001,transferCount=1,offsetX=0,offsetY=0,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [12] = {name="灵梦大招6",moveTime=0.7,transferCount=1,offsetX=0,offsetY=80,moveType=PlayerMoveType.TRACK_CURRENT_POSITION},
    [13] = {name="CP大招2",offsetX=200,offsetY=360,moveType=PlayerMoveType.NOT_MOVE}
}

RemoteEffectConfig._remoteEffectData = nil

function RemoteEffectConfig.init()
    RemoteEffectConfig._remoteEffectData = {}
    for remoteEffectId, remoteEffectData in pairs(RemoteEffectConfig._define) do
        local remoteEffectInfo = RemoteEffectInfo.create(remoteEffectId)
        remoteEffectInfo:parse(remoteEffectData)
        RemoteEffectConfig._remoteEffectData[remoteEffectId] = remoteEffectInfo
    end
end

function RemoteEffectConfig.getRemoteEffectInfoById(remoteEffectId)
    if RemoteEffectConfig._remoteEffectData == nil then
        RemoteEffectConfig.init()
    end

    if RemoteEffectConfig._remoteEffectData[remoteEffectId] == nil then
        error(StringManager.getString(StringKey.REMOTE_EFFECT_ID_ERROR, remoteEffectId))
    else
        return RemoteEffectConfig._remoteEffectData[remoteEffectId]
    end
end