-- 游戏启动入口

require("Service/ResSvc")
require("System/LoginSys")
require("UIWindow/LoadingWnd")

GameRoot = {}

function GameRoot:Init()
    GameRootInst = GameObject.Find("GameRoot")
    --服务模块初始化
    LuaComponent.Add(GameRootInst, ResSvc)

    --业务系统初始化
    LuaComponent.Add(GameRootInst, LoginSys)

    --UI初始化
    UIs.LoadingWndUI = GameObject.Find("GameRoot/Canvas/LoadingWnd")
    LuaComponent.Add(UIs.LoadingWndUI, LoadingWnd)

    --进入登陆场景 加载UI
    LoginSys:EnterLogin()
end


