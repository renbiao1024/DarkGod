MainCitySys = {}
MainCitySys.player = nil
MainCitySys.charShowCamTrans = nil

function MainCitySys:InitSys()
    self.player = GameObject.Find("AssassinCity")
    LuaComponent.Add(self.player, PlayerController)
    self.charShowCamTrans = GameObject.FindGameObjectWithTag("CharShowCam").transform
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

function MainCitySys:OpenInfoWnd()
    self.charShowCamTrans.localPosition = self.player.transform.position + self.player.transform.forward * 3.8 + Vector3(0, 1.2, 0)
    self.charShowCamTrans.localEulerAngles = Vector3(0, 180 + self.player.transform.localEulerAngles.y, 0)
end