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