using PEProtocol;

public class LoginSys
{
    private static LoginSys instance = null;
    public static LoginSys Instance
    {
        get
        {
            if (instance == null)
                instance = new LoginSys();
            return instance;
        }
    }

    private CacheSvc cacheSvc = null;
    public void Init()
    {
        cacheSvc = CacheSvc.Instance;
        PECommon.Log("LoginSys Init Done.");
    }
    public void ReqLogin(MsgPack pack)
    {
        ReqLogin data = pack.msg.reqLogin;
        GameMsg msg = new GameMsg
        {
            cmd = (int)CMD.RspLogin,
            rspLogin = new RspLogin
            {
                
            }
        };

        if (cacheSvc.IsAcctOnline(data.acct))//当前帐号上线？
        {
            msg.err = (int)ErrorCode.AcctIsOnline;
        }
        else
        {//未上线
            PlayerData pd = cacheSvc.GetPlayerData(data.acct, data.pass);//账号存在于数据库吗？
            if(pd == null ) 
            {
                msg.err = (int)ErrorCode.WrongPass;
            }
            else
            {
                msg.rspLogin = new RspLogin
                {
                    playerData = pd
                };

                // 缓存上线的账号数据
                cacheSvc.AcctOnline(data.acct, pack.session, pd);
            }
        }

        pack.session.SendMsg(msg);//发回客户端
    }

    public void ReqRename(MsgPack pack)
    {
        ReqRename data = pack.msg.reqRename;
        GameMsg msg = new GameMsg
        {
            cmd = (int)CMD.RspRename
        };

        //名字存在吗

        //存在：errorcode
        if (cacheSvc.IsNameExist(data.name))
        {
            msg.err = (int)ErrorCode.NameIsExist;
        }
        else//不存在
        {
            //缓存
            PlayerData playerData = cacheSvc.GetPlayerDataBySession(pack.session);
            playerData.name = data.name;
            //更新数据库
            if (!cacheSvc.UpdatePlayerData(playerData.id, playerData))
            {
                msg.err = (int)ErrorCode.UpdateDBError;
            }
            else
            {
                msg.rspRename = new RspRename
                {
                    name = data.name
                };
            }
            //返回客户端
            pack.session.SendMsg(msg);
        }
    }

    public void ClearOfflineData(ServerSession session)
    {
        cacheSvc.AcctOffLine(session);
    }
}

