require("game/config/URLConfig")

ARMATURE_NAME = "effect"

AnimationManager = class("AnimationManager")

function AnimationManager.getPlayerBody(fileName, clothId)
--    local json_url = string.gsub(string.gsub(URLConfig.AVATAR_JSON_PREFIX, "&", fileName), "*", clothId)
--    local atlas_url = string.gsub(string.gsub(URLConfig.AVATAR_ATLAS_PREFIX, "&", fileName), "*", clothId)
--    local skeleton = sp.SkeletonAnimation:create(json_url,atlas_url,1)
--
--    return skeleton

--    local texture_url = string.gsub(string.gsub(URLConfig.AVATAR_TEXTURE, "&", fileName), "*", clothId)
--    local xml_url = string.gsub(string.gsub(URLConfig.AVATAR_XML, "&", fileName), "*", clothId)
--
--    local dragonBonesName = "AVATAR_"..tostring(fileName).."_"..clothId
--    if not db.DBCCFactory:getInstance():hasDragonBones(dragonBonesName) then
--        db.DBCCFactory:getInstance():loadDragonBonesData(xml_url, dragonBonesName)
--        db.DBCCFactory:getInstance():loadTextureAtlas(texture_url, dragonBonesName)
--    end
--
--    return db.DBCCFactory:getInstance():buildArmatureNode(fileName, dragonBonesName)

    local png_url = string.gsub(string.gsub(URLConfig.AVATAR_PNG, "&", fileName), "*", clothId)
    local plist_url = string.gsub(string.gsub(URLConfig.AVATAR_PLIST, "&", fileName), "*", clothId)
    local xml_url = string.gsub(string.gsub(URLConfig.AVATAR_XML, "&", fileName), "*", clothId)

    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(png_url,plist_url,xml_url)
    
    local armature = ccs.Armature:create(fileName)
    armature:getAnimation():playWithIndex(0)
    armature:getAnimation():setSpeedScale(0.5)
    return armature
end

function AnimationManager.getActionEffect(id)
--  spine
--    local json_url = string.gsub(URLConfig.ACTION_EFFECT_JSON_PREFIX, "&", tostring(id))
--    local atlas_url = string.gsub(URLConfig.ACTION_EFFECT_ATLAS_PREFIX, "&", tostring(id))
--    local skeleton = sp.SkeletonAnimation:create(json_url,atlas_url,1.6)
--
--    return skeleton


    -- dragonbones
    local png_url = string.gsub(URLConfig.ACTION_EFFECT_PNG, "&", tostring(id))
    local texture_url = string.gsub(URLConfig.ACTION_EFFECT_PLIST, "&", tostring(id))
    local xml_url = string.gsub(URLConfig.ACTION_EFFECT_XML, "&", tostring(id))

    local dragonBonesName = "ACTION_EFFECT_".. tostring(id)
    if not db.DBCCFactory:getInstance():hasDragonBones(dragonBonesName) then
        db.DBCCFactory:getInstance():loadDragonBonesData(xml_url, dragonBonesName)
        db.DBCCFactory:getInstance():loadTextureAtlas(texture_url, dragonBonesName)
    end

    return db.DBCCFactory:getInstance():buildArmatureNode(ARMATURE_NAME, dragonBonesName)

--  ccs    
--    ccs.ArmatureDataManager:getInstance():addArmatureFileInfo(xml_url,plist_url,xml_url)   
--    local armatureName = "actioneffect"..tostring(id)
--    local armature = ccs.Armature:create("molisa 3")
--    armature:getAnimation():playWithIndex(0)
--    armature:getAnimation():setSpeedScale(0.5)
--    return armature
end

function AnimationManager.getRemoteEffectSkeleton(id)
--    local json_url = string.gsub(URLConfig.REMOTE_EFFECT_JSON_PREFIX, "&", tostring(id))
--    local atlas_url = string.gsub(URLConfig.REMOTE_EFFECT_ATLAS_PREFIX, "&", tostring(id))
--    local skeleton = sp.SkeletonAnimation:create(json_url,atlas_url,1.6)
--
--    return skeleton

    -- dragonbones
    local png_url = string.gsub(URLConfig.REMOTE_EFFECT_PNG, "&", tostring(id))
    local texture_url = string.gsub(URLConfig.REMOTE_EFFECT_PLIST, "&", tostring(id))
    local xml_url = string.gsub(URLConfig.REMOTE_EFFECT_XML, "&", tostring(id))

    local dragonBonesName = "REMOTE_EFFECT_".. tostring(id)
    if not db.DBCCFactory:getInstance():hasDragonBones(dragonBonesName) then
        db.DBCCFactory:getInstance():loadDragonBonesData(xml_url, dragonBonesName)
        db.DBCCFactory:getInstance():loadTextureAtlas(texture_url, dragonBonesName)
    end

    return db.DBCCFactory:getInstance():buildArmatureNode(ARMATURE_NAME, dragonBonesName)
end

function AnimationManager.getStateEffectSkeleton(id)
    local json_url = string.gsub(URLConfig.STATE_EFFECT_JSON_PREFIX, "&", tostring(id))
    local atlas_url = string.gsub(URLConfig.STATE_EFFECT_ATLAS_PREFIX, "&", tostring(id))
    local skeleton = sp.SkeletonAnimation:create(json_url,atlas_url,1)

    return skeleton
end

function AnimationManager.getHitEffectSkeleton(id)
--    local json_url = string.gsub(URLConfig.HIT_EFFECT_JSON_PREFIX, "&", tostring(id))
--    local atlas_url = string.gsub(URLConfig.HIT_EFFECT_ATLAS_PREFIX, "&", tostring(id))
--    local skeleton = sp.SkeletonAnimation:create(json_url,atlas_url,1)
--
--    return skeleton

    -- dragonbones
    local png_url = string.gsub(URLConfig.HIT_EFFECT_PNG, "&", tostring(id))
    local texture_url = string.gsub(URLConfig.HIT_EFFECT_PLIST, "&", tostring(id))
    local xml_url = string.gsub(URLConfig.HIT_EFFECT_XML, "&", tostring(id))

    local dragonBonesName = "HIT_EFFECT_".. tostring(id)
    if not db.DBCCFactory:getInstance():hasDragonBones(dragonBonesName) then
        db.DBCCFactory:getInstance():loadDragonBonesData(xml_url, dragonBonesName)
        db.DBCCFactory:getInstance():loadTextureAtlas(texture_url, dragonBonesName)
    end

    return db.DBCCFactory:getInstance():buildArmatureNode(ARMATURE_NAME, dragonBonesName)
end

function AnimationManager.getEnergyFullEffect()
    local png_url = URLConfig.ENERGY_FULL_PNG
    local texture_url = URLConfig.ENERGY_FULL_PNG
    local xml_url = URLConfig.ENERGY_FULL_XML

    local dragonBonesName = "ENERGY_FULL"
    if not db.DBCCFactory:getInstance():hasDragonBones(dragonBonesName) then
        db.DBCCFactory:getInstance():loadDragonBonesData(xml_url, dragonBonesName)
        db.DBCCFactory:getInstance():loadTextureAtlas(texture_url, dragonBonesName)
    end

    return db.DBCCFactory:getInstance():buildArmatureNode(ARMATURE_NAME, dragonBonesName)
end