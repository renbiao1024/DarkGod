PlayerController = {}
PlayerController.player = nil
PlayerController.camTrans = nil
PlayerController.camOffset = nil
PlayerController.isMove = false
PlayerController.ctrl = nil
PlayerController.ani = nil
PlayerController.dir = Vector2.zero
PlayerController.targetBlend = 0
PlayerController.curBlend = 0


function PlayerController:ctor(obj)
    local o = {}
    setmetatable(o,self)
    self.__index = self
    return o
end

function PlayerController.Start()
    PlayerController.player = GameObject.Find("AssassinCity")
    PlayerController.camTrans = Camera.main.transform
    PlayerController.camOffset = PlayerController.player.transform.position - PlayerController.camTrans.position
    PlayerController.ctrl = PlayerController.player:GetComponent(typeof(CharacterController))
    PlayerController.ani = PlayerController.player:GetComponent(typeof(Animator))
end

function PlayerController.Update()
    -- local h = Input.GetAxis("Horizontal")
    -- local v = Input.GetAxis("Vertical")
    -- local _dir = Vector2(h,v).normalized
    -- if(_dir ~= Vector2.zero)then
    --     PlayerController.dir = _dir
    --     PlayerController.isMove = true
    --     PlayerController.targetBlend = 1
    -- else
    --     PlayerController.dir = Vector2.zero
    --     PlayerController.isMove = false
    --     PlayerController.targetBlend = 0
    -- end

    if(PlayerController.curBlend ~= PlayerController.targetBlend)then
        PlayerController.UpdateMixBlend()
    end

    if(PlayerController.isMove)then
        PlayerController.SetDir()
        PlayerController.SetMove()
        PlayerController.SetCam()
    end
end

function PlayerController.SetDir()
    local angle = Vector2.SignedAngle(PlayerController.dir, Vector2(0,1)) + PlayerController.camTrans.eulerAngles.y
    local eulerAngles = Vector3(0, angle, 0)
    PlayerController.player.transform.localEulerAngles = eulerAngles
end

function PlayerController.SetMove()
    PlayerController.ctrl:Move(PlayerController.player.transform.forward * Time.deltaTime * MoveSpeed.PlayerMoveSpeed)
end

function PlayerController.SetCam()
    if(PlayerController.camTrans ~= nil)then
        PlayerController.camTrans.position = PlayerController.player.transform.position - PlayerController.camOffset
    end
end

function PlayerController.UpdateMixBlend()
    if(Mathf.Abs(PlayerController.curBlend - PlayerController.targetBlend) < MoveSpeed.AccelerSpeed * Time.deltaTime)then
        PlayerController.curBlend = PlayerController.targetBlend
    elseif(PlayerController.curBlend > PlayerController.targetBlend)then
        PlayerController.curBlend = PlayerController.curBlend - MoveSpeed.AccelerSpeed * Time.deltaTime
    else
        PlayerController.curBlend = PlayerController.curBlend + MoveSpeed.AccelerSpeed * Time.deltaTime
    end
    PlayerController.ani:SetFloat("Blend",PlayerController.curBlend)
end
