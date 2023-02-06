using PENet;
using PEProtocol;
using System.Collections.Generic;


public class MsgPack
{
    public ServerSession session;
    public GameMsg msg;
    public MsgPack(ServerSession session, GameMsg msg) 
    {
        this.session = session;
        this.msg = msg;
    }
}
public class NetSvc
{
    private static NetSvc instance = null;
    public static NetSvc Instance
    {
        get
        {
            if (instance == null)
                instance = new NetSvc();
            return instance;
        }
    }

    private static readonly string obj = "lock";
    private Queue<MsgPack> msgPackQue = new Queue<MsgPack>();
    public void Init()
    {
        PESocket<ServerSession, GameMsg> server = new PESocket<ServerSession, GameMsg>();
        server.StartAsServer(SrvCfg.srvIP, SrvCfg.srvPort);
        PECommon.Log("NetSvc Init Done.");
    }

    public void AddMsgQue(ServerSession session, GameMsg msg)
    {
        lock(obj)
        {
            msgPackQue.Enqueue(new MsgPack(session, msg));
        }
    }

    public void Update()
    {
        //网络消息的检测
        if(msgPackQue.Count > 0)
        {
            //PECommon.Log("PackCount: " + msgPackQue.Count);
            lock(obj)
            {
                MsgPack pack = msgPackQue.Dequeue();
                HandleOutMsg(pack);
            }
        }
    }

    private void HandleOutMsg(MsgPack pack)
    {
        switch((CMD)pack.msg.cmd)
        { 
        case CMD.ReqLogin:
            LoginSys.Instance.ReqLogin(pack);//登陆游戏
            break;
        case CMD.ReqRename:
            LoginSys.Instance.ReqRename(pack);//重命名
            break;
        }
    }
}
