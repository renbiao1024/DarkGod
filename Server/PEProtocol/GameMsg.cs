using System;
using PENet;

namespace PEProtocol
{
    [Serializable]
    public class GameMsg : PEMsg
    {
        public ReqLogin reqLogin;
        public RspLogin rspLogin;
        public ReqRename reqRename;
        public RspRename rspRename;
    }

    #region 登陆相关
    [Serializable]
    public class ReqLogin
    {
        public string acct;
        public string pass;
    }

    [Serializable]
    public class RspLogin 
    {
        public PlayerData playerData;
    }

    [Serializable]
    public class PlayerData
    {
        public int id;
        public string name;
        public int lv;
        public int exp;
        public int power;
        public int coin;
        public int diamond;

        public int hp;
        public int ad;
        public int ap;
        public int addef;
        public int apdef;
        public int dodge;//闪避概率
        public int pierce;//穿透比率
        public int critical;//暴击概率
    }

    [Serializable]
    public class ReqRename
    {
        public string name;
    }
    [Serializable]
    public class RspRename
    {
        public string name;
    }
    #endregion

    public enum ErrorCode
    {
        None = 0,
        AcctIsOnline,
        WrongPass,
        NameIsExist,
        UpdateDBError // 更新数据库出错
    }
    public enum CMD
    {
        None = 0,
        ReqLogin = 101,
        RspLogin = 102,

        ReqRename = 103,
        RspRename = 104
    }
    public class SrvCfg
    {
        public const string srvIP = "192.168.3.91";
        public const int srvPort = 59963;
    }

}