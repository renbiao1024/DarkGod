PETools = {}

function PETools.RDInt(min, max, rd)
    if(IsNull(rd)) then
        rd = Random()
    end
    local val = rd:Next(min, max+1)
    return val
end
