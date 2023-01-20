/****************************************************
    文件：NewBehaviourScript.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    日期：#CreateTime#
    功能：
*****************************************************/

using UnityEngine;

public class BaseManager<T> where T: new()
{
    private static T instance;
    public static T GetInstance()
    {
        if(instance == null)
        {
            instance = new T();
        }
        return instance;
    }

}