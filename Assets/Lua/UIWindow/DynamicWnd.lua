require("Common/Coroutine_cs")

WindowRoot:subClass("DynamicWnd")

DynamicWnd.tipsAni = nil
DynamicWnd.txtTips = nil

function DynamicWnd:InitWnd()
    self.base.InitWnd(self)

    self.tipsAni = GameObject.Find("GameRoot/Canvas/DynamicWnd/CenterPin/txtTips"):GetComponent(typeof(Animation))
    self.txtTips = GameObject.Find("GameRoot/Canvas/DynamicWnd/CenterPin/txtTips"):GetComponent(typeof(Text))
    self.txtTips.gameObject:SetActive(false)
end

function DynamicWnd:SetTips(tips)
    self.txtTips.gameObject:SetActive(true)
    self.txtTips.text = tips
    local clip = self.tipsAni:GetClip("TipsShowAni")
    self.tipsAni:Play()

    coroutine_cs.start(function()
        coroutine_cs.wait(clip.length)
        self.txtTips.gameObject:SetActive(false)
    end)

end

