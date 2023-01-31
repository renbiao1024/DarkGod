using System.IO;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;
using static System.Net.Mime.MediaTypeNames;
//编辑器开发需要继承的类Editor
public class LuaCopyEditor : Editor
{
    //放在编辑器头顶菜单的哪个位置
    [MenuItem("XLua/generate lua.txt")]
    public static void CopyLuaToTxt()
    {
        //存放.lua文件的路径
        string path= UnityEngine.Application.dataPath+"/Lua/";
        //判断路径是否存在
        if(!Directory.Exists(path))
            return;

        string[] dir = Directory.GetDirectories(path); //子文件夹路径
        for(int j = 0; j < dir.Length;j++)
        {
        //路径存在获取文件后缀为.lua的所有文件名
            string[] strs=Directory.GetFiles(dir[j],"*.lua"); //路径内的lua文件
            //如果新路径不存在创建新路径
            //如果存在删除该路径下的所有文件
            string dirName = dir[j].Substring(dir[j].LastIndexOf("/")+1);
            string newPath=UnityEngine.Application.dataPath+"/LuaTxt/"+dirName;
            if(!Directory.Exists(newPath))
                Directory.CreateDirectory(newPath);
            else
            {
                string[] oldStrs=Directory.GetFiles(newPath,"*.txt");
                for(int i=0;i<oldStrs.Length;i++)
                {
                    File.Delete(oldStrs[i]);
                }
            }
        
            List<string> newFileNames=new List<string>();
            string fileName=null;
            for(int i=0;i<strs.Length;i++)
            {
                fileName=newPath + "/" + strs[i].Substring(strs[i].LastIndexOf("\\")+1)+".txt";   
                newFileNames.Add(fileName); 
                //将第一个路径的文件内容拷贝到 第二个路径的文件
                File.Copy(strs[i],fileName);
            }

            //打成订制包
            for(int i=0;i<newFileNames.Count;i++)
            {
                //Unity Api
                //该API传入的路径必须是 相对于Assets文件夹的 Assets/..../....
                //该API是将某个文件 放入定制包中
                AssetImporter importer=AssetImporter.GetAtPath(newFileNames[i].Substring(newFileNames[i].IndexOf("Assets")));
                //定制包名为 lua，可以自行修改
                if(importer!=null)
                    importer.assetBundleName="lua/" + dirName;
            }
        }
        
        //刷新编辑器
        AssetDatabase.Refresh();
    }
    
}

