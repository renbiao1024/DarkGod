/****************************************************
    文件：ABMgr.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    功能：AB包管理器,让外部方便资源加载
*****************************************************/

using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;

public class ABMgr : SingletonAutoMono<ABMgr> 
{
    private AssetBundle mainAB = null;
    private AssetBundleManifest manifest = null;
    private string PathUrl
    {
        get { return Application.streamingAssetsPath + "/"; }
    }

    private string mainABName
    {
        get
        {
#if UNITY_IOS
            return "IOS";
#elif UNITY_ANDROID
            return "Android";
#else  
            return "PC";
#endif
        }
    }

    private Dictionary<string, AssetBundle> abDic = new Dictionary<string, AssetBundle>(); //用字典存储加载完的AB包

    public void LoadAB(string abName)
    {
        //加载依赖包
        if (mainAB == null)
        {
            mainAB = AssetBundle.LoadFromFile(PathUrl + mainABName);
            manifest = mainAB.LoadAsset<AssetBundleManifest>("AssetBundleManifest");
        }

        AssetBundle ab;

        string[] strs = manifest.GetAllDependencies(abName);
        for (int i = 0; i < strs.Length; i++)
        {
            if (!abDic.ContainsKey(strs[i]))
            {
                ab = AssetBundle.LoadFromFile(PathUrl + strs[i]);
                abDic.Add(strs[i], ab);
            }
        }

        //加载要用的资源
        if (!abDic.ContainsKey(abName))
        {
            ab = AssetBundle.LoadFromFile(PathUrl + abName);
            abDic.Add(abName, ab);
        }
    }

    //同步加载:不指定类型
    public Object LoadRes(string abName, string resName)
    {
        //加载AB包
        LoadAB(abName);

        //加载资源：gameobject直接实例化
        Object obj = abDic[abName].LoadAsset(resName);
        if (obj is GameObject)
            return Instantiate(obj);
        else 
            return obj;
    }

    //同步加载:指定类型，lua主要用
    public Object LoadRes(string abName, string resName, System.Type type)
    {
        //加载AB包
        LoadAB(abName);

        Object obj = abDic[abName].LoadAsset(resName, type);
        if (obj is GameObject)
            return Instantiate(obj);
        else
            return obj;
    }

    //同步加载：根据泛型指定类型，c#主要用
    public T LoadRes<T>(string abName, string resName) where T: Object
    {
        //加载AB包
        LoadAB(abName);

        T obj = abDic[abName].LoadAsset<T>(resName);
        if (obj is GameObject)
            return Instantiate(obj);
        else
            return obj;
    }

    //协程创建AB包，用委托分享出去
    //根据名字异步加载
    public void LoadResAsync(string abName, string resName, UnityAction<Object> callBack)
    {
        StartCoroutine(ReallyLoadResAsync(abName, resName, callBack));
    }

    private IEnumerator ReallyLoadResAsync(string abName, string resName, UnityAction<Object> callBack)
    {
        LoadAB(abName);

        AssetBundleRequest abr = abDic[abName].LoadAssetAsync(resName);
        yield return abr;

        if (abr.asset is GameObject)
            callBack(Instantiate(abr.asset));
        else
            callBack(abr.asset);
    }

    //根据Type异步加载
    public void LoadResAsync(string abName, string resName, System.Type type, UnityAction<Object> callBack)
    {
        StartCoroutine(ReallyLoadResAsync(abName, resName, type, callBack));
    }

    private IEnumerator ReallyLoadResAsync(string abName, string resName, System.Type type, UnityAction<Object> callBack)
    {
        LoadAB(abName);

        AssetBundleRequest abr = abDic[abName].LoadAssetAsync(resName, type);
        yield return abr;

        if (abr.asset is GameObject)
            callBack(Instantiate(abr.asset));
        else
            callBack(abr.asset);
    }

    //根据泛型异步加载
    public void LoadResAsync<T>(string abName, string resName, UnityAction<T> callBack) where T: Object
    {
        StartCoroutine(ReallyLoadResAsync<T>(abName, resName, callBack));
    }

    private IEnumerator ReallyLoadResAsync<T>(string abName, string resName, UnityAction<T> callBack) where T : Object
    {
        LoadAB(abName);

        AssetBundleRequest abr = abDic[abName].LoadAssetAsync<T>(resName);
        yield return abr;

        if (abr.asset is GameObject)
            callBack(Instantiate(abr.asset) as T);
        else
            callBack(abr.asset as T);
    }

    //单个包卸载
    public void UnLoad(string abName)
    {
        if(abDic.ContainsKey(abName))
        {
            abDic[abName].Unload(false);
            abDic.Remove(abName);
        }
    }

    //所有包的卸载
    public void ClearAB()
    {
        AssetBundle.UnloadAllAssetBundles(false);
        abDic.Clear();
        mainAB = null;
        manifest = null;
    }
}