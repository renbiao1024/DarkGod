require("Common/Coroutine_cs")

WindowRoot:subClass("DynamicWnd")

DynamicWnd.tipsAni = nil
DynamicWnd.txtTips = nil
local Que_Str = Generic.Queue(CS.System.String)
DynamicWnd.tipsQue =Que_Str()
DynamicWnd.isTipsShow = false

function DynamicWnd:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function DynamicWnd:InitWnd()
    self.base.InitWnd(self)

    self.tipsAni = GameObject.Find("GameRoot/Canvas/DynamicWnd/CenterPin/txtTips"):GetComponent(typeof(Animation))
    self.txtTips = GameObject.Find("GameRoot/Canvas/DynamicWnd/CenterPin/txtTips"):GetComponent(typeof(Text))
    self.txtTips.gameObject:SetActive(false)
end

function DynamicWnd:AddTips(tips)
    self.tipsQue:Enqueue(tips)
end

function DynamicWnd.Update()
    if DynamicWnd.tipsQue.Count > 0 and DynamicWnd.isTipsShow == false then
        local tips = DynamicWnd.tipsQue:Dequeue()
        DynamicWnd.isTipsShow = true
        DynamicWnd:SetTips(tips)
    end
end

function DynamicWnd:SetTips(tips)
    self.txtTips.gameObject:SetActive(true)
    self.txtTips.text = tips
    local clip = self.tipsAni:GetClip("TipsShowAni")
    self.tipsAni:Play()

    coroutine_cs.start(function()
        coroutine_cs.wait(clip.length)
        self.txtTips.gameObject:SetActive(false)
        self.isTipsShow = false
    end)
end

