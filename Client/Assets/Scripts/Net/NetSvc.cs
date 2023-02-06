/****************************************************
    文件：NetSvc.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    日期：2023/2/6 16:44:2
    功能：
*****************************************************/
using PENet;
using PEProtocol;
using UnityEngine;

public class NetSvc : MonoBehaviour 
{
    public static NetSvc Instance = null;
    PESocket<ClientSession, GameMsg> client = null;

    public void InitSvc()
    {
        Instance = this;
        client = new PESocket<ClientSession, GameMsg>();
        client.SetLog(true, (string msg, int lv)=>{
            switch(lv){
                case 0:
                    Debug.Log("Log: " + msg);
                    break;
                case 1:
                    Debug.LogWarning("Warn: " + msg);
                    break;
                case 2:
                    Debug.LogError("Error: " + msg);
                    break;
                case 3:
                    Debug.Log("Info: " + msg);
                    break;
                default: 
                    break;
            }
        });
        client.StartAsClient(SrvCfg.srvIP, SrvCfg.srvPort);
    }
}