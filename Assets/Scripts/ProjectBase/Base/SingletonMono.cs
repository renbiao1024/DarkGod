/****************************************************
    文件：SingletonMono.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    日期：#CreateTime#
    功能：
*****************************************************/

using UnityEngine;

public class SingletonMono<T> : MonoBehaviour where T : MonoBehaviour 
{
    private static T instance;
    public static T GetInstance() { return instance; }

    protected virtual void Awake()
    {
        instance = this as T;
    }
}