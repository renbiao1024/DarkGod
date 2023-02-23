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
PEProtocol = CS.PEProtocol
Screen = UnityEngine.Screen
Camera = UnityEngine.Camera
CharacterController = UnityEngine.CharacterController
Animator = UnityEngine.Animator
Input = UnityEngine.Input
Time = UnityEngine.Time
Mathf = UnityEngine.Mathf
RectTransform = UnityEngine.RectTransform

-- UI
UI = UnityEngine.UI
Text = UI.Text
Image = UI.Image
Button = UI.Button
InputField = UI.InputField
GridLayoutGroup = UI.GridLayoutGroup
RawImage = UI.RawImage

-- 自定义类
LuaComponent = CS.LuaComponent
ABMgr = CS.ABMgr.GetInstance()
ClientSession = CS.ClientSession
PEListener = CS.PEListener

-- 全局单例
GameRootInst = nil

--自定义UI
UIs = {
    LoadingWndUI = nil,
    LoginWndUI = nil,
    DynamicWndUI = nil,
    CreateWndUI = nil,
    MainCityWndUI = nil,
    InfoWndUI = nil
}

-- 场景名称
Scenes = {
    SceneLogin = "SceneLogin",
    SceneMainCity = "SceneMainCity"
}

-- 音效名称
Audios = {
    BGLogin = "bgLogin",
    BGMainCity = "bgMainCity",
    UIClickBtn = "uiClickBtn",
    UILoginBtn = "uiLoginBtn",
    UIExtenBtn = "uiExtenBtn",
    UIOpenPage = "uiOpenPage"
}

-- ConfigName
Configs = {
    RDNameCfg = "ResCfgs/rdname"
}

-- 标准屏幕宽高
ScreenSize = {
    stdWidth = 1334,
    stdHeight = 750,
    stdOptionDis = 90
}

-- 移动速度
MoveSpeed = {
    PlayerMoveSpeed = 8,
    MonsterMoveSpeed = 4,
    AccelerSpeed = 5
}

BlendState = {
    Idle = 0,
    Walk = 1
}

-- 判空
function IsNull(obj)
	if obj == nil or obj:Equals(nil) then
	return true
end
	return false
end
