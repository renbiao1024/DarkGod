-- 资源加载服务

ResSvc = {
    name = "ResSvc"
}

ResSvc.isPrgFinish = false
ResSvc.sceneAsync = nil
ResSvc.loaded = nil

function ResSvc:InitSvc()
    print("ResSvc Init")
end

function ResSvc:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function ResSvc:AsyncLoadScene(sceneName, loaded)
    UIs.LoadingWndUI.gameObject:SetActive(true)
    LoadingWnd:InitWnd()
    self.sceneAsync = SceneManager.LoadSceneAsync(sceneName)
    self.loaded = loaded
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
        UIs.LoadingWndUI.gameObject:SetActive(false)
    end
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
