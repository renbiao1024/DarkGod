-- 登陆系统
--print("LoginSystem Init")
LoginSys = {
    name = "LoginSys"
}

function LoginSys:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function LoginSys:InitSys()
    print("LoginSys Init")
end

function LoginSys:EnterLogin()
    UIs.LoadingWndUI.gameObject:SetActive(true)

    ResSvcInst:AsyncLoadScene(Scenes.SceneLogin)
end

