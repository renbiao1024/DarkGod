--unity类
UnityEngine = CS.UnityEngine
GameObject = UnityEngine.GameObject
InspectorName = UnityEngine.Object.name
SceneManager = UnityEngine.SceneManagement.SceneManager

-- 自定义类
LuaComponent = CS.LuaComponent

-- 全局单例
GameRootInst = nil
ResSvc = nil
LoginSys = nil

--UI
UIs = {
    LoadingWndUI = nil
}

-- 场景名称
Scenes = {
    SceneLogin = "SceneLogin"
}