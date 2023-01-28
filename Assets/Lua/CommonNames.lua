-- unity类
UnityEngine = CS.UnityEngine
GameObject = UnityEngine.GameObject
InspectorName = UnityEngine.Object.name
SceneManager = UnityEngine.SceneManagement.SceneManager
Vector2 = UnityEngine.Vector2
Vector3 = UnityEngine.Vector3
RectTransform = UnityEngine.RectTransform
PlayerPrefs  = UnityEngine.PlayerPrefs
Object = UnityEngine.Object
Transform = UnityEngine.Transform

-- UI
UI = UnityEngine.UI
Text = UI.Text
Image = UI.Image
Button = UI.Button
InputField = UI.InputField

-- 自定义类
LuaComponent = CS.LuaComponent

-- 全局单例
GameRootInst = nil

--自定义UI
UIs = {
    LoadingWndUI = nil,
    LoginWndUI = nil
}

-- 场景名称
Scenes = {
    SceneLogin = "SceneLogin"
}

-- 判空
function IsNull(obj)
	if obj == nil or obj:Equals(nil) then
	return true
end
	return false
end
