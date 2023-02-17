PETools = {}

function PETools.RDInt(min, max, rd)
    if(IsNull(rd)) then
        rd = Random()
    end
    local val = rd:Next(min, max+1)
    return val
end

function PETools:GetFightByProps()
    return PlayerData.lv * 100 + PlayerData.ad + PlayerData.ap + PlayerData.addef + PlayerData.apdef
end

function PETools:GetPowerLimit()
    return ((PlayerData.lv-1)/10) * 150 + 150
end

function PETools:GetExpUpValByLv()
    return 100 * PlayerData.lv * PlayerData.lv
end