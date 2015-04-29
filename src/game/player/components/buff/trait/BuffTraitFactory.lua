require("game/player/components/buff/trait/AvatarPauseTrait")
require("game/player/components/buff/trait/StopUseSkillTrait")
require("game/type/BuffTraitID")
BuffTraitFactory = class("BuffTraitFactory")

BuffTraitFactory._idToCls = {
    [BuffTraitID.AVATAR_PAUSE] = AvatarPauseTrait,
    [BuffTraitID.STOP_USE_SKILL] = StopUseSkillTrait
}

function BuffTraitFactory.getTraitById(id, player)
    if BuffTraitFactory._idToCls[id] ~= nil then
        return BuffTraitFactory._idToCls[id].create(player)
    else
        error(StringManager.getString(StringKey.BUFF_TRAIT_ID_ERROR,id))
    end
end