/****************************************************
    文件：Main.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    功能：xlua主入口
*****************************************************/

using UnityEngine;

public class Main : MonoBehaviour 
{
    private void Start()
    {
        LuaMgr.GetInstance().Init();
        LuaMgr.GetInstance().DoLuaFile("Main");
        // Ray ray = new Ray();
        // RaycastHit hitRet;
        // Physics.Raycast(ray, out hitRet);
    }
}