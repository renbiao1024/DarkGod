BaseObject:subClass("WindowRoot")

function WindowRoot:InitWnd()
end

function WindowRoot:ClearWnd()
end

function WindowRoot:SetWndState(go, isActive)
    if(go.gameObject.activeSelf ~= isActive) then
        go.gameObject:SetActive(isActive)
    end
    
    if isActive then
        self:InitWnd()
    else
        self:ClearWnd()
    end
end


-- function WindowRoot:SetText(obj, content)
--     if  typeof(obj) == Text then
--         obj.text = tostring(content)
--     else
--         obj:GetComponent(typeof(Text)).text = tostring(content)
--     end
-- end

