using PENet;
using PEProtocol;

public class PECommon
{
    public static void Log(string msg = "", int lv = 0)
    {
        PETool.LogMsg(msg, (LogLevel)lv);
    }

    public static int GetFightByProps(PlayerData pd)
    {
        return pd.lv * 100 + pd.ad + pd.ap + pd.addef + pd.apdef;
    }

    public static int GetPowerLimit(int lv)
    {
        return ((lv - 1)/10) * 150 + 150;
    }

    public static int GetExpUpValByLv(int lv)
    {
        return 100 * lv * lv;
    }
}
