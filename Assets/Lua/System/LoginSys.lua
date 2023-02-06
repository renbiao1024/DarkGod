-- 登陆系统
--print("LoginSystem Init")
LoginSys = {
    name = "LoginSys"
}

-- function LoginSys:ctor(obj)
--     local o = {}
--     setmetatable(o,self)
--     self.__index = self
--     return o
-- end

function LoginSys:InitSys()
    --print("LoginSys Init")
end

function LoginSys:EnterLogin()
    ResSvc:AsyncLoadScene(Scenes.SceneLogin,function()
        UIs.LoginWndUI.gameObject:SetActive(true)
        LoginWnd:InitWnd()
        LoginWnd:SetWndState(UIs.LoginWndUI, true)
        AudioSvc:PlayBGMusic(Audios.BGLogin,true)
    end)
end

function LoginSys:RspLogin()
    GameRoot:AddTips("登陆成功")
    CreateWnd:InitWnd()
    CreateWnd:SetWndState(UIs.CreateWndUI,true)
    LoginWnd:SetWndState(UIs.LoginWndUI,false)
end