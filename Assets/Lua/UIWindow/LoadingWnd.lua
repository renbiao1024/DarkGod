WindowRoot:subClass("LoadingWnd")

-- LoadingWnd = {
--     name = "LoadingWnd"
-- }

LoadingWnd.txtTips = nil
LoadingWnd.imgFG = nil
LoadingWnd.imgPoint = nil
LoadingWnd.txtPrg = nil

function LoadingWnd:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function LoadingWnd:InitWnd()
    self.base.InitWnd(self)
    self.txtTips = GameObject.Find("GameRoot/Canvas/LoadingWnd/BottomPin/txtTips"):GetComponent(typeof(Text))
    self.imgFG = GameObject.Find("GameRoot/Canvas/LoadingWnd/BottomPin/loadingfg"):GetComponent(typeof(Image))
    self.imgPoint = GameObject.Find("GameRoot/Canvas/LoadingWnd/BottomPin/loadingfg/imgPoint"):GetComponent(typeof(Image))
    self.txtPrg = GameObject.Find("GameRoot/Canvas/LoadingWnd/BottomPin/txtPrg"):GetComponent(typeof(Text))

    self.fgWidth = self.imgFG:GetComponent(typeof(RectTransform)).sizeDelta.x;
    self.txtTips.text = "这是一条Tips"
    self.txtPrg.text = "0%"
    self.imgFG.fillAmount = 0
    self.imgPoint.transform.localPosition = Vector3(-545, 0 ,0)
end

function LoadingWnd:SetProgress(prg)
    self.txtPrg.text = tostring((prg*100)) .. "%"
    self.imgFG.fillAmount = prg
    local posX =  -545 + prg * self.fgWidth
    self.imgPoint:GetComponent(typeof(RectTransform)).anchoredPosition = Vector2(posX, 0)
end


function LoadingWnd:SetWndState(go, isActive)
    self.base.SetWndState(self, go, isActive)
end