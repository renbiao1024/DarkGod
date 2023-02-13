/****************************************************
    文件：NetSvc.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    日期：2023/2/6 16:44:2
    功能：
*****************************************************/
using System.Collections.Generic;
using System.Linq;
using PENet;
using PEProtocol;
using UnityEngine;
using XLua;

// call lua class
[CSharpCallLua]
interface LuaLoginSys
{

     void RspLogin(GameMsg msg);

     void RspRename(GameMsg msg);
}


public class NetSvc : MonoBehaviour 
{
    public static NetSvc Instance = null;
    private static readonly string obj = "lock";
    PESocket<ClientSession, GameMsg> client = null;
    private Queue<GameMsg> msgQue = new Queue<GameMsg>();

    public void InitSvc()
    {
        client = new PESocket<ClientSession, GameMsg>();
        Instance = this;
        //在 unity 输出
        client.SetLog(true, (string msg, int lv) =>
        {
            switch (lv)
            {
                case 0:
                    msg = "Log: " + msg;
                    Debug.Log(msg);
                    break;
                case 1:
                    msg = "Warning: " + msg;
                    Debug.LogWarning(msg);
                    break;
                case 2:
                    msg = "Error: " + msg;
                    Debug.LogError(msg);
                    break;
                case 3:
                    msg = "Info: " + msg;
                    Debug.Log(msg);
                    break;
            }
        });
        client.StartAsClient(SrvCfg.srvIP, SrvCfg.srvPort);
        PECommon.Log("Init NetSvc...");
    }

    public void SendMsg(GameMsg msg)
    {
        if (client.session != null)
        {
            client.session.SendMsg(msg);//发送到服务器
        }
        else
        {
            Debug.Log("服务器未连接");
            InitSvc();
        }
    }

    public void AddNetPkg(GameMsg msg)
    {
        lock (obj)
        {
            msgQue.Enqueue(msg);
        }
    }
    private void Update()//处理收到的服务端消息
    {
        if(msgQue.Count > 0)
        {
            lock(obj)
            {
                GameMsg msg = msgQue.Dequeue();
                ProcessMsg(msg);
            }
        }
    }

    private void ProcessMsg(GameMsg msg)
    {
        if(msg.err != (int)ErrorCode.None)//错误码处理
        {
            switch ((ErrorCode)msg.err)
            {
                case ErrorCode.UpdateDBError:
                    PECommon.Log("数据库更新异常", 2);
                    //GameRoot.AddTips("网络不稳定");
                    break;
                case ErrorCode.AcctIsOnline:
                    //GameRoot.AddTips("当前账号已经登陆");
                    break;
                case ErrorCode.WrongPass:
                    //GameRoot.AddTips("密码错误");
                    break;
            }
            return;
        }

        LuaLoginSys loginSys = LuaMgr.GetInstance().Globle.Get<LuaLoginSys>("LoginSys");
        //Debug.Log("point");
        switch((CMD)msg.cmd)//处理回应消息
        {
            case CMD.RspLogin:
                loginSys.RspLogin(msg); // 由于版本不兼容，这里简单处理
                break;
            case CMD.RspRename:
                loginSys.RspRename(msg);
                break;
        }
    }

}