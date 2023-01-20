-- 资源加载服务

ResSvc = {
    name = "ResSvc"
}

function ResSvc:InitSvc()
    print("ResSvc Init")
end

function ResSvc:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function ResSvc:AsyncLoadScene(sceneName)
    SceneManager.LoadSceneAsync(sceneName)
end

-- function ResSvc:Awake(gameObject)
--     print("GameObject "..gameObject.name)end


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
