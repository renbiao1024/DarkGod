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



GameRoot = {}

function GameRoot:Init()
    GameRootInst = GameObject.Find("GameRoot")
    Object.DontDestroyOnLoad(GameRootInst)

    --服务模块初始化
    LuaComponent.Add(GameRootInst, ResSvc)
    LuaComponent.Add(GameRootInst, AudioSvc)
    AudioSvc:InitSvc()
    --业务系统初始化
    LuaComponent.Add(GameRootInst, LoginSys)


    --UI初始化
    UIs.LoadingWndUI = GameObject.Find("GameRoot/Canvas/LoadingWnd")
    --LuaComponent.Add(UIs.LoadingWndUI, LoadingWnd)
    UIs.LoginWndUI = GameObject.Find("GameRoot/Canvas/LoginWnd")
    --LuaComponent.Add(UIs.LoginWndUI, LoginWnd)
    UIs.DynamicWnd = GameObject.Find("GameRoot/Canvas/DynamicWnd")
    
    LoadingWnd:InitWnd()
    LoginWnd:InitWnd()
    DynamicWnd:InitWnd()
    
    --进入登陆场景 加载UI
    LoginSys:EnterLogin()

end


