require("game/model/info/NPCInfo")

NPCConfig = {}

NPCConfig._data = {
    {id=1,name="魔理沙",left=true},
    {id=2,name="灵梦",left=true},
    {id=3,name="十六夜",left=false},
    {id=4,name="雷米",left=false}
}

NPCConfig._listNPCInfo = nil

function NPCConfig.init()
    NPCConfig._listNPCInfo = {}
    
    for _,npcData in pairs(NPCConfig._data) do
        local info = NPCInfo.create()
        info:parse(npcData)
        NPCConfig._listNPCInfo[info:getId()] = info
    end
end;

function NPCConfig.getNPCInfoById(id)
    if NPCConfig._listNPCInfo == nil then
        NPCConfig.init()
    end
    
    if NPCConfig._listNPCInfo[id] == nil then
        error(StringManager.getString(StringKey.NPC_ID_ERROR,id))
    else
        return NPCConfig._listNPCInfo[id]
    end
end