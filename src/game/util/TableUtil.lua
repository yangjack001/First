TableUtil = class("TableUtil")

function TableUtil.arraySort(t, sortHandler)
    for i=1, #t - 1 do
        local min = i
        for j=i+1, #t do
            if sortHandler(t[j],t[min]) == -1 then
                min = j
            end
        end
        if min ~= i then
            t[min], t[i] = t[i], t[min]
        end
    end
end

---- 从数组中移除一个元素
function TableUtil.remove(t, element)
    for i = 1, #t do
        if t[i] == element then
            table.remove(t,i)
        end
    end
end