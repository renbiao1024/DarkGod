WindowRoot:subClass("LoginWnd")

-- LoginWnd = {
--     name = "LoginWnd"
-- }

LoginWnd.iptAcct = nil
LoginWnd.iptPass = nil
LoginWnd.btnEnter = nil
LoginWnd.btnNotice = nil

-- function LoginWnd:ctor(obj)
--     local o = {}
--     setmetatable(o,self)
--     self.__index = self
--     return o
-- end

function LoginWnd:InitWnd()
    self.base.InitWnd(self)
    self.iptAcct = GameObject.Find("GameRoot/Canvas/LoginWnd/RightPin/iptbg1/iptAcct"):GetComponent(typeof(InputField))
    self.iptPass = GameObject.Find("GameRoot/Canvas/LoginWnd/RightPin/iptbg2/iptPass"):GetComponent(typeof(InputField))
    self.btnEnter = GameObject.Find("GameRoot/Canvas/LoginWnd/RightPin/btnEnter"):GetComponent(typeof(Button))
    self.btnNotice = GameObject.Find("GameRoot/Canvas/LoginWnd/btnNotice"):GetComponent(typeof(Button))

    self.btnEnter.onClick:AddListener(function()
        self:ClickEnterBtn()
    end)

    self.btnNotice.onClick:AddListener(function()
        self:ClickNoticeBtn()
    end)

    if PlayerPrefs.HasKey("Acct") and PlayerPrefs.HasKey("Pass") then
        self.iptAcct.text = PlayerPrefs.GetString("Acct")
        self.iptPass.text = PlayerPrefs.GetString("Pass")
    else
        self.iptAcct.text = ""
        self.iptPass.text = ""
    end
end


function LoginWnd:ClickEnterBtn()

    AudioSvc:PlayUIAudio(Audios.UILoginBtn)
    local _acct = self.iptAcct.text
    local _pass = self.iptPass.text
    if(_acct ~= "" and _pass ~= "") then
        if(PlayerPrefs.GetString("Acct")==_acct) then
            if(PlayerPrefs.GetString("Pass")==_pass)then
                PlayerData.id = PlayerPrefs.GetString("Id")
                PlayerData.name = PlayerPrefs.GetString("Name")
                PlayerData.lv = PlayerPrefs.GetString("Lv")
                PlayerData.exp = PlayerPrefs.GetString("Exp")
                PlayerData.pow = PlayerPrefs.GetString("Pow")
                PlayerData.coin = PlayerPrefs.GetString("Coin")
                PlayerData.diamond = PlayerPrefs.GetString("Diamond")
                PlayerData.hp = PlayerPrefs.GetString("Hp")
                PlayerData.ad = PlayerPrefs.GetString("Ad")
                PlayerData.ap = PlayerPrefs.GetString("Ap")
                PlayerData.addef = PlayerPrefs.GetString("Addef")
                PlayerData.apdef = PlayerPrefs.GetString("Apdef")
                PlayerData.dodge = PlayerPrefs.GetString("Dodge")
                PlayerData.pierce = PlayerPrefs.GetString("Pierce")
                PlayerData.critical = PlayerPrefs.GetString("Critical")
                LoginSys:Login()
            else
                GameRoot:AddTips("密码错误")
            end
        else
                PlayerPrefs.SetString("Acct",_acct)
                PlayerPrefs.SetString("Pass",_pass)
                PlayerPrefs.SetString("Id",-1)
                PlayerPrefs.SetString("Name","")
                PlayerPrefs.SetString("Lv",1)
                PlayerPrefs.SetString("Exp",0)
                PlayerPrefs.SetString("Pow",150)
                PlayerPrefs.SetString("Coin",5000)
                PlayerPrefs.SetString("Diamond",500)
                PlayerPrefs.SetString("Hp",2000)
                PlayerPrefs.SetString("Ad",275)
                PlayerPrefs.SetString("Ap",265)
                PlayerPrefs.SetString("Addef",67)
                PlayerPrefs.SetString("Apdef",43)
                PlayerPrefs.SetString("Dodge",7)
                PlayerPrefs.SetString("Pierce",5)
                PlayerPrefs.SetString("Critical",2)
                LoginSys:Login()
        end
    else
        GameRoot:AddTips("账号或密码为空")
    end
end

function LoginWnd:ClickNoticeBtn()
    AudioSvc:PlayUIAudio(Audios.UIClickBtn)
    GameRoot:AddTips("功能开发中...")
end