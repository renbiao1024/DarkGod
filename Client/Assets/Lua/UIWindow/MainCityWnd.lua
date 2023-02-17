WindowRoot:subClass("MainCityWnd")

MainCityWnd.txtFight = nil
MainCityWnd.txtPow = nil
MainCityWnd.imgPowPrg = nil
MainCityWnd.txtLv = nil
MainCityWnd.txtName = nil
MainCityWnd.expPrgLst = nil
MainCityWnd.txtExpPrg = nil

function MainCityWnd:InitWnd()
    self.base.InitWnd(self)
    self.txtFight = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgFight/txtFight"):GetComponent(typeof(Text))
    --print(self.txtFight)
    self.txtPow = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgPower/txtPower"):GetComponent(typeof(Text))
    self.imgPowPrg = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgPower/imgPowerPrg"):GetComponent(typeof(Image))
    self.txtLv = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgLv/txtLv"):GetComponent(typeof(Text))
    self.txtName = UIs.MainCityWndUI.transform:Find("CenterPin/txtName"):GetComponent(typeof(Text))
    self.expPrgLst = UIs.MainCityWndUI.transform:Find("BottomPin/bgExp/itemLst").transform
    self.txtExpPrg = UIs.MainCityWndUI.transform:Find("BottomPin/txtExpPrg"):GetComponent(typeof(Text))

    self:RefreshUI()
end

function MainCityWnd:RefreshUI()
    self.txtFight.text = PETools:GetFightByProps()
    self.txtPow.text = "体力:"..PlayerData.pow.."/"..PETools:GetPowerLimit()
    self.imgPowPrg.fillAmount = PlayerData.pow / PETools:GetPowerLimit()
    self.txtLv.text = PlayerData.lv
    self.txtName.text = PlayerData.name

    local globalRate = ScreenSize.stdHeight / Screen.height
    local screenWidth = Screen.width * globalRate
    local width = (screenWidth - 180) // 10
    local grid = self.expPrgLst:GetComponent(typeof(GridLayoutGroup))
    grid.cellSize = Vector2(width,7)

    local expPrgVal = PlayerData.exp / PETools:GetExpUpValByLv() * 100
    expPrgVal = 100
    self.txtExpPrg.text = expPrgVal.."%"
    local idx = expPrgVal // 10
    for i = 0,self.expPrgLst.childCount-1 do
        local img = self.expPrgLst:GetChild(i):GetComponent(typeof(Image))
        if(i < idx) then
            img.fillAmount = 1
        elseif (i == idx) then
            img.fillAmount = expPrgVal % 10 / 10
        else
            img.fillAmount = 0
        end
    end
end




