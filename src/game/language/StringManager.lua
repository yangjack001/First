require("game/language/config/zh_cn")
require("game/language/config/en_us")
require("game/language/config/zh_tw")
require("game/type/LanguageType")

StringManager = class("StringManager")

StringManager._typeToData = {
    [LanguageType.ZH_CN] = ZH_CN.data,
    [LanguageType.ZH_TW] = ZH_TW.data,
    [LanguageType.EN_US] = EN_US.data
}
StringManager._curLanguage = nil
StringManager._curData = nil

function StringManager.setLanguage(languageType)
    StringManager._curLanguage = languageType
    StringManager._curData = StringManager._typeToData[languageType]
end

function StringManager.getString(stringKey, ...)
    if StringManager._curLanguage == nil then
        StringManager.setLanguage(LanguageType.ZH_CN)
    end
    
    return string.format(StringManager._curData[stringKey],...) 
end

function StringManager.getLanguage()
    return StringManager._curLanguage
end
