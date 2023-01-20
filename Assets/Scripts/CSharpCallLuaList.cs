using XLua;
using System;
using System.Collections.Generic;
using UnityEngine.Events;

public static class CSharpCallLuaList
{
    [CSharpCallLua]
    public static List<Type> csharpCallLuaList = new List<Type>(){
        typeof(UnityAction<bool>)
    };
}