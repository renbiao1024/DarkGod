-- 资源加载服务

ResSvc = {
    name = "ResSvc"
}
local List_String = CS.System.Collections.Generic.List(CS.System.String)
ResSvc.surnameLst = List_String()
ResSvc.manLst = List_String()
ResSvc.womanLst = List_String()

ResSvc.isPrgFinish = false
ResSvc.sceneAsync = nil
ResSvc.loaded = nil

local Dic_String_Bool = Generic.Dictionary(CS.System.String,CS.System.Boolean)
ResSvc.adDic = Dic_String_Bool()


function ResSvc:InitSvc()
    print("ResSvc Init")
    self:InitRDNameCfg()
end

function ResSvc:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function ResSvc:AsyncLoadScene(sceneName, loaded)
    UIs.LoadingWndUI.gameObject:SetActive(true)

    self.sceneAsync = SceneManager.LoadSceneAsync(sceneName)
    self.loaded = loaded
    self.isPrgFinish = false
end

function ResSvc:Update()
    --print("ResSvc:Update")
    if ResSvc.isPrgFinish == false then
        ResSvc:UpdatePrg()
    end
end

function ResSvc:UpdatePrg()
    local val = self.sceneAsync.progress
    LoadingWnd:SetProgress(val)
    if val == 1 then
        if self.loaded ~= nil then
            self.loaded()
        end
        self.isPrgFinish = true
        self.sceneAsync = nil
        self.loaded = nil
        LoadingWnd:SetWndState(UIs.LoadingWndUI, false)
    end
end

function ResSvc:LoadAudio(path, cache)
    local getSucceed, au = self.adDic:TryGetValue(path)
    if getSucceed == false then
        au = ABMgr:LoadRes("audio", path, typeof(AudioClip))
        if cache then
            self.adDic:Add(path, au)
        end
    end
    return au
end

function ResSvc:InitRDNameCfg()
    local xml = ABMgr:LoadRes("config", "rdname", typeof(TextAsset))
    if(xml) then
        local doc = Xml.XmlDocument()
        doc:LoadXml(xml.text)
        local nodeLst = doc:SelectSingleNode("root").ChildNodes
        for i = 0, nodeLst.Count-1 do
            local ele = nodeLst[i]
            if(ele:GetAttributeNode("ID")) then
                local ID = tonumber(ele:GetAttributeNode("ID").InnerText)
                local childLst = ele.ChildNodes.Count
                for j = 0, childLst-1 do
                    local childnode = nodeLst[i].ChildNodes[j]
                    if childnode.Name == "surname" then
                        self.surnameLst:Add(childnode.InnerText)
                    elseif childnode.Name == "man" then
                        self.manLst:Add(childnode.InnerText)
                    elseif childnode.Name == "woman" then
                        self.womanLst:Add(childnode.InnerText)
                    end
                end
            end
        end
    end
    --print(self.surnameLst[3])
end

function ResSvc:GetRDNameData(isMan)
    local rd = Random()
    local rdName = self.surnameLst[PETools.RDInt(0, self.surnameLst.Count-1, rd)]
    if(isMan) then
        rdName = rdName .. self.manLst[PETools.RDInt(0, self.manLst.Count-1, rd)]
    else
        rdName = rdName .. self.womanLst[PETools.RDInt(0, self.womanLst.Count-1, rd)]
    end
    return rdName
end

-- function ResSvc:Start()
--     print("ResSvc Start")
-- end

-- function ResSvc:OnEnable()
--     print("TestCmp OnEnable...")
-- end

-- function ResSvc:OnDestroy()
--     print("TestCmp OnDestroy...")
-- end

-- function ResSvc:OnDisable()
--     print("TestCmp OnDisable...")
-- end
