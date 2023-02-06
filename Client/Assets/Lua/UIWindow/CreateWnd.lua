WindowRoot:subClass("CreateWnd")

CreateWnd.btnEnter = nil
CreateWnd.btnRandom = nil
CreateWnd.iptName = nil

function CreateWnd:InitWnd()
    self.base.InitWnd(self)

    self.btnEnter = GameObject.Find("GameRoot/Canvas/CreateWnd/RightPin/btnEnter"):GetComponent(typeof(Button))
    self.btnRandom = GameObject.Find("GameRoot/Canvas/CreateWnd/RightPin/iptName/btnRand"):GetComponent(typeof(Button))
    self.iptName = GameObject.Find("GameRoot/Canvas/CreateWnd/RightPin/iptName"):GetComponent(typeof(InputField))
    
    self.btnEnter.onClick:AddListener(function()
        self:ClickEnterBtn()
    end)

    self.btnRandom.onClick:AddListener(function()
        self:ClickRandBtn()
    end)

    self.iptName.text = ResSvc:GetRDNameData(false)

end

function CreateWnd:ClickEnterBtn()
    AudioSvc:PlayUIAudio(Audios.UIClickBtn)
    if(self.iptName.text ~= "") then
        -- TODO 服务器登陆
    else
        GameRoot:AddTips("名字不符合规范")
    end
end

function CreateWnd:ClickRandBtn()
    AudioSvc:PlayUIAudio(Audios.UIClickBtn)
    local rdName = ResSvc:GetRDNameData(false)
    self.iptName.text = rdName
end