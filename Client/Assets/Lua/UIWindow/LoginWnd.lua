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
        PlayerPrefs.SetString("Acct",_acct)
        PlayerPrefs.SetString("Pass",_pass)
        -- local msg = PEProtocol.GameMsg()
        -- msg.cmd = PEProtocol.CMD.ReqLogin
        -- msg.reqLogin = PEProtocol.ReqLogin()
        -- msg.reqLogin.acct = _acct
        -- msg.reqLogin.pass = _pass

        -- NetSvc:SendMsg(msg)
        LoginSys:Login()
    else
        GameRoot:AddTips("账号或密码为空")
    end
end

function LoginWnd:ClickNoticeBtn()
    AudioSvc:PlayUIAudio(Audios.UIClickBtn)
    GameRoot:AddTips("功能开发中...")
end