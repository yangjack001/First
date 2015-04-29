require("game/type/BattleScriptType")
require("game/model/info/BattleScriptInfo")
require("game/type/GroupType")
require("game/type/PositionType")

BattleScriptConfig = {}

BattleScriptConfig._data = {
    [1] = {
        [BattleEvent.BEFORE_BATTLE]={
            {{type=BattleScriptType.INIT_DEFAULT_PLAYER}},
            {{type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.LEFT,positionType=PositionType.FIGHT_POSITION,time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="看来异变的源头就是这里呐，魔理沙也不是每次都那么没用嘛。",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=1, speaker=GroupType.RIGHT, txt="我每次都很有用的好不！",time=2}},
            {{type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.RIGHT,positionType=PositionType.FIGHT_POSITION,time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=3, speaker=GroupType.RIGHT, txt="怎么回事？是大小姐的客人吗？",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=3, speaker=GroupType.RIGHT, txt="没错，我们可是你主人的贵客呢。",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=1, rightId=0, speaker=GroupType.LEFT, txt="（喂～喂～，摆着一副“就是这样子”的表情来扯谎，到底是怎么办到的呀！）",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=3, speaker=GroupType.RIGHT, txt="原来是大小姐的客人！但是，还是不能让你通过！大小姐今天是不会见人的！）",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="嗟，还以为不用战斗就能糊弄过去呢，真是麻烦。",time=2}}
        },
        [BattleEvent.FINISH_BATTLE]={
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="好了，现在我可以见她了吧",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=3, speaker=GroupType.RIGHT, txt="好强……但是，还差得远呢……回到两小时前重新来吧！！！",time=2}},
            {{type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.LEFT,positionType=PositionType.LEAVE_POSITION,time=3}}
        }
    },
    [2] = {
        [BattleEvent.BEFORE_BATTLE]={
            {{type=BattleScriptType.INIT_DEFAULT_PLAYER}},
            {
                {type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.LEFT,positionType=PositionType.FIGHT_POSITION,time=2},
                {type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.RIGHT,positionType=PositionType.FIGHT_POSITION,time=2}
            },
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=1, rightId=0, speaker=GroupType.LEFT, txt="咦？居然回到了两小时前DA☆ZE～",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="居然是操纵时间的能力，真是麻烦呀。",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=3, speaker=GroupType.RIGHT, txt="只要有我在，是绝对不会放你们通过的！",time=2}}
        },
        [BattleEvent.FINISH_BATTLE]={
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=3, speaker=GroupType.RIGHT, txt="回到两小时前重新来吧！！！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=3, speaker=GroupType.RIGHT, txt="咦？居然没办法发动能力？",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="这是当然的呀，你的能力已经被我的灵符所封印了。",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=3, speaker=GroupType.RIGHT, txt="好强……但是，大小姐总会有办法的。",time=2}},
            {{type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.LEFT,positionType=PositionType.LEAVE_POSITION,time=3}}
        }
    },
    [3] = {
        [BattleEvent.BEFORE_BATTLE]={
            {{type=BattleScriptType.INIT_DEFAULT_PLAYER}},
            {
                {type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.LEFT,positionType=PositionType.FIGHT_POSITION,time=2},
                {type=BattleScriptType.MOVE_PLAYER,groupType=GroupType.RIGHT,positionType=PositionType.FIGHT_POSITION,time=2}
            },
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=4, speaker=GroupType.RIGHT, txt="嗟，人类就是不中用啊！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="刚才的女仆长果然是人类呀！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="那么，这场红雾一定就是你搞的鬼吧，真是给人添麻烦呢！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=4, speaker=GroupType.RIGHT, txt="真是奇怪的推理逻辑呢，而且连过程也不说明！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=4, speaker=GroupType.RIGHT, txt="不过，无所谓了。在如此鲜红的月亮之下，我真的会杀掉你哦！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="是呢，今晚的月色还真是够鲜红的呢！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=0, rightId=4, speaker=GroupType.RIGHT, txt="呵呵呵，看来今晚注定会成为欢愉之夜呢！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=2, rightId=0, speaker=GroupType.LEFT, txt="不，是会成为永恒之夜！",time=2}},
            {{type=BattleScriptType.SHOW_NPC_PANEL,leftId=1, rightId=0, speaker=GroupType.LEFT, txt="开战咯开战咯！不等你们两个中二病了，看我先干掉她DA☆ZE。",time=2}}
        }
    }
}

BattleScriptConfig._listBattleScriptInfo = nil

function BattleScriptConfig.init()
    BattleScriptConfig._listBattleScriptInfo = {}
    
    for battleId, battleData in pairs(BattleScriptConfig._data) do
        local battleScriptInfo = BattleScriptInfo.create(battleId)
        battleScriptInfo:parse(battleData)
        BattleScriptConfig._listBattleScriptInfo[battleScriptInfo:getBattleId()] = battleScriptInfo 
    end
end

function BattleScriptConfig.getBattleScriptById(id)
    if BattleScriptConfig._listBattleScriptInfo == nil then
        BattleScriptConfig.init()
    end
        
    if BattleScriptConfig._listBattleScriptInfo[id] == nil then
        error(StringManager.getString(StringKey.BATTLE_SCRIPT_ID_ERROR,id)) 
    else
        return BattleScriptConfig._listBattleScriptInfo[id]
    end
end