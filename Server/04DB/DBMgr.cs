using MySql.Data.MySqlClient;
using PEProtocol;
using System;
using System.ComponentModel;

public class DBMgr
{
    private static DBMgr instance = null;
    public static DBMgr Instance
    {
        get
        {
            if (instance == null)
                instance = new DBMgr();
            return instance;
        }
    }

    private MySqlConnection conn;
    public void Init()
    {
        conn = new MySqlConnection("server=localhost;User Id = root;password=;Database = darkgod;Charset = utf8");
        conn.Open();
        PECommon.Log("DBMgr Init Done.");

        //测试
        //QueryPlayerData("xyz", "123");
    }

    public PlayerData QueryPlayerData(string acct, string pass)
    {
        PlayerData playerData = null;
        MySqlDataReader reader = null;
        bool isNew = true;
        try//有账号直接返回
        {
            MySqlCommand cmd = new MySqlCommand("select * from account where acct = @acct", conn);
            cmd.Parameters.AddWithValue("acct", acct);
            reader = cmd.ExecuteReader();
            if(reader.Read())
            {
                isNew = false;
                string _pass = reader.GetString("pass");
                if(_pass.Equals(pass)) 
                {
                    playerData = new PlayerData
                    {
                        id = reader.GetInt32("id"),
                        name = reader.GetString("name"),
                        lv = reader.GetInt32("level"),
                        exp = reader.GetInt32("exp"),
                        power = reader.GetInt32("power"),
                        coin = reader.GetInt32("coin"),
                        diamond = reader.GetInt32("diamond"),
                        hp = reader.GetInt32("hp"),
                        ad = reader.GetInt32("ad"),
                        ap = reader.GetInt32("ap"),
                        addef = reader.GetInt32("addef"),
                        apdef = reader.GetInt32("apdef"),
                        dodge = reader.GetInt32("dodge"),
                        pierce = reader.GetInt32("pierce"),
                        critical = reader.GetInt32("critical")

                    };
                }
            }
        }
        catch(Exception e)
        {
            PECommon.Log("Query PlayerData By Acct&Pass Error:" + e, 2);
        }
        finally
        {
            if(reader != null)
            {
                reader.Close();
            }
            if(isNew )//没有账号，创建新账号
            {
                playerData = new PlayerData
                {
                    id = -1,
                    name = "",
                    lv = 1,
                    exp = 0,
                    power = 150,
                    coin = 5000,
                    diamond = 500,
                    hp = 2000,
                    ad = 275,
                    ap = 265,
                    addef = 67,
                    apdef = 43,
                    dodge = 7,
                    pierce = 5,
                    critical = 2,
                };
                playerData.id = InsertNewAccountData(acct, pass, playerData);//写入到数据库
            }
        }

        return playerData;
    }

    //插入新玩家数据
    private int InsertNewAccountData(string acct, string pass, PlayerData pd)
    {
        int id = -1;
        try
        {
            MySqlCommand cmd = new MySqlCommand(
                "insert into account set acct=@acct,pass=@pass,name=@name,level=@level,exp=@exp,power=@power,coin=@coin,diamond=@diamond," + 
                "hp=@hp,ad=@ad,ap=@ap,addef=@addef,apdef=@apdef,dodge=@dodge,pierce=@pierce,critical=@critical", conn);
            cmd.Parameters.AddWithValue("acct", acct);
            cmd.Parameters.AddWithValue("pass", pass);
            cmd.Parameters.AddWithValue("name", pd.name);
            cmd.Parameters.AddWithValue("level", pd.lv);
            cmd.Parameters.AddWithValue("exp", pd.exp);
            cmd.Parameters.AddWithValue("power", pd.power);
            cmd.Parameters.AddWithValue("coin", pd.coin);
            cmd.Parameters.AddWithValue("diamond", pd.diamond);
            cmd.Parameters.AddWithValue("hp", pd.hp);
            cmd.Parameters.AddWithValue("ad", pd.ad);
            cmd.Parameters.AddWithValue("ap", pd.ap);
            cmd.Parameters.AddWithValue("addef", pd.addef);
            cmd.Parameters.AddWithValue("apdef", pd.apdef);
            cmd.Parameters.AddWithValue("dodge", pd.dodge);
            cmd.Parameters.AddWithValue("pierce", pd.pierce);
            cmd.Parameters.AddWithValue("critical", pd.critical);
            cmd.ExecuteNonQuery();
            id = (int)cmd.LastInsertedId;
        }
        catch (Exception e)
        {
            PECommon.Log("Insert PlayerData Error:" + e, 2);
        }

        return 0;
    }

    public bool QueryNameData(string name)
    {
        bool exist = false;
        MySqlDataReader reader = null;
        try
        {
            MySqlCommand cmd = new MySqlCommand("select * from account where name=@name", conn);
            cmd.Parameters.AddWithValue("name", name);
            reader = cmd.ExecuteReader();
            if (reader.Read())
            {
                exist = true;
            }
        }
        catch (Exception e)
        {
            PECommon.Log("Query Name State Error:" + e, 2);
        }
        finally
        {
            if (reader != null) { reader.Close(); }
        }
        return exist;
    }

    public bool UpdatePlayerData(int id, PlayerData playerData)
    {
        try
        {
            MySqlCommand cmd = new MySqlCommand(
                "update account set name=@name,level=@level,exp=@exp,power=@power,coin=@coin,diamond=@diamond," + 
                "hp=@hp,ad=@ad,ap=@ap,addef=@addef,apdef=@apdef,dodge=@dodge,pierce=@pierce,critical=@critical where id=@id", conn);
            cmd.Parameters.AddWithValue("id", id);
            cmd.Parameters.AddWithValue("name", playerData.name);
            cmd.Parameters.AddWithValue("level", playerData.lv);
            cmd.Parameters.AddWithValue("exp", playerData.exp);
            cmd.Parameters.AddWithValue("power", playerData.power);
            cmd.Parameters.AddWithValue("coin", playerData.coin);
            cmd.Parameters.AddWithValue("diamond", playerData.diamond);
            cmd.Parameters.AddWithValue("hp", playerData.hp);
            cmd.Parameters.AddWithValue("ad", playerData.ad);
            cmd.Parameters.AddWithValue("ap", playerData.ap);
            cmd.Parameters.AddWithValue("addef", playerData.addef);
            cmd.Parameters.AddWithValue("apdef", playerData.apdef);
            cmd.Parameters.AddWithValue("dodge", playerData.dodge);
            cmd.Parameters.AddWithValue("pierce", playerData.pierce);
            cmd.Parameters.AddWithValue("critical", playerData.critical);
            cmd.ExecuteNonQuery();
        }
        catch (Exception e)
        {
            PECommon.Log("Update Player Data Error:" + e, 2);
            return false;
        }

        return true;
    }
}