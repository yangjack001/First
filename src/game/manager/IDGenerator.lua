IDGenerator = class("IDGenerator")

IDGenerator._curId = 0

function IDGenerator.getNewId()
    IDGenerator._curId = IDGenerator._curId + 1
    return IDGenerator._curId
end