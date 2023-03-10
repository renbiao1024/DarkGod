
using PENet;

public class ServerRoot
{
    private static ServerRoot instance = null;
    public static ServerRoot Instance
    {
        get { 
            if(instance == null) 
                instance = new ServerRoot();
            return instance; 
        }
    }

    //服务端起点
    public void Init()
    {
        //数据层
        DBMgr.Instance.Init();

        // 服务层
        NetSvc.Instance.Init();
        CacheSvc.Instance.Init();


        //业务系统
        LoginSys.Instance.Init();
    }

    public void Update()
    {
        NetSvc.Instance.Update();
    }

    private int SessionID = 0;
    public int GetSessionID()
    {
        if(SessionID == int.MaxValue)
        {
            SessionID = 0;
        }
        return SessionID += 1;
    }
}
