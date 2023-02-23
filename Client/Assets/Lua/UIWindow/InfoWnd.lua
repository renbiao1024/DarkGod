WindowRoot:subClass("InfoWnd")

InfoWnd.txtInfo = nil
InfoWnd.txtExp = nil
InfoWnd.imgExpPrg = nil
InfoWnd.txtPower = nil
InfoWnd.imgPowPrg = nil
InfoWnd.txtJob = nil
InfoWnd.txtFight = nil
InfoWnd.txtHP = nil
InfoWnd.txtHurt = nil
InfoWnd.txtDef = nil
InfoWnd.btnClose = nil
InfoWnd.imgChar = nil
InfoWnd.dragStartPos = nil
InfoWnd.dragStartRot = nil

--详细信息面板
InfoWnd.btnDetail = nil
InfoWnd.btnCloseDetail = nil
InfoWnd.transDetail = nil
InfoWnd.dtxthp = nil
InfoWnd.dtxtad = nil
InfoWnd.dtxtap = nil
InfoWnd.dtxtaddef = nil
InfoWnd.dtxtapdef = nil
InfoWnd.dtxtdodge = nil
InfoWnd.dtxtpierce = nil
InfoWnd.dtxtcritical = nil

function InfoWnd:InitWnd()
    self.base.InitWnd(self)
    self.txtInfo = UIs.InfoWndUI.transform:Find("charbg/infobg/txtInfo"):GetComponent(typeof(Text))
    self.txtExp = UIs.InfoWndUI.transform:Find("MainContent/valitem1/barbg/txtExpprg"):GetComponent(typeof(Text))
    self.imgExpPrg = UIs.InfoWndUI.transform:Find("MainContent/valitem1/barbg/imgExpprg"):GetComponent(typeof(Image))
    self.txtPower = UIs.InfoWndUI.transform:Find("MainContent/valitem2/barbg/txtPowerprg"):GetComponent(typeof(Text))
    self.imgPowPrg = UIs.InfoWndUI.transform:Find("MainContent/valitem2/barbg/imgPowerprg"):GetComponent(typeof(Image))
    self.txtJob = UIs.InfoWndUI.transform:Find("MainContent/valitem3/chardes"):GetComponent(typeof(Text))
    self.txtFight = UIs.InfoWndUI.transform:Find("MainContent/valitem4/txtFight"):GetComponent(typeof(Text))
    self.txtHP = UIs.InfoWndUI.transform:Find("MainContent/valitem5/txthp"):GetComponent(typeof(Text))
    self.txtHurt = UIs.InfoWndUI.transform:Find("MainContent/valitem6/txthurt"):GetComponent(typeof(Text))
    self.txtDef = UIs.InfoWndUI.transform:Find("MainContent/valitem7/txtdef"):GetComponent(typeof(Text))
    self.btnClose = UIs.InfoWndUI.transform:Find("MainContent/btnClose"):GetComponent(typeof(Button))
    self.imgChar = UIs.InfoWndUI.transform:Find("charbg/charShow"):GetComponent(typeof(RawImage))
    self.btnDetail = UIs.InfoWndUI.transform:Find("MainContent/btnDetail"):GetComponent(typeof(Button))
    self.btnCloseDetail = UIs.InfoWndUI.transform:Find("transDetail/btnClose"):GetComponent(typeof(Button))
    self.transDetail = UIs.InfoWndUI.transform:Find("transDetail"):GetComponent(typeof(RectTransform))
    local group = UIs.InfoWndUI.transform:Find("transDetail/Group").transform
    self.dtxthp = group:Find("propItem1/val"):GetComponent(typeof(Text))
    self.dtxtad = group:Find("propItem2/val"):GetComponent(typeof(Text))
    self.dtxtap = group:Find("propItem3/val"):GetComponent(typeof(Text))
    self.dtxtaddef = group:Find("propItem4/val"):GetComponent(typeof(Text))
    self.dtxtapdef = group:Find("propItem5/val"):GetComponent(typeof(Text))
    self.dtxtdodge = group:Find("propItem6/val"):GetComponent(typeof(Text))
    self.dtxtpierce = group:Find("propItem7/val"):GetComponent(typeof(Text))
    self.dtxtcritical = group:Find("propItem8/val"):GetComponent(typeof(Text))
    self.transDetail.gameObject:SetActive(false)

    self.btnClose.onClick:AddListener(function()
        self:ClickCloseBtn()
    end)

    self.btnDetail.onClick:AddListener(function()
        self:ClickDetailBtn()
    end)

    self.btnCloseDetail.onClick:AddListener(function()
        self:ClickCloseDetailBtn()
    end)
    self:RegisterTouchEvents()
    self:RefreshUI()
end

function InfoWnd:RefreshUI()
    self.txtInfo.text = PlayerData.name .. "  LV." .. PlayerData.lv
    self.txtExp.text = PlayerData.exp .. "/" .. PETools:GetExpUpValByLv()
    self.imgExpPrg.fillAmount = PlayerData.exp / PETools:GetExpUpValByLv()
    self.txtPower.text = PlayerData.pow .. "/" .. PETools:GetPowerLimit()
    self.imgPowPrg.fillAmount = PlayerData.pow / PETools:GetPowerLimit()

    self.txtJob.text = "职业  暗夜刺客"
    self.txtFight.text = "战力  " .. PETools:GetFightByProps()
    self.txtHP.text = "血量  " .. PlayerData.hp
    self.txtHurt.text = "伤害  " .. (PlayerData.ad + PlayerData.ap)
    self.txtDef.text = "防御  " .. (PlayerData.addef + PlayerData.apdef)

    self.dtxthp.text = PlayerData.hp
    self.dtxtad.text = PlayerData.ad
    self.dtxtap.text = PlayerData.ap
    self.dtxtaddef.text = PlayerData.addef
    self.dtxtapdef.text = PlayerData.apdef
    self.dtxtdodge.text = PlayerData.dodge .. "%"
    self.dtxtpierce.text = PlayerData.pierce .. "%"
    self.dtxtcritical.text = PlayerData.critical .. "%"


end

function InfoWnd:ClickCloseBtn()
    AudioSvc:PlayUIAudio(Audios.UIClickBtn)
    InfoWnd:SetWndState(UIs.InfoWndUI,false)
    MainCitySys.charShowCamTrans.gameObject:SetActive(false)
end

function InfoWnd:RegisterTouchEvents()
    local listener = self.imgChar:GetComponent(typeof(PEListener))
    listener.onClickDown = function(evt)
        self.dragStartPos = evt.position
        self.dragStartRot = MainCitySys.player.transform.localEulerAngles.y
    end

    listener.onDrag = function(evt)
        local rotate = -(evt.position.x - self.dragStartPos.x) * 0.4
        MainCitySys.player.transform.localEulerAngles = Vector3(0, self.dragStartRot + rotate, 0)
    end
end

function InfoWnd:ClickDetailBtn()
    AudioSvc:PlayUIAudio(Audios.UIClickBtn)
    self.transDetail.gameObject:SetActive(true)
end

function InfoWnd:ClickCloseDetailBtn()
    AudioSvc:PlayUIAudio(Audios.UIClickBtn)
    self.transDetail.gameObject:SetActive(false)
end