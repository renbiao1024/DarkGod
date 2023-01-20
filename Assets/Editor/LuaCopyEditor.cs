using System.Collections.Generic;
using System.IO;
/****************************************************
    文件：LuaCopyEditor.cs
    作者：Biu
    邮箱: 1024906432@qq.com
    日期：#CreateTime#
    功能：
*****************************************************/

using UnityEditor;
using UnityEngine;

public class LuaCopyEditor : Editor
{
    [MenuItem("XLua/自动生成txt后缀的lua")]
    public static void CopyLuaToTxt()
    {
        //Debug.Log("自动生成txt后缀的lua");

        //找到所有lua文件
        string path = Application.dataPath + "/Lua/"; //    Assets/Lua/
        if(!Directory.Exists(path)) return;

        string[] strs = Directory.GetFiles(path,"*.lua");
        // for(int i = 0; i < strs.Length; ++i)
        //     Debug.Log(strs[i]);

        //拷贝到新的文件夹
        string newPath = Application.dataPath + "/LuaTxt/";

        //先清空LuaTxt文件夹，再拷贝，防止无用文件滞留
        if(!Directory.Exists(newPath))
        {
            Directory.CreateDirectory(newPath);
        }
        else
        {
            string[] oldFileStrs = Directory.GetFiles(newPath, "*.txt");
            for(int i = 0; i < oldFileStrs.Length; ++i)
            {
                File.Delete(oldFileStrs[i]);
            }
        }
        List<string> newFileNames = new List<string>();
        string fileName;
        for(int i = 0; i < strs.Length; ++i)
        {
            fileName = newPath + strs[i].Substring(strs[i].LastIndexOf("/")+1) + ".txt";
            //Debug.Log(fileName);
            newFileNames.Add(fileName);
            File.Copy(strs[i], fileName);
        }
        AssetDatabase.Refresh();

        //添加到AB包
        for(int i = 0; i < newFileNames.Count; ++i)
        {
            AssetImporter importer = AssetImporter.GetAtPath(newFileNames[i].Substring(newFileNames[i].IndexOf("Assets")));
            if(importer != null)
                importer.assetBundleName = "lua";
        }
    }
}