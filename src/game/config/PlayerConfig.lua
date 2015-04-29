require("game/type/PlayerTypeID")
require("game/language/StringManager")
require("game/language/StringKey")

PlayerConfig = class("PlayerConfig")

PlayerConfig._playerData = {
    [PlayerTypeID.MI_YA] = {typeId=PlayerTypeID.MI_YA,name="miya", fileName="miya", bodyWidth=120},
    [PlayerTypeID.HUN_PO_YAO_MENG] = {typeId=PlayerTypeID.HUN_PO_YAO_MENG,name="hunpoyaomeng", fileName="hunpoyaomeng", bodyWidth=80},
    [PlayerTypeID.MO_LI_SHA] = {typeId=PlayerTypeID.MO_LI_SHA,name="molisha", fileName="molisha", bodyWidth=160},
    [PlayerTypeID.LING_MENG] = {typeId=PlayerTypeID.LING_MENG,name="lingmeng", fileName="lingmeng", bodyWidth=80},
    [PlayerTypeID.LEIMI] = {typeId=PlayerTypeID.LEIMI,name="leimi", fileName="leimi", bodyWidth=80},
    [PlayerTypeID.FULAN] = {typeId=PlayerTypeID.FULAN,name="fulan", fileName="fulan", bodyWidth=80},
    [PlayerTypeID.SHI_LIU_YE] = {typeId=PlayerTypeID.SHI_LIU_YE,name="shiliuye", fileName="shiliuye", bodyWidth=80},
    [PlayerTypeID.YAO_JING_NV_PU] = {typeId=PlayerTypeID.YAO_JING_NV_PU,name="yaojingnvpu", fileName="yaojingnvpu", bodyWidth=80}
}

function PlayerConfig.getPlayerDataById(id)
    if PlayerConfig._playerData[id] == nil then
        error(StringManager.getString(StringKey.PLAYER_TYPE_ID_ERROR, id))
    else
        return PlayerConfig._playerData[id]
    end
end