-- 游戏启动入口

require("Service/ResSvc")
require("System/LoginSys")
require("BaseObject")
require("UIWindow/WindowRoot")
require("UIWindow/LoadingWnd")
require("UIWindow/LoginWnd")



GameRoot = {}

function GameRoot:Init()
    GameRootInst = GameObject.Find("GameRoot")
    Object.DontDestroyOnLoad(GameRootInst)

    --服务模块初始化
    LuaComponent.Add(GameRootInst, ResSvc)

    --业务系统初始化
    LuaComponent.Add(GameRootInst, LoginSys)

    --UI初始化
    UIs.LoadingWndUI = GameObject.Find("GameRoot/Canvas/LoadingWnd")
    --LuaComponent.Add(UIs.LoadingWndUI, LoadingWnd)
    UIs.LoginWndUI = GameObject.Find("GameRoot/Canvas/LoginWnd")
    --LuaComponent.Add(UIs.LoginWndUI, LoginWnd)

    --进入登陆场景 加载UI
    LoginSys:EnterLogin()
end


