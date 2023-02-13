MainCitySys = {}

function MainCitySys:InitSys()

end

function MainCitySys:EnterMainCity()
    ResSvc:AsyncLoadScene(Scenes.SceneMainCity,function()
        
        AudioSvc:PlayBGMusic(Audios.BGMainCity,true) 
        MainCityWnd:InitWnd()
        MainCityWnd:SetWndState(UIs.MainCityWndUI, true)

    end)
end