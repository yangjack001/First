IconManager = class("IconManager")

function IconManager.getPlayerHead(id)
    local url = string.gsub(URLConfig.PLAYER_HEAD_URL, "&", tostring(id))
    return cc.Sprite:create(url)
end

function IconManager.getNPCIdFace(npcId, faceId)
    local url = string.gsub(string.gsub(URLConfig.NPC_FACE_URL, "&", tostring(npcId)),"*",tostring(faceId))
    return cc.Sprite:create(url)
end