LoadingWnd = {
    name = "LoadingWnd"
}

function LoadingWnd:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end
