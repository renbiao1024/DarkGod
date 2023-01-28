WindowRoot:subClass("LoginWnd")

-- LoginWnd = {
--     name = "LoginWnd"
-- }

LoginWnd.iptAcct = nil
LoginWnd.iptPass = nil
LoginWnd.btnEnter = nil
LoginWnd.btnNotice = nil

function LoginWnd:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function LoginWnd:InitWnd()
    self.base.InitWnd(self)
    self.iptAcct = GameObject.Find("GameRoot/Canvas/LoginWnd/RightPin/iptbg1/iptAcct"):GetComponent(typeof(InputField))
    self.iptPass = GameObject.Find("GameRoot/Canvas/LoginWnd/RightPin/iptbg2/iptPass"):GetComponent(typeof(InputField))
    self.btnEnter = GameObject.Find("GameRoot/Canvas/LoginWnd/RightPin/btnEnter"):GetComponent(typeof(Button))
    self.btnNotice = GameObject.Find("GameRoot/Canvas/LoginWnd/btnNotice"):GetComponent(typeof(Button))

    if PlayerPrefs.HasKey("Acct") and PlayerPrefs.HasKey("Pass") then
        self.iptAcct.text = PlayerPrefs.GetString("Acct")
        self.iptPass.text = PlayerPrefs.GetString("Pass")
    else
        self.iptAcct.text = ""
        self.iptPass.text = ""
    end
end


function LoginWnd:SetWndState(go, isActive)
    self.base.SetWndState(self, go, isActive)
end