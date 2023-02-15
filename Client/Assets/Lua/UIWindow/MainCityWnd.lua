WindowRoot:subClass("MainCityWnd")

MainCityWnd.txtFight = nil
MainCityWnd.txtPow = nil
MainCityWnd.imgPowPrg = nil
MainCityWnd.txtLv = nil
MainCityWnd.txtName = nil
MainCityWnd.expPrg = nil

function MainCityWnd:InitWnd()
    self.base.InitWnd(self)
    self.txtFight = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgFight/txtFight"):GetComponent(typeof(Text))
    --print(self.txtFight)
    self.txtPow = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgPower/txtPower"):GetComponent(typeof(Text))
    self.imgPowPrg = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgPower/imgPowerPrg"):GetComponent(typeof(Image))
    self.txtLv = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgLv/txtLv"):GetComponent(typeof(Text))
    self.txtName = UIs.MainCityWndUI.transform:Find("CenterPin/txtName"):GetComponent(typeof(Text))
    --self.expPrg

    self:RefreshUI()
end

function MainCityWnd:RefreshUI()
    self.txtFight.text = PETools:GetFightByProps()
    self.txtPow.text = "体力："..PlayerData.pow.."/"..PETools:GetPowerLimit()
    self.imgPowPrg.fillAmount = PlayerData.pow / PETools:GetPowerLimit()
    self.txtLv.text = PlayerData.lv
    self.txtName.text = PlayerData.name
end




