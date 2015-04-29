MathUtil = {}

function MathUtil.getCocosRotation(tarX,tarY,curX,curY)
    local rotationAngle = math.atan2(math.abs(tarY - curY),math.abs(tarX - curX)) * 180 / math.pi
    if tarX >= curX then
        if tarY < curY then
            return rotationAngle
        else
            return - rotationAngle
        end
    else
        if tarY >= curY then
            return rotationAngle
        else
            return - rotationAngle
        end
    end
end