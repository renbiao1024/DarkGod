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
        LoginWnd:InitWnd()
        LoginWnd:SetWndState(UIs.LoginWndUI, true)
        AudioSvc:PlayBGMusic(Audios.BGLogin,true)
    end)
end

function LoginSys:Login()
    --GameRoot:AddTips("登陆成功")
    --GameRoot:SetPlayerData(msg.rspLogin)
    --if(msg.rspLogin.playerData.name == "") then
    --end

    CreateWnd:InitWnd()
    CreateWnd:SetWndState(UIs.CreateWndUI,true)
    -- MainCitySys:EnterMainCity()
    LoginWnd:SetWndState(UIs.LoginWndUI,false)
end

-- public void RspLogin(GameMsg msg)
-- {
--     GameRoot.AddTips("登陆成功");

--     GameRoot.Instance.SetPlayerData(msg.rspLogin);

--     if(msg.rspLogin.playerData.name == "")//新账号
--     {
--         createWnd.SetWndState(true);
--     }
--     else
--     {
--         MainCitySys.Instance.EnterMainCity();
--     }

--     loginWnd.SetWndState(false);
-- }

-- public void RspRename(GameMsg msg)
-- {
--     GameRoot.Instance.SetPlayerName(msg.rspRename.name);

--     MainCitySys.Instance.EnterMainCity();
--     createWnd.SetWndState(false);
-- }