using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.Events;
using XLua;

[CSharpCallLua]
public class LuaMonoMgr : MonoBehaviour
{
    private UnityAction start;
    private UnityAction update;
    private UnityAction fixedUpdate;
    private UnityAction lateUpdate;
    private UnityAction onEnable;
    private UnityAction onDisable;
    private UnityAction onDestroy;
 
    private void Start()
    {
        if (start != null)
            start();
    }
    private void Update()
    {
        if (update != null)
            update();
    }
    private void FixedUpdate()
    {
        if (fixedUpdate != null)
            fixedUpdate();
    }
    private void LateUpdate()
    {
        if (lateUpdate != null)
            lateUpdate();
    }
    private void OnEnable()
    {
        if (onEnable != null)
            onEnable();
    }
    private void OnDisable()
    {
        if (onDisable != null)
            onDisable();
    }
    private void OnDestroy()
    {
        if (onDestroy != null)
            onDestroy();
        start = null;
        update = null;
        fixedUpdate = null;
        lateUpdate = null;
        onEnable = null;
        onDisable = null;
        onDestroy = null;
    }
 
    public void AddOrRemoveListener(UnityAction fun , E_LifeFun_Type type, bool isAdd = true)
    {
        switch (type)
        {
            case E_LifeFun_Type.Start:
                if (isAdd)
                    start += fun;
                else
                    start -= fun;
                break;
            case E_LifeFun_Type.Update:
                if (isAdd)
                    update += fun;
                else
                    update -= fun;
                break;
            case E_LifeFun_Type.LateUpdate:
                if (isAdd)
                    lateUpdate += fun;
                else
                    lateUpdate -= fun;
                break;
            case E_LifeFun_Type.FixedUpdate:
                if (isAdd)
                    fixedUpdate += fun;
                else
                    fixedUpdate -= fun;
                break;
            case E_LifeFun_Type.OnEnable:
                if (isAdd)
                    onEnable += fun;
                else
                    onEnable -= fun;
                break;
            case E_LifeFun_Type.OnDisable:
                if (isAdd)
                    onDisable += fun;
                else
                    onDisable -= fun;
                break;
            case E_LifeFun_Type.OnDestroy:
                if (isAdd)
                    onDestroy += fun;
                else
                    onDestroy -= fun;
                break;
        }
    }
 
}
 
public enum E_LifeFun_Type
{
    Start,
    Update,
    LateUpdate,
    FixedUpdate,
    OnEnable,
    OnDisable,
    OnDestroy
}