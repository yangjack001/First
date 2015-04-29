require("game/type/PlayerTypeID")
require("game/type/SkillKey")

SkillSequenceConfig = class("SkillSequenceConfig")

SkillSequenceConfig._data = {
    [PlayerTypeID.MO_LI_SHA] = {SkillKey.ATTCK,SkillKey.SKILL_2,SkillKey.SKILL_3},
    [PlayerTypeID.LING_MENG] = {SkillKey.ATTCK},
    [PlayerTypeID.LEIMI] = {SkillKey.ATTCK,SkillKey.SKILL_3},
    [PlayerTypeID.FULAN] = {SkillKey.ATTCK,SkillKey.SKILL_3,SkillKey.SKILL_4},
    [PlayerTypeID.SHI_LIU_YE] = {SkillKey.ATTCK, SkillKey.SKILL_2},
    [PlayerTypeID.YAO_JING_NV_PU] = {SkillKey.ATTCK}
}

function SkillSequenceConfig.getSequence(playerId)
    if SkillSequenceConfig._data[playerId] == nil then
        error(StringManager.getString(StringKey.PLAYER_ID_ERROR, playerId))
    else
        return SkillSequenceConfig._data[playerId]
    end
end