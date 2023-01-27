-- unity类
UnityEngine = CS.UnityEngine
GameObject = UnityEngine.GameObject
InspectorName = UnityEngine.Object.name
SceneManager = UnityEngine.SceneManagement.SceneManager
Vector2 = UnityEngine.Vector2
Vector3 = UnityEngine.Vector3
RectTransform = UnityEngine.RectTransform
-- UI
UI = UnityEngine.UI
Text = UI.Text
Image = UI.Image

-- 自定义类
LuaComponent = CS.LuaComponent

-- 全局单例
GameRootInst = nil

--自定义UI
UIs = {
    LoadingWndUI = nil
}

-- 场景名称
Scenes = {
    SceneLogin = "SceneLogin"
}