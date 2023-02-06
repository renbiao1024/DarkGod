/****************************************************
    文件：LuaComponent.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    日期：2023/1/20 9:47:3
    功能：
*****************************************************/

using System;
using UnityEngine;
using XLua;

[LuaCallCSharp]
public class LuaComponent : MonoBehaviour {

    public LuaTable luaTable;

    LuaFunction luaStart;
    LuaFunction luaUpdate;
    LuaFunction luaOnDestroy ;
    LuaFunction luaAwake ;
    LuaFunction luaOnEnable;
    LuaFunction luaFixedUpdate;
    LuaFunction luaOnDisable;
    LuaFunction luaLateUpdate;

    /// <summary>
    /// 添加lua组件
    /// </summary>
    /// <param name="go"></param>
    /// <param name="tableClass"></param>
    /// <returns></returns>
    public static LuaTable Add(GameObject go,LuaTable tableClass)
    {
        LuaFunction luaCtor =  tableClass.Get<LuaFunction>("ctor");
        if ( null != luaCtor)
        {
            object[] rets = luaCtor.Call(tableClass);
            if (1 != rets.Length)
            {
                return null;
            }
            LuaComponent cmp = go.AddComponent<LuaComponent>();
            cmp.luaTable = (LuaTable)rets[0];
            cmp.initLuaFunction();
            cmp.CallAwake();
            //cmp.name = cmp.luaTable.Get<string>("name");
            return cmp.luaTable;
        }
        else
        {
            throw new Exception("Lua function .ctor not found");
        }
    }

    /// <summary>
    /// 获取lua组件
    /// </summary>
    /// <param name="go"></param>
    /// <param name="table"></param>
    /// <returns></returns>
    public static LuaTable Get(GameObject go,LuaTable table)
    {
        LuaComponent[] cmps =   go.GetComponents<LuaComponent>();
        string tableStr = table.ToString();
        for(int i = 0; i < cmps.Length;i++)
        {
            string temp = cmps[i].luaTable.ToString();
            if(string.Equals(tableStr,cmps[i].luaTable.ToString()))
            {
                return cmps[i].luaTable;
            }
        }
        return null;
        
    }

    /// <summary>
    /// 设置组件父节点
    /// </summary>
    /// <param name="go"></param>
    /// <param name="parent"></param>
    public static void SetParent(GameObject go,Transform parent)
    {
        go.transform.SetParent(parent);
    }

    /// <summary>
    /// 初始化Lua脚本中的方法
    /// </summary>
    void initLuaFunction()
    {
        luaOnDestroy =  luaTable.Get<LuaFunction>("OnDestroy");
        luaAwake = luaTable.Get<LuaFunction>("Awake");
        luaStart = luaTable.Get<LuaFunction>("Start");
        luaUpdate = luaTable.Get<LuaFunction>("Update");
        luaOnEnable = luaTable.Get<LuaFunction>("OnEnable");
        luaFixedUpdate = luaTable.Get<LuaFunction>("FixedUpdate");
        luaOnDisable = luaTable.Get<LuaFunction>("OnDisable");
        luaLateUpdate = luaTable.Get<LuaFunction>("LateUpdate");
    }

    /// <summary>
    /// 调用lua脚本中定义的Awake方法
    /// </summary>
    void CallAwake()
    {
        if ( null != luaAwake)
        {
            luaAwake.Call(luaTable, gameObject);
        }
    }

    /// <summary>
    /// 调用lua脚本中定义的Start方法
    /// </summary>
    private void Start()
    {

        if ( null != luaStart)
        {
            luaStart.Call(luaTable, gameObject);
        }
    }

    /// <summary>
    /// 调用lua脚本中定义的Update方法
    /// </summary>
    private void Update()
    {
        if (null != luaUpdate)
        {
            luaUpdate.Call();
        }
    }

    /// <summary>
    /// 调用lua脚本中定义的FixedUpdate方法
    /// </summary>
    private void FixedUpdate()
    {
        if (null != luaFixedUpdate)
        {
            luaFixedUpdate.Call();
        }
    }

    /// <summary>
    /// 调用lua脚本中定义的OnDestroy方法
    /// </summary>
    private void OnDestroy()
    {
        if (null != luaOnDestroy)
        {
            luaOnDestroy.Call();
        }
    }

    /// <summary>
    /// 调用lua脚本中定义的 OnEnable
    /// </summary>
    private void OnEnable()
    {
        if (null != luaOnEnable)
        {
            luaOnEnable.Call();
        }
    }

    /// <summary>
    /// 调用lua脚本中定义的 OnDisable
    /// </summary>
    private void OnDisable()
    {
        if (null != luaOnDisable)
        {
            luaOnDisable.Call();
        }
    }

    /// <summary>
    /// 调用lua脚本中定义的 LateUpdate
    /// </summary>
    private void LateUpdate()
    {
        if (null != luaLateUpdate)
        {
            luaLateUpdate.Call();
        }
    }
}