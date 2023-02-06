/****************************************************
    文件：ClientSession.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    日期：2023/2/6 16:40:30
    功能：
*****************************************************/

using PENet;
using PEProtocol;
using UnityEngine;

public class ClientSession : PESession<GameMsg>
{
    protected override void OnConnected()
    {
        //GameRoot.AddTips("连接服务器成功");
        PECommon.Log("Connect to server");
    }

    protected override void OnReciveMsg(GameMsg msg)
    {
        PECommon.Log("RcvPack CMD: " + ((CMD)msg.cmd).ToString());
        //NetSvc.Instance.AddNetPkg(msg);
    }

    protected override void OnDisConnected()
    {
        //GameRoot.AddTips("断开服务器链接");

        PECommon.Log("DisConnect from server");
    }
}
