require("game/model/info/CPSkillInfo")

CPSkillConfig = class("CPSkillConfig")

CPSkillConfig._define = {
    [1] = {
        playerTypeIds={3,4},
        playerSkillKeys={SkillKey.CP_SKILL_1, SkillKey.CP_SKILL_1},
        remoteEffectId = {3,13},
        tarType = TargetType.ENEMY_FIRST_ROW
    }
}

CPSkillConfig._skillInfoData = nil

function CPSkillConfig.init()
    CPSkillConfig._skillInfoData = {}
    for skillId, skillData in pairs(CPSkillConfig._define) do
        local skillInfo = CPSkillInfo.create(skillId)
        skillInfo:parse(skillData)
        CPSkillConfig._skillInfoData[skillId] = skillInfo
    end
end

function CPSkillConfig:getCPSkillById(id)
    if CPSkillConfig._skillInfoData == nil then
        CPSkillConfig.init()
    end
    
    if CPSkillConfig._skillInfoData[id] ~= nil then
        return CPSkillConfig._skillInfoData[id]
    else
        error(StringManager.getString(StringKey.CP_SKILL_ID_ERROR, id))
    end
end

function CPSkillConfig:getSkillInfoData()
    if CPSkillConfig._skillInfoData == nil then
        CPSkillConfig.init()
    end
    
    return CPSkillConfig._skillInfoData
end