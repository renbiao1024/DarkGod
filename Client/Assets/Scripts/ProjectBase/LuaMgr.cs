using System;
/****************************************************
    文件：LuaMgr.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    功能：lua管理器，提供lua解析器，保证解析器的唯一性
*****************************************************/

using System.IO;
using UnityEngine;
using XLua;

public class LuaMgr : BaseManager<LuaMgr>
{
    private LuaEnv luaEnv;
    public LuaTable Globle
    {
        get { return luaEnv.Global; }
    }
    //初始化解析器
    public void Init()
    {
        if (luaEnv != null)
            return;
        luaEnv = new LuaEnv();

        //按顺序查找，找到为止
        //当前的解决方法，如果用直接加载，require需要带入文件层级，如果在AB包加载，不需要层级
        luaEnv.AddLoader(MyCustomLoader);
        luaEnv.AddLoader(MyCustomABLoader);
    }

    //自定义lua路径
    private byte[] MyCustomLoader(ref string filePath)
    {
        //传入的是reqire的脚本文件路径
        string path = Application.dataPath + "/Lua/" + filePath + ".lua";
        Debug.Log(path);

        if (File.Exists(path))
        {
            return File.ReadAllBytes(path);
        }
        else
        {
            Debug.Log(filePath + " 重定向失败");
        }
        return null;
    }

    //重定向加载AB包中的lua脚本
    private byte[] MyCustomABLoader(ref string filePath)
    {
        //Debug.Log("进入AB包加载");
        //string path = Application.streamingAssetsPath + "/lua";
        //AssetBundle ab = AssetBundle.LoadFromFile(path);

        //TextAsset tx = ab.LoadAsset<TextAsset>(filePath + ".lua");
        //return tx.bytes;

        TextAsset lua = ABMgr.GetInstance().LoadRes<TextAsset>("lua/common",filePath + ".lua");
        if(lua != null)
        {
            return lua.bytes;
        }
        else
        {
            lua = ABMgr.GetInstance().LoadRes<TextAsset>("lua/service",filePath + ".lua");
            if(lua != null)
            {
                return lua.bytes;
            }
            else 
            {
                lua = ABMgr.GetInstance().LoadRes<TextAsset>("lua/system",filePath + ".lua");
                if(lua != null)
                {
                    return lua.bytes;
                }
                else
                {
                    lua = ABMgr.GetInstance().LoadRes<TextAsset>("lua/uiwindow",filePath + ".lua");
                    if(lua != null)
                    {
                        return lua.bytes;
                    }
                    else
                    {
                        Debug.Log(filePath + "重定向失败");
                    }
                }
            }
        }
        return null;
    }

    public void DoLuaFile(string fileName)
    {
        string str = string.Format("require('{0}')", fileName);
        DoString(str);
    }

    //执行lua
    public void DoString(string str)
    {
        if(luaEnv == null)
        {
            Debug.Log("解析器没有初始化");
            return;
        }
        luaEnv.DoString(str);
    }

    //释放lua垃圾
    public void Tick()
    {
        if (luaEnv == null)
        {
            Debug.Log("解析器没有初始化");
            return;
        }
        luaEnv.Tick();
    }

    //销毁解析器
    public void Dispose() 
    {
        if (luaEnv == null)
        {
            Debug.Log("解析器没有初始化");
            return;
        }
        luaEnv.Dispose();
        luaEnv= null;
    }
}