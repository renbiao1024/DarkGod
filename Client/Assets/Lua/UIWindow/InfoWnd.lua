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

    self.btnClose.onClick:AddListener(function()
        self:ClickCloseBtn()
    end)

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

end

function InfoWnd:ClickCloseBtn()
    InfoWnd:SetWndState(UIs.InfoWndUI,false)
end