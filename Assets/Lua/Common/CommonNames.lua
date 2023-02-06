-- unity类
UnityEngine = CS.UnityEngine
Generic = CS.System.Collections.Generic
GameObject = UnityEngine.GameObject
InspectorName = UnityEngine.Object.name
SceneManager = UnityEngine.SceneManagement.SceneManager
Vector2 = UnityEngine.Vector2
Vector3 = UnityEngine.Vector3
RectTransform = UnityEngine.RectTransform
PlayerPrefs  = UnityEngine.PlayerPrefs
Object = UnityEngine.Object
Transform = UnityEngine.Transform
AudioClip = UnityEngine.AudioClip
AudioSource = UnityEngine.AudioSource
Resources = UnityEngine.Resources
Animation = UnityEngine.Animation
AnimationClip = UnityEngine.AnimationClip
WaitForSeconds = UnityEngine.WaitForSeconds
TextAsset = UnityEngine.TextAsset
Xml = CS.System.Xml
Random = CS.System.Random

-- UI
UI = UnityEngine.UI
Text = UI.Text
Image = UI.Image
Button = UI.Button
InputField = UI.InputField

-- 自定义类
LuaComponent = CS.LuaComponent
ABMgr = CS.ABMgr.GetInstance()

-- 全局单例
GameRootInst = nil

--自定义UI
UIs = {
    LoadingWndUI = nil,
    LoginWndUI = nil,
    DynamicWndUI = nil,
    CreateWndUI = nil
}

-- 场景名称
Scenes = {
    SceneLogin = "SceneLogin"
}

-- 音效名称
Audios = {
    BGLogin = "bgLogin",
    UIClickBtn = "uiClickBtn",
    UILoginBtn = "uiLoginBtn"
}

-- ConfigName
Configs = {
    RDNameCfg = "ResCfgs/rdname"
}

-- 判空
function IsNull(obj)
	if obj == nil or obj:Equals(nil) then
	return true
end
	return false
end
