/****************************************************
    文件：SingleAutoMono.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    功能：单例模式
*****************************************************/

using UnityEngine;

public class SingletonAutoMono<T> : MonoBehaviour where T : MonoBehaviour
{
    private static T instance;

    public static T GetInstance()
    {
        if(instance == null)
        {
            GameObject obj = new GameObject();
            obj.name = typeof(T).ToString();
            DontDestroyOnLoad(obj);
            instance = obj.AddComponent<T>();
        }
        return instance;
    }
}