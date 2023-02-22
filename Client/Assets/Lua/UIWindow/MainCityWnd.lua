WindowRoot:subClass("MainCityWnd")

MainCityWnd.txtFight = nil
MainCityWnd.txtPow = nil
MainCityWnd.imgPowPrg = nil
MainCityWnd.txtLv = nil
MainCityWnd.txtName = nil
MainCityWnd.expPrgLst = nil
MainCityWnd.txtExpPrg = nil
MainCityWnd.menuState = true
MainCityWnd.btnMenuBtn = nil
MainCityWnd.menuAni = nil
MainCityWnd.imgTouch = nil
MainCityWnd.imgDirBg = nil
MainCityWnd.imgDirPoint = nil
MainCityWnd.pointDis = nil
MainCityWnd.startPos = Vector3.zero
MainCityWnd.defaultPos = Vector3.zero

-- 主菜单里的btn
MainCityWnd.headBth = nil

function MainCityWnd:InitWnd()
    self.base.InitWnd(self)
    self.txtFight = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgFight/txtFight"):GetComponent(typeof(Text))
    self.txtPow = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgPower/txtPower"):GetComponent(typeof(Text))
    self.imgPowPrg = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgPower/imgPowerPrg"):GetComponent(typeof(Image))
    self.txtLv = UIs.MainCityWndUI.transform:Find("LeftTopPin/bgLv/txtLv"):GetComponent(typeof(Text))
    self.txtName = UIs.MainCityWndUI.transform:Find("CenterPin/txtName"):GetComponent(typeof(Text))
    self.expPrgLst = UIs.MainCityWndUI.transform:Find("BottomPin/bgExp/itemLst").transform
    self.txtExpPrg = UIs.MainCityWndUI.transform:Find("BottomPin/txtExpPrg"):GetComponent(typeof(Text))
    self.btnMenuBtn = UIs.MainCityWndUI.transform:Find("RightBottomPin/MenuRoot/btnMenu"):GetComponent(typeof(Button))
    self.menuAni = UIs.MainCityWndUI.transform:Find("RightBottomPin/MenuRoot"):GetComponent(typeof(Animation))
    self.imgTouch = UIs.MainCityWndUI.transform:Find("LeftBottomPin/imgTouch")
    self.imgDirBg = UIs.MainCityWndUI.transform:Find("LeftBottomPin/imgTouch/imgDirBg")
    self.imgDirPoint = UIs.MainCityWndUI.transform:Find("LeftBottomPin/imgTouch/imgDirBg/imgDirPoint")

    self.pointDis = Screen.height / ScreenSize.stdHeight * ScreenSize.stdOptionDis
    self.defaultPos = self.imgDirBg.transform.position

    self.headBth = UIs.MainCityWndUI.transform:Find("LeftTopPin/btnHead"):GetComponent(typeof(Button))

    self.btnMenuBtn.onClick:AddListener(function()
        self:ClickMenuBtn()
    end)

    self.headBth.onClick:AddListener(function()
        self:ClickHeadBtn()
    end)

    self:RegisterTouchEvents()
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

function MainCityWnd:ClickMenuBtn()
    AudioSvc:PlayUIAudio(Audios.UIExtenBtn)
    self.menuState = not self.menuState
    local clip = nil
    if(self.menuState)then
        clip = self.menuAni:GetClip("OpenMCMenu")
        --print("Open")
    else
        clip = self.menuAni:GetClip("CloseMCMenu")
        --print("Close")
    end
    self.menuAni:Play(clip.name)
end

function MainCityWnd:RegisterTouchEvents()
    local listener = self.imgTouch:GetComponent(typeof(PEListener))

    listener.onClickDown = function(evt)
        self.startPos = Vector3(evt.position.x, evt.position.y, 0)
        self.imgDirBg.transform.position = Vector3(evt.position.x, evt.position.y, 0)
    end

    listener.onClickUp = function(evt)
        self.imgDirBg.transform.position = self.defaultPos
        self.imgDirPoint.transform.localPosition = Vector3.zero
        MainCitySys:SetMoveDir(Vector2.zero)
    end

    listener.onDrag = function(evt)
        local dir = Vector3(evt.position.x, evt.position.y, 0) - self.startPos
        local len = dir.magnitude
        if(len > self.pointDis)then
            local clampDir = Vector3.ClampMagnitude(dir, self.pointDis)
            self.imgDirPoint.transform.position = self.startPos + clampDir
        else
            self.imgDirPoint.transform.position = Vector3(evt.position.x, evt.position.y, 0)
        end
        local dir2D = Vector2(dir.x, dir.y)
        MainCitySys:SetMoveDir(dir2D.normalized)
    end
end

function MainCityWnd:ClickHeadBtn()
    AudioSvc:PlayUIAudio(Audios.UIOpenPage)
    InfoWnd:SetWndState(UIs.InfoWndUI,true)
    InfoWnd:InitWnd()
end