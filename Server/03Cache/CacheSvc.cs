
using PEProtocol;
using System.Collections.Generic;

public class CacheSvc
{
    private static CacheSvc instance = null;
    public static CacheSvc Instance
    {
        get
        {
            if (instance == null)
                instance = new CacheSvc();
            return instance;
        }
    }

    private DBMgr dbMgr;
    private Dictionary<string, ServerSession> onlineAccDic = new Dictionary<string, ServerSession>();
    private Dictionary<ServerSession, PlayerData> onlineSessionDic = new Dictionary<ServerSession, PlayerData>();
    public void Init()
    {
        dbMgr = DBMgr.Instance;
        PECommon.Log("CacheSvc Init Done.");
    }

    public bool IsAcctOnline(string acct)
    {
        return onlineAccDic.ContainsKey(acct);
    }

    public PlayerData GetPlayerData(string acct, string pass)
    {
        return dbMgr.QueryPlayerData(acct, pass);//在数据库查找
    }

    /// <summary>
    /// 帐号上线 缓存数据
    /// </summary>
    /// <param name="acct"></param>
    /// <param name="session"></param>
    /// <param name="playerData"></param>
    public void AcctOnline(string acct, ServerSession session, PlayerData playerData)
    {
        onlineAccDic.Add(acct, session);
        onlineSessionDic.Add(session, playerData);
    }

    public bool IsNameExist(string name)
    {
        return dbMgr.QueryNameData(name);
    }

    public PlayerData GetPlayerDataBySession(ServerSession session)
    {
        if(onlineSessionDic.TryGetValue(session, out PlayerData playerData))
        {
            return playerData;
        }
        else
        {
            return null;
        }
    }
    public bool UpdatePlayerData(int id, PlayerData playerData)
    {
        return dbMgr.UpdatePlayerData(id, playerData);
    }

    public void AcctOffLine(ServerSession session)
    {
        foreach(var item in onlineAccDic)
        {
            if(item.Value == session)
            {
                onlineAccDic.Remove(item.Key);
                break;
            }
        }
        bool succ = onlineSessionDic.Remove(session);
        PECommon.Log("Session ID:" + session.sessionID + " Offline Result:" + succ);
    }
}
