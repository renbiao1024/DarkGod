-- 游戏启动入口
require("Common/BaseObject")
require("Common/SplitTools")
Json = require("Common/JsonUtility")
require("Common/Coroutine_cs")

require("Service/ResSvc")
require("Service/AudioSvc")

require("System/LoginSys")

require("UIWindow/WindowRoot")
require("UIWindow/LoadingWnd")
require("UIWindow/LoginWnd")
require("UIWindow/DynamicWnd")
require("UIWindow/CreateWnd")



GameRoot = {}

function GameRoot:Init()
    GameRootInst = GameObject.Find("GameRoot")
    Object.DontDestroyOnLoad(GameRootInst)

    --服务模块初始化
    LuaComponent.Add(GameRootInst, ResSvc)
    AudioSvc:InitSvc()

    --业务系统初始化
    LoginSys:InitSys()
    --LuaComponent.Add(GameRootInst, LoginSys)


    --UI初始化
    UIs.LoadingWndUI = GameObject.Find("GameRoot/Canvas/LoadingWnd")
    --LuaComponent.Add(UIs.LoadingWndUI, LoadingWnd)
    UIs.LoginWndUI = GameObject.Find("GameRoot/Canvas/LoginWnd")
    --LuaComponent.Add(UIs.LoginWndUI, LoginWnd)
    UIs.DynamicWndUI = GameObject.Find("GameRoot/Canvas/DynamicWnd")
    LuaComponent.Add(UIs.DynamicWndUI, DynamicWnd)
    UIs.CreateWndUI = GameObject.Find("GameRoot/Canvas/CreateWnd")

    LoadingWnd:InitWnd()
    DynamicWnd:InitWnd()

    --进入登陆场景 加载UI
    LoginSys:EnterLogin()
end

function GameRoot:AddTips(tips)
    DynamicWnd:AddTips(tips)
end