MainCitySys = {}
MainCitySys.player = nil

function MainCitySys:InitSys()
    self.player = GameObject.Find("AssassinCity")
    LuaComponent.Add(self.player, PlayerController)
end

function MainCitySys:EnterMainCity()
    ResSvc:AsyncLoadScene(Scenes.SceneMainCity,function()
        AudioSvc:PlayBGMusic(Audios.BGMainCity,true)
        MainCityWnd:InitWnd()
        MainCityWnd:SetWndState(UIs.MainCityWndUI, true)
        self:InitSys()
    end)
end

function MainCitySys:SetMoveDir(dir)
    if(dir == Vector2.zero)then
        PlayerController.targetBlend = 0
        PlayerController.isMove = false
    else
        PlayerController.targetBlend = 1
        PlayerController.isMove = true
    end
    PlayerController.dir = dir
end