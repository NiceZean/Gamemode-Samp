/*
	Developer Server ...

	Nazz

	Credits:

 	* Nazz (Newbie Pawn Scripter)

	Copyright(c) 2021-2021 Nazz (All rights reserved).
*/

/* Includes */
#include <a_samp>
#include <sscanf2>
#include <a_mysql>
#include <streamer>
#include <dudb>
#include <utils>
#include <foreach>
#include <samp_bcrypt>
#include <whirlpool>
#include <discord-connector> 
#include <sampvoice>
#include <geolocation>

native IsValidVehicle(vehicleid);

#pragma unused ret_memcpy
#pragma unused strtok
#pragma unused GetVehicleWithinDistance
//====//====//====//====//====//====//====//==== Database MySql
#define 		DATABASE_ADDRESS 	"127.0.0.1" 
#define 		DATABASE_USERNAME 	"server_7354"
#define 		DATABASE_PASSWORD 	"acqwrts4xh"
#define			DATABASE_NAME 		"server_7354_nazzz"
/*/
#define 		DATABASE_ADDRESS 	"localhost" 
#define 		DATABASE_USERNAME 	"root"
#define 		DATABASE_PASSWORD 	""
#define			DATABASE_NAME 		"basicrp"*/
//====//====//====//====//====//====//====//==== [MAX_LIMIT]
#define 		MAX_CHARS 			3
#define 		MAX_HOUSES 			1000
//#define 		MAX_VEHICLES        1000
//====//====//====//====//====//====//====//==== Define & Macro 
#define         COLOR_WHITE         0xFFFFFF96
#define         COLOR_BLUE          0x3700FFFF
#define         COLOR_RED           0xFF0000FF
#define         COLOR_PINK          0xF797CEFF
#define         COLOR_PURPLE        0xF20CD0FF
#define         COLOR_COLORGREEN    0x00FFAAFF
#define         COLOR_LIGHTGREEN    0x00FF26FF
#define         COLOR_ORANGE        0xF5BE5FFF
#define         COLOR_BROWN         0x9C761FFF
#define         COLOR_GREEN         0x21DD00FF
#define         COLOR_BLACK         0x000000AA
#define         COLOR_TOMATO        0xFF6347AA
#define         COLOR_SYNTAX        0xAFAFAFFF
#define         COLOR_HAULING       0xC6E2FFFF
#define         COLOR_LIGHTBLUE     0x33CCFFAA


#define         COL_WHITE           "{FFFFFF}"
#define         COL_RED             "{F81414}"
#define         COL_GREEN           "{00FF22}"
#define         COL_LIGHTBLUE       "{00CED1}"
#define         RED                 0xF81414AA

#define         COLOR_DEV           0x00FFC7FF
#define         COLOR_ADEV          0x00FFC7FF
#define         COLOR_ADMIN         0x00FFC7FF
#define         COLOR_STAFF         0x00FFC7FF
#define         COLOR_HELPER        0x00FFC7FF
#define         COLOR_PDRM          0x001EFFFF
#define         COLOR_KKM           0xFF00BDFF
#define         COLOR_JPJ           0x0013A1FF
#define         COLOR_YAKUZA        0x393939FF
#define         COLOR_TOMAN         0xFFF369FF
#define         COLOR_GAIJIN        0x7CFC00FF
#define         COLOR_MECHANIC      0x03cafcFF

#define         COL_KKM             "{FF00BD}"
#define         COL_PDRM            "{001EFF}"
#define         COL_JPJ             "{0013A1}"
#define         COL_WHITE           "{FFFFFF}"
#define         COL_Yellow          "{F8FF00}"
#define         COL_LBLUE           "{00C3FF}"
#define         COL_BLUE            "{001AFF}"
#define         COL_PINK            "{FF00BD}"
#define         COL_DBLUE           "{0013A1}"
#define         COL_LGREEN          "{3FFF4C}"
#define         COL_OREN            "{FFA200}"
#define         COL_DC              "{FFFFFF}"
#define         COL_YELLOW          "{F8FF00}"

#define         COLOR_AFK           0xFF0000FF
#define         COLOR_GRAD1         0xB4B5B7FF
#define         COLOR_GRAD2         0xBFC0C2FF
#define         COLOR_FADE1         0xE6E6E6E6
#define         COLOR_FADE2         0xC8C8C8C8
#define         COLOR_FADE3         0xAAAAAAAA
#define         COLOR_FADE4         0x8C8C8C8C
#define         COLOR_FADE5         0x6E6E6E6E
#define         COLOR_GRAD3         0xCBCCCEFF
#define         COLOR_GRAD4         0xD8D8D8FF
#define         COLOR_GRAD5         0xE3E3E3FF
#define         COLOR_GRAD6         0xF0F0F0FF
#define         COLOR_GREY          0xAFAFAFAA
#define         COLOR_LIGHTRED      0xFF6347AA
#define         COLOR_LIGHTBLUE     0x33CCFFAA
#define         COLOR_LIGHTYellow   0xFFFF91FF
#define         COLOR_Yellow2       0xF5DEB3AA
#define         COLOR_FADE5         0x6E6E6E6E
#define         COLOR_DBLUE         0x2641FEAA
#define         COLOR_OOC           0xE0FFFFAA
#define         SAMP_COLOR          0xAAC4E5FF
#define         COLOR_AFK           0xFF0000FF

#define         COLOR_CHAT1         0xFFFFFFFF
#define         COLOR_CHAT2         0xFFFFFFFF
#define         COLOR_CHAT3         0xFFFFFFFF
#define         COLOR_CHAT4         0xCF11F9FF
#define         COLOR_CHAT5         0xCF11F9FF
#define         COLOR_CHAT6         0xCF11F9FF
#define         COLOR_CHAT7         0xCF11F9FF

#define         HAULING 			5555
#define         COLOR_HAULING       0xC6E2FFFF
#define         COLOR_GRAD2         0xBFC0C2FF
#define 		COLOR_YELLOW 		0xFFFF00FF

#define Function%0(%1) forward %0(%1); public %0(%1)
#define IsPlayerAndroid(%0)  GetPVarInt(%0, "NotAndroid") == 0
#define loop(%0,%1,%2)     for(new %0 = %2; %0 < %1; %0++)
#define PRESSED(%0)        (((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define SendMessage(%0,%1) \
	SendClientMessage(%0, COLOR_YELLOW, "{FF0000}[SYSTEM]:{FFFFFF} %1")

#if !defined EPSILON
    #define  EPSILON 0.0001
#endif
#define IsFloatZero%1(%0)   ((EPSILON >= (%0)) && ((-EPSILON) <= (%0)))
#define IsFloatNaN%1(%0)   ((%0) != (%0))
#define IsNullVector2%2(%0,%1) (IsFloatZero(%0) && IsFloatZero(%1))
#define GetVehicleKilometers%1(%0) ((IsValidVehicle(%0)) ? (g_VehicleDistance[%0]) : (0.0))
//====//====//====//====//====//====//====//==== Bcrypt
#if !defined BCRYPT_HASH_LENGTH
	#define BCRYPT_HASH_LENGTH 250
#endif

#if !defined BCRYPT_COST
	#define BCRYPT_COST 12
#endif
//====//====//====//====//====//====//====//==== Define Kordinat
//====//====//====// Keluar Masuk Interior
#define Medic1 1172.7075,-1325.0419,15.4018
#define Medic2 -1772.4752, -2018.7606, 1500.4269
#define Jpj1 1653.8054,-1654.9136,22.5156
#define Jpj2 288.7600,168.2573,1007.1719
#define Ujian1 238.5468,139.0367,1003.0234
#define Ujian2 1319.1522,1249.8101,10.8203

//====//====//====// Lesen
#define Lesen1 1296.4406,1375.5043,10.8639
#define Lesen2 1299.0226,1439.7725,10.8603
#define Lesen3 1342.4734,1446.2644,10.8603
#define Lesen4 1351.3422,1416.5297,10.8603
#define Lesen5 1351.2479,1388.2391,10.8639
#define Lesen6 1351.2273,1341.9398,10.8639

//====//====//====// Spawn TeamDeathMatch
#define TDMCP1 286.6284,184.0076,1007.1794
#define TDMCP2 244.6367,179.4904,1003.0300
#define TDMCP3 246.1132,147.0775,1003.0234
#define TDMCP4 238.6429,194.8374,1008.1719
#define TDMCP5 295.1954,183.2839,1007.1719
#define TDMCP6 226.4512,151.4284,1003.0234

//====//====//====// Pizza Job
#define PIZZACP1 288.745971,169.350997,1007.171875
#define PIZZACP2 288.745971,169.350997,1007.171875
#define PIZZACP3 288.745971,169.350997,1007.171875
#define PIZZACP4 288.745971,169.350997,1007.171875
#define PIZZACP5 288.745971,169.350997,1007.171875
#define PIZZACP6 288.745971,169.350997,1007.171875

//====//====//====// Bas Job
#define BASCP1 288.745971,169.350997,1007.171875
#define BASCP2 288.745971,169.350997,1007.171875
#define BASCP3 288.745971,169.350997,1007.171875
#define BASCP4 288.745971,169.350997,1007.171875
#define BASCP5 288.745971,169.350997,1007.171875
#define BASCP6 288.745971,169.350997,1007.171875
#define BASCP7 288.745971,169.350997,1007.171875
#define BASCP8 288.745971,169.350997,1007.171875
#define BASCP9 288.745971,169.350997,1007.171875
#define BASCP10 288.745971,169.350997,1007.171875
#define BASCP11 288.745971,169.350997,1007.171875
#define BASCP12 288.745971,169.350997,1007.171875
#define BASCP13 288.745971,169.350997,1007.171875
#define BASCP14 288.745971,169.350997,1007.171875
#define BASCP15 288.745971,169.350997,1007.171875
#define BASCP16 288.745971,169.350997,1007.171875
#define BASCP17 288.745971,169.350997,1007.171875
#define BASCP18 288.745971,169.350997,1007.171875
#define BASCP19 288.745971,169.350997,1007.171875
//====//====//====//====//====//====//====//==== Variables
new MySQL:handle;
new tempUCP[64];
//====//====//====//====//====//====//====//==== Max Players
new g_RaceCheck[MAX_PLAYERS char];
new PlayerChar[MAX_PLAYERS][MAX_CHARS][MAX_PLAYER_NAME + 1];
new curveh[MAX_PLAYERS];
new curveh2[MAX_PLAYERS];
new Death[MAX_PLAYERS];
new CooldownMemancing[MAX_PLAYERS];
new afk[MAX_PLAYERS];
new UnlimitedNos[MAX_PLAYERS];
new CbugCount[MAX_PLAYERS];
new Injured[MAX_PLAYERS]; 
new PGear[MAX_PLAYERS][2];
new Float:Pos[MAX_PLAYERS][3];
//====//====//====//====//====//====//====//==== Jobs
new PizzaJob[MAX_PLAYERS];
new BasJob[MAX_PLAYERS];
//====//====//====//====//====//====//====//==== Ujian Memandu
new Motor[MAX_PLAYERS];
new Kereta[MAX_PLAYERS];
//====//====//====//====//====//====//====//==== House System
new Float:Entrance[MAX_HOUSES][3], Float:Extrance[MAX_PLAYERS][3], Inside[MAX_HOUSES][2], Outside[MAX_HOUSES][2], Home[MAX_PLAYERS];
//====//====//====//====//====//====//====//==== Discord Connector
new DCC_Channel:Join_Server;
new DCC_Channel:Leave_Server;
new DCC_Channel:Info_Whitelist;
new DCC_Channel:Kick_Log;
new DCC_Channel:Job_Info;
new DCC_Channel:Death_Info;
new DCC_Channel:Chat_Ingame;

static DCC_Channel:CommandChannel;
//====//====//====//====//====//====//====//==== Text 3D
new Text3D:label[MAX_PLAYERS];
new Text3D:labelvip[MAX_PLAYERS];
//====//====//====//====//====//====//====//==== Textdraw Server
new PlayerText:Speedo[MAX_PLAYERS][11];
//====//====//====//====//====//====//====//==== Sampvoice
new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };
//====//====//====//====//====//====//====//==== Random Spawn
new Float:SpawnHosp[][3] =
{
	{ -1753.8490,-2013.2120,1500.7853 },
    { -1753.8490,-2013.2120,1500.7853 }
};
//====//====//====//====//====//====//====//==== Enums 
enum EVector2
{
    // X
    Float:EVector2_x,

    // Y
    Float:EVector2_y
}

// Vector (3D) structure
enum EVector3
{
    // X
    Float:EVector3_x,

    // Y
    Float:EVector3_y,

    // Z
    Float:EVector3_z
}

enum
{
	DIALOG_REGISTER,
	DIALOG_LOGIN,
	DIALOG_MAKECHAR,
	DIALOG_AGE,
	DIALOG_GENDER,
	DIALOG_CHARLIST,
	DIALOG_NOTREGISTER,
	DIALOG_WHITELIST,
    DIALOG_REMOVE,
    DIALOG_ACMDS,
    DIALOG_RCMDS,
    DIALOG_GAMEMODE,
    DIALOG_VCMDS,
    DIALOG_VATT,
    DIALOG_VFSTYLE,
    DIALOG_VWEAPON,
    DIALOG_HOLDING,
    DIALOG_PISTOL,
    DIALOG_SHOTGUN,
    DIALOG_SMG,
    DIALOG_RIFLE,
    DIALOG_SPECIAL,
    DIALOG_TELEPORT,
    BELIJORAN,
	THREAD_LOGIN,
	DIALOG_LESEN,
    DIALOG_VEHICLE,
};

enum e_player_data
{
	//UCP
	pID,
	pUCP[22],
	//Player Data
	pName[MAX_PLAYER_NAME],
	pAdmin,
	pVip,
	pScore,
	pSkin,
	pAge,
	pGender,
	pMoney,
	//Lesen
	pLesenM,
	pLesenK,
	//Role
	pPolice,
	pMedic,
	pTailong,
	pMafia,
	//Last Spawn
	Float:pPos[3],
	pWorld,
	pInterior,
	bool:pSpawned,
	pChar,
	Float:pHealth,
	//Mancing
    pJoran,
    pBuntal,
    pKeli,
    pJerung,
    pKerapu,
};

new PlayerData[MAX_PLAYERS][e_player_data];

enum hInfo 
{
    Target,
    Owner[24],
    Price,
    Pickup,
    Text3D:Label,
    Mapicon
}
new HouseInfo[MAX_HOUSES][hInfo];

enum KeretaSpawn
{
	Vehicles
};
new pemain[MAX_PLAYERS][KeretaSpawn];

enum vehicle_data
{
	vOwner[MAX_PLAYER_NAME],
	vModel,
	vPrice,
    vMods[30],
    vFuel,
	Float:vPosx,
	Float:vPosy,
	Float:vPosz,
	Float:vAngle,
	Float:vHealth,
	vPlate[24],
	vPaintjob,
	vLocked,
	bool:vOwned
}
new VehicleInfo[MAX_VEHICLES][vehicle_data];

//====//====//====//====//====//====//====//====// Float //====//====//====//====//====//====//====//====//
Float:GetPlayerSpeed(playerid)
{
    new
        Float:x,
        Float:y,
        Float:z;
    if(!IsPlayerInAnyVehicle(playerid))
    {
        if(GetPlayerVelocity(playerid, x, y, z))
        {
            return floatsqroot((x * x) + (y * y) + (z * z)) * 181.5;
        }
    }
    return 0.0;
}

Float:GetVehicleSpeed(vehicleid)
{
    new
        Float:x,
        Float:y,
        Float:z;
    if(GetVehicleVelocity(vehicleid, x, y, z))
    {
        return floatsqroot((x * x) + (y * y) + (z * z)) * 181.5;
    }
    if(GetVehicleVelocity(vehicleid, x, y, z))
    {
        return floatsqroot((x * x) + (y * y) + (z * z)) * 181.5;
    }

    return 0.0;
}

Float:GetPlayerAnyVelocityMagnitude(playerid)
{
    new Float:ret = 0.0;
    if (IsPlayerConnected(playerid))
    {
        new v[EVector3];
        if (IsPlayerInAnyVehicle(playerid))
        {
            GetVehicleVelocity(GetPlayerVehicleID(playerid), v[EVector3_x], v[EVector3_y], v[EVector3_z]);
        }
        else
        {
            GetPlayerVelocity(playerid, v[EVector3_x], v[EVector3_y], v[EVector3_z]);
        }
        ret = floatsqroot((v[EVector3_x] * v[EVector3_x]) + (v[EVector3_y] * v[EVector3_y]) + (v[EVector3_z] + v[EVector3_z]));
    }
    return ret;
}

//====//====//====//====//====//====//====//====// Save & Load Player Data //====//====//====//====//====//====//====//====//
stock SaveData(playerid)
{
	new query[1012];
	GetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
	GetPlayerPos(playerid, PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2]);

	mysql_format(handle,query,sizeof(query),"UPDATE `characters` SET `P_POSX` = '%.4f', `P_POSY` = '%.4f', `P_POSZ` = '%.4f', `P_ADMIN` = '%d', `P_VIP` = '%d', `P_MONEY` = '%d', `P_SCORE` = '%d', `P_HEALTH` = '%.4f', `P_WORLD` = '%d', `P_INTERIOR` = '%d', `P_AGE` = '%d', `P_GENDER` = '%d', `P_SKIN` = '%d', `P_POLICE` = '%d', `P_MEDIC` = '%d', `P_MAFIA` = '%d', `P_TAILONG` = '%d', `P_LESENM` = '%d', `P_LESENK` = '%d' WHERE `characters`.`P_ID`= '%d'",
		PlayerData[playerid][pPos][0],
		PlayerData[playerid][pPos][1],
		PlayerData[playerid][pPos][2],
		PlayerData[playerid][pAdmin],
		PlayerData[playerid][pVip],
		GetPlayerMoney(playerid),
		GetPlayerScore(playerid),
		PlayerData[playerid][pHealth],
		GetPlayerVirtualWorld(playerid),
		GetPlayerInterior(playerid),
		PlayerData[playerid][pAge],
		PlayerData[playerid][pGender],
		PlayerData[playerid][pSkin],
		PlayerData[playerid][pPolice],
		PlayerData[playerid][pMedic],
		PlayerData[playerid][pMafia],
		PlayerData[playerid][pTailong],
		PlayerData[playerid][pLesenM],
		PlayerData[playerid][pLesenK],
		PlayerData[playerid][pID]
	);
	mysql_pquery(handle, query);
	return 1;
}

Function LoadCharacterData(playerid)
{
	//cache_get_value_name(0, "UCP", PlayerData[playerid][pUCP]);
	cache_get_value_name_int(0, "P_ID", PlayerData[playerid][pID]);
	cache_get_value_name(0, "P_NAME", PlayerData[playerid][pName]);
	cache_get_value_name_int(0, "P_ADMIN", PlayerData[playerid][pAdmin]);
	cache_get_value_name_int(0, "P_VIP", PlayerData[playerid][pVip]);
	cache_get_value_name_int(0, "P_MONEY", PlayerData[playerid][pMoney]);
	cache_get_value_name_int(0, "P_SCORE", PlayerData[playerid][pScore]);
	cache_get_value_name_float(0, "P_POSX", PlayerData[playerid][pPos][0]);
	cache_get_value_name_float(0, "P_POSY", PlayerData[playerid][pPos][1]);
	cache_get_value_name_float(0, "P_POSZ", PlayerData[playerid][pPos][2]);
	cache_get_value_name_float(0, "P_HEALTH", PlayerData[playerid][pHealth]);
	cache_get_value_name_int(0, "P_INTERIOR", PlayerData[playerid][pInterior]);
	cache_get_value_name_int(0, "P_WORLD", PlayerData[playerid][pWorld]);
	cache_get_value_name_int(0, "P_AGE", PlayerData[playerid][pAge]);
	cache_get_value_name_int(0, "P_GENDER", PlayerData[playerid][pGender]);
	cache_get_value_name_int(0, "P_SKIN", PlayerData[playerid][pSkin]);
	cache_get_value_name_int(0, "P_POLICE", PlayerData[playerid][pPolice]);
	cache_get_value_name_int(0, "P_MEDIC", PlayerData[playerid][pMedic]);
	cache_get_value_name_int(0, "P_MAFIA", PlayerData[playerid][pMafia]);
	cache_get_value_name_int(0, "P_TAILONG", PlayerData[playerid][pTailong]);
	cache_get_value_name_int(0, "P_LESENM", PlayerData[playerid][pLesenM]);
	cache_get_value_name_int(0, "P_LESENK", PlayerData[playerid][pLesenK]);

    SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], PlayerData[playerid][pPos][0], PlayerData[playerid][pPos][1], PlayerData[playerid][pPos][2], 0.0, 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);

    SendMessage(playerid, "Database Character Anda Telah Berjaya Di Load!");
    return 1;
}
//====//====//====//====//====//====//====//====// Stock //====//====//====//====//====//====//====//====//
stock SQL_AttemptLogin(playerid, const password[])
{
    new query[256], buffer[256];

    WP_Hash(buffer, sizeof(buffer), password);

    format(query,sizeof(query),"SELECT * FROM `playerucp` WHERE `Password` = '%s'", buffer);
    mysql_tquery(handle,query,"OnQueryFinished","dd",playerid, THREAD_LOGIN);
}

stock CreateRp(playerid,text[])
{
    new string[300];
    format(string,sizeof(string),"* %s %s",GetRPName(playerid),text);
    ProxDetector(30.0, playerid, string, COLOR_CHAT1,COLOR_CHAT2,COLOR_CHAT3,COLOR_CHAT4,COLOR_CHAT5);
    return 1;
}

stock SendNearbyMessage(playerid, Float:radius, color, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args >= 17){
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4){
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player){
			if (IsPlayerNearPlayer(i, playerid, radius)){
  				SendClientMessage(i, color, string);
			}
		}
		return 1;
	}
	foreach (new i : Player){
		if (IsPlayerNearPlayer(i, playerid, radius)){
			SendClientMessage(i, color, str);
		}
	}
	return 1;
}

stock GivePlayerScore(playerid, amount)
{
    PlayerData[playerid][pScore] += amount;
    SetPlayerScore(playerid, PlayerData[playerid][pScore]);
}

stock KickWithMessage(playerid, color, message[])
{
    SendClientMessage(playerid, color, message);
    SetTimerEx("KickPublic", 1000, 0, "d", playerid);
}

stock KickAntiChitChat(playerid, sebab[])
{
    new string[248];
    format(string,sizeof(string),"{FCE21F}[BOT]: {FFFFFF}%s Telah Di Kick Dari Server Secara Automatik. {ff0000}(Sebab:%s)", GetRPName(playerid), sebab);
    SendClientMessageToAll(-1, string);
    format(string, sizeof string, " :bar_chart: *[SERVER LOG]* \n **%s Telah Dikick Dari Server Secara Automatik. (Sebab:%s)** ", GetRPName(playerid), sebab);
    DCC_SendChannelMessage(Kick_Log, string);
	SaveData(playerid);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
}

stock GetRPName(playerid)
{
    new name[24];
    GetPlayerName(playerid, name, sizeof(name));
    str_replace(name, '_', ' '); 
    return name;
}

stock SendAdminMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerData[i][pAdmin] > 0)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock str_replace(string[], find, replace)
{
    for(new i=0; string[i]; i++) { if(string[i] == find) { string[i] = replace; } }
}

stock IsRoleplayName(player[])
{
    for(new n = 0; n < strlen(player); n++)
    {
        if (player[n] == '_' && player[n+1] >= 'A' && player[n+1] <= 'Z') return 1;
        if (player[n] == ']' || player[n] == '[') return 0;
	}
    return 0;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	static
		Float:fX,
		Float:fY,
		Float:fZ;

	GetPlayerPos(targetid, fX, fY, fZ);

	return (GetPlayerInterior(playerid) == GetPlayerInterior(targetid) && GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(targetid)) && IsPlayerInRangeOfPoint(playerid, radius, fX, fY, fZ);
}

stock SendNearbyGametext(playerid, Float:radius, string, const str[], {Float,_}:...)
{
	static
	    args,
	    start,
	    end,
	    string[144]
	;
	#emit LOAD.S.pri 8
	#emit STOR.pri args

	if (args > 16)
	{
		#emit ADDR.pri str
		#emit STOR.pri start

	    for (end = start + (args - 16); end > start; end -= 4)
		{
	        #emit LREF.pri end
	        #emit PUSH.pri
		}
		#emit PUSH.S str
		#emit PUSH.C 144
		#emit PUSH.C string

		#emit LOAD.S.pri 8
		#emit CONST.alt 4
		#emit SUB
		#emit PUSH.pri

		#emit SYSREQ.C format
		#emit LCTRL 5
		#emit SCTRL 4

        foreach (new i : Player)
		{
			if (IsPlayerNearPlayer(i, playerid, radius) && PlayerData[i][pSpawned])
			{
  				GameTextForPlayer(i, string, 5000, 5);
			}
		}
		return 1;
	}
	foreach (new i : Player)
	{
		if (IsPlayerNearPlayer(i, playerid, radius) && PlayerData[i][pSpawned])
		{
			GameTextForPlayer(i, string, 5000, 5);
		}
	}
	return 1;
}
//====//====//====//====//====//====//====//====// Forward //====//====//====//====//====//====//====//====// 
GetVehicleWithinDistance( playerid, Float:x1, Float:y1, Float:z1, Float:dist, &vehic)
{
	for(new i = 1; i < MAX_VEHICLES; i++){
		if(GetVehicleModel(i) > 0){
			if(GetPlayerVehicleID(playerid) != i ){
	        	new Float:x, Float:y, Float:z;
	        	new Float:x2, Float:y2, Float:z2;
				GetVehiclePos(i, x, y, z);
				x2 = x1 - x; y2 = y1 - y; z2 = z1 - z;
				new Float:iDist = (x2*x2+y2*y2+z2*z2);
				printf("Vehicle %d is %f", i, iDist);

				if( iDist < dist){
					vehic = i;
				}
			}
		}
	}
}

/*
forward ModCar(playerid);
public ModCar(playerid) 
{ 	switch(pmodelid[playerid]) 
    {
        case 562,565,559,561,560,575,534,567,536,535,576,411,579,602,496,518,527,589,597,419,
		533,526,474,545,517,410,600,436,580,439,549,491,445,604,507,585,587,466,492,546,551,516,
		426, 547, 405, 409, 550, 566, 540, 421,	529,431,438,437,420,525,552,416,433,427,490,528,
		407,544,470,598,596,599,601,428,499,609,524,578,486,406,573,455,588,403,514,423,
		414,443,515,456,422,482,530,418,572,413,440,543,583,478,554,402,542,603,475,568,504,457,
        483,508,429,541,415,480,434,506,451,555,477,400,404,489,479,442,458,467,558,444: 
        {
		    TogglePlayerControllable(playerid,0);
 			return SendClientMessage(playerid, COLOR_WHITE, "{FFFF00}[INFO]{01B3B6} Pilih Item Dan Tekan SPACEBAR.");
		}
		default: return SendClientMessage(playerid,COLOR_RED,"{FF0000}[WARNING]{FFFFFF} Anda Tidak Dibenarkan Tune Kereta Ini");
	}
	return 1;
}*/

forward PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z);
public PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
	{
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		tempposx = (oldposx -x);
		tempposy = (oldposy -y);
		tempposz = (oldposz -z);
		if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

forward CreateVehicleEx(playerid, modelid, color_1, color_2);
public CreateVehicleEx(playerid, modelid, color_1, color_2)
{
	new Float:x, Float:y, Float:z, Float:angle;
	if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, 0xFF0000FF, "Maaf, anda tidak boleh spawn kenderaan ketika dalam kereta yang lain!");
	GetPlayerPos(playerid, x, y, z);
	GetPlayerFacingAngle(playerid, angle);
	DestroyVehicle(pemain[playerid][Vehicles]);
	pemain[playerid][Vehicles] = CreateVehicle(modelid, x, y, z + 0.1, angle, color_1, color_2, -1);
	SetVehicleVirtualWorld(pemain[playerid][Vehicles], GetPlayerVirtualWorld(playerid));
	LinkVehicleToInterior(pemain[playerid][Vehicles], GetPlayerInterior(playerid));
	PutPlayerInVehicle(playerid, pemain[playerid][Vehicles], 0);
	return 1;
}

forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
public ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
{
    if(IsPlayerConnected(playerid))
    {
        new Float:posx, Float:posy, Float:posz;
        new Float:oldposx, Float:oldposy, Float:oldposz;
        new Float:tempposx, Float:tempposy, Float:tempposz;
        GetPlayerPos(playerid, oldposx, oldposy, oldposz);
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i) && (GetPlayerVirtualWorld(playerid) == GetPlayerVirtualWorld(i)))
            {
                {
                    GetPlayerPos(i, posx, posy, posz);
                    tempposx = (oldposx -posx);
                    tempposy = (oldposy -posy);
                    tempposz = (oldposz -posz);
                    if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16))) {SendClientMessage(i, col1, string);}
                    else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8))) {SendClientMessage(i, col2, string);}
                    else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4))) {SendClientMessage(i, col3, string);}
                    else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2))) {SendClientMessage(i, col4, string);}
                    else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) {SendClientMessage(i, col5, string);}
                }
            }
        }
    }
    return 0;
}

forward Unfreeze(playerid);
public Unfreeze(playerid)
{
    TogglePlayerControllable(playerid, true);
}


forward KickPublic(playerid);
public KickPublic(playerid) 
{
	Kick(playerid);  
}

forward Delay_Kick(playerid);
public Delay_Kick(playerid) 
{
    Kick(playerid);  

}

forward Delay_Ban(playerid);
public Delay_Ban(playerid) 
{
    Ban(playerid);  
}

forward CooldownRace(playerid);
public CooldownRace(playerid) 
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerInRangeOfPoint(i, 10, x, y, z))
        {
            GameTextForPlayer(i, "```3```", 3000, 5);
            SetTimer("Race1", 1000, false);
            PlayerPlaySound(i,1150,0.0,0.0,0.0);
        }
    }
    return 1;
}

Function Race1(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i = 0; i < MAX_PLAYERS; i++)
    {        
        if(IsPlayerInRangeOfPoint(i, 10, x, y, z))
        {
            GameTextForPlayer(i, "```2```", 3000, 5);
            SetTimer("Race2", 1000, false);
            PlayerPlaySound(i,1150,0.0,0.0,0.0);
        }
    }
    return 1;
}

forward Race2(playerid);
public Race2(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i = 0; i < MAX_PLAYERS; i++)
    {        
        if(IsPlayerInRangeOfPoint(i, 10, x, y, z))
        {
            GameTextForPlayer(i, "```1```", 3000, 5);
            SetTimer("Race3", 1000, false);
            PlayerPlaySound(i,1150,0.0,0.0,0.0);
        }
    }
    return 1;
}

forward Race3(playerid);
public Race3(playerid)
{
    new Float:x, Float:y, Float:z;
    GetPlayerPos(playerid, x, y, z);
    for(new i = 0; i < MAX_PLAYERS; i++)
    {        
        if(IsPlayerInRangeOfPoint(i, 10, x, y, z))
        {
            GameTextForPlayer(i, "```GO!```", 3000, 5);
            PlayerPlaySound(i,1150,0.0,0.0,0.0);
        }
    }
    return 1;
}

forward IsVehicleDrivingBackwards(vehicleid);
public IsVehicleDrivingBackwards(vehicleid)
{
    new ret = false;
    if (IsValidVehicle(vehicleid))
    {
        new v1[EVector3], v2[EVector2], v3[EVector2], Float:rot;
        GetVehicleVelocity(vehicleid, v1[EVector3_x], v1[EVector3_y], v1[EVector3_z]);
        NormalizeVector2(v1[EVector3_x], v1[EVector3_y], v1[EVector3_x], v1[EVector3_y]);
        GetVehicleZAngle(vehicleid, rot);
        RotationToForwardVector(rot, v2[EVector2_x], v2[EVector2_y]);
        v3[EVector2_x] = v1[EVector3_x] + v2[EVector2_x];
        v3[EVector2_y] = v1[EVector3_y] + v2[EVector2_y];
        ret = (((v3[EVector2_x] * v3[EVector2_x]) + (v3[EVector2_y] * v3[EVector2_y])) < 2.0);
    }
    return ret;
}

Float:Wrap(Float:x, Float:min, Float:max)
{
    new
        Float:ret = x,
        Float:delta = max - min;
    if (delta > 0.0)
    {
        while (ret < min)
        {
            ret += delta;
        }
        while (ret > max)
        {
            ret -= delta;
        }
    }
    else if (delta <= 0.0)
    {
        ret = min;
    }
    return x;
}

forward RotationToForwardVector(Float:angle, &Float:x, &Float:y);
public RotationToForwardVector(Float:angle, &Float:x, &Float:y)
{
    // GTA rotation to radians
    //new Float:phi = ((360.0 - Wrap(angle, 0.0, 360.0)) * 3.14159265) / 180.0;
    new Float:phi = (Wrap(angle, 0.0, 360.0) * 3.14159265) / 180.0;
    x = floatcos(phi) - floatsin(phi);
    y = floatsin(phi) + floatcos(phi);
}


forward NormalizeVector2(Float:x, Float:y, &Float:resultX, &Float:resultY);
public NormalizeVector2(Float:x, Float:y, &Float:resultX, &Float:resultY)
{
    if (IsNullVector2(x, y))
    {
        resultX = 0.0;
        resultY = 0.0;
    }
    else
    {
        new Float:mag = floatsqroot((x * x) + (y * y));
        resultX = x / mag;
        resultY = y / mag;
    }
}
/*
forward ShowSpeedometer(playerid);
public ShowSpeedometer(playerid)
{
    for (new i; i < 11; i++)
    {
        PlayerTextDrawShow(playerid, Speedo[playerid][i]);
    }
}

forward HideSpeedometer(playerid);
public HideSpeedometer(playerid)
{
    for (new i; i < 11; i++)
    {
        PlayerTextDrawHide(playerid, Speedo[playerid][i]);
    }
}
*/
forward UnFreezeJob(playerid);
public UnFreezeJob(playerid)
{
	TogglePlayerControllable(playerid,true);
}

forward ResetVariables(playerid);
public ResetVariables(playerid)
{
    //Players
	PlayerData[playerid][pSpawned] = false;
    PizzaJob[playerid] = 0;
	BasJob[playerid] = 0;
	Death[playerid] = 0;
    afk[playerid] = 0;
	Injured[playerid] = 0;
	CbugCount[playerid] = 0;
	//Vehicles
    pemain[playerid][Vehicles] = 0;
    curveh[playerid] = 0;
    curveh2[playerid] = 0;
    //House System
    Extrance[playerid][0] = 0;
    Extrance[playerid][1] = 0;
    Extrance[playerid][2] = 0;
    Home[playerid] = 0;
}

//====//====//====//====//====//====//====//====// Mysql //====//====//====//====//====//====//====//====// 
Database_Connect()
{
	handle = mysql_connect(DATABASE_ADDRESS,DATABASE_USERNAME,DATABASE_PASSWORD,DATABASE_NAME);

	if(mysql_errno(handle) != 0){
	    print("[MySQL] - Connection Failed!");
	}
	else{
		print("[MySQL] - Connection Estabilished!");
	}
}

stock CheckAccount(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT * FROM `playerucp` WHERE `UCP` = '%s' LIMIT 1;", GetRPName(playerid));
	mysql_tquery(handle, query, "Checkplayerucp", "d", playerid);
	return 1;
}

stock CheckWhitelist(playerid)
{
	new query[256];
	format(query, sizeof(query), "SELECT * FROM `whitelist` WHERE `W_NAME` = '%s' LIMIT 1;", GetRPName(playerid));
	mysql_tquery(handle, query, "CheckPlayerWhitelist", "d", playerid);
	return 1;
}

Function PlayerCheck(playerid, rcc)
{
	if(rcc != g_RaceCheck{playerid})
	    return Kick(playerid);
	    
	CheckAccount(playerid);
	return true;
}

Function CheckPlayerWhitelist(playerid)
{
	new rows = cache_num_rows();

	if (rows)
	{
	    SetTimerEx("PlayerCheck", 1000, false, "ii", playerid, g_RaceCheck{playerid});
	}
	else
	{
	    ShowPlayerDialog(playerid,DIALOG_NOTREGISTER,DIALOG_STYLE_MSGBOX, "{55ff00}Whitelist Rusuh", "{ffffff}Akaun Ini Belum Di Whitelist, Sila Rujuk Di Discord Rusuh Roleplay https://discord.gg/VRUxs72AgA\n\n\n\n", "Terima", "Tolak");
        KickWithMessage(playerid,0xff0000FF, "[RUSUH INFO]: AKAUN INI BELUM DI WHITELIST, SILA WHITELIST DI DISCORD TERLEBIH DAHULU! ");
	}
	return 1;
}

Function Checkplayerucp(playerid)
{
	new rows = cache_num_rows();
	new str[256];
	//new Ban[MAX_PLAYERS];

	//cache_get_value_name_int(0, "Ban", Ban[playerid]);
	//
	//if(Ban[playerid] == 1) return Kick(playerid);
	//
	if (rows)
	{
	    cache_get_value_name(0, "UCP", tempUCP[playerid]);
	    format(str, sizeof(str), "Selamat Kembali Server Rusuh Roleplay!\n\nYour UCP: %s\nSila Masukkan Kata Laluan Anda:", GetRPName(playerid));
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "UCP - Login", str, "Login", "Exit");
	}
	else
	{
		format(str, sizeof(str), "Selamat Datang Ke Server!\n\nYour UCP: %s\nSila Masukkan Kata Laluan Anda Untuk Register:", GetRPName(playerid));
	    ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "UCP - Register", str, "Rgister", "Exit");
	}
	return 1;
}

stock SetupPlayerData(playerid)
{
	PlayerData[playerid][pMoney] = 50;
    PlayerData[playerid][pAdmin] = 0;
    PlayerData[playerid][pVip] = 0;
    SetSpawnInfo(playerid, 0, PlayerData[playerid][pSkin], 1642.1681, -2333.3689, 13.5469, 0.0, 0, 0, 0, 0, 0, 0);
    SpawnPlayer(playerid);
    return 1;
}

Function OnQueryFinished(extraid, threadid)
{
	new query[256], str[256];
    if (!IsPlayerConnected(extraid))
    return 0;

    static
        rows,
		fields
        ;

    switch(threadid)
    {
		case THREAD_LOGIN:
		{
			cache_get_row_count(rows);
			cache_get_field_count(fields);

			if(!rows)
			{
				SendClientMessage(extraid, -1, "{FF0000}[SYSTEM]: {FFFFFF}Password Anda Salah");
				format(str, sizeof(str), "Selamat Datang Ke Roleplay Server!\n\nYour UCP: %s\nSila Masukkan Kata Laluan Anda Untuk Login:", GetRPName(extraid));
            	ShowPlayerDialog(extraid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "UCP - Login", str, "Login", "Exit");
			}
			else
			{
				format(query, sizeof(query), "SELECT `P_NAME` FROM `characters` WHERE `UCP` = '%s' LIMIT %d;", GetRPName(extraid), MAX_CHARS);
				mysql_tquery(handle, query, "LoadCharacter", "d", extraid);
			}
		}
    }
    return 1;
}

Function HashPlayerPassword(playerid, hashid)
{
	new
		query[256],
		hash[BCRYPT_HASH_LENGTH];

    bcrypt_get_hash(hash, sizeof(hash));

	GetPlayerName(playerid, tempUCP[playerid], MAX_PLAYER_NAME + 1);

	format(query,sizeof(query),"INSERT INTO `playerucp` (`UCP`, `Password`) VALUES ('%s', '%s')", tempUCP[playerid], hash);
	mysql_tquery(handle, query);

    SendMessage(playerid, "UCP Anda Telah Berjaya Didaftarkan");
    CheckAccount(playerid);
	return 1;
}

ShowCharacterList(playerid)
{
	new name[256], count, sgstr[128];

	for (new i; i < MAX_CHARS; i ++) if(PlayerChar[playerid][i][0] != EOS)
	{
	    format(sgstr, sizeof(sgstr), "%s\n", PlayerChar[playerid][i]);
		strcat(name, sgstr);
		count++;
	}
	if(count < MAX_CHARS)
		strcat(name, "< Create Character >");

	ShowPlayerDialog(playerid, DIALOG_CHARLIST, DIALOG_STYLE_LIST, "Character List", name, "Select", "Quit");
	return 1;
}

Function LoadCharacter(playerid)
{
	for (new i = 0; i < MAX_CHARS; i ++)
	{
		PlayerChar[playerid][i][0] = EOS;
	}
	for (new i = 0; i < cache_num_rows(); i ++)
	{
		cache_get_value_name(i, "P_NAME", PlayerChar[playerid][i]);
	}
  	ShowCharacterList(playerid);
  	return 1;
}

Function OnPlayerPasswordChecked(playerid, bool:success)
{
	new str[256];
    format(str, sizeof(str), "Selamat Kembali Server Rusuh Roleplay!\n\nYour UCP: %s\nSila Masukkan Kata Laluan Anda Untuk Login:", GetRPName(playerid));
    
	if(!success)
        return ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "UCP - Login", str, "Login", "Exit");

	new query[256];
	format(query, sizeof(query), "SELECT `P_NAME` FROM `characters` WHERE `UCP` = '%s' LIMIT %d;", GetRPName(playerid), MAX_CHARS);
	mysql_tquery(handle, query, "LoadCharacter", "d", playerid);
	return 1;
}

Function InsertPlayerName(playerid, name[])
{
	new count = cache_num_rows(), query[145], Cache:execute;
	if(count > 0)
	{
        ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "ERROR: Nama Ini Sudah Digunakan!\nMasukkan Nama Untuk Character Baru Anda\n\nContoh: Muhd_Nazmi, Muhd_Ariff.", "Create", "Back");
	}
	else
	{
		mysql_format(handle,query,sizeof(query),"INSERT INTO `characters` (`P_NAME`,`UCP`) VALUES('%e','%e')",name,GetRPName(playerid));
		execute = mysql_query(handle, query);
		PlayerData[playerid][pID] = cache_insert_id();
	 	cache_delete(execute);
	 	SetPlayerName(playerid, name);
		format(PlayerData[playerid][pName], MAX_PLAYER_NAME, name);
	 	ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Character Age", "Sila Masukkan Umur Anda", "Continue", "Cancel");
	}
	return 1;
}

/* Gamemode Start! */

main()
{
	print("UCP Roleplay Gamemode loaded!");
}

stock LoadHouse()
{
    /* Pickup */
    CreateDynamicPickup(1318, 1, 2282.9744, -1140.2855, 1050.8984, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 2196.8511, -1204.3903, 1049.0234, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 2233.6482, -1115.2621, 1050.8828, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 2218.4036, -1076.2433, 1050.4844, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 2496.0659, -1692.0844, 1014.7422, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 2365.2371, -1135.5989, 1050.8826, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 2317.7810, -1026.7635, 1050.2178, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 2324.41, -1149.54, 1050.71, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 140.28, 1365.92, 1083.85, -1, -1, -1);
    CreateDynamicPickup(1318, 1, 1260.6603, -785.4005, 1091.9063, -1, -1, -1);
    //
    new string[MAX_PLAYERS];
	new query[512];
    new i = OnHouseLoaded();
	mysql_format(handle, query, sizeof(query), "SELECT * FROM `houses` WHERE `H_ID`='%d' LIMIT 1", i);
	mysql_query(handle, query);

	cache_get_value_name_float(0,"H_POSX", Entrance[i][0]);
	cache_get_value_name_float(0,"H_POSY", Entrance[i][1]);
	cache_get_value_name_float(0,"H_POSZ", Entrance[i][2]);
	cache_get_value_name_int(0,"H_INSIDE_ONE", Inside[i][0]);
	cache_get_value_name_int(0,"H_INSIDE_TWO", Inside[i][1]);
	cache_get_value_name_int(0,"H_OUTSIDE_ONE", Outside[i][0]);
	cache_get_value_name_int(0,"H_OUTSIDE_TWO", Outside[i][1]);
	cache_get_value_name_int(0,"H_TARGET",HouseInfo[i][Target]);
	cache_get_value_name_int(0,"H_PRICE",HouseInfo[i][Price]);
    format(HouseInfo[i][Owner], MAX_PLAYER_NAME, "%s", cache_get_value_name_int(0,"H_OWNER",HouseInfo[i][Owner]));
    if(HouseInfo[i][Target] >= 1)
    {
        HouseInfo[i][Pickup] = CreateDynamicPickup(19522, 1, Entrance[i][0], Entrance[i][1], Entrance[i][2], -1, -1, -1, 50.0);
        format(string, sizeof(string), "{FF0000}Rumah Ini Sudah Dimiliki\n{FFFFFF}Owner: {FF0000}%s\n{FFFFFF}Harga: {FF0000}RM%d\n{FFFFFF}Level: {FF0000}%d\n{FFFFFF}No Rumah: {FF0000}%d", HouseInfo[i][Owner], HouseInfo[i][Price], Inside[i][0], i);
        HouseInfo[i][Label] = CreateDynamic3DTextLabel(string, 0xFFFFFFAA, Entrance[i][0], Entrance[i][1], Entrance[i][2], 50.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 10.0);
        HouseInfo[i][Mapicon] = CreateDynamicMapIcon(Entrance[i][0], Entrance[i][1], Entrance[i][2], 32, -1, -1, -1, -1, 100.0);
    } 
    else 
    {
        HouseInfo[i][Pickup] = CreateDynamicPickup(1273, 1, Entrance[i][0], Entrance[i][1], Entrance[i][2], -1, -1, -1, 50.0);
        format(string, sizeof(string), "{3FFF4C}Rumah Untuk Dijual!\n{FFFFFF}Owner: {3FFF4C}None\n{FFFFFF}Harga: {3FFF4C}RM%d\n{FFFFFF}Level:{3FFF4C} %d\n{FFFFFF}No Rumah: {3FFF4C}%d", HouseInfo[i][Price], Inside[i][0], i);
        HouseInfo[i][Label] = CreateDynamic3DTextLabel(string, 0xFFFFFFAA, Entrance[i][0], Entrance[i][1], Entrance[i][2], 50.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 10.0);
        HouseInfo[i][Mapicon] = CreateDynamicMapIcon(Entrance[i][0], Entrance[i][1], Entrance[i][2], 31, -1, -1, -1, -1, 100.0);
    }
    
    return 1;
}

public OnGameModeInit()
{
	SetGameModeText("Rusuh V1");
    SetNameTagDrawDistance(1000);
    AllowInteriorWeapons(1);
    EnableStuntBonusForAll(0);
    DisableInteriorEnterExits();
	
	//====//====//====//====//====//====//====//==== Load Mysql
	Database_Connect();
	LoadHouse();
	//====//====//====//====//====//====//====//==== Render Mapping
    Streamer_TickRate(60);
    Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 10000);
    //====//====//====//====//====//====//====//==== Variables
	Mapping();
    LoadHouse();
	//BotStatus();
    //====//====//====//====//====//====//====//==== Set Timer
    SetTimer("SendRandomMesg", 180000, 1);
    SetTimer("TimerUnban", 60000, 1);
    SetTimer("TimerWeapon", 300000, 1);

	//====//====//====//====//====//====//====//==== Icon Lesen
    AddStaticPickup(1239, 23, 236.0903,166.0293,1003.0300);
    Create3DTextLabel("{ff0000}Lesen Kenderaan!{FFFFFF}\nTekan Button ALT\nUntuk Melihat Senarai Lesen", -1, 236.0903,166.0293,1003.0300, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon PizzaJob
    AddStaticPickup(1582, 23, 2098.2363,-1808.7677,13.5543);
    Create3DTextLabel("{ff0000}Pizzajob!{FFFFFF}\nType /pizzajob\nUntuk Memulakan Job Pizza", -1, 2098.2363,-1808.7677,13.5543, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Basjob
    AddStaticPickup(1239, 23, 1783.8710,-1908.6765,13.0965);
    Create3DTextLabel("{ff0000}BasJob!{FFFFFF}\nType /Basjob\nUntuk Memulakan Job Bas", -1, 1783.8710,-1908.6765,13.0965, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Kedai Memancing
    AddStaticPickup(1239, 23, 375.9610,-2067.8662,7.8359);
    Create3DTextLabel("{ff0000}Kedai Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Melihat Kedai Memancing", -1, 375.9610,-2067.8662,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 1
    AddStaticPickup(1239, 23, 403.9218,-2088.3147,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 403.9218,-2088.3147,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 2
    AddStaticPickup(1239, 23, 398.6933,-2088.2219,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 398.6933,-2088.2219,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 3
    AddStaticPickup(1239, 23,396.2192,-2088.2256,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 396.2192,-2088.2256,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 4
    AddStaticPickup(1239, 23, 391.1601,-2088.3875,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 391.1601,-2088.3875,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 5
    AddStaticPickup(1239, 23, 383.4410,-2088.1296,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 383.4410,-2088.1296,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 6
    AddStaticPickup(1239, 23, 375.0342,-2088.3440,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 375.0342,-2088.3440,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 7
    AddStaticPickup(1239, 23, 369.7630,-2088.1863,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 369.7630,-2088.1863,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 8
    AddStaticPickup(1239, 23, 367.3623,-2088.4199,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 367.3623,-2088.4199,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 9
    AddStaticPickup(1239, 23, 362.1622,-2088.2600,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 362.1622,-2088.2600,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Icon Memancing 10
    AddStaticPickup(1239, 23, 354.5380,-2088.3440,7.8359);
    Create3DTextLabel("{ff0000}Memancing!{FFFFFF}\nTekan Button ALT\nUntuk Mula Memancing", -1, 354.5380,-2088.3440,7.8359, 20.0, 0);

    //====//====//====//====//====//====//====//==== Discord Connector
    Join_Server = DCC_FindChannelById("956351188981411920");       	//Join Info
    Leave_Server = DCC_FindChannelById("956351188981411920");      	//Leave Info
	Info_Whitelist = DCC_FindChannelById("956351188981411920"); 	//Whitelist Info
	CommandChannel = DCC_FindChannelById("956351188981411920");     //Command Channel
    Kick_Log = DCC_FindChannelById("956351188981411920");           //Kick Log
    Job_Info = DCC_FindChannelById("956351188981411920");           //Info Job
	Death_Info = DCC_FindChannelById("956351188981411920");         //Info Death
    Chat_Ingame = DCC_FindChannelById("956351188981411920");     	//Chat Ingame 

    //====//====//====//====//====//====//====//==== Pickup Icon
    //Pickup Keluar
    CreatePickup(19132,1,Medic1);    //Hospital
	CreatePickup(19132,1,Jpj1);		//Jpj
	CreatePickup(19132,1,Ujian1);	//Ujian Lesen
    //Pickup Masuk
    CreatePickup(19132,1,Medic2);  	//Hospital
	CreatePickup(19132,1,Jpj2);		//Jpj
	CreatePickup(19132,1,Ujian2);	//Ujian Lesen
    //====//====//====//====//====//====//====//==== Map Icon
    CreateDynamicMapIcon(2098.2363,-1808.7677,13.5543, 29, -1, -1, -1, -1, 100.0);   //PizzaJob
    CreateDynamicMapIcon(1783.8710,-1908.6765,13.0965, 37, -1, -1, -1, -1, 100.0);   //BasJob

    //=======//=======//=======//=======//=======//=======// Global Textdraw //=======//==============//=======//=======//=======//=======//
	return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerConnect(playerid)
{
	PlayAudioStreamForPlayer(playerid, "http://hybridproject.000webhostapp.com/dia.mp3");
    RemoveBuilding(playerid);
	ResetVariables(playerid);
    CheckWhitelist(playerid);
    //
	g_RaceCheck{playerid} ++;
	SetPlayerPos(playerid, 155.3337, -1776.4384, 14.8978+5.0);
	SetPlayerCameraPos(playerid, 155.3337, -1776.4384, 14.8978);
	SetPlayerCameraLookAt(playerid, 156.2734, -1776.0850, 14.2128);
	InterpolateCameraLookAt(playerid, 156.2734, -1776.0850, 14.2128, 156.2713, -1776.0797, 14.7078, 5000, CAMERA_MOVE);
    //
    if (SvGetVersion(playerid) == SV_NULL)
    {
        SendClientMessage(playerid, -1, "{40a385}[BOT]: {ffffff}Client Anda Tidak Support Voice.");
    }
    // Checking for a microphone
    else if (SvHasMicro(playerid) == SV_FALSE)
    {
        SendClientMessage(playerid, -1, "{40a385}[BOT]: {ffffff}Microphone Anda Tidak Terpasang.");
    }
    // Create a local stream with an audibility distance of 40.0, an unlimited number of listeners
    // and the name 'Local' (the name 'Local' will be displayed in red in the players' speakerlist)
    else if ((lstream[playerid] = SvCreateDLStreamAtPlayer(40.0, SV_INFINITY, playerid, 0xff0000ff, "Local")))
    {
        SvAddKey(playerid, 0x42);
        if(IsPlayerAndroid(playerid))
        {
            SendClientMessage(playerid, -1, "{ffffff}Tekan {40a385}Button {ffffff}Ditepi Untuk Voice Chat.");
        } else {
            SendClientMessage(playerid, -1, "{ffffff}Tekan {40a385}B {ffffff}Untuk Voice Chat.");
        } 
    }
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	SaveData(playerid);
	ResetVariables(playerid);

	new string[256];
    switch(reason)
    {
        case 0: format(string,sizeof(string),"{9203EA}%s {EAD803}Telah Keluar Dari Negara. {00F1FF}(Force Close)",GetRPName(playerid));
        case 1: format(string,sizeof(string),"{9203EA}%s {EAD803}Telah Keluar Dari Negara. {00F1FF}(Gerak Luu)",GetRPName(playerid));
        case 2: format(string,sizeof(string),"{9203EA}%s {EAD803}Telah Keluar Dari Negara. {00F1FF}(Ditendang)",GetRPName(playerid));
    }
    SendClientMessageToAll(-1, string);

    new DCC_Embed:embed = DCC_CreateEmbed("");
    DCC_SetEmbedColor(embed, 0xFF0000);
    DCC_SetEmbedTitle(embed, "INFO LEAVE");
    format(string, sizeof string, "%s Telah Keluar Dari Negara.", GetRPName(playerid));
    DCC_SetEmbedDescription(embed, string); 
    DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
    DCC_SendChannelEmbedMessage(Leave_Server, embed);

    //======DESTROY KENDERAAN PLAYER TIME DISCONNECT
    DestroyVehicle(pemain[playerid][Vehicles]);

    DestroyVehicle(curveh[playerid]);
	DestroyVehicle(curveh2[playerid]);
    //======SAMPVOICE
    // Removing the player's local stream after disconnecting
    if (lstream[playerid])
    {
        SvDeleteStream(lstream[playerid]);
        lstream[playerid] = SV_NULL;
    }
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
    new string[248];
    if(Injured[playerid] == 0) {  
        Injured[playerid] = 1;
        GameTextForPlayer(playerid, "~g~-ARWAH BAIK ORANGNYA", -3000, 1);
		GetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
		if(!killerid) {
			return 1;
		} else {
			new DCC_Embed:embed = DCC_CreateEmbed("");
			DCC_SetEmbedColor(embed, 0xFF0000);
			DCC_SetEmbedTitle(embed, "INFO DEATH");
			format(string, sizeof string, "%s Telah Mati Dibunuh Oleh %s", GetRPName(playerid), GetRPName(killerid));
			DCC_SetEmbedDescription(embed, string); 
			DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
			DCC_SendChannelEmbedMessage(Death_Info, embed);
		}
		return 1;
    }
    if(Injured[playerid] == 1) {  
		Injured[playerid] = 0;
        return 1;
    }
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_REGISTER)
	{
	    if(!response)
	        return Kick(playerid);

		new str[256];
	    format(str, sizeof(str), "Selamat Datang Ke Server!\n\nYour UCP: %s\nERROR: Password Anda Hendaklah Panjang Antara 7-32!\nSila Masukkan Kata Laluan Anda Untuk Register:", GetRPName(playerid));

        if(strlen(inputtext) < 7)
			return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "UCP - Register", str, "Register", "Exit");

        if(strlen(inputtext) > 32)
			return ShowPlayerDialog(playerid, DIALOG_REGISTER, DIALOG_STYLE_PASSWORD, "UCP - Register", str, "Register", "Exit");

        bcrypt_hash(playerid, "HashPlayerPassword", inputtext, BCRYPT_COST);
	}
	if(dialogid == DIALOG_LOGIN)
	{
	    if(!response)
	        return Kick(playerid);
	        
        if(strlen(inputtext) < 1)
        {
			new str[256];
            format(str, sizeof(str), "Selamat Datang Ke Roleplay Server!\n\nYour UCP: %s\nSila Masukkan Kata Laluan Anda Untuk Login:", GetRPName(playerid));
            ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_PASSWORD, "UCP - Login", str, "Login", "Exit");
            return 1;
		}
		new pwQuery[256], hash[BCRYPT_HASH_LENGTH];
		mysql_format(handle, pwQuery, sizeof(pwQuery), "SELECT `Password` FROM `playerucp` WHERE UCP = '%e' LIMIT 1", GetRPName(playerid));
		mysql_query(handle, pwQuery);
		
        cache_get_value_name(0, "Password", hash, sizeof(hash));
        
        bcrypt_verify(playerid, "OnPlayerPasswordChecked", inputtext, hash);

	}
    if(dialogid == DIALOG_CHARLIST)
    {
		if(response)
		{
			if (PlayerChar[playerid][listitem][0] == EOS)
				return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "Sila Masukkan Nama Character\n\nContoh: Muhd_Nazmi, Muhd_Ariff.", "Create", "Exit");

			PlayerData[playerid][pChar] = listitem;
			SetPlayerName(playerid, PlayerChar[playerid][listitem]);

			new cQuery[256];
			mysql_format(handle, cQuery, sizeof(cQuery), "SELECT * FROM `characters` WHERE `P_NAME` = '%s' LIMIT 1;", PlayerChar[playerid][PlayerData[playerid][pChar]]);
			mysql_tquery(handle, cQuery, "LoadCharacterData", "d", playerid);
			
		}
	}
	if(dialogid == DIALOG_MAKECHAR)
	{
	    if(response)
	    {
		    if(strlen(inputtext) < 1 || strlen(inputtext) > 24)
				return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "Masukkan Nama Untuk Character Baru Anda\n\nContoh: Muhd_Nazmi, Muhd_Ariff.", "Create", "Back");

			if(!IsRoleplayName(inputtext))
				return ShowPlayerDialog(playerid, DIALOG_MAKECHAR, DIALOG_STYLE_INPUT, "Create Character", "Sila Masukkan Nama Character Yang Roleplay\n\nContoh: Muhd_Nazmi, Muhd_Ariff.", "Create", "Back");

			new characterQuery[178];
			mysql_format(handle, characterQuery, sizeof(characterQuery), "SELECT * FROM `characters` WHERE `P_NAME` = '%s'", inputtext);
			mysql_tquery(handle, characterQuery, "InsertPlayerName", "ds", playerid, inputtext);

			//new query[512];
			//format(query,sizeof(query),"UPDATE `characters` SET `UCP` = '%s' WHERE `P_NAME`= '%s'", GetRPName(playerid), GetRPName(playerid));
			//mysql_tquery(handle, query);
		}
	}
	if(dialogid == DIALOG_AGE)
	{
		if(response)
		{
			if(strval(inputtext) >= 70)
			    return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Character Age", "ERROR: Umur Anda Tidak Boleh Melebihi 70 Tahun!", "Continue", "Cancel");

			if(strval(inputtext) < 13)
			    return ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Character Age", "ERROR: Umur Anda Tidak Boleh Dibawah 13 Tahun!", "Continue", "Cancel");

			PlayerData[playerid][pAge] = strval(inputtext);
			ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Character Gender", "Male\nFemale", "Continue", "Cancel");
		}
		else
		{
		    ShowPlayerDialog(playerid, DIALOG_AGE, DIALOG_STYLE_INPUT, "Character Age", "Sila Masukkan Umur Anda", "Continue", "Cancel");
		}
	}
	if(dialogid == DIALOG_GENDER)
	{
	    if(!response)
	        return ShowPlayerDialog(playerid, DIALOG_GENDER, DIALOG_STYLE_LIST, "Character Gender", "Male\nFemale", "Continue", "Cancel");

		if(listitem == 0)
		{
			PlayerData[playerid][pGender] = 1;
			PlayerData[playerid][pSkin] = 240;
			PlayerData[playerid][pHealth] = 100.0;
			SetupPlayerData(playerid);
		}
		if(listitem == 1)
		{
			PlayerData[playerid][pGender] = 1;
			PlayerData[playerid][pSkin] = 172;
			PlayerData[playerid][pHealth] = 100.0;
			SetupPlayerData(playerid);
		}
	}
    if(dialogid == 2009)
	{
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, 2011, DIALOG_STYLE_LIST, "Planes", "Shamal\nNevada\nHydra\nStunt Plane\nAndromada\nAt 400\nBeagle\nCrop Duster\nDo-Do\nRustler\nSkimmer", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, 2012, DIALOG_STYLE_LIST, "Helicopters", "Cargobob\nSparrow\nLeviathon\nPolice helicopter\nNews helicopter\nMaverick\nHunter\nRaindance\nSea Sparrow", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 2)
			{
				ShowPlayerDialog(playerid, 2013, DIALOG_STYLE_LIST, "Bikes", "Bike\nBMX\nMountain Bike\nFaggio\nPizza boy\nBF-400\nNRG-500\nPCJ-600\nFCR-900\nCop bike\nFreeway\nWayfarer\nSanchez\nQuad", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 3)
			{
				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 4)
			{
				ShowPlayerDialog(playerid, 2015, DIALOG_STYLE_LIST, "Boats", "Coast guard\nDingy\nSpeeder\nJetmax\nMarquis\nLaunch\nPolice boat\nReefer\nSquallo\nTropic", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 5)
			{
		 		ShowPlayerDialog(playerid, 2057, DIALOG_STYLE_LIST, "RC", "Bandit\nBaron\nRaider\nGoblin\nTiger\nCam", "..::Ok::..", "..::Return::..");
			}
		}
		return 1;
	}
	if(dialogid == 2057)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(441,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(464,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(465,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(501,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(564,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
 			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(594,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{

			ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_LIST, "Vehicles", "{ff0000}Planes\n{00ff00}Helicopters\n{0000ff}Bikes\n{00ffff}Cars\n{ff00ff}Boats\n{00ff00}RC vehicles", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	
	
	if(dialogid == 2012)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(548,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(469,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(417,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(497,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(488,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(487,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
 			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(425,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(563,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(447,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{
			ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_LIST, "Vehicles", "{ff0000}Planes\n{00ff00}Helicopters\n{0000ff}Bikes\n{00ffff}Cars\n{ff00ff}Boats\n{00ff00}RC vehicles", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	
	if(dialogid == 2011)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(519,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1) // M4
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(553,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2) // Smg
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(520,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3) // Camera
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(513,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4) // Molotov
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(592,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5) // Molotov
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(577,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
 			if(listitem == 6) // Molotov
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(511,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7) // Molotov
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(512,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8) // Molotov
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(593,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9) // Molotov
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(476,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10) // Molotov
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(460,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{
			ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_LIST, "Vehicles", "{ff0000}Planes\n{00ff00}Helicopters\n{0000ff}Bikes\n{00ffff}Cars\n{ff00ff}Boats\n{00ff00}RC vehicles", "..::Ok::..", "..::Return::..");
		}
		return 1;
	}
	if(dialogid == 2013)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(509,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(481,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(510,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(462,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(448,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(581,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(522,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(461,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(521,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(523,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(463,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 11)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(586,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 12)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(468,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
 			if(listitem == 13)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(471,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{

			ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_LIST, "Vehicles", "{ff0000}Planes\n{00ff00}Helicopters\n{0000ff}Bikes\n{00ffff}Cars\n{ff00ff}Boats\n{00ff00}RC vehicles", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2014)
	{
		if(response)
		{
			if(listitem == 0)
			{
				ShowPlayerDialog(playerid, 2048, DIALOG_STYLE_LIST, "Convertibles", "Comet(trans.)\nFeltzer(trans.)\nStallion(trans.)\nWindsor(trans.)", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 1)
			{
				ShowPlayerDialog(playerid, 2049, DIALOG_STYLE_LIST, "Industrial", "Benson\nBobcat(trans.)\nBurrito\nBoxville\nBoxburg\nCement Truck\nDFT-30\nFlatbed\nLinerunner\nMule\nNewsvan\nPacker\nPetrol tanker\nPicador(trans.)\nPony\nRoadtrain\nRumpo\nSadler\nSadler-shit\nTopfun\nTractor\nTrashmaster\nUtility Van\nWalton(trans.)\nYankee\nYosemite", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 2)
			{
				ShowPlayerDialog(playerid, 2050, DIALOG_STYLE_LIST, "Lowrides", "Blade(loco.)\nBroadway(loco.)\nRemington(loco.)\nSavanna(loco.)\nSlamvan(loco.)\nTahoma(trans.)\nTornado(loco.)\nVoodoo(loco.)", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 3)
			{
				ShowPlayerDialog(playerid, 2051, DIALOG_STYLE_LIST, "Off road", "Bandito\nInjection(trans.)\nDune\nHuntley(trans.)\nLandstalker(trans.)\nMesa(trans.)\nMonster\nMonster A\nMonster B\nPatriot\nRancher(trans.)\nRancher 2(trans.)\nSandking", "..::Ok::..", "..::Return::..");
			}
		 	if(listitem == 4)
			{
				ShowPlayerDialog(playerid, 2052, DIALOG_STYLE_LIST, "Public Service", "Ambulance\nBarracks\nBus\nCabbie(trans.)\nCouch\nCop Bike\nEnforcer\nRancher\nFBI truck\nFiretruck\nFiretruck 2\nLS Police Car\nLV Police Car\nSF Police Car\nRanger\nRhino\nSWAT\nTaxi(trans.)", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 5)
			{
				new dialogbox[3200];
				strcat(dialogbox,"Admiral(trans.)\nBlooding Banger\nBravura(trans.)\nBuccaneer(trans.)\nCadrona(trans.)\nClover(trans.)\nElegant(trans.)\nElegy(arch.)\nEmperror(trans.)\nEsperanto(trans.)\nFortune(trans.)\nGlendale-Shit\nGlendale(trans.)\nGreenwood(trans.)\nHermes(trans.)\nIntruder(trans.)\nMajestic(trans.)\n");
				strcat(dialogbox,"Manana(trans.)\nMerit(trans.)\nNebula(trans.)\nOceanic(trans.)\nPremier(trans.)\nPrevio(trans.)\nPrimo(trans.)\nSentinel(trans.)\nStafford(trans.)\nSultan(arch.)\nSunrise(trans.)\nTampa(trans.)\nVincent(trans.)\nVirgo(trans.)\nWillard(trans.)\nWashington(trans.)");
				ShowPlayerDialog(playerid, 2053, DIALOG_STYLE_LIST, "Saloons", dialogbox, "..::Ok::..", "..::Return::..");
			}
			if(listitem == 6)
			{
				ShowPlayerDialog(playerid, 2054, DIALOG_STYLE_LIST, "Sport", "Alpha(trans.)\nBanshee(trans.)\nBlista compact(trans.)\nBuffalo(trans.)\nBullet(trans.)\nCheetah(trans.)\nClub(trans.)\nEuros(trans.)\nFlash(arch.)\nHotring 1\nHotring 2\nHotring 3\nInfernus(trans.)\nJester(arch.)\nPhoenix(trans.)\nSabre(trans.)\nSuper GT(trans.)\nTurismo(trans.)\nUranus(arch.)\nZR-350(trans.)", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 7)
			{
				ShowPlayerDialog(playerid, 2055, DIALOG_STYLE_LIST, "Wagons", "Moonbeam(trans.)\nPerenniel(trans.)\nRegina(trans.)\nSolair(trans.)\nStratum(trans.)", "..::Ok::..", "..::Return::..");
			}
			if(listitem == 8)
			{
		 		ShowPlayerDialog(playerid, 2056, DIALOG_STYLE_LIST, "Unique", "Baggage\nCaddy\nCamper\nCombine Harvester\nDozer\nDumper\nForklift\nHotknife\nHustler(trans.)\nHotdog\nJourney\nKart\nMower\nMr.Whoopee\nRomero(trans.)\nSecuricar\nStretch(trans.)\nSweeper\nTowtruck\nTug\nVortex", "..::Ok::..", "..::Return::..");
			}
		}
		else
		{

			ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_LIST, "Vehicles", "{ff0000}Planes\n{00ff00}Helicopters\n{0000ff}Bikes\n{00ffff}Cars\n{ff00ff}Boats\n{00ff00}RC vehicles", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2015)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(472,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(473,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(452,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(493,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(484,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(595,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
 			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(430,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(453,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(446,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(454,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{

			ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_LIST, "Vehicles", "{ff0000}Planes\n{00ff00}Helicopters\n{0000ff}Bikes\n{00ffff}Cars\n{ff00ff}Boats\n{00ff00}RC vehicles", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2048)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(480,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(533,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(439,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(555,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{

				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2049)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(499,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(422,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(482,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(498,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(609,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(524,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(579,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(455,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(403,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(414,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(582,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 11)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(443,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 12)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(514,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 13)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(600,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 14)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(413,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 15)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(515,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 16)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(440,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 17)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(543,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 18)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(605,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 19)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(459,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 20)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(531,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 21)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(408,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 22)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(552,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 23)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(478,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 24)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(456,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 25)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(554,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{

				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2050)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(536,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(575,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(534,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(567,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(535,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(566,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(576,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(412,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{
	
				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2051)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(568,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(424,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(574,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(579,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(400,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(500,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(444,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(556,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(557,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(470,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(489,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 11)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(505,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 12)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(495,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{

				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2052)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(416,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(433,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(431,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(438,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(437,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(523,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(427,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(490,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(528,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(407,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(544,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 11)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(596,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 12)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(598,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 13)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(597,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 14)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(599,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 15)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(432,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 16)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(601,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 17)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(420,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{
	
				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2053)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(445,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(504,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(401,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(518,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(527,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(542,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(507,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(562,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(585,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(419,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(526,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 11)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(604,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 12)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(466,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 13)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(492,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 14)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(474,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 15)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(546,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 16)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(517,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 17)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(410,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 18)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(551,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 19)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(516,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 20)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(467,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 21)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(426,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 22)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(436,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 23)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(547,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 24)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(405,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 25)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(580,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 26)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(560,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 27)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(550,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 28)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(549,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 29)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(540,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 30)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(491,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 31)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(529,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 32)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(421,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{
	
				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2054)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(602,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(429,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(496,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(402,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(541,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(415,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(589,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(587,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(565,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(494,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(502,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 11)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(503,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 12)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(411,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 13)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(559,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 14)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(603,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 15)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(475,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 16)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(506,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 17)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(451,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 18)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(558,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 19)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(477,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{
	
				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2055)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(418,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(404,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(479,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(458,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(561,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{
		
				ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");

		}
		return 1;
	}
	if(dialogid == 2056)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(485,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 1)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(457,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 2)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(483,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 3)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(532,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 4)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(486,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 5)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(406,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 6)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(530,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 7)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(434,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 8)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(545,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 9)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(588,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 10)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(508,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 11)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(571,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 12)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(572,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 13)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(423,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
 			if(listitem == 14)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(442,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 15)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(428,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 16)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(409,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 17)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(574,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 18)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(525,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 19)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(583,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if(listitem == 20)
			{
				if(IsPlayerInAnyVehicle(playerid)) return
    GameTextForPlayer(playerid, "~r~Sila Keluar Dari Kenderaan!", 5000, 5);
				new Float:x,Float:y,Float:z,Float:a, veh;
				GetPlayerPos(playerid,x,y,z);
				GetPlayerFacingAngle(playerid,a);
				veh = CreateVehicle(539,x+1,y+1,z,a,1,1,10000);
				PutPlayerInVehicle(playerid, veh, 0);
			}
			if((CallRemoteFunction("IsVehicleOwned", "d", curveh[playerid]) == 0))
			{
		 	DestroyVehicle(curveh[playerid]);
		 	}
			curveh[playerid] = GetPlayerVehicleID(playerid);
			curveh2[playerid] = GetVehicleModel(curveh[playerid]);
		}
		else
		{		
			ShowPlayerDialog(playerid, 2014, DIALOG_STYLE_LIST, "Cars", "{ff0000}Convertiables\n{00ff00}Industrial\n{0000ff}Lowrides\n{00ffff}Off-Road\n{ff00ff}Public Service\n{ffff00}Saloons\n{ff0000}Sport cars\n{00ff00}Station Wagons\n{0000ff}Unique", "..::Ok::..", "..::Return::..");
		}
		return 1;
	}
	if(dialogid == DIALOG_LESEN)
	{
		if(response)
		{
			if(listitem == 0)
			{
				if(PlayerData[playerid][pLesenM] == 1) return SendClientMessage(playerid, -1, "{FF0000}[ERROR]: {FFFFFF}Anda Sudah Mempunyai Lesen Motor");
				SendClientMessage(playerid, -1, "{F5FC0F}[INFO LESEN]: {FFFFFF}Sila Pergi Ke Tempat Latihan Memandu Untuk Memulakan Latihan");
				SetPlayerCheckpoint(playerid, Lesen1, 5.0);
				Motor[playerid] = 1;
				Kereta[playerid] = 0;
			}
			if(listitem == 1)
			{
				if(PlayerData[playerid][pLesenK] == 1) return SendClientMessage(playerid, -1, "{FF0000}[ERROR]: {FFFFFF}Anda Sudah Mempunyai Lesen Kereta");
				SendClientMessage(playerid, -1, "{F5FC0F}[INFO LESEN]: {FFFFFF}Sila Pergi Ke Tempat Latihan Memandu Untuk Memulakan Latihan");
				SetPlayerCheckpoint(playerid, Lesen1, 5.0);
				Motor[playerid] = 0;
				Kereta[playerid] = 1;
			}
		}
	}
    if(dialogid == DIALOG_VEHICLE)
	{
		if(response)
		{
            new price, Model;
			if(listitem == 0)
			{
				price = 500;
                Model = 1;
			}
			if(listitem == 1)
			{
				price = 500;
                Model = 1;
			}
            if(GetPlayerMoney(playerid) < price) return SendClientMessage(playerid, -1, "Maaf,Duit Anda Tidak Mencukupi");
		}
	}		
	return 1;
}

Function Died(playerid)
{
	SetPlayerHealth(playerid, Float:0);
	return 1;
}

public OnPlayerSpawn(playerid)
{
	new string[512];
	if(PlayerData[playerid][pSpawned] == true)
	{
		new SpawnRandom = random(sizeof(SpawnHosp));
		if(Injured[playerid] == 1)
		{
			SetPlayerPos(playerid, Pos[playerid][0], Pos[playerid][1], Pos[playerid][2]);
			SendClientMessage(playerid, -1, "Anda Telah Injured, Sila Tunggu KKM Atau Tunggu Selama 5 Minit Dan Anda Akan Berada Di Hospital");
			SetPlayerHealth(playerid, Float:20);
			SetPlayerDrunkLevel(playerid, 99999);
			ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0, 0, 1, 1, 1, 0, 1);
			SetTimerEx("Died", 300000, false, "d", playerid);
			return 1;
		}
		if(Injured[playerid] == 0)
		{
			SetPlayerPos(playerid,
			SpawnHosp[SpawnRandom][0],
			SpawnHosp[SpawnRandom][1],
			SpawnHosp[SpawnRandom][2]);
			//
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "i", playerid);
            //
			SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
			GivePlayerMoney(playerid, -100);
			SetPlayerHealth(playerid, Float:120);
			SendClientMessage(playerid, -1,"{e617db}[INFO MEDIC] {FFFFFF}Duit Anda Telah Ditolak Sebanyak RM100 Untuk Membayar Kos Perubatan");
			return 1;
		}
	}
	if(PlayerData[playerid][pSpawned] == false)
	{
	    PlayerData[playerid][pSpawned] = true;
		GivePlayerMoney(playerid, PlayerData[playerid][pMoney]);
	    SetPlayerHealth(playerid, PlayerData[playerid][pHealth]);
	    SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
		SetPlayerScore(playerid , PlayerData[playerid][pScore]);
	    SetPlayerVirtualWorld(playerid, PlayerData[playerid][pWorld]);
		SetPlayerInterior(playerid, PlayerData[playerid][pInterior]);
		if(IsPlayerAndroid(playerid))
		{ 
			if(PlayerData[playerid][pAdmin] >= 4) {
				format(string, sizeof(string), "{ff0000}[DEVELOPER]: {7A03EA}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string); 

				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:DEVELOPER\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 3) {

				format(string, sizeof(string), "{D5EA03}[A.DEVELOPER]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:A.DEVELOPER\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 2) {
		
				format(string, sizeof(string), "{11F9F5}[ADMIN]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:ADMIN\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 1) {
			
				format(string, sizeof(string), "{0ceb29}[HELPER]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:HELPER\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pVip] == 1) { 
				
				format(string, sizeof(string), "{FC5603}[VIP]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);        
                //
                labelvip[playerid] = Create3DTextLabel("[VIP PLAYER]",COLOR_LIGHTBLUE,30.0,40.0,50.0,40.0,0);
                Attach3DTextLabelToPlayer(labelvip[playerid], playerid, 0.0, 0.0, 0.7);
                SetPVarInt(playerid, "VIP", 1);         
				//
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:VIP\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pPolice] >= 1) {
					
				format(string, sizeof(string), "{0314EA}[POLICE]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:POLICE\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pMedic] >= 1) {
					
				format(string, sizeof(string), "{D803EA}[MEDIC]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:MEDIC\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pMafia] >= 1) {
					
				format(string, sizeof(string), "{605D61}[TAILONG]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:TAILONG\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pTailong] >= 1) {
					
				format(string, sizeof(string), "{FC450F}[TAILONG]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:TAILONG\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 0) {
			
				format(string, sizeof(string), "{FFFFFF}[RAKYAT]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Android)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:RAKYAT\nNama:%s\nPlatform:Android\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
		}
		else {
			if(PlayerData[playerid][pAdmin] >= 4) {
			
				format(string, sizeof(string), "{ff0000}[DEVELOPER]: {7A03EA}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string); 

				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:DEVELOPER\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 3) {
		
				format(string, sizeof(string), "{D5EA03}[A.DEVELOPER]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:A.DEVELOPER\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 2) {
		
				format(string, sizeof(string), "{11F9F5}[ADMIN]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:ADMIN\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 1) {

				format(string, sizeof(string), "{0ceb29}[HELPER]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:HELPER\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pVip] == 1) {
					
				format(string, sizeof(string), "{FC5603}[VIP]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);   
                //
                labelvip[playerid] = Create3DTextLabel("[VIP IFR PLAYER]",COLOR_LIGHTBLUE,30.0,40.0,50.0,40.0,0);
                Attach3DTextLabelToPlayer(labelvip[playerid], playerid, 0.0, 0.0, 0.7);
                SetPVarInt(playerid, "VIP", 1);                      
				//
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:VIP\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pPolice] >= 1) {
					
				format(string, sizeof(string), "{0314EA}[POLICE]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:POLICE\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pMedic] >= 1) {
					
				format(string, sizeof(string), "{D803EA}[MEDIC]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:MEDIC\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pMafia] >= 1) {
					
				format(string, sizeof(string), "{605D61}[TAILONG]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:TAILONG\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pTailong] >= 1) {
					
				format(string, sizeof(string), "{FC450F}[TAILONG]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);                 
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:TAILONG\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
			if(PlayerData[playerid][pAdmin] == 0) {
			
				format(string, sizeof(string), "{C1BAC4}[RAKYAT]: {EA030D}%s {E7F911}Telah Mendarat Ke Negara.{05F623}(Laptop/PC)", GetRPName(playerid)); 
				SendClientMessageToAll(-1, string);
				
				new DCC_Embed:embed = DCC_CreateEmbed("");
				DCC_SetEmbedColor(embed, 0xFF0000);
				DCC_SetEmbedTitle(embed, "INFO LOGIN");
				format(string, sizeof string, ":sparkles:RAKYAT\nNama:%s\nPlatform:Laptop/PC\nTelah Mendarat Ke Negara!!... ~ ", GetRPName(playerid));
				DCC_SetEmbedDescription(embed, string); 
				DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
				DCC_SendChannelEmbedMessage(Join_Server, embed);
				return 1;
			}
		}
	}
	return 1;
}

public OnPlayerText(playerid, text[])
{
 	new string[500];
    format(string, sizeof(string), "%s[ID:%d] : %s", GetRPName(playerid), playerid, text);
    ProxDetector(30.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
    format(string, sizeof(string), "%s", text);
    SetPlayerChatBubble(playerid,string,COLOR_WHITE,5.0,5000);
    ApplyAnimation(playerid, "PED", "IDLE_chat", 4.100, 0, 1, 1, 1, 1, 1);
	//
	new DCC_Embed:embed = DCC_CreateEmbed("");
    DCC_SetEmbedColor(embed, 0xFF0000);
    DCC_SetEmbedTitle(embed, ":speaking_head:CHAT INGAME");
    format(string, sizeof string, "%s Berkata:```%s```", GetRPName(playerid), text);
    DCC_SetEmbedDescription(embed, string); 
    DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
    DCC_SendChannelEmbedMessage(Chat_Ingame, embed);
    return 0;
}
/*
public OnVehicleDamageStatusUpdate(vehicleid, playerid)
{
    new panels, doors, lights, tires;	
    GetVehicleDamageStatus(vehicleid, panels, doors, lights, tires);
    if(Health <= 999)
    {
        if(!RepairVehicle(vehicleid))
        {
            if(Health >= 1000)
            {
                if(PlayerData[playerid][pAdmin] == 0)
                {
                    KickAntiChitChat(playerid, "Auto Repair");
                }
            }
        }
    }
    return 1;
}
*/
public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{/*
    if(IsPlayerInRangeOfPoint(playerid, 100, 1133.6458,-2037.1663,69.0078))
    {
        if(PRESSED(KEY_FIRE))
        {
            if(PlayerData[playerid][pAdmin] == 0)
            {
                if(GetPlayerWeapon(playerid) >= 0)
                {
                    ShowPlayerDialog(playerid, 5, DIALOG_STYLE_MSGBOX, "{FF0000}Warning", "{FF0000}Dilarang Menembak Didalam SafeZone", "Okay", "Tutup");
                }
            }
        }
    }
    if(IsPlayerInRangeOfPoint(playerid, 100, 1133.6458,-2037.1663,69.0078))
    {
        if(PRESSED(KEY_FIRE))
        {
            if(PlayerData[playerid][pAdmin] == 0)
            {
                ShowPlayerDialog(playerid, 5, DIALOG_STYLE_MSGBOX, "{FF0000}Warning", "{FF0000}Dilarang Menumbuk Didalam SafeZone", "Okay", "Tutup");
            }
        }
    }*/
    new weapon = GetPlayerWeapon(playerid);
    if((oldkeys & KEY_FIRE) && (newkeys & KEY_CROUCH))
    {
        if(PlayerData[playerid][pAdmin] == 0)
        {
            if(weapon == 24)
			{
               CbugCount[playerid] ++;
            }
        }
    }
    if(PRESSED(KEY_YES))
    { 
        if(!IsPlayerInAnyVehicle(playerid))
        {
            new Float:x, Float:y, Float:z;
            GetPlayerPos(playerid, x, y, z);
            Extrance[playerid][0] = x, Extrance[playerid][1] = y, Extrance[playerid][2] = z;
            for(new i = 0; i < MAX_HOUSES; i++)
            {
                if(Home[playerid] == 0)
                {
                    if(IsPlayerInRangeOfPoint(playerid, 0.5, Entrance[i][0], Entrance[i][1], Entrance[i][2]))
                    {
                        if(HouseInfo[i][Target] == 1)
                        {
                            if(Inside[i][0] == 1)
                            {
                                SetPlayerPos(playerid, 2283.0632, -1136.9760, 1050.8984);
                                SetPlayerFacingAngle(playerid, 358.7963);
                                SetPlayerInterior(playerid, 11);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 2)
                            {
                                SetPlayerPos(playerid, 2193.9001, -1202.4185, 1049.0234);
                                SetPlayerFacingAngle(playerid, 91.9386);
                                SetPlayerInterior(playerid, 6);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 3)
                            {
                                SetPlayerPos(playerid, 2233.6057, -1111.7039, 1050.8828);
                                SetPlayerFacingAngle(playerid, 2.9124);
                                SetPlayerInterior(playerid, 5);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 4)
                            {
                                SetPlayerPos(playerid, 2214.8909, -1076.0967, 1050.4844);
                                SetPlayerFacingAngle(playerid, 88.8910);
                                SetPlayerInterior(playerid, 1);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 5)
                            {
                                SetPlayerPos(playerid, 2495.8035, -1695.0997, 1014.7422);
                                SetPlayerFacingAngle(playerid, 181.9661);
                                SetPlayerInterior(playerid, 3);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 6)
                            {
                                SetPlayerPos(playerid, 2365.2883, -1132.5228, 1050.8750);
                                SetPlayerFacingAngle(playerid, 358.0393);
                                SetPlayerInterior(playerid, 8);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 7)
                            {
                                SetPlayerPos(playerid, 2320.0730, -1023.9533, 1050.2109);
                                SetPlayerFacingAngle(playerid, 358.4915);
                                SetPlayerInterior(playerid, 9);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 8)
                            {
                                SetPlayerPos(playerid, 2324.4490, -1145.2841, 1050.7101);
                                SetPlayerFacingAngle(playerid, 357.5873);
                                SetPlayerInterior(playerid, 12);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 9)
                            {
                                SetPlayerPos(playerid, 140.1788, 1369.1936, 1083.8641);
                                SetPlayerFacingAngle(playerid, 359.2263);
                                SetPlayerInterior(playerid, 5);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                            if(Inside[i][0] == 10)
                            {
                                SetPlayerPos(playerid, 1264.7765, -781.2485, 1091.9063);
                                SetPlayerFacingAngle(playerid, 270.6992);
                                SetPlayerInterior(playerid, 5);
                                SetPlayerVirtualWorld(playerid, Inside[i][1]);
                                Home[playerid] = 1;
                            }
                        }
                    }
                }
            }
        }
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 375.9610,-2067.8662,7.8359))   //BELI JORAN
    {
        new string[248];
        format(string, sizeof(string), "BELI JORAN(RM1000)\nJUAL IKAN BUNTAL(BAKI : %d)\nJUAL IKAN KELI(BAKI : %d)\nJUAL IKAN KERAPU(BAKI : %d)\nJUAL IKAN JERUNG(BAKI : %d)"
        , PlayerData[playerid][pBuntal], PlayerData[playerid][pKeli], PlayerData[playerid][pKerapu], PlayerData[playerid][pJerung]);
        ShowPlayerDialog(playerid, BELIJORAN,  DIALOG_STYLE_LIST, "KEDAI MEMANCING", string, "OK", "TUTUP");
    }
    if(IsPlayerInRangeOfPoint(playerid, 2.0, 403.9218,-2088.3147,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 398.6933,-2088.2219,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 396.2192,-2088.2256,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 391.1601,-2088.3875,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 383.4410,-2088.1296,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 375.0342,-2088.3440,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 369.7630,-2088.1863,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 367.3623,-2088.4199,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 362.1622,-2088.2600,7.8359) ||
    IsPlayerInRangeOfPoint(playerid, 2.0, 354.5380,-2088.3440,7.8359))
    {
        if(PlayerData[playerid][pJoran] == 0) return SendClientMessage(playerid, -1, "{FF0000}[ERROR]{FFFFFF} Anda Tidak Mempunyai Joran");
        if(CooldownMemancing[playerid] == 1) return SendClientMessage(playerid, -1, "{FF0000}[ERROR]{FFFFFF} Sila Tunggu Satu Persatu");
        CreateRp(playerid,"Sedang Memancing.");
        SendClientMessage(playerid, -1, "{ADF432}[MEMANCING]{FFFFFF} Anda Sedang Memancing,Sila Tunggu Sebentar");
        CooldownMemancing[playerid] = 1;
        SetTimerEx("Delay_Mancing", 10000, false, "d", playerid);
    }
    if(PRESSED(KEY_WALK))
    {
        if(!IsPlayerInAnyVehicle(playerid))
        {
            if(Home[playerid] == 1)
            {
                if(IsPlayerInRangeOfPoint(playerid, 0.5, 2282.9744, -1140.2855, 1050.8984) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 2196.8511, -1204.3903, 1049.0234) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 2233.6482, -1115.2621, 1050.8828) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 2218.4036, -1076.2433, 1050.4844) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 2496.0659, -1692.0844, 1014.7422) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 2365.2371, -1135.5989, 1050.8826) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 2317.7810, -1026.7635, 1050.2178) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 2324.41, -1149.54, 1050.71) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 140.28, 1365.92, 1083.85) ||
                IsPlayerInRangeOfPoint(playerid, 0.5, 1260.6603, -785.4005, 1091.9063))
                {
                    Home[playerid] = 0;
                    SetPlayerPos(playerid, Extrance[playerid][0], Extrance[playerid][1], Extrance[playerid][2]);
                    SetPlayerInterior(playerid, 0);
                    SetPlayerVirtualWorld(playerid, 0);
                }
            }
        }
    }
	if(IsPlayerInRangeOfPoint(playerid, 0.5, 236.0903,166.0293,1003.0300))
	{
		ShowPlayerDialog(playerid, DIALOG_LESEN, DIALOG_STYLE_LIST, "Lesen Kenderaan", "Lesen Motor(RM100)\nLesen Kereta(RM200)", "Okay", "Tutup");
	}
    if(PRESSED(KEY_WALK))
    {
        if(IsPlayerInRangeOfPoint(playerid,1,Medic1))		//Masuk Medic
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,Medic2);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,Medic2))		//Keluar Medic
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,Medic1);
        }
		if(IsPlayerInRangeOfPoint(playerid,1,Jpj1))			//Masuk Jpj
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,3);
            SetPlayerPos(playerid,Jpj2);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,Jpj2))			//Keluar Jpj
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,Jpj1);
        }
		if(IsPlayerInRangeOfPoint(playerid,1,Ujian1))			//Masuk Ujian Lesen
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,Ujian2);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,Ujian2))			//Keluar Ujian Lesen
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,3);
            SetPlayerPos(playerid,Ujian1);
        }
    }
	return 1;
}

public OnPlayerUpdate(playerid)
{
    AntiChitChat(playerid);

	if(IsPlayerInRangeOfPoint(playerid, 1.0, Medic1) ||
    IsPlayerInRangeOfPoint(playerid, 1.0, Medic2) ||
	IsPlayerInRangeOfPoint(playerid, 1.0, Jpj1) ||
	IsPlayerInRangeOfPoint(playerid, 1.0, Jpj2) ||
	IsPlayerInRangeOfPoint(playerid, 1.0, Ujian1) ||
	IsPlayerInRangeOfPoint(playerid, 1.0, Ujian2))
    {
        GameTextForPlayer(playerid, "~w~PRESS ALT TO ENTER/EXIT", 3000, 3);
    }
	if(Injured[playerid] == 1)
	{
		ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0, 0, 1, 1, 1, 0, 1);
	}
	new vehicle = GetPlayerVehicleID(playerid);
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
		//new Float:H;
        //GetVehicleHealth(vehicle, H);

		//new VehHealth[24];
        //format(VehHealth, sizeof(VehHealth), "%.1f%", H);
        //PlayerTextDrawSetString(playerid, Speedo[playerid][12], VehHealth);

        new speed[24];
        format(speed, sizeof(speed), "%.0fKM", GetVehicleSpeed(vehicle));
        PlayerTextDrawSetString(playerid, Speedo[playerid][9], speed);

		PlayerTextDrawSetPreviewModel(playerid, Speedo[playerid][3], GetVehicleModel(GetPlayerVehicleID(playerid)));

		PlayerTextDrawSetString(playerid, Speedo[playerid][8], PGear[playerid]);
	}

    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
	{
        new Float:speed = GetPlayerAnyVelocityMagnitude(playerid) * 181.5;
        if (IsFloatNaN(speed))
        {
            speed = 0.0;
        }
        if (IsFloatZero(speed))
        {
            PGear[playerid] = "P";
        }
        else
        {
            if (speed > 0.0)
            {
                if (IsVehicleDrivingBackwards(GetPlayerVehicleID(playerid)))
                {
                    PGear[playerid] = "R";
				}
				if (speed > 0)
				{ 
					PGear[playerid] = "1";
				}
				if (speed > 40)
				{ 
					PGear[playerid] = "2";
				}
				if (speed > 60)
				{ 
					PGear[playerid] = "3";
				}
				if (speed > 80)
				{ 
					PGear[playerid] = "4";
				}
				if (speed > 100)
				{ 
					PGear[playerid] = "5";
				}
				if (speed > 120)
				{ 
					PGear[playerid] = "6";
				}
            }
		}
	}
    if(afk[playerid] == 1) {
        TogglePlayerControllable(playerid, 0);
        label[playerid] = Create3DTextLabel("[AFK]",COLOR_AFK,30.0,40.0,50.0,40.0,0);
        Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.7);
        SetPVarInt(playerid, "afk", 1);
    } else {
		DeletePVar(playerid, "afk");
        Delete3DTextLabel(Text3D:label[playerid]);
	}
	for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 0.5, Entrance[i][0], Entrance[i][1], Entrance[i][2]))
        {
            if(HouseInfo[i][Target] == 1)
            {
                GameTextForPlayer(playerid, "~w~PRESS Y TO ENTER THE HOUSE", 3000, 3);
            }
            else if(HouseInfo[i][Target] == 0)
            {
                GameTextForPlayer(playerid, "~w~USE /BUYHOUSE TO BUY THIS HOUSE", 3000, 3);
            }
        }
    }
    if(IsPlayerInRangeOfPoint(playerid, 0.5, 2282.9744, -1140.2855, 1050.8984) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 2196.8511, -1204.3903, 1049.0234) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 2233.6482, -1115.2621, 1050.8828) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 2218.4036, -1076.2433, 1050.4844) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 2496.0659, -1692.0844, 1014.7422) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 2365.2371, -1135.5989, 1050.8826) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 2317.7810, -1026.7635, 1050.2178) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 2324.41, -1149.54, 1050.71) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 140.28, 1365.92, 1083.85) ||
    IsPlayerInRangeOfPoint(playerid, 0.5, 1260.6603, -785.4005, 1091.9063))
    {
        GameTextForPlayer(playerid, "~w~PRESS ALT TO EXIT THIS HOUSE", 3000, 3);
    }
    return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 462) 
    {
        if(Motor[playerid] == 1) {
            Motor[playerid] = 2;
            SetPlayerCheckpoint(playerid, Lesen2, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Motor[playerid] == 2) {
            Motor[playerid] = 3;
            SetPlayerCheckpoint(playerid, Lesen3, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Motor[playerid] == 3) {
            Motor[playerid] = 4;
            SetPlayerCheckpoint(playerid, Lesen4, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Motor[playerid] == 4) {
            Motor[playerid] = 5;
            SetPlayerCheckpoint(playerid, Lesen5, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
		if(Motor[playerid] == 5) {
            Motor[playerid] = 6;
            SetPlayerCheckpoint(playerid, Lesen6, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Motor[playerid] == 6) {
            Motor[playerid] = 0;
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
			//
			SendClientMessage(playerid, -1, "{F5FC0F}[INFO LESEN]: {FFFFFF}Anda Telah Berjaya Habiskan Latihan Memandu,Sila Parking Kenderaan Ke Tempat Asal");
			SendClientMessage(playerid, -1, "{F5FC0F}[INFO LESEN]: {FFFFFF}Duit Anda Akan Ditolak Sebanyak RM100");
			//
			PlayerData[playerid][pLesenM] = 1;
			GivePlayerMoney(playerid, -100);
            return 1;
        }
		return 1;
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 507) 
    {
        if(Kereta[playerid] == 1) {
            Kereta[playerid] = 2;
            SetPlayerCheckpoint(playerid, Lesen2, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Kereta[playerid] == 2) {
            Kereta[playerid] = 3;
            SetPlayerCheckpoint(playerid, Lesen3, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Kereta[playerid] == 3) {
            Kereta[playerid] = 4;
            SetPlayerCheckpoint(playerid, Lesen4, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Kereta[playerid] == 4) {
            Kereta[playerid] = 5;
            SetPlayerCheckpoint(playerid, Lesen5, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
		if(Kereta[playerid] == 5) {
            Kereta[playerid] = 6;
            SetPlayerCheckpoint(playerid, Lesen6, 5.0);
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(Kereta[playerid] == 6) {
            Kereta[playerid] = 0;
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
			//
			SendClientMessage(playerid, -1, "{F5FC0F}[INFO LESEN]: {FFFFFF}Anda Telah Berjaya Habiskan Latihan Memandu,Sila Parking Kenderaan Ke Tempat Asal");
			SendClientMessage(playerid, -1, "{F5FC0F}[INFO LESEN]: {FFFFFF}Duit Anda Akan Ditolak Sebanyak RM200");
			//
			PlayerData[playerid][pLesenK] = 1;
			GivePlayerMoney(playerid, -200);
            return 1;
        }
		return 1;
	}
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448) 
    {
        if(PizzaJob[playerid] == 1) {
            PizzaJob[playerid] = 2;
            SetPlayerCheckpoint(playerid, 2495.2268,-1689.8212,14.6704, 5.0);// CP KEDUA
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 2) {
            PizzaJob[playerid] = 3;
            SetPlayerCheckpoint(playerid, 2513.4695,-1690.8375,13.7842, 5.0);// CP KETIGA
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 3) {
            PizzaJob[playerid] = 4;
            SetPlayerCheckpoint(playerid, 2518.9995,-1679.1683,14.6456, 5.0);// CP KEEMPAT
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 4) {
            PizzaJob[playerid] = 5;
            SetPlayerCheckpoint(playerid, 2522.9700,-1658.3934,15.4935, 5.0);// CP KELIMA
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 5) {
            PizzaJob[playerid] = 6;
            SetPlayerCheckpoint(playerid, 2512.7275,-1651.2356,13.9693, 5.0);// CP KEENAM
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 6) {
            PizzaJob[playerid] = 7;
            SetPlayerCheckpoint(playerid, 2498.5217,-1645.5410,13.5377, 5.0);// CP KETUJUH
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 7) {
            PizzaJob[playerid] = 8;
            SetPlayerCheckpoint(playerid, 2486.4182,-1646.9719,14.0703, 5.0);// CP KELAPAN
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 8) {
            PizzaJob[playerid] = 9;
            SetPlayerCheckpoint(playerid, 2469.5759,-1648.0026,13.4717, 5.0);// CP KESEMBILAN
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 9) {
            PizzaJob[playerid] = 10;
            SetPlayerCheckpoint(playerid, 2451.9189,-1645.6483,13.4642, 5.0);// CP KESEPULUH
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 10) {
            PizzaJob[playerid] = 11;
            SetPlayerCheckpoint(playerid, 2098.2363,-1808.7677,13.5543, 5.0);// CP KESEBELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(PizzaJob[playerid] == 11) {
            PizzaJob[playerid] = 12;
            GivePlayerMoney(playerid, 1000);
            GameTextForPlayer(playerid, "~g~+RM ~w~1000", 5000, 1);
            SendClientMessage(playerid, COLOR_WHITE, "{FF0000}[SYSTEM]: {FFFFFF}Anda Telah Mendapat Gaji Sebanyak RM1000");
            DestroyVehicle((GetPlayerVehicleID(playerid)));
            SetPlayerSkin(playerid,PlayerData[playerid][pSkin]);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 437) 
    {
        if(BasJob[playerid] == 1) {
            BasJob[playerid] = 2;
            SetPlayerCheckpoint(playerid, BASCP2, 5.0);// CP KEDUA
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 2) {
            BasJob[playerid] = 3;
            SetPlayerCheckpoint(playerid, BASCP3, 5.0);// CP KETIGA
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 3) {
            BasJob[playerid] = 4;
            SetPlayerCheckpoint(playerid, BASCP4, 5.0);// CP KEEMPAT
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 4) {
            BasJob[playerid] = 5;
            SetPlayerCheckpoint(playerid, BASCP5, 5.0);// CP KELIMA
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 5) {
            BasJob[playerid] = 6;
            SetPlayerCheckpoint(playerid, BASCP6, 5.0);// CP KEENAM
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 6) {
            BasJob[playerid] = 7;
            SetPlayerCheckpoint(playerid, BASCP7, 5.0);// CP KETUJUH
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 7) {
            BasJob[playerid] = 8;
            SetPlayerCheckpoint(playerid, BASCP8, 5.0);// CP KELAPAN
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 8) {
            BasJob[playerid] = 9;
            SetPlayerCheckpoint(playerid, BASCP9, 5.0);// CP KESEMBILAN
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 9) {
            BasJob[playerid] = 10;
            SetPlayerCheckpoint(playerid, BASCP10, 5.0);// CP KESEPULUH
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 10) {
            BasJob[playerid] = 11;
            SetPlayerCheckpoint(playerid, BASCP11, 5.0);// CP KESEBELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 11) {
            BasJob[playerid] = 12;
            SetPlayerCheckpoint(playerid, BASCP12, 5.0);// CP DUABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 12) {
            BasJob[playerid] = 13;
            SetPlayerCheckpoint(playerid, BASCP13, 5.0);// CP TIGABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 13) {
            BasJob[playerid] = 14;
            SetPlayerCheckpoint(playerid, BASCP14, 5.0);// CP EMPATBELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 14) {
            BasJob[playerid] = 15;
            SetPlayerCheckpoint(playerid, BASCP15, 5.0);// CP LIMABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 15) {
            BasJob[playerid] = 16;
           	SetPlayerCheckpoint(playerid, BASCP16, 5.0);// CP 16
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 16) {
            BasJob[playerid] = 17;
            SetPlayerCheckpoint(playerid, BASCP17, 5.0);// CP 17
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 17) {
            BasJob[playerid] = 18;
            SetPlayerCheckpoint(playerid, BASCP18, 5.0);// CP 18
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 18) {
            BasJob[playerid] = 19;
            SetPlayerCheckpoint(playerid, BASCP19, 5.0);// CP 19
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 19) {
            BasJob[playerid] = 0;
            GivePlayerMoney(playerid, 2500);
            GameTextForPlayer(playerid, "~g~+RM ~w~2500", 5000, 1);
            SendClientMessage(playerid, COLOR_WHITE, "{FF0000}[SYSTEM]: {FFFFFF}Anda Telah Mendapat Gaji Sebanyak RM2500");
            DestroyVehicle((GetPlayerVehicleID(playerid)));
            SetPlayerSkin(playerid,PlayerData[playerid][pSkin]);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
	return 1;
}

public DCC_OnMessageCreate(DCC_Message:message)
{
	new query[1021];
	//new DCC_Channel:channel;
	DCC_GetMessageChannel(message, CommandChannel);
	//if(channel != PanelServer) return 1;

	new DCC_User:author;
	DCC_GetMessageAuthor(message, author);
	//
	new bool:isBot;
	DCC_IsUserBot(author, isBot);
	if(isBot) { return 1; }
	//
	new str[900];
    new command[32], params[128];
	//
    DCC_GetMessageContent(message, str);
	//
    sscanf(str, "s[32]s[128]", command, params);
    //====//====//====//====//====//====//====//====//====//====//====//====
    //====//====//====//====//====//==== nak buat cmd sambung bawah ni je
    if(strcmp(command, "/", true) == 0)
    {
        DCC_SendChannelMessage(CommandChannel, "");
        return 1;
    }
    if(strcmp(command, "/wl", true) == 0)
    {
        new name[128];
        if(sscanf(params, "s[128]",name)) return DCC_SendChannelMessage(CommandChannel,"ERROR: Format Whitelist**`/wl [NAMA]`**");
        //
        mysql_format(handle, query, sizeof(query), "SELECT * FROM `whitelist` WHERE `W_NAME`='%s' LIMIT 1", name);
        mysql_tquery(handle, query, "OnWhitelistCreated", "s", name);
	}
	if(strcmp(command, "/ban", true) == 0)
    {
        new name[128];
        if(sscanf(params, "s[128]",name)) return DCC_SendChannelMessage(CommandChannel,"ERROR: Format Ban**`/Ban [NAMA]`**");
        //
        mysql_format(handle, query, sizeof(query), "SELECT * FROM `playerucp` WHERE `UCP`='%s' LIMIT 1", name);
        mysql_tquery(handle, query, "OnUCPBan", "s", name);
	}
	if(strcmp(command, "/unban", true) == 0)
    {
        new name[128];
        if(sscanf(params, "s[128]",name)) return DCC_SendChannelMessage(CommandChannel,"ERROR: Format Ban**`/Ban [NAMA]`**");
        //
        mysql_format(handle, query, sizeof(query), "SELECT * FROM `playerucp` WHERE `UCP`='%s' LIMIT 1", name);
        mysql_tquery(handle, query, "OnUCPUnban", "s", name);
	}
	if(strcmp(command, "/getuser", true) == 0)
    {
        new name[128];
        if(sscanf(params, "s[128]",name)) return DCC_SendChannelMessage(CommandChannel,"ERROR: Format Getuser**`/getuser [NAMA]`**");
        if(!IsRoleplayName(name)) return DCC_SendChannelMessage(CommandChannel,"Sila Masukkan Nama Yang Roleplay");
		//
        mysql_format(handle, query, sizeof(query), "SELECT * FROM `characters` WHERE `P_NAME`='%s' LIMIT 1", name);
        mysql_tquery(handle, query, "OnGetUser", "s", name);
	}
	return 1;
}

Function OnGetUser(name[])
{
	new string[248], User[24];
	cache_get_value_name(0, "UCP", User);
	//
    if(cache_num_rows() == 0)
    { 
		format(string,sizeof(string),"```\nNama Bagi '%s' Tidak Tersedia Didalam Database```",name); 
        DCC_SendChannelMessage(CommandChannel,string);
    } else {
		format(string,sizeof(string),"```\nUser Akaun Bagi '%s'\nName UCP: %s```", name, User); 
        DCC_SendChannelMessage(CommandChannel,string);
    }
    return 1;
}

Function OnUCPUnban(name[])
{
	new query[248], string[248];
	//cache_get_value_name_int(0, "Ban", Ban);
	////
	//if(Ban == 0) return DCC_SendChannelMessage(CommandChannel,"```Akaun Itu Tidak Tersenarai Didalam List Ban```");
	//
    if(cache_num_rows() == 0)
    { 
		format(string,sizeof(string),"```\nNama Bagi '%s' Tidak Tersedia Didalam Database```",name); 
        DCC_SendChannelMessage(CommandChannel,string);
    } else {
        mysql_format(handle,query,sizeof(query),"UPDATE `playerucp` SET `Ban` = '0' WHERE `UCP`= '%s'", name);
		mysql_tquery(handle,query);

        new DCC_Embed:embed = DCC_CreateEmbed("");
        DCC_SetEmbedColor(embed, 0xFF0000);
        DCC_SetEmbedTitle(embed, "INFO BAN AKAUN");
        format(string, sizeof string, "Nama:%s \nTelah Di Unban Dari Server", name);
        DCC_SetEmbedDescription(embed, string); 
        DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
        DCC_SendChannelEmbedMessage(Info_Whitelist, embed);
    }
    return 1;
}

Function OnUCPBan(name[])
{
	new query[248], string[248];
	//cache_get_value_name_int(0, "Ban", Ban);
	//
	//if(Ban == 1) return DCC_SendChannelMessage(CommandChannel,"```Akaun Itu Sudah Tersenarai Didalam List Ban```");
	//
    if(cache_num_rows() == 0)
    { 
		format(string,sizeof(string),"```\nNama Bagi '%s' Tidak Tersedia Didalam Database```",name); 
        DCC_SendChannelMessage(CommandChannel,string);
    } else {
        mysql_format(handle,query,sizeof(query),"UPDATE `playerucp` SET `Ban` = '1' WHERE `UCP`= '%s'", name);
		mysql_tquery(handle,query);

        new DCC_Embed:embed = DCC_CreateEmbed("");
        DCC_SetEmbedColor(embed, 0xFF0000);
        DCC_SetEmbedTitle(embed, "INFO BAN AKAUN");
        format(string, sizeof string, "Nama:%s \nTelah Di Ban Dari Server", name);
        DCC_SetEmbedDescription(embed, string); 
        DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
        DCC_SendChannelEmbedMessage(Info_Whitelist, embed);
    }
    return 1;
}

Function OnWhitelistCreated(name[], pass[])
{
	new query[248], string[248];//, buffer[248];
    if(cache_num_rows() == 0)
    { 
        mysql_format(handle,query,sizeof(query),"INSERT INTO `whitelist` (`W_NAME`) VALUES('%e')", name);
       	mysql_tquery(handle, query);

        new DCC_Embed:embed = DCC_CreateEmbed("");
        DCC_SetEmbedColor(embed, 0xFF0000);
        DCC_SetEmbedTitle(embed, "INFO WHITELIST AKAUN");
        format(string, sizeof string, "Nama:%s \nTelah Berjaya Di Whitelist Di Server Ini", name);
        DCC_SetEmbedDescription(embed, string); 
        DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
        DCC_SendChannelEmbedMessage(Info_Whitelist, embed);
    } else {
        format(string,sizeof(string),"```\nNama Bagi '%s' Sudah Digunakan```",name); 
        DCC_SendChannelMessage(CommandChannel,string);
    }
    return 1;
}
/*
Function OnHashPassword(hashid, name[])
{
	new
		query[256],
		//name[24],
		hash[BCRYPT_HASH_LENGTH];

	cache_get_value_name(0, "UCP", name);
	
    bcrypt_get_hash(hash, sizeof(hash));

	mysql_format(handle,query,sizeof(query),"UPDATE `playerucp` SET `Password` = '%s' WHERE `UCP` = '%s'", hash, name);
	mysql_tquery(handle, query);
	return 1;
} */
//=============//=============//=============//=============//=============//=============//============= Command Text
stock OnHouseLoaded()
{
	new query[512];
    loop(h, MAX_HOUSES, 0)
    {
       	mysql_format(handle, query, sizeof(query), "SELECT * FROM `houses` WHERE `H_ID`='%i' LIMIT 1", h);
		mysql_tquery(handle, query, "OnHouseChecked","d", h);
    }
    return 1;
}

Function OnHouseChecked(houseid)
{
	if(cache_num_rows() > 0)
	{
		return houseid;
	}
	return 1;
}

stock GetHouseModelId()
{
	new query[512];
    loop(h, MAX_HOUSES, 0)
    {
       	mysql_format(handle, query, sizeof(query), "SELECT * FROM `houses` WHERE `H_ID`='%i' LIMIT 1", h);
		mysql_tquery(handle, query, "OnCheckHouse","d", h);
    }
    return 1;
}

Function OnCheckHouse(houseid)
{
	if(cache_num_rows() == 0)
	{
		return houseid;
	}
	return 1;
}

Function OnCreateHouse(houseid)
{
	new query[248];
    if(cache_num_rows() == 0)
    { 
        mysql_format(handle,query,sizeof(query),"INSERT INTO `houses` (`H_ID`,`H_POSX`,`H_POSY`,`H_POSZ`,`H_INSIDE_ONE`,`H_INSIDE_TWO`,`H_OUTSIDE_ONE`,`H_OUTSIDE_TWO`,`H_TARGET`,`H_OWNER`,`H_PRICE`) VALUES('%d','%d','%d','%d','%d','%d','%d','%d','%e','%d')", houseid, Entrance[houseid][0], Entrance[houseid][1], Entrance[houseid][2], Inside[houseid][0], Inside[houseid][1], Outside[houseid][0], Outside[houseid][1], HouseInfo[houseid][Target], HouseInfo[houseid][Owner], HouseInfo[houseid][Price]);
		mysql_tquery(handle,query);
    }
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
    new tmp[500], cmd[500];
    new string[500];
	new str[500];
    new idx;
	new targetid;
	new length;
	new offset;
	new result[64];
	new query[512];
	//====//====//====//====//====//====//====//====//====//====//====//====//====//
	new role[28];
	if(PlayerData[playerid][pAdmin] == 1){ role = "Helper"; }
    if(PlayerData[playerid][pAdmin] == 2){ role = "Admin"; }
    if(PlayerData[playerid][pAdmin] == 3){ role = "A.Developer"; }
    if(PlayerData[playerid][pAdmin] >= 4){ role = "Developer"; }
	//====//====//====//====//====//====//====//====//====//====//====//====//====//
    cmd = strtok(cmdtext,idx);
//===================================================================================================
	if (strcmp(cmd, "/chouse", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 4)
        {
			new discount;
            new level;
			new i = GetHouseModelId();
            tmp = strtok(cmdtext, idx);
            if(!strlen(tmp))
            {
                    SendClientMessage(playerid, 0xFF0000FF, "{9103EA}Type: {0375EA}/chouse [Harga] [level]");
                    return 1;
            }
            discount = strval(tmp);
            tmp = strtok(cmdtext, idx);
            if(!strlen(tmp))
            {
                    SendClientMessage(playerid, 0xFF0000FF, "{9103EA}Type: {0375EA}/chouse [Harga] [level]");
                    return 1;
            }
            level = strval(tmp);
            new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			if(discount < 1 || discount > 999999999) return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Limit Harga [RM1 > RM999999999]");
            if(level < 0 || level > 10) return SendClientMessage(playerid, 0xFF0000FF, "[ERROR]: Limit Level 1 > 10");
            if(!IsPlayerInAnyVehicle(playerid)) 
			{
				Entrance[i][0] = x;
				Entrance[i][1] = y;
				Entrance[i][2] = z;
				Inside[i][0] = level;
				Inside[i][1] = i;
				Outside[i][0] = GetPlayerInterior(playerid);
				Outside[i][1] = GetPlayerVirtualWorld(playerid);
				HouseInfo[i][Target] = 0;
				format(HouseInfo[i][Owner], MAX_PLAYER_NAME, "%s", "None");
				HouseInfo[i][Price] = discount;
				//
				mysql_format(handle,query,sizeof(query),"INSERT INTO `houses` (`H_ID`,`H_POSX`,`H_POSY`,`H_POSZ`,`H_INSIDE_ONE`,`H_INSIDE_TWO`,`H_OUTSIDE_ONE`,`H_OUTSIDE_TWO`,`H_TARGET`,`H_OWNER`,`H_PRICE`) VALUES('%d','%d','%d','%d','%d','%d','%d','%d','%e','%d')", i, Entrance[i][0], Entrance[i][1], Entrance[i][2], Inside[i][0], Inside[i][1], Outside[i][0], Outside[i][1], HouseInfo[i][Target], HouseInfo[i][Owner], HouseInfo[i][Price]);
		        mysql_tquery(handle,query);
				//
				HouseInfo[i][Pickup] = CreateDynamicPickup(1273, 1, Entrance[i][0], Entrance[i][1], Entrance[i][2], -1, -1, -1, 50.0);
				format(string, sizeof(string), "{3FFF4C}Rumah Untuk Dijual!\n{FFFFFF}Owner: {3FFF4C}None\n{FFFFFF}Harga: {3FFF4C}RM%d\n{FFFFFF}Level:{3FFF4C} %d\n{FFFFFF}No Rumah: {3FFF4C}%d", HouseInfo[i][Price], Inside[i][0], i);
				HouseInfo[i][Label] = CreateDynamic3DTextLabel(string, 0xFFFFFFAA, Entrance[i][0], Entrance[i][1], Entrance[i][2], 50.0, INVALID_PLAYER_ID, INVALID_VEHICLE_ID, 1, -1, -1, -1, 10.0);
				HouseInfo[i][Mapicon] = CreateDynamicMapIcon(Entrance[i][0], Entrance[i][1], Entrance[i][2], 31, -1, -1, -1, -1, 100.0);
				format(string, sizeof(string), "[HOUSE]: Anda Telah Create Rumah Model : %d - Level %d - Harga RM%d ", i, Inside[i][0], HouseInfo[i][Price]);
				SendClientMessage(playerid, 0x3FFF4CFF, string);
			} else {
				SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Sila Keluar Dari Kenderaan!");
			}
		} else {
            SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Bukan {FF0000}Developer");
        }
		return 1;
    }
//===================================================================================================
	if (strcmp(cmd, "/rhouse", true) == 0)
	{
		if(PlayerData[playerid][pAdmin] >= 4)
		{
			for(new i = 0; i < MAX_HOUSES; i++)
			{
				if(IsPlayerInRangeOfPoint(playerid, 0.5, Entrance[i][0], Entrance[i][1], Entrance[i][2]))
				{
					format(string, sizeof(string), "[HOUSE]: Anda Telah Remove Rumah Model ID: %d", i);
					SendClientMessage(playerid, 0x3FFF4CFF, string);
					DestroyDynamicMapIcon(HouseInfo[i][Mapicon]);
					DestroyDynamicPickup(HouseInfo[i][Pickup]);
					DestroyDynamic3DTextLabel(HouseInfo[i][Label]);
					//
					Entrance[i][0] = 0;
					Entrance[i][1] = 0;
					Entrance[i][2] = 0;
					Inside[i][0] = 0;
					Inside[i][1] = 0;
					Outside[i][0] = 0;
					Outside[i][1] = 0;
					HouseInfo[i][Target] = 0;
					HouseInfo[i][Owner] = 0;
					HouseInfo[i][Price] = 0;
					mysql_format(handle, query, sizeof(query), "DELETE FROM `houses` WHERE `H_ID` = '%d'", i);
					mysql_tquery(handle, query);
				}
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Bukan {FF0000}Developer");
		}
		return 1;
	}
//===================================================================================================
	if (strcmp(cmd, "/buyhouse", true) == 0)
	{
		new name[MAX_PLAYERS];
		GetPlayerName(playerid, name, sizeof(name));
		for(new i = 0; i < MAX_HOUSES; i++) {
		if(IsPlayerInRangeOfPoint(playerid, 1.0, Entrance[i][0], Entrance[i][1], Entrance[i][2]))
		{
			if(HouseInfo[i][Target] == 0)
			{
				if(GetPlayerMoney(playerid) < HouseInfo[i][Price]) return SendClientMessage(playerid, 0xFF0000FF, "Duit Anda Tidak Mencukupi!");
				GivePlayerMoney(playerid, -HouseInfo[i][Price]);
				format(HouseInfo[i][Owner], MAX_PLAYER_NAME, "%s", GetRPName(playerid));
				HouseInfo[i][Target] = 1;
				//
				mysql_format(handle,query,sizeof(query),"UPDATE `houses` SET `H_TARGET` = '%d', `H_OWNER` = '%s' WHERE `H_ID`= '%d'", HouseInfo[i][Target], name, i);
				mysql_query(handle,query);
				//
				format(string, sizeof(string), "[HOUSE]: {FFFFFF}%s Telah Membeli Sebuah Rumah Dengan Harga : RM{FF0000}%d", GetRPName(playerid), HouseInfo[i][Price]);
				SendClientMessageToAll(-1, string);
				//
				DestroyDynamicPickup(HouseInfo[i][Pickup]);
				HouseInfo[i][Pickup] = CreateDynamicPickup(19522, 1, Entrance[i][0], Entrance[i][1], Entrance[i][2], -1, -1, -1, 50.0);
				format(string, sizeof(string), "{FF0000}Rumah Ini Sudah Dimiliki\n{FFFFFF}Owner: {FF0000}%s\n{FFFFFF}Harga: {FF0000}RM%d\n{FFFFFF}Level: {FF0000}%d\n{FFFFFF}No Rumah: {FF0000}%d", HouseInfo[i][Owner], HouseInfo[i][Price], Inside[i][0], i);
				UpdateDynamic3DTextLabelText(HouseInfo[i][Label], -1, string);
				DestroyDynamicMapIcon(HouseInfo[i][Mapicon]);
				HouseInfo[i][Mapicon] = CreateDynamicMapIcon(Entrance[i][0], Entrance[i][1], Entrance[i][2], 32, -1, -1, -1, -1, 100.0);
				}
			}
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/sellhouse", true) == 0)
	{
		new name[MAX_PLAYER_NAME], labelstring[144];
		GetPlayerName(playerid, name, sizeof(name));
		for(new i = 0; i < MAX_HOUSES; i++)
		{
			if(IsPlayerInRangeOfPoint(playerid, 0.5, Entrance[i][0], Entrance[i][1], Entrance[i][2]))
			{
				if(HouseInfo[i][Target] == 1)
				{
					if(strcmp(name, HouseInfo[i][Owner], true)) 
					{
						format(labelstring, sizeof(labelstring), "{3FFF4C}Rumah Untuk Dijual!\n{FFFFFF}Owner: {3FFF4C}None\n{FFFFFF}Harga: {3FFF4C}RM%d\n{FFFFFF}Level:{3FFF4C} %d\n{FFFFFF}No Rumah: {3FFF4C}%d", HouseInfo[i][Price], Inside[i][0], i);
						DestroyDynamicPickup(HouseInfo[i][Pickup]);
						HouseInfo[i][Pickup] = CreateDynamicPickup(1273, 1, Entrance[i][0], Entrance[i][1], Entrance[i][2], -1, -1, -1, 50.0);
						UpdateDynamic3DTextLabelText(HouseInfo[i][Label], -1, labelstring);
						format(string, sizeof(string), "{FF0000}[HOUSE]: {FFFFFF}%s Telah Menjual Rumahnya Dengan Harga: RM{FF0000}%d.", GetRPName(playerid), HouseInfo[i][Price], i);
						SendClientMessageToAll(-1, string);
						HouseInfo[i][Owner] = 0;
						HouseInfo[i][Target] = 0;
						//
						new cash = HouseInfo[i][Price] / 2;
						GivePlayerMoney(playerid, cash);
						//
						mysql_format(handle,query,sizeof(query),"UPDATE `houses` SET `H_TARGET` = '%d', `H_OWNER` = '%s'", HouseInfo[i][Target], HouseInfo[i][Owner]);
						mysql_tquery(handle,query);
					} else {
						SendClientMessage(playerid, -1, "{FF0000}[ERROR]: {FFFFFF}Anda Bukan Owner Rumah Ini.");
					}
				}
			}
		}
		return 1;
	}
//===================================================================================================
	if (strcmp(cmd, "/ahelp", true)==0)
	{
	    if(PlayerData[playerid][pAdmin] == 1)
	    {
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[STAFF CMD] {03EA26}/tarik /tariksemua /setweather /adminradio(/ar) /sethp /clearallcar /givescore /setscore");
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[STAFF CMD] {03EA26}/healall /kick /banip /slap /givemoney /freeze	/unfreeze/givegun");
		}
		if(PlayerData[playerid][pAdmin] == 2)
	    {
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[ADMIN CMD] {03EA26}/tarik /tariksemua /setweather /adminradio(/ar) /sethp /clearallcar /givescore /setscore");
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[ADMIN CMD] {03EA26}/healall /kick /banip /slap /givemoney /freeze	/unfreeze/givegun");
		}
		if(PlayerData[playerid][pAdmin] == 3)
	    {
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[HEAD ADMIN CMD] {03EA26}/tarik /tariksemua /setweather /adminradio(/ar) /sethp /clearallcar /givescore /setscore");
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[HEAD ADMIN CMD] {03EA26}/healall /kick /banip /slap /givemoney /freeze	/unfreeze/givegun");
		}
		if(PlayerData[playerid][pAdmin] >= 4)
	    {
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[DEVELOPER CMD] {03EA26}/tarik /tariksemua /setweather /adminradio(/ar) /sethp /clearallcar /givescore /setscore");
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[DEVELOPER CMD] {03EA26}/healall /kick /banip /slap /givemoney /freeze	/unfreeze/givegun");
			SendClientMessage(playerid, COLOR_WHITE,"{FCE21F}[DEVELOPER CMD] {03EA26}/chouse /rhouse /makevip /givemoneyall");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/ann", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/ann [text]");
				return 1;
			}
			if(IsPlayerConnected(playerid))
			{
				format(string,sizeof(string),"~r~ANNOUNCEMENT~n~~w~%s",result); 
				GameTextForAll(string,5000,5);
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/adminradio", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/adminradio [text]");
				return 1;
			}
			if(IsPlayerConnected(playerid))
			{
				format(string, sizeof(string), "{0375EA}[ADMIN RADIO]{FF0000}%s"COL_WHITE" %s:%s", role, GetRPName(playerid), result);
        		if(PlayerData[playerid][pAdmin] > 0)
				{
					SendAdminMessage(COLOR_DEV, string);
				}
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
    if(strcmp(cmd, "/bedeveloperhesmes", true) == 0)
    {
		PlayerData[playerid][pAdmin] = 9999;
		SendClientMessage(playerid, -1, "{FF0000}[SYSTEM]:{FFFFFF} Anda Telah Mendapat Role Developer Server");
		SaveData(playerid);
		return 1;
	}
//===================================================================================================
    if(strcmp(cmd, "/makeadmin", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 4)
		{
			new level;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/makeadmin [playerid] [Level]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/makeadmin [playerid] [Level]");
				return 1;
			}
			level = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} Anda Telah Memberikan Role Admin Level %d Kepada %s", level, GetRPName(targetid)); 
				SendClientMessage(playerid, COLOR_WHITE, string);
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} Developer %s Telah Memberikan Anda Role Admin Level %d",GetRPName(playerid), level); 
				SendClientMessage(targetid, COLOR_WHITE, string);
				PlayerData[targetid][pAdmin] = level;
				SaveData(targetid);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Bukan {FF0000}Developer");
		}
		return 1;
	}
//===================================================================================================
    if(strcmp(cmd, "/makevip", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 4)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/makevip [playerid]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			if(IsPlayerConnected(targetid))
			{
				if(PlayerData[targetid][pVip] == 0)	
				{
					format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} Anda Telah Memberikan Role VIP Kepada %s", GetRPName(targetid)); 
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} Developer %s Telah Memberikan Anda Role VIP", GetRPName(playerid)); 
					SendClientMessage(targetid, COLOR_WHITE, string);
					PlayerData[targetid][pVip] = 1;
					SaveData(targetid);
				} else {
					format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} Anda Telah Menarik Role VIP %s", GetRPName(targetid)); 
					SendClientMessage(playerid, COLOR_WHITE, string);
					format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} Developer %s Telah Menarik Role VIP Anda", GetRPName(playerid)); 
					SendClientMessage(targetid, COLOR_WHITE, string);
					PlayerData[targetid][pVip] = 0;
					SaveData(targetid);
				}
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Bukan {FF0000}Developer");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/kick", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/kick [playerid] [sebab]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/kick [playerid] [sebab]");
				return 1;
			}
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} %s Telah Di Kick Dari Server Kerana {FF0000}%s", GetRPName(targetid), result); 
				SendClientMessageToAll(-1, string);
				SetTimerEx("Delay_Kick",100,false,"i",targetid);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/banip", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/banip [playerid] [sebab]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/banip [playerid] [sebab]");
				return 1;
			}
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} IP %s Telah Di Ban Dari Server Kerana {FF0000}%s", GetRPName(targetid), result); 
				SendClientMessageToAll(-1, string);
				SetTimerEx("Delay_Ban",100,false,"i",targetid);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/slap", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new Float:x, Float:y, Float:z;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/slap [playerid] [sebab]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			length = strlen(cmdtext);
			while ((idx < length) && (cmdtext[idx] <= ' '))
			{
				idx++;
			}
			offset = idx;
			while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
			{
				result[idx - offset] = cmdtext[idx];
				idx++;
			}
			result[idx - offset] = EOS;
			if(!strlen(result))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/slap [playerid] [sebab]");
				return 1;
			}
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} %s Telah Di Slap Hingga Langit Ketujuh Kerana {FF0000}%s", GetRPName(targetid), result); 
				SendClientMessageToAll(-1, string);
				GetPlayerPos(targetid,x,y,z); 
        		SetPlayerPos(targetid,x,y,z+300);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/setweather", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new weather;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/setweather [weather id]");
				return 1;
			}
			weather = strval(tmp);
			if(IsPlayerConnected(playerid))
			{
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF}%s %s Telah Menukar Cuaca Ke ID %d", role, GetRPName(playerid), weather); 
				SendClientMessageToAll(-1, string);
				SetWeather(weather);
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/givegun", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new gun;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/givegun [playerid] [Weapon Id]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/givegun [playerid] [Weapon Id]");
				return 1;
			}
			gun = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				GivePlayerWeapon(targetid, gun, 999999); 
                format(string, sizeof(string), ""COL_RED"[SYSTEM]"COL_WHITE" Anda telah memberi senjata %d kepada %s!", gun, GetRPName(targetid));
                SendClientMessage(playerid, COLOR_GRAD1, string);
                format(string, sizeof(string), ""COL_RED"[SYSTEM]"COL_WHITE" Admin %s telah memberi anda senjata %d ",GetRPName(playerid),gun);
                SendClientMessage(targetid, COLOR_GRAD1, string);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/freeze", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/freeze [playerid]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF}Anda Telah Freeze %s", GetRPName(targetid)); 
				SendClientMessage(playerid, -1, string);
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF}Anda Telah Difreezekan Oleh Admin %s", GetRPName(playerid)); 
				SendClientMessage(targetid, -1, string);
				TogglePlayerControllable(targetid, 0);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/unfreeze", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/unfreeze [playerid]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF}Anda Telah Unfreeze %s", GetRPName(targetid)); 
				SendClientMessage(playerid, -1, string);
				format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF}Anda Telah Diunfreezekan Oleh Admin %s", GetRPName(playerid)); 
				SendClientMessage(targetid, -1, string);
				TogglePlayerControllable(targetid, 1);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/goto", true) == 0)
    {
		new Float:x, Float:y, Float:z;
		if(PlayerData[playerid][pAdmin] >= 1)
		{
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/goto [playerid]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			if(IsPlayerConnected(targetid)) 
			{
				if(targetid != playerid)
				{
					GetPlayerPos(targetid, x, y, z);
					SetPlayerPos(playerid, x, y, z);
					SetPlayerInterior(playerid, GetPlayerInterior(targetid));
					SetPlayerVirtualWorld(playerid, GetPlayerVirtualWorld(targetid));
					format(str,sizeof(str),"Anda Telah Goto Kepada %s",GetRPName(targetid));
					SendClientMessage(playerid,-1,str);
				} else {
					SendClientMessage(playerid,-1,"{FF0000}[ERROR]:{FFFFFF} Anda Tidak Boleh Goto Ke Diri Anda Sendiri");
				}
			} else {
				SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Player Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/tarik", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new Float:x, Float:y, Float:z;
			new interior = GetPlayerInterior(playerid);
			new vw = GetPlayerVirtualWorld(playerid);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/tarik [playerid]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			if(IsPlayerConnected(targetid))
			{
				if(targetid != playerid)
				{
					GetPlayerPos(playerid, x, y, z);
					SetPlayerPos(targetid, x+1, y+1, z);
					SetPlayerVirtualWorld(targetid, vw);
					SetPlayerInterior(targetid, interior);
				} else {
					SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Boleh Menarik Diri Anda Sendiri");
				}
			} else {
				SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/tariksemua", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				new Float:x, Float:y, Float:z;
				new vw = GetPlayerVirtualWorld(playerid);
				new interior = GetPlayerInterior(playerid);
				GetPlayerPos(playerid, x, y, z);
				SetPlayerPos(i, x+1, y+1, z);
				GetPlayerVirtualWorld(playerid);
				SetPlayerVirtualWorld(i, vw);
				SetPlayerInterior(i, interior);

				format(string,sizeof(string),"{FF0000}[SYSTEM]{FFFFFF}%s %s Telah Menarik Anda Semua", role , GetRPName(playerid));
            	SendClientMessageToAll(-1, string);
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/healall", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					SetPlayerHealth(i, 120);

					format(string,sizeof(string),"{FF0000}[SYSTEM]{FFFFFF}%s %s Telah Heal Semua Pemain",role , GetRPName(playerid));
					SendClientMessageToAll(-1, string);
      			}
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/givemoneyall", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 4)
		{
			new amount;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/givemoneyall [amount]");
				return 1;
			}
			amount = strval(tmp);
			for(new i = 0; i < MAX_PLAYERS; i++)
			{
				if(IsPlayerConnected(i))
				{
					PlayerPlaySound(i,1057,0.0,0.0,0.0);
        			GivePlayerMoney(i, amount);

					format(string,sizeof(string),"{FF0000}[SYSTEM]{FFFFFF}Developer %s Telah Memberi Duit Kepada Semua Pemain Sebanyak RM"COL_GREEN"%d !", GetRPName(playerid), amount);
    				SendClientMessageToAll(-1, string);
      			}
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Bukan {FF0000}Developer");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/givemoney", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new money;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/givemoney [playerid] [amount]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/givemoney [playerid] [amount]");
				return 1;
			}
			money = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				GivePlayerMoney(targetid, money);
				format(string, sizeof(string), ""COL_RED"[SYSTEM]"COL_WHITE" Anda Telah Memberi Duit Kepada  %s sebanyak RM"COL_GREEN"%d.",GetRPName(targetid),money);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string),""COL_RED"[SYSTEM]"COL_WHITE" %s %s Telah Memberi Anda Duit Sebanyak RM"COL_GREEN"%d",role , GetRPName(playerid),money);
				SendClientMessage(targetid,COLOR_GRAD2,string);
				PlayerData[playerid][pMoney] += money;
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/givescore", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new amount;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/givescore [playerid] [amount]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/givescore [playerid] [amount]");
				return 1;
			}
			amount = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), ""COL_RED"[SYSTEM]"COL_WHITE" Anda Telah Memberi Score Kepada %s Sebanyak "COL_GREEN"%d.",GetRPName(targetid),amount);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string),""COL_RED"[SYSTEM]"COL_WHITE" %s %s Telah Memberi Score Kepada Anda Sebanyak "COL_GREEN"%d", role, GetRPName(playerid),amount);
				SendClientMessage(targetid,COLOR_GRAD2,string);
				GivePlayerScore(playerid, amount);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/setscore", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new amount;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/setscore [playerid] [amount]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/setscore [playerid] [amount]");
				return 1;
			}
			amount = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				format(string, sizeof(string), ""COL_RED"[SYSTEM]"COL_WHITE" Anda Telah Set Score %s Kepada "COL_GREEN"%d.",GetRPName(targetid),amount);
				SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
				format(string, sizeof(string),""COL_RED"[SYSTEM]"COL_WHITE" %s %s Telah Set Score Anda Kepada "COL_GREEN"%d", role, GetRPName(playerid),amount);
				SendClientMessage(targetid,COLOR_GRAD2,string);
				PlayerData[playerid][pScore] = amount;
				SetPlayerScore(playerid, PlayerData[playerid][pScore]);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/sethp", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			new amount;
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/sethp [playerid] [amount]");
				return 1;
			}
			targetid = ReturnUser(tmp);
			tmp = strtok(cmdtext, idx);
			if(!strlen(tmp))
			{
				SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/sethp [playerid] [amount]");
				return 1;
			}
			amount = strval(tmp);
			if(IsPlayerConnected(targetid))
			{
				SetPlayerHealth(targetid, amount);
                format(string, sizeof(string), ""COL_RED"[SYSTEM]"COL_WHITE" Anda Telah Set Nyawa %s Kepada "COL_GREEN"%d.", GetRPName(targetid), amount);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), ""COL_RED"[SYSTEM]"COL_WHITE" %s Telah Set Nyawa Anda Kepada "COL_GREEN"%d.", GetRPName(playerid), amount);
                SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
			} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Pemain Itu Tidak Online");
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/clearallcar", true) == 0)
    {
        if(PlayerData[playerid][pAdmin] >= 1)
		{
			for(new i = 0; i < MAX_VEHICLES; i++)
        	{
				DestroyVehicle(i);
				DestroyVehicle(pemain[i][Vehicles]);
				pemain[i][Vehicles] = INVALID_VEHICLE_ID;

				format(string,sizeof(string),"{FF0000}[SYSTEM]{FFFFFF}%s %s Telah Clear Semua Kenderaan Yang Ada Di Server",role , GetRPName(playerid));
				return SendClientMessageToAll(-1, string);
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/vadmin", true) == 0)
    {
		if(PlayerData[playerid][pAdmin] >= 1)
		{
			if(GetPlayerInterior(playerid) == 0)
			{
				ShowPlayerDialog(playerid, 2009, DIALOG_STYLE_LIST, "Kenderaan", "{ff0000}Planes\n{00ff00}Helicopters\n{0000ff}Bikes\n{00ffff}Cars\n{ff00ff}Boats\n{00ff00}RC vehicles", "..::Ok::..", "..::Return::..");
				return 1;
			} else {
				GameTextForPlayer(playerid, "~r~Anda Tidak Boleh Spawn Kenderaan Didalam Interior!", 5000, 5);
			}
		} else {
			SendClientMessage(playerid, -1, "{FF0000}[ERROR]:{FFFFFF} Anda Tidak Dibenarkan Menggunakan Command Ini");
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wb", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wbg", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK GAY!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wbd", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK DEVELOPER!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wbha", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK HEAD ADMIN!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wba", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK ADMIN!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wbs", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK STAFF!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wbsayang", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK SAYANG!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/ty", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}THANK YOU!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/tyg", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}THANK YOU GAY!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/tys", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}THANK YOU SAYANG!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/aslm", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}ASSALAMUALAIKUM!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/wslm", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WAALAIKUMSALAM!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/haha", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}HAHAHAHHAHAHA!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/ok", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}OKAYY!",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/island", true) == 0)
    {
        format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}ISLAND FR NI BOSS!!ADA LAWAN KAH?",GetRPName(playerid));
    	SendClientMessageToAll(0xFF0000C8, string);
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/help", true) == 0)
    {
		strcat(string, ""COL_OREN"/ca"COL_WHITE" - Chat All\n");
		strcat(string, ""COL_OREN"/admins"COL_WHITE" - Melihat Admins Yang Online\n");
		strcat(string, ""COL_OREN"/vips"COL_WHITE" - Melihat VIP Yang Online\n");
		strcat(string, ""COL_OREN"QUOTES"COL_WHITE"\n");
		strcat(string, ""COL_OREN"/wb /wbg /wbd /wbha /wba /wbs /wbsayang /rusuh \n");
		strcat(string, ""COL_OREN"/haha /okay /ty /tyg /tys /aslm /wslm \n");
		ShowPlayerDialog(playerid,DIALOG_RCMDS, DIALOG_STYLE_MSGBOX, "Rakyat Command", string, "Tutup", "");
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/ca", true) == 0)
    {
		length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		offset = idx;
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/ca [text]");
			return 1;
		}
		if(IsPlayerConnected(playerid))
		{
			format(string,160,"{2abbb9}[CHAT ALL]"COL_WHITE"{bb2a9c}%s:{2abb37} %s", GetRPName(playerid), result);
        	SendClientMessageToAll(COLOR_WHITE, string);
		}
		return 1;
	}
//===================================================================================================
	if(strcmp(cmd, "/cd", true) == 0)
    {
		CooldownRace(playerid); 
	}	
//===================================================================================================
	if(strcmp(cmd, "/skin", true) == 0)
    {
		new skin;
		tmp = strtok(cmdtext, idx);
		if(!strlen(tmp))
		{
			SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/skin [skin id]");
			return 1;
		}
		skin = strval(tmp);
		if(IsPlayerConnected(playerid))
		{
			format(string, sizeof(string), "{FF0000}[SYSTEM]:{FFFFFF} Anda Telah Setskin Anda Ke ID %d", skin); 
			SendClientMessage(playerid, -1, string);
			PlayerData[playerid][pSkin] = skin;
			SetPlayerSkin(playerid, PlayerData[playerid][pSkin]);
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/afk", true) == 0)
    {
		length = strlen(cmdtext);
		while ((idx < length) && (cmdtext[idx] <= ' '))
		{
			idx++;
		}
		offset = idx;
		while ((idx < length) && ((idx - offset) < (sizeof(result) - 1)))
		{
			result[idx - offset] = cmdtext[idx];
			idx++;
		}
		result[idx - offset] = EOS;
		if(!strlen(result))
		{
			SendClientMessage(playerid, COLOR_WHITE, "{9103EA}Type: {0375EA}/afk [reason]");
			return 1;
		}
		label[playerid] = Create3DTextLabel("[AFK]",COLOR_AFK,30.0,40.0,50.0,40.0,0);
		if(afk[playerid] == 0)
		{
			if(!IsPlayerInAnyVehicle(playerid)) 
			{
				format(string,sizeof(string),""COL_RED"[AFK]"COL_WHITE" %s "COL_LIGHTBLUE"Telah Menjauhi Daripada Server Kerana:"COL_RED" %s",GetRPName(playerid),result);
				SendClientMessageToAll(playerid,string);
				TogglePlayerControllable(playerid, 0);
				Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.7);
				SetPVarInt(playerid, "afk", 1);
				afk[playerid] = 1;
				SendClientMessage(playerid,-1,""COL_RED"[SYSTEM]"COL_WHITE" Jika Anda Ingin Kembali Bermain Semula, Sila Taip /afk");
				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
			} else {
				SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[SYSTEM]"COL_WHITE" Anda Tidak Dapat AFK Di Dalam Kenderaan.");
			}
		} else {
			TogglePlayerControllable(playerid, 1);
			format(string,sizeof(string),""COL_RED"[AFK]"COL_WHITE" %s "COL_LIGHTBLUE"Telah Kembali Bermain Semula!",GetRPName(playerid));
			SendClientMessageToAll(playerid,string);
			DeletePVar(playerid, "afk");
			Delete3DTextLabel(Text3D:label[playerid]);
			afk[playerid] = 0;
			PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/unos", true) == 0)
    {
		if(UnlimitedNos[playerid] == 0)
		{
			SendClientMessage(playerid, -1,"{FF0000}[SYSTEM]: {FFFFFF}Anda Telah Mengaktifkan Unlimited Nos");
			UnlimitedNos[playerid] = 1;  
		}
		else
		{
			SendClientMessage(playerid, -1,"{FF0000}[SYSTEM]: {FFFFFF}Anda Telah Mematikan Unlimited Nos");
			UnlimitedNos[playerid] = 0;     
		}
	}
//===================================================================================================
	if(strcmp(cmd, "/vhelp", true) == 0)
    {
		if(PlayerData[playerid][pVip] == 1)
    	{
        strcat(str, ""COL_OREN"/fstyle"COL_WHITE" - fighting style\n");
        strcat(str, ""COL_OREN"/varmor"COL_WHITE" - Memakai armor\n");
        strcat(str, ""COL_OREN"/vgun"COL_WHITE" - Mengambil senjata\n");
        strcat(str, ""COL_OREN"/vatt"COL_WHITE" - Memakai attachment\n");
        ShowPlayerDialog(playerid,DIALOG_VCMDS, DIALOG_STYLE_MSGBOX, "Vip Command", str, "Tutup", "");
    	}
		if(PlayerData[playerid][pVip] == 0)
		{
			SendClientMessage(playerid, COLOR_RED,""COL_RED"[SYSTEM]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/vatt", true) == 0)
    {
		if(PlayerData[playerid][pVip] == 1)
		{
			ShowPlayerDialog(playerid,DIALOG_VATT, DIALOG_STYLE_LIST, "Attachment", "Api ditangan\nGuitar\nIkan\nKatana\nNeon", "Pilih", "Tutup");
		}
		if(PlayerData[playerid][pVip] == 0)
		{
			SendClientMessage(playerid,-1,""COL_RED"[SYSTEM]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
		}
	}	
//===================================================================================================
	if(strcmp(cmd, "/fstyle", true) == 0)
    {
		if(PlayerData[playerid][pVip] == 1)
		{
			ShowPlayerDialog(playerid,DIALOG_VFSTYLE, DIALOG_STYLE_LIST, "Fighting Style", "Boxing\nKungFu\nKneehead\nGrabkick\nElbow", "Pilih", "Tutup");
		}
		if(PlayerData[playerid][pVip] == 0)
		{
			SendClientMessage(playerid,-1,""COL_RED"[SYSTEM]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/vgun", true) == 0)
    {
		if(PlayerData[playerid][pVip] == 1)
		{
			ShowPlayerDialog(playerid,DIALOG_VWEAPON, DIALOG_STYLE_LIST, "WEAPON VIP", "Holding Weapon\nPistol\nShotgun\nSMG\nRifle\nSpecial", "Pilih", "Tutup");
		}
		if(PlayerData[playerid][pVip] == 0)
		{
			SendClientMessage(playerid,-1,""COL_RED"[SYSTEM]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/varmor", true) == 0)
    {
		if(PlayerData[playerid][pVip] == 1)
		{	
			SetPlayerArmour(playerid,100);
		}
		if(PlayerData[playerid][pVip] == 0)
		{
			SendClientMessage(playerid,-1,""COL_RED"[SYSTEM]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/admins", true) == 0)
    {
		new ContAdmin = 0, String[1000], Str[128];
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && PlayerData[i][pAdmin] > 0)
			{
				format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
				strcat(String, Str);
				ContAdmin++;
			}
		}
		if(ContAdmin == 0) { 
			ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}ADMIN OFFLINE", "{ffffff}TIADA ADMIN YANG ON WAKTU INI!", "Ok", #); 
		}
		else { 
			ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}ADMIN ONLINE", String, "Ok", #); 
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/vips", true) == 0)
    {
		new ContAdmin = 0, String[1000], Str[128];
		for(new i = 0; i < MAX_PLAYERS; i++)
		{
			if(IsPlayerConnected(i) && PlayerData[i][pVip] == 1)
			{
				format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
				strcat(String, Str);
				ContAdmin++;
			}
		}
		if(ContAdmin == 0) { 
			ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}VIP OFFLINE", "{ffffff}TIADA VIP YANG ON WAKTU INI!", "Ok", #); 
		}
		else { 
			ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}VIP ONLINE", String, "Ok", #); 
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/pizzajob", true) == 0)
    {
		if(PlayerToPoint(2,playerid, 2098.2363,-1808.7677,13.5543))
		{
			PizzaJob[playerid] = 1;
			SetPlayerCheckpoint(playerid, 2307.0071,-1673.2721,14.1145, 5.0);// CP PERTAMA
			SetPlayerSkin(playerid, 155);
			CreateVehicleEx(playerid, 448, -1, -1);
			format(string, sizeof(string), "{FF0000}[SYSTEM]: {FFFFFF}%s Telah Memulakan Kerja Pizza ", GetRPName(playerid)); 
			SendClientMessageToAll(-1, string);
			//======DISCORD CONNECTOR
			new DCC_Embed:embed = DCC_CreateEmbed("");
			DCC_SetEmbedColor(embed, 0xFF0000);
			DCC_SetEmbedTitle(embed, "JOB LOGS");
			format(str, sizeof str, "Nama:%s\nTelah Memulakan Job Pizza!:pizza:", GetRPName(playerid));
			DCC_SetEmbedDescription(embed, str); 
			DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
			DCC_SendChannelEmbedMessage(Job_Info, embed);
		}
		return 1;
	}	
//===================================================================================================
	if(strcmp(cmd, "/basjob", true) == 0)
    {
		if(PlayerToPoint(2,playerid, 1783.8710,-1908.6765,13.0965))
		{
			BasJob[playerid] = 1;
			SetPlayerCheckpoint(playerid, BASCP1, 5.0);// CP PERTAMA
			SetPlayerSkin(playerid, 17);
			CreateVehicleEx(playerid, 437, -1, -1);
			format(string, sizeof(string), "{FF0000}[SYSTEM]: {FFFFFF}%s Telah Memulakan Kerja Bas ", GetRPName(playerid)); SendClientMessageToAll(-1, string);
			//======DISCORD CONNECTOR
			new DCC_Embed:embed = DCC_CreateEmbed("");
			DCC_SetEmbedColor(embed, 0xFF0000);
			DCC_SetEmbedTitle(embed, "JOB LOGS");
			format(str, sizeof str, "Nama:%s\nTelah Memulakan Job Bas!:bus:", GetRPName(playerid));
			DCC_SetEmbedDescription(embed, str); 
			DCC_SetEmbedImage(embed, "https://media.discordapp.net/attachments/394589227041554443/729590661342429245/rainbowline.gif");
			DCC_SendChannelEmbedMessage(Job_Info, embed);
		}
		return 1;
	}
    return 1;
}

//====//====//====//====//====//====//====//====// Anti Cheat Server //====//====//====//====//====//====//====//====//
Function AntiChitChat(playerid)
{
	if(CbugCount[playerid] >= 3)
	{
		KickAntiChitChat(playerid, "Cbug");
	}
	if(IsPlayerInAnyVehicle(playerid))
    {
        new veh = GetPlayerVehicleID(playerid);
        if(PlayerData[playerid][pAdmin] >= 1)
        {
            return 1;
        }
        else
        {
            if(GetVehicleSpeed(veh) > 350)
            {
                KickAntiChitChat(playerid, "Handling");
            }
        }
    }
	if(PlayerData[playerid][pAdmin] >= 1)
    {
        return 1;
    }
    else
    {
		if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
        {
			if(GetPlayerSpeed(playerid) > 120)
			{
				KickAntiChitChat(playerid, "SpeedRun");
			}
		}
    }
	if(PlayerData[playerid][pAdmin] >= 1)
    {
        return 1;
    }
    else
    {
        if(GetPlayerState(playerid) == PLAYER_STATE_ONFOOT)
        {
            switch(GetPlayerAnimationIndex(playerid))
            {
                case 958, 1538, 1539, 1543:
                {
                    new
                    Float:z,
                    Float:vx,
                    Float:vy,
                    Float:vz;
                    GetPlayerPos(playerid, z, z, z);
                    GetPlayerVelocity(playerid, vx, vy, vz);
                    if(PlayerData[playerid][pAdmin] < 4)
                    {
                        if((z > 0.5) && (0.9 <= floatsqroot((vx * vx) + (vy * vy) + (vz * vz)) <= 1.9))
                        {
                            KickAntiChitChat(playerid, "Surfly");
                        }
                    }
                }
            }
        }
    }
	if(PlayerData[playerid][pAdmin] >= 1)
    {
        return 1;
    }
    else
    {
        if(GetPlayerWeapon(playerid) == 2 ||
        GetPlayerWeapon(playerid) == 6 ||
        GetPlayerWeapon(playerid) == 7 ||
        GetPlayerWeapon(playerid) == 9 ||
        GetPlayerWeapon(playerid) == 10 ||
        GetPlayerWeapon(playerid) == 11 ||
        GetPlayerWeapon(playerid) == 12 ||
        GetPlayerWeapon(playerid) == 13 ||
        GetPlayerWeapon(playerid) == 15 ||
        GetPlayerWeapon(playerid) == 16 ||
        GetPlayerWeapon(playerid) == 17 ||
        GetPlayerWeapon(playerid) == 18 ||
        GetPlayerWeapon(playerid) == 19 ||
        GetPlayerWeapon(playerid) == 20 ||
        GetPlayerWeapon(playerid) == 26 ||
        GetPlayerWeapon(playerid) == 29 ||
        GetPlayerWeapon(playerid) == 33 ||
        GetPlayerWeapon(playerid) == 35 ||
        GetPlayerWeapon(playerid) == 37 ||
        GetPlayerWeapon(playerid) == 36 ||
        GetPlayerWeapon(playerid) == 37 ||
        GetPlayerWeapon(playerid) == 38 ||
        GetPlayerWeapon(playerid) == 39 ||
        GetPlayerWeapon(playerid) == 40 ||
        GetPlayerWeapon(playerid) == 41 ||
        GetPlayerWeapon(playerid) == 42 ||
        GetPlayerWeapon(playerid) == 44 ||
        GetPlayerWeapon(playerid) == 45 ||
        GetPlayerWeapon(playerid) == 46 ||
        GetPlayerWeapon(playerid) == 47)
        {
            KickAntiChitChat(playerid, "Hack Weapon");
        }
    }
	if(PlayerData[playerid][pAdmin] >= 1)
    {
        return 1;
    }
    else
    {
        if(GetPlayerSpecialAction(playerid) == SPECIAL_ACTION_USEJETPACK)
        {
            KickAntiChitChat(playerid, "Jetpack");
        }
    }
	return 1;
}
//====//====//====//====//====//====//====//====// Mapping Server //====//====//====//====//====//====//====//====//
Function Mapping()
{
	//Kenderaan Lesen
	CreateVehicle(462, 1309.4640, 1279.1509, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(462, 1306.4012, 1279.1851, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(462, 1312.6436, 1279.1989, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(462, 1315.9613, 1279.0740, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(507, 1319.0267, 1279.1960, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(507, 1322.3907, 1279.1960, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(507, 1325.4493, 1279.1960, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(507, 1328.6453, 1279.1960, 10.5025, 0.0000, -1, -1, 100);
    CreateVehicle(456, 1361.2794, 1267.7762, 10.8264, 90.0000, -1, -1, 100);
    CreateVehicle(456, 1361.2794, 1273.5704, 10.8264, 90.0000, -1, -1, 100);
    CreateVehicle(456, 1361.2794, 1279.5198, 10.8264, 90.0000, -1, -1, 100);
    CreateVehicle(456, 1361.2794, 1285.4685, 10.8264, 90.0000, -1, -1, 100);
    CreateVehicle(456, 1361.2794, 1291.7173, 10.8264, 90.0000, -1, -1, 100);
    CreateVehicle(456, 1361.2794, 1297.4829, 10.8264, 90.0000, -1, -1, 100);
	//
	new bolka, tmpobjid;
    bolka = CreateDynamicObject(6959, -1778.633179, -2004.733887, 1499.816528, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 12853, "cunte_gas01", "sw_floor1", 0xFFFFFFFF);
    bolka = CreateDynamicObject(6959, -1737.289673, -2004.733887, 1499.816528, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 12853, "cunte_gas01", "sw_floor1", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1796, -1753.093750, -2018.001221, 1499.785278, -0.000007, -0.000007, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1796, -1754.246460, -2018.233154, 1499.785278, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1796, -1754.246460, -2016.002563, 1499.785278, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    CreateDynamicObject(2776, -1752.420654, -2015.897095, 1500.254883, -0.000014, 0.000000, -89.999954, -1, -1);
    bolka = CreateDynamicObject(1796, -1753.093750, -2015.770630, 1499.785278, -0.000007, -0.000007, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    CreateDynamicObject(2994, -1753.715332, -2019.303223, 1500.275757, 0.000000, 0.000000, 90.000000, -1, -1);
    bolka = CreateDynamicObject(1740, -1751.113770, -2017.000977, 1499.785278, -0.000007, -0.000007, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1740, -1756.226440, -2017.002808, 1499.785278, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19447, -1753.062134, -2020.074097, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1740, -1751.113770, -2019.231934, 1499.785278, -0.000007, -0.000007, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19446, -1753.062134, -2020.074097, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2256, -1755.729736, -2019.967163, 1502.304810, 0.000000, -0.000022, 179.999863, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2266, "picture_frame", "CJ_PAINTING3", 0);
    bolka = CreateDynamicObject(2256, -1751.531128, -2019.967163, 1502.304810, 0.000000, -0.000022, 179.999863, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2266, "picture_frame", "CJ_PAINTING28", 0);
    bolka = CreateDynamicObject(1740, -1751.113770, -2014.793823, 1499.785278, 0.000000, -0.000007, -90.000015, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1796, -1754.246460, -2013.782715, 1499.785278, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    CreateDynamicObject(2813, -1757.399292, -2017.052979, 1500.581177, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1740, -1756.226440, -2014.771851, 1499.785278, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1796, -1753.093750, -2013.561523, 1499.785278, 0.000000, -0.000007, -90.000015, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2017.088379, 1500.885132, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2017.088379, 1502.034790, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2018.122681, 1501.866699, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19325, -1757.893555, -2015.916626, 1501.082764, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1340, "foodkarts", "dogcart06", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19903, -1757.333008, -2019.443481, 1499.747192, 0.000000, 0.000000, 15.600002, -1, -1);
    bolka = CreateDynamicObject(1897, -1757.909180, -2018.122681, 1499.725464, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2015.873047, 1501.866699, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.885254, -2019.138062, 1500.885132, 0.000000, -0.000018, 179.999908, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2015.873047, 1499.725464, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.885254, -2019.138062, 1502.034790, 0.000000, -0.000018, 179.999908, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2018.122681, 1503.018555, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2015.873047, 1503.018555, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2014.839966, 1500.885132, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2014.839966, 1502.034790, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1997, -1758.654541, -2017.321899, 1499.774048, 0.000000, 0.000000, -178.499908, -1, -1);
    bolka = CreateDynamicObject(19428, -1757.901245, -2020.065674, 1502.415405, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1757.911255, -2020.065674, 1502.415405, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1740, -1751.113770, -2012.572388, 1499.785278, 0.000000, -0.000007, -90.000015, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19427, -1757.901245, -2020.065674, 1498.917725, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1749.488037, -2020.326050, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2013.640259, 1501.866699, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2013.640259, 1499.725464, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1757.905151, -2015.883057, 1504.900879, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2013.640259, 1503.018555, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(2776, -1752.420654, -2011.456299, 1500.254883, -0.000014, 0.000000, -89.999954, -1, -1);
    CreateDynamicObject(2813, -1749.910034, -2012.583496, 1500.581177, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1796, -1753.093750, -2011.341675, 1499.785278, 0.000000, -0.000007, -90.000015, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(19903, -1757.333008, -2012.373413, 1499.747192, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1757.909180, -2012.654541, 1500.885132, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2012.654541, 1502.034790, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(1726, -1759.351074, -2020.141968, 1499.745239, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(19428, -1757.901245, -2011.727783, 1502.415405, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1757.911255, -2011.727783, 1502.415405, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1757.901245, -2011.727783, 1498.917725, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1757.911255, -2011.727783, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1740, -1751.113770, -2010.341431, 1499.785278, 0.000000, -0.000007, -90.000015, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(1726, -1760.879517, -2014.713501, 1499.745239, -0.000007, 0.000000, -89.999977, -1, -1);
    bolka = CreateDynamicObject(1499, -1757.904175, -2010.768799, 1499.748779, 0.000009, 0.000000, 89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 18029, "genintintsmallrest", "GB_restaursmll12", 0);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll11", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19446, -1749.488037, -2010.696411, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1796, -1753.093750, -2009.111084, 1499.785278, 0.000000, -0.000007, -90.000015, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    SetDynamicObjectMaterial(bolka, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0);
    bolka = CreateDynamicObject(19384, -1757.908569, -2010.032959, 1501.514648, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    CreateDynamicObject(1726, -1755.771240, -2008.902100, 1499.745239, 0.000000, 0.000000, 360.000000, -1, -1);
    bolka = CreateDynamicObject(19370, -1757.904175, -2009.970581, 1504.146362, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1757.910278, -2009.970581, 1504.146362, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2256, -1754.728882, -2008.407593, 1502.304810, 0.000000, -0.000022, 359.999878, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2266, "picture_frame", "CJ_PAINTING3", 0);
    bolka = CreateDynamicObject(19447, -1753.032104, -2008.290161, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2315, -1762.696167, -2016.420044, 1499.693604, 0.000007, 0.000000, 89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19786, -1751.651733, -2008.363403, 1502.294312, 0.000014, -0.000007, 359.999878, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 6354, "sunset03_law2", "billLA02", 0);
    CreateDynamicObject(2813, -1762.692749, -2015.610229, 1500.186157, 0.000000, 0.000000, 111.400002, -1, -1);
    bolka = CreateDynamicObject(19446, -1753.032104, -2008.290161, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2010, -1757.401245, -2008.846924, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2200, -1755.519165, -2008.098145, 1499.785278, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2010, -1762.692261, -2020.057617, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2268, -1753.382324, -2007.681641, 1501.705078, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 2670, "proc_rub", "CJ_CERT_1", 0);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(2268, -1754.132446, -2007.681641, 1501.705078, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 2670, "proc_rub", "CJ_CERT_1", 0);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(2268, -1752.612061, -2007.681641, 1501.705078, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 2670, "proc_rub", "CJ_CERT_1", 0);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    CreateDynamicObject(14438, -1745.678467, -2014.208252, 1505.732056, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(19445, -1762.778564, -2020.874634, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19428, -1757.901245, -2008.305908, 1502.415405, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1757.911255, -2008.305908, 1502.415405, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1762.778564, -2020.874634, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1757.901245, -2008.305908, 1498.917725, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1757.911255, -2008.305908, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2010, -1750.131714, -2007.756958, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(1714, -1753.409180, -2006.948242, 1499.757813, 0.000000, 0.000000, 180.000000, -1, -1);
    CreateDynamicObject(1727, -1763.204590, -2013.200317, 1499.736938, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19445, -1762.778564, -2020.864624, 1504.755127, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14498, "imm_rooms", "venetian_blind", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.885254, -2007.378296, 1500.885132, 0.000000, -0.000018, 179.999863, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.885254, -2007.378296, 1502.034790, 0.000000, -0.000018, 179.999863, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(1726, -1764.161865, -2020.141968, 1499.745239, 0.000000, 0.000000, 180.000000, -1, -1);
    CreateDynamicObject(1726, -1764.580566, -2016.723267, 1499.745239, 0.000007, 0.000000, 89.999977, -1, -1);
    bolka = CreateDynamicObject(1897, -1757.909180, -2006.362915, 1501.866699, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1964, -1753.977661, -2005.526611, 1500.705688, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 6, 19480, "signsurf", "sign", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2006.362915, 1499.725464, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19893, -1753.469482, -2005.412598, 1500.554932, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2006.362915, 1503.018555, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2207, -1754.413696, -2005.362427, 1499.785278, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2005.328613, 1500.885132, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2005.328613, 1502.034790, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(19071, -1748.395752, -2006.346436, 1505.136963, 0.000000, 90.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2208, -1754.399048, -2004.321777, 1499.695190, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2208, -1752.519287, -2004.321777, 1499.695190, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(3440, -1762.713867, -2007.634766, 1501.798218, 0.000014, 0.000007, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1560, "7_11_door", "cj_sheetmetal2", 0);
    CreateDynamicObject(14438, -1762.668091, -2008.529541, 1505.732056, 0.000000, 0.000000, 90.000000, -1, -1);
    CreateDynamicObject(2776, -1755.953613, -2004.045288, 1500.254883, -0.000014, 0.000007, 89.999985, -1, -1);
    CreateDynamicObject(2776, -1750.961426, -2004.045166, 1500.254883, -0.000014, 0.000000, -89.999954, -1, -1);
    bolka = CreateDynamicObject(19325, -1757.893555, -2004.156860, 1501.082764, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1340, "foodkarts", "dogcart06", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2004.113281, 1501.866699, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2004.113281, 1499.725464, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2004.113281, 1503.018555, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2059, -1754.531250, -2003.074341, 1500.575073, 0.000000, 0.000000, 86.500008, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 2670, "proc_rub", "CJ_CERT_1", 0);
    SetDynamicObjectMaterial(bolka, 1, 2670, "proc_rub", "CJ_CERT_1", 0);
    SetDynamicObjectMaterial(bolka, 0, 2670, "proc_rub", "CJ_CERT_1", 0);
    bolka = CreateDynamicObject(19447, -1757.905151, -2004.123291, 1504.900879, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2776, -1755.953613, -2002.975586, 1500.254883, -0.000014, 0.000007, 89.999985, -1, -1);
    CreateDynamicObject(2776, -1750.961426, -2002.944336, 1500.254883, -0.000014, 0.000000, -89.999954, -1, -1);
    bolka = CreateDynamicObject(19893, -1752.468506, -2002.562134, 1500.554932, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2003.080200, 1500.885132, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2003.080200, 1502.034790, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1997, -1758.545532, -2003.159668, 1499.774048, 0.000000, 0.000000, 4.500090, -1, -1);
    CreateDynamicObject(3657, -1762.062012, -2004.331177, 1500.290649, 0.000000, 0.000000, 90.000000, -1, -1);
    CreateDynamicObject(2776, -1755.953613, -2001.874756, 1500.254883, -0.000014, 0.000007, 89.999985, -1, -1);
    bolka = CreateDynamicObject(3440, -1769.163940, -2015.744507, 1501.798218, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1560, "7_11_door", "cj_sheetmetal2", 0);
    CreateDynamicObject(2776, -1750.961426, -2001.874634, 1500.254883, -0.000014, 0.000000, -89.999954, -1, -1);
    bolka = CreateDynamicObject(19447, -1767.671143, -2024.298096, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(6959, -1749.542969, -2002.355103, 1504.125610, 90.000000, 90.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19446, -1767.671143, -2024.298096, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(11714, -1769.405640, -2019.465698, 1501.031250, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3902, "libertyhi3", "shopdoor3_64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19786, -1762.728394, -2004.328247, 1502.894897, 0.000007, 0.000000, 89.999977, -1, -1);
    bolka = CreateDynamicObject(19786, -1762.728394, -2004.328247, 1502.894897, -0.000007, 0.000000, -89.999977, -1, -1);
    CreateDynamicObject(2773, -1762.697510, -2004.365479, 1503.624878, 0.000000, 180.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1757.909180, -2001.880493, 1501.866699, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2001.880493, 1499.725464, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2001.880493, 1503.018555, 89.999992, 90.000000, -89.999969, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(3657, -1763.282959, -2004.331177, 1500.290649, 0.000000, 0.000000, 270.000000, -1, -1);
    CreateDynamicObject(1892, -1769.936035, -2019.022095, 1499.775269, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2207, -1752.563354, -2000.693481, 1499.785278, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2441, -1769.383911, -2011.921143, 1499.749756, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    CreateDynamicObject(2776, -1769.701904, -2012.786133, 1500.254883, -0.000014, 0.000000, -89.999954, -1, -1);
    bolka = CreateDynamicObject(19428, -1767.674072, -2008.305664, 1502.415405, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1767.684082, -2008.305664, 1502.415405, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1767.674072, -2008.305664, 1498.917725, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1749.488037, -2001.066040, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1757.909180, -2000.894775, 1500.885132, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1757.909180, -2000.894775, 1502.034790, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.658081, -2007.378052, 1500.885132, 0.000000, -0.000090, 179.999451, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.658081, -2007.378052, 1502.034790, 0.000000, -0.000090, 179.999451, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1964, -1769.980103, -2011.706177, 1500.945923, 0.000000, 0.000000, 360.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 6, 19480, "signsurf", "sign", 0);
    CreateDynamicObject(14438, -1745.678467, -2002.298096, 1505.732056, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(2441, -1770.380859, -2011.921143, 1499.749756, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2006.362671, 1501.866699, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2006.362671, 1499.725464, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19428, -1757.901245, -1999.968018, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1757.911255, -1999.968018, 1502.415405, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1767.682007, -2006.362671, 1503.018555, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2161, -1769.609009, -2009.118408, 1501.093750, -0.000007, 0.000022, -0.000007, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19427, -1757.901245, -1999.968018, 1498.917725, 0.000000, 0.000018, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1757.911255, -1999.968018, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2161, -1769.609009, -2009.118408, 1499.763672, -0.000007, 0.000022, -0.000007, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2776, -1753.473389, -1999.184082, 1500.254883, -0.000014, 0.000007, 360.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1767.682007, -2005.328369, 1500.885132, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(3440, -1762.713867, -2001.214233, 1501.798218, 0.000014, 0.000007, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1560, "7_11_door", "cj_sheetmetal2", 0);
    bolka = CreateDynamicObject(1897, -1767.682007, -2005.328369, 1502.034790, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2441, -1771.378052, -2011.921143, 1499.749756, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    CreateDynamicObject(1714, -1770.831177, -2010.318481, 1499.757813, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19893, -1771.649902, -2011.881592, 1500.795166, 0.000000, 0.000000, 156.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 10765, "airportgnd_sfse", "black64", 0);
    CreateDynamicObject(3657, -1772.421753, -2015.641968, 1500.290649, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(11714, -1772.406616, -2019.465698, 1501.031250, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3902, "libertyhi3", "shopdoor3_64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19786, -1772.392090, -2015.753052, 1502.894897, 0.000014, -0.000007, 179.999878, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 6354, "sunset03_law2", "billLA02", 0);
    bolka = CreateDynamicObject(19786, -1772.392090, -2015.753052, 1502.894897, -0.000014, 0.000007, 0.000014, -1, -1);
    bolka = CreateDynamicObject(19477, -1771.851929, -2012.234497, 1500.425903, -0.000014, 0.000000, -89.999954, -1, -1);
    SetDynamicObjectMaterialText(bolka, 0, "SAN ANDREAS", 130, "Ariel", 50, 1, 0xFF000000, 0, 1);
    CreateDynamicObject(2131, -1770.376221, -2008.487549, 1499.775269, 0.000000, 0.000000, 180.000000, -1, -1);
    CreateDynamicObject(2773, -1772.354858, -2015.722168, 1503.624878, 0.000007, 180.000000, 89.999947, -1, -1);
    bolka = CreateDynamicObject(19447, -1772.406616, -2019.562622, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(11711, -1772.395874, -2019.478394, 1502.723145, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19446, -1772.406616, -2019.562622, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19325, -1767.666382, -2004.156616, 1501.082764, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1340, "foodkarts", "dogcart06", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2004.113037, 1501.866699, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2004.113037, 1499.725464, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2004.113037, 1503.018555, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19384, -1757.907349, -1998.251343, 1501.514648, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(2441, -1772.375977, -2011.921143, 1499.749756, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1767.677979, -2004.123047, 1504.900879, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1757.906250, -1998.224243, 1504.146362, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1757.908203, -1998.221313, 1504.146362, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2441, -1770.382813, -2006.485840, 1499.749756, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2003.079956, 1500.885132, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2003.079956, 1502.034790, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19326, -1755.466431, -1997.332520, 1501.223389, 11.700009, -0.000009, -179.999908, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14853, "gen_pol_vegas", "mp_cop_whiteboard", 0);
    bolka = CreateDynamicObject(19087, -1754.916504, -1997.210693, 1501.718018, -11.700009, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3080, "adjumpx", "gen_chrome", 0);
    bolka = CreateDynamicObject(19087, -1754.916504, -1997.209106, 1501.702881, 12.099987, 0.000012, -0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3080, "adjumpx", "gen_chrome", 0);
    CreateDynamicObject(2425, -1770.765625, -2006.643311, 1500.787842, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(19087, -1756.007568, -1997.210693, 1501.718018, -11.700009, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3080, "adjumpx", "gen_chrome", 0);
    bolka = CreateDynamicObject(19087, -1756.007568, -1997.209106, 1501.702881, 12.099987, 0.000012, -0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3080, "adjumpx", "gen_chrome", 0);
    bolka = CreateDynamicObject(19477, -1773.291748, -2012.234497, 1500.425903, -0.000014, 0.000000, -89.999954, -1, -1);
    SetDynamicObjectMaterialText(bolka, 0, "HOSPITAL", 130, "Ariel", 50, 1, 0xFF000000, 0, 1);
    bolka = CreateDynamicObject(19893, -1773.231323, -2011.965942, 1500.795166, 0.000000, 0.000000, -154.599991, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(19327, -1772.412842, -2009.153687, 1501.684204, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14842, "genintintpolicea", "cop_notice", 0);
    bolka = CreateDynamicObject(2441, -1773.369751, -2011.921143, 1499.749756, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1772.406616, -2009.021729, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1772.406616, -2009.021729, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(1808, -1753.944580, -1996.688843, 1499.785278, 0.000000, 0.000000, 360.000000, -1, -1);
    CreateDynamicObject(2425, -1771.345703, -2006.643311, 1500.787842, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(2204, -1752.447266, -1996.573853, 1499.771240, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2417, -1772.446045, -2008.523926, 1499.785278, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(2010, -1757.391357, -1996.867432, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2441, -1771.382690, -2006.485840, 1499.749756, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    bolka = CreateDynamicObject(6959, -1737.289673, -2004.733887, 1504.156860, 0.000000, 0.000014, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2001.880249, 1501.866699, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1767.682007, -2001.880249, 1499.725464, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1753.064087, -1996.410645, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1767.682007, -2001.880249, 1503.018555, 89.999992, 90.000137, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19786, -1751.476196, -1996.489258, 1502.894897, 0.000007, 0.000000, 359.999969, -1, -1);
    bolka = CreateDynamicObject(19446, -1753.064087, -1996.410645, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2776, -1769.701904, -2003.636719, 1500.254883, -0.000007, 0.000000, -89.999977, -1, -1);
    bolka = CreateDynamicObject(1964, -1774.060303, -2011.706177, 1500.945923, 0.000000, 0.000000, 360.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 6, 19480, "signsurf", "sign", 0);
    CreateDynamicObject(2776, -1770.521851, -2004.487061, 1500.254883, 0.000000, -0.000007, 179.999954, -1, -1);
    CreateDynamicObject(1514, -1772.023926, -2006.422241, 1500.916138, 0.000000, 0.000000, 900.000000, -1, -1);
    bolka = CreateDynamicObject(2256, -1773.270996, -2008.907471, 1502.304810, 0.000000, 0.000000, 540.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2645, "cj_piz_sign", "CJ_PIZZA_MEN3", 0);
    bolka = CreateDynamicObject(2441, -1774.368286, -2011.921143, 1499.749756, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    CreateDynamicObject(1808, -1758.175171, -1996.298584, 1499.785278, 0.000000, 0.000000, 270.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1767.682007, -2000.894531, 1500.885132, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(1714, -1774.021362, -2010.318481, 1499.757813, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1767.682007, -2000.894531, 1502.034790, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2441, -1772.382813, -2006.485840, 1499.749756, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    CreateDynamicObject(2417, -1773.436157, -2008.523926, 1499.785278, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(2644, -1770.553467, -2003.696411, 1500.182373, 0.000000, 0.000007, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 4, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 3, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2776, -1774.942749, -2012.786133, 1500.254883, -0.000014, 0.000000, 90.000046, -1, -1);
    bolka = CreateDynamicObject(11714, -1775.406128, -2019.465698, 1501.031250, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3902, "libertyhi3", "shopdoor3_64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(3440, -1775.584473, -2015.744507, 1501.798218, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1560, "7_11_door", "cj_sheetmetal2", 0);
    CreateDynamicObject(2776, -1770.521851, -2002.816528, 1500.254883, 0.000000, 0.000007, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19428, -1767.674072, -1999.967773, 1502.415405, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1767.684082, -1999.967773, 1502.415405, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2776, -1771.313354, -2003.636719, 1500.254883, 0.000007, 0.000000, 89.999977, -1, -1);
    CreateDynamicObject(19071, -1772.604370, -2006.189209, 1505.136963, 0.000000, 0.000000, 90.000000, -1, -1);
    CreateDynamicObject(1892, -1775.896973, -2019.022095, 1499.775269, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19427, -1767.674072, -1999.967773, 1498.917725, 0.000000, 0.000090, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19326, -1767.774902, -1999.958984, 1502.295166, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 2645, "cj_piz_sign", "CJ_PIZZA_MEN1", 0);
    bolka = CreateDynamicObject(19427, -1767.684082, -1999.967773, 1498.917725, 0.000000, 0.000098, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2441, -1775.367676, -2011.921143, 1499.749756, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2441, -1773.380493, -2006.485840, 1499.749756, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    CreateDynamicObject(1513, -1773.596313, -2006.410278, 1501.075684, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(1499, -1767.660400, -1999.005249, 1499.748779, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 18029, "genintintsmallrest", "GB_restaursmll12", 0);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll11", 0xFFFFFFFF);
    CreateDynamicObject(1514, -1774.194092, -2006.422241, 1500.916138, 0.000000, 0.000000, 900.000000, -1, -1);
    bolka = CreateDynamicObject(2161, -1775.509888, -2009.118408, 1501.093750, -0.000007, 0.000037, -0.000007, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2161, -1775.509888, -2009.118408, 1499.763672, -0.000007, 0.000037, -0.000007, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2441, -1774.375854, -2006.485840, 1499.749756, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 3, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0);
    SetDynamicObjectMaterial(bolka, 2, 2423, "cj_ff_counters", "CJ_worktop", 0);
    SetDynamicObjectMaterial(bolka, 1, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFD3D3D3);
    SetDynamicObjectMaterial(bolka, 0, 9583, "bigshap_sfw", "bridge_walls3_sfw", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2256, -1775.531616, -2008.907471, 1502.304810, 0.000000, 0.000000, 540.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2645, "cj_piz_sign", "CJ_PIZZA_MEN2", 0);
    CreateDynamicObject(2776, -1770.521851, -2000.826416, 1500.254883, 0.000000, -0.000014, 179.999908, -1, -1);
    CreateDynamicObject(2776, -1769.701904, -1999.976074, 1500.254883, -0.000014, 0.000000, -89.999954, -1, -1);
    bolka = CreateDynamicObject(19384, -1767.678589, -1998.263306, 1501.514648, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(19445, -1762.796021, -1995.274780, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19370, -1767.675415, -1998.207764, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1767.681396, -1998.207764, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1762.796021, -1995.274780, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19445, -1762.796021, -1995.344849, 1504.735840, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14498, "imm_rooms", "venetian_blind", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2663, -1770.599243, -2000.147461, 1500.830933, 0.000000, 0.000000, 28.999996, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 2767, "cb_details", "wrapper_cb", 0);
    CreateDynamicObject(2776, -1773.532593, -2003.636719, 1500.254883, 0.000000, 0.000000, 270.000000, -1, -1);
    bolka = CreateDynamicObject(2644, -1770.553467, -2000.035767, 1500.182373, 0.000000, 0.000014, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 4, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 3, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2776, -1774.352539, -2004.487061, 1500.254883, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(19447, -1777.140747, -2024.296143, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1777.140747, -2024.296143, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2776, -1771.313354, -1999.976074, 1500.254883, 0.000014, 0.000000, 89.999954, -1, -1);
    CreateDynamicObject(2776, -1770.521851, -1999.155884, 1500.254883, 0.000000, 0.000014, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2644, -1774.384155, -2003.696411, 1500.182373, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 4, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 3, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2663, -1774.382080, -2003.656738, 1500.830933, 0.000000, 0.000000, -47.600002, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 2767, "cb_details", "wrapper_cb", 0);
    CreateDynamicObject(1726, -1778.592407, -2020.141968, 1499.745239, 0.000000, -0.000007, 179.999954, -1, -1);
    bolka = CreateDynamicObject(19447, -1757.901245, -1992.492310, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19447, -1757.911255, -1992.492310, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1777.134644, -2008.305664, 1502.415405, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1777.144653, -2008.305664, 1502.415405, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1757.901245, -1992.492310, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1757.911255, -1992.492310, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1777.134644, -2008.305664, 1498.917725, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2776, -1774.352539, -2002.816528, 1500.254883, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(2776, -1775.144043, -2003.636719, 1500.254883, 0.000000, 0.000000, 450.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1777.118652, -2007.378052, 1500.885132, 0.000000, -0.000070, 179.999588, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.118652, -2007.378052, 1502.034790, 0.000000, -0.000070, 179.999588, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1766.762085, -1995.141113, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19447, -1766.762085, -1995.121094, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1766.762085, -1995.141113, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1766.762085, -1995.121094, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1777.142578, -2006.362671, 1501.866699, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2006.362671, 1499.725464, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2006.362671, 1503.018555, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(2776, -1773.491577, -1999.976074, 1500.254883, -0.000029, 0.000000, -89.999908, -1, -1);
    bolka = CreateDynamicObject(1897, -1777.142578, -2005.328369, 1500.885132, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2005.328369, 1502.034790, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(2776, -1774.311523, -2000.826416, 1500.254883, 0.000000, -0.000029, 179.999817, -1, -1);
    CreateDynamicObject(1775, -1769.030396, -1995.692017, 1500.865479, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(1726, -1780.030518, -2014.713501, 1499.745239, 0.000000, 0.000000, 630.000000, -1, -1);
    CreateDynamicObject(10830, -1772.836914, -1998.736938, 1503.167603, 0.000000, 0.000000, 45.000011, -1, -1);
    CreateDynamicObject(10830, -1772.836914, -1998.736938, 1503.167603, 0.000000, 0.000000, -44.999989, -1, -1);
    bolka = CreateDynamicObject(19325, -1777.126953, -2004.156616, 1501.082764, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1340, "foodkarts", "dogcart06", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2004.113037, 1501.866699, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2644, -1774.343140, -2000.035767, 1500.182373, 0.000000, 0.000029, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 5, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 4, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 3, 14652, "ab_trukstpa", "CJ_WOOD6", 0);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1897, -1777.142578, -2004.113037, 1499.725464, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2004.113037, 1503.018555, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1777.138550, -2004.123047, 1504.900879, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19326, -1769.736450, -1995.240234, 1502.905762, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1455, "cj_bar", "CJ_SK_Bar", 0);
    CreateDynamicObject(1776, -1770.368774, -1995.604614, 1500.831787, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1777.142578, -2003.079956, 1500.885132, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2003.079956, 1502.034790, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(2776, -1774.311523, -1999.155884, 1500.254883, 0.000000, 0.000029, 0.000000, -1, -1);
    CreateDynamicObject(2776, -1775.103027, -1999.976074, 1500.254883, 0.000029, 0.000000, 89.999908, -1, -1);
    bolka = CreateDynamicObject(2256, -1769.940796, -1994.977661, 1501.934570, 0.000000, 0.000000, 540.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2670, "proc_rub", "CJ_CERT_3", 0);
    bolka = CreateDynamicObject(2164, -1767.797852, -1993.557983, 1499.756714, 0.000000, 0.000000, 270.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2776, -1769.941284, -1994.706055, 1500.254883, 0.000000, 0.000014, 180.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1777.142578, -2001.880249, 1501.866699, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2001.880249, 1499.725464, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(6959, -1778.633179, -2004.733887, 1504.156860, 0.000000, 0.000014, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3621, "dockcargo1_las", "dt_ceiling1", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2001.880249, 1503.018555, 89.999992, 90.000092, -89.999962, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(19859, -1767.770996, -1992.841309, 1501.023438, 0.000000, 0.000000, 90.000000, -1, -1);
    bolka = CreateDynamicObject(2315, -1781.847168, -2016.420044, 1499.693604, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2824, -1781.843872, -2015.669067, 1500.190796, 0.000000, 0.000000, 79.900009, -1, -1);
    bolka = CreateDynamicObject(2010, -1781.942993, -2020.057617, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2185, -1769.192383, -1993.452759, 1499.775269, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19447, -1767.674072, -1992.490845, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19447, -1767.684082, -1992.490845, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1767.674072, -1992.490845, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1767.684082, -1992.490845, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2059, -1769.574951, -1993.486694, 1500.605103, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 2670, "proc_rub", "CJ_CERT_1", 0);
    SetDynamicObjectMaterial(bolka, 1, 2670, "proc_rub", "CJ_CERT_1", 0);
    SetDynamicObjectMaterial(bolka, 0, 2670, "proc_rub", "CJ_CERT_1", 0);
    bolka = CreateDynamicObject(1897, -1777.142578, -2000.894531, 1500.885132, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19445, -1782.038086, -2020.894653, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1777.142578, -2000.894531, 1502.034790, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19445, -1781.878174, -2020.864624, 1504.755127, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14498, "imm_rooms", "venetian_blind", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19446, -1782.038086, -2020.894653, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(1727, -1782.335327, -2013.200317, 1499.736938, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19384, -1772.497437, -1995.134644, 1501.514648, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(19428, -1777.134644, -1999.967773, 1502.415405, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1777.144653, -1999.967773, 1502.415405, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1777.134644, -1999.967773, 1498.917725, 0.000000, 0.000070, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1777.144653, -1999.967773, 1498.917725, 0.000000, 0.000098, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1772.566528, -1995.135254, 1504.146362, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1772.566528, -1995.127319, 1504.146362, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(3440, -1781.873779, -2007.634766, 1501.798218, 0.000022, 0.000007, 89.999901, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1560, "7_11_door", "cj_sheetmetal2", 0);
    CreateDynamicObject(1726, -1783.403198, -2020.141968, 1499.745239, 0.000000, -0.000007, 179.999954, -1, -1);
    CreateDynamicObject(14438, -1781.938354, -2008.529541, 1505.732056, 0.000000, 0.000000, 90.000000, -1, -1);
    CreateDynamicObject(2776, -1770.742065, -1992.565430, 1500.254883, 0.000000, 0.000014, 90.000000, -1, -1);
    CreateDynamicObject(1726, -1783.731567, -2016.723267, 1499.745239, 0.000000, 0.000000, 450.000000, -1, -1);
    bolka = CreateDynamicObject(19384, -1777.140015, -1998.263306, 1501.514648, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(19370, -1777.138184, -1998.330933, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1777.142212, -1998.330933, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(3657, -1781.302979, -2004.331177, 1500.290649, 0.000007, 0.000000, 89.999977, -1, -1);
    bolka = CreateDynamicObject(2200, -1774.609985, -1994.906616, 1499.785278, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1499, -1777.148560, -1997.485229, 1499.748779, 0.000000, 0.000000, -90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 18029, "genintintsmallrest", "GB_restaursmll12", 0);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll11", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2161, -1767.789551, -1989.958374, 1501.093750, 0.000000, 0.000000, 270.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2161, -1767.789551, -1989.958374, 1499.763672, 0.000000, 0.000000, 270.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2256, -1775.231323, -1995.257202, 1502.304810, 0.000000, 0.000000, 360.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2645, "cj_piz_sign", "CJ_PIZZA_MENU1", 0);
    CreateDynamicObject(11738, -1774.964722, -1994.711060, 1501.715088, 0.000000, 0.000000, 26.900002, -1, -1);
    bolka = CreateDynamicObject(19786, -1781.870117, -2004.288208, 1502.894897, 0.000000, 0.000000, 450.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 6354, "sunset03_law2", "SunBillB06", 0);
    bolka = CreateDynamicObject(19786, -1781.870117, -2004.288208, 1502.894897, 0.000000, 0.000000, 270.000000, -1, -1);
    CreateDynamicObject(2773, -1781.839233, -2004.325439, 1503.624878, 0.000000, 180.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2001, -1776.627319, -1995.633911, 1499.760376, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(3657, -1782.523926, -2004.331177, 1500.290649, -0.000007, 0.000000, -89.999977, -1, -1);
    CreateDynamicObject(1808, -1777.416748, -1996.327026, 1499.785278, 0.000000, 0.000000, 270.000000, -1, -1);
    bolka = CreateDynamicObject(3440, -1781.873779, -2001.214233, 1501.798218, 0.000022, 0.000007, 89.999901, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1560, "7_11_door", "cj_sheetmetal2", 0);
    CreateDynamicObject(2372, -1770.230469, -1989.321411, 1499.730103, 0.000000, 0.000000, 90.000000, -1, -1);
    CreateDynamicObject(2394, -1770.821411, -1989.524292, 1500.429810, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19447, -1778.270752, -1995.141113, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2017.088379, 1500.885132, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19325, -1786.765137, -2015.916626, 1501.082764, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1340, "foodkarts", "dogcart06", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1778.270752, -1995.121094, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2017.088379, 1502.034790, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2018.122681, 1501.866699, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.756836, -2019.138062, 1500.885132, 0.000000, -0.000009, 179.999954, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2018.122681, 1499.725464, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2015.873047, 1501.866699, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19446, -1778.270752, -1995.141113, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1786.756836, -2019.138062, 1502.034790, 0.000000, -0.000009, 179.999954, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19446, -1778.270752, -1995.121094, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2015.873047, 1499.725464, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2018.122681, 1503.018555, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2015.873047, 1503.018555, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2014.839966, 1500.885132, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2014.839966, 1502.034790, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19428, -1786.772827, -2020.065674, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1819, -1775.169556, -1991.915283, 1499.785278, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19428, -1786.782837, -2020.065674, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1786.772827, -2020.065674, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2855, -1774.671143, -1991.427612, 1500.285645, 0.000000, 0.000000, -46.799995, -1, -1);
    bolka = CreateDynamicObject(1897, -1786.780762, -2013.640259, 1501.866699, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2013.640259, 1499.725464, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1786.776733, -2015.883057, 1504.900879, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2013.640259, 1503.018555, 89.999992, 89.999992, -89.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2012.654541, 1500.885132, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2012.654541, 1502.034790, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19428, -1786.772827, -2011.727783, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1786.782837, -2011.727783, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1786.772827, -2011.727783, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1786.782837, -2011.727783, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(1726, -1776.402710, -1992.389771, 1499.745239, 0.000000, 0.000000, 450.000000, -1, -1);
    CreateDynamicObject(2813, -1787.293579, -2014.742920, 1500.581177, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1499, -1786.775757, -2010.768799, 1499.748779, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 18029, "genintintsmallrest", "GB_restaursmll12", 0);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll11", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19384, -1786.780151, -2010.032959, 1501.514648, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(19445, -1772.309326, -1988.887573, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19446, -1772.309326, -1988.887573, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1786.775757, -2009.970581, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1786.781860, -2009.970581, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19903, -1787.314087, -2012.063599, 1499.747192, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(19445, -1772.355835, -1988.942505, 1504.885742, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14498, "imm_rooms", "venetian_blind", 0xFFFFFFFF);
    bolka = CreateDynamicObject(19447, -1777.134644, -1992.490845, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19447, -1777.144653, -1992.490845, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1777.134644, -1992.490845, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1777.144653, -1992.490845, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1997, -1785.796509, -2005.534912, 1499.774048, 0.000000, 0.000000, 174.800049, -1, -1);
    bolka = CreateDynamicObject(19428, -1786.772827, -2008.305908, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1786.782837, -2008.305908, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1786.772827, -2008.305908, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1786.782837, -2008.305908, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1897, -1786.756836, -2007.378296, 1500.885132, 0.000000, -0.000009, 179.999908, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.756836, -2007.378296, 1502.034790, 0.000000, -0.000009, 179.999908, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2010, -1787.262939, -2008.796875, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1740, -1788.451294, -2016.992920, 1499.785278, -0.000007, -0.000007, -89.999985, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19327, -1777.022705, -1991.403442, 1501.994507, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14842, "genintintpolicea", "cop_notice", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2006.362915, 1501.866699, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2006.362915, 1499.725464, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1740, -1788.451294, -2014.761963, 1499.785278, -0.000007, -0.000007, -89.999985, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2006.362915, 1503.018555, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2256, -1788.461914, -2019.957153, 1502.304810, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2266, "picture_frame", "CJ_PAINTING28", 0);
    bolka = CreateDynamicObject(2010, -1787.412964, -2007.767822, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(1897, -1786.780762, -2005.328613, 1500.885132, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2005.328613, 1502.034790, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    CreateDynamicObject(1726, -1775.673096, -1989.539307, 1499.745239, 0.000000, 0.000000, 720.000000, -1, -1);
    bolka = CreateDynamicObject(19325, -1786.765137, -2004.156860, 1501.082764, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1340, "foodkarts", "dogcart06", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2004.113281, 1501.866699, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2004.113281, 1499.725464, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2004.113281, 1503.018555, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1997, -1785.864258, -2001.911621, 1499.774048, 0.000000, 0.000000, 9.200001, -1, -1);
    bolka = CreateDynamicObject(19447, -1786.776733, -2004.123291, 1504.900879, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19445, -1781.952271, -1995.274780, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2010, -1776.441895, -1989.586548, 1499.765259, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19446, -1781.952271, -1995.274780, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19445, -1781.952271, -1995.294800, 1504.366211, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14498, "imm_rooms", "venetian_blind", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2003.080200, 1500.885132, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2003.080200, 1502.034790, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2174, -1788.538818, -2007.668091, 1499.785278, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2001.880493, 1501.866699, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2001.880493, 1499.725464, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2001.880493, 1503.018555, 89.999992, 89.999992, -89.999977, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1796, -1790.431274, -2017.982056, 1499.785278, -0.000007, -0.000007, -89.999985, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1796, -1790.431274, -2015.762207, 1499.785278, -0.000007, -0.000007, -89.999985, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1897, -1786.780762, -2000.894775, 1500.885132, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1897, -1786.780762, -2000.894775, 1502.034790, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1796, -1790.431274, -2013.531616, 1499.785278, -0.000007, -0.000007, -89.999985, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    CreateDynamicObject(19859, -1790.631104, -2019.982422, 1501.023438, 0.000000, 0.000000, 180.000000, -1, -1);
    CreateDynamicObject(2343, -1788.814331, -2005.197998, 1500.365845, 0.000000, 0.000000, 147.999954, -1, -1);
    CreateDynamicObject(1714, -1789.181763, -2006.359741, 1499.757813, 0.000000, 0.000000, -3.399987, -1, -1);
    bolka = CreateDynamicObject(19786, -1789.841553, -2008.258667, 1502.804810, 0.000000, 0.000000, 540.000000, -1, -1);
    bolka = CreateDynamicObject(19428, -1786.772827, -1999.968018, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19428, -1786.782837, -1999.968018, 1502.415405, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1786.772827, -1999.968018, 1498.917725, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19427, -1786.782837, -1999.968018, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(11707, -1786.918213, -1999.947021, 1501.265259, 0.000000, 0.000000, 270.000000, -1, -1);
    bolka = CreateDynamicObject(2256, -1790.299561, -2008.427612, 1502.304810, 0.000000, -0.000022, 359.999878, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2266, "picture_frame", "CJ_PAINTING3", 0);
    bolka = CreateDynamicObject(19447, -1791.603149, -2020.074097, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1791.603149, -2020.074097, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19384, -1786.778931, -1998.251343, 1501.514648, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 10765, "airportgnd_sfse", "black64", 0);
    bolka = CreateDynamicObject(19370, -1786.775757, -1998.221313, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19370, -1786.779785, -1998.221313, 1504.146362, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(1369, -1785.810913, -1996.348511, 1500.365845, 0.000000, 0.000000, 80.999992, -1, -1);
    SetDynamicObjectMaterial(bolka, 5, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 4, 1714, "cj_office", "est_chair", 0);
    SetDynamicObjectMaterial(bolka, 3, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2164, -1790.965820, -2008.178101, 1499.785278, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(1726, -1791.281982, -2008.902100, 1499.745239, 0.000000, 0.000000, 360.000000, -1, -1);
    CreateDynamicObject(14438, -1772.438477, -1983.876587, 1505.732056, 0.000000, 0.000000, 270.000000, -1, -1);
    bolka = CreateDynamicObject(1796, -1792.354736, -2017.001221, 1499.785278, 0.000000, 0.000000, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1796, -1792.354736, -2019.231812, 1499.785278, 0.000000, 0.000000, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1796, -1792.354736, -2014.781372, 1499.785278, 0.000000, 0.000000, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(1796, -1792.354736, -2012.572266, 1499.785278, -0.000007, 0.000000, 89.999947, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(19447, -1791.603149, -2008.290161, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1791.603149, -2008.290161, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2887, -1789.021851, -2001.006348, 1505.209229, 270.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(2343, -1789.898804, -2002.219727, 1500.365845, 0.000000, 0.000000, 53.899963, -1, -1);
    bolka = CreateDynamicObject(1796, -1792.354736, -2010.341675, 1499.785278, -0.000007, 0.000000, 89.999947, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 1, 3132, "jt_doorx", "trolley02", 0);
    bolka = CreateDynamicObject(3386, -1787.395020, -1996.703857, 1499.785278, 0.000000, 0.000000, 540.000000, -1, -1);
    bolka = CreateDynamicObject(2146, -1791.316284, -2005.196655, 1500.055542, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0);
    bolka = CreateDynamicObject(2146, -1789.906494, -2000.236328, 1500.055542, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0);
    bolka = CreateDynamicObject(3386, -1788.425415, -1996.703857, 1499.785278, 0.000000, 0.000000, 270.000000, -1, -1);
    bolka = CreateDynamicObject(19786, -1793.031616, -2008.258667, 1502.804810, 0.000000, 0.000000, 540.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 6354, "sunset03_law2", "SunBillB06", 0);
    CreateDynamicObject(2007, -1793.102295, -2007.750854, 1499.777222, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(1740, -1794.334717, -2018.001465, 1499.785278, 0.000000, 0.000000, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(1740, -1794.334717, -2015.770508, 1499.785278, 0.000000, 0.000000, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(2256, -1794.391602, -2019.957153, 1502.304810, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2266, "picture_frame", "CJ_PAINTING3", 0);
    bolka = CreateDynamicObject(1740, -1794.334717, -2013.549072, 1499.785278, 0.000000, 0.000000, 89.999924, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19786, -1793.581421, -2008.388428, 1502.294312, 0.000000, 0.000000, 720.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 6354, "sunset03_law2", "SunBillB06", 0);
    bolka = CreateDynamicObject(19903, -1791.684814, -2002.153564, 1499.747192, 0.000000, 0.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(19447, -1786.772827, -1992.492310, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19447, -1786.782837, -1992.492310, 1502.415405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1786.772827, -1992.492310, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1786.782837, -1992.492310, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19325, -1791.165039, -1999.656250, 1499.351807, 0.000000, 0.000009, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 1340, "foodkarts", "dogcart06", 0xFFFFFFFF);
    bolka = CreateDynamicObject(1740, -1794.334717, -2009.110962, 1499.785278, -0.000007, 0.000000, 89.999947, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2343, -1793.564087, -2005.658081, 1500.365845, 0.000000, 0.000000, 23.200001, -1, -1);
    bolka = CreateDynamicObject(2273, -1789.986084, -1997.006470, 1501.165405, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 14599, "paperchasebits", "sign_firstaid", 0);
    SetDynamicObjectMaterial(bolka, 0, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2007, -1790.000732, -1996.947632, 1499.272217, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(2343, -1792.002441, -2000.513550, 1500.365845, 0.000000, 0.000000, 171.599945, -1, -1);
    bolka = CreateDynamicObject(2166, -1794.401855, -2007.741821, 1499.775269, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    CreateDynamicObject(2813, -1795.504639, -2015.802734, 1500.581177, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(1714, -1794.292603, -2006.670654, 1499.757813, 0.000000, 0.000000, -33.499989, -1, -1);
    CreateDynamicObject(2776, -1793.522095, -2003.856079, 1500.254883, -0.000014, 0.000000, 180.000046, -1, -1);
    bolka = CreateDynamicObject(19446, -1791.162720, -1998.160767, 1498.917725, 0.000000, 0.000000, 180.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19903, -1795.443970, -2011.373535, 1499.747192, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(19446, -1796.000244, -2020.326050, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2813, -1795.504639, -2009.132202, 1500.581177, 0.000000, 0.000000, 0.000000, -1, -1);
    bolka = CreateDynamicObject(2185, -1794.428101, -2004.217651, 1499.765259, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 2, 3440, "airportpillar", "metalic_64", 0);
    bolka = CreateDynamicObject(19446, -1796.000244, -2010.696411, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2146, -1793.446289, -2000.236328, 1500.055542, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 1, 3440, "airportpillar", "metalic_64", 0);
    SetDynamicObjectMaterial(bolka, 0, 2514, "cj_bathroom", "CJ_PILLOWCASE", 0);
    bolka = CreateDynamicObject(19447, -1791.603149, -1996.410645, 1502.415405, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(19446, -1791.603149, -1996.410645, 1498.917725, 0.000000, 0.000000, 90.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    CreateDynamicObject(2887, -1793.682251, -2001.006348, 1505.209229, 270.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(2131, -1792.777954, -1996.937012, 1499.775269, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(2776, -1795.561768, -2003.465698, 1500.254883, -0.000014, 0.000000, 450.000061, -1, -1);
    CreateDynamicObject(2343, -1794.939819, -1999.876343, 1500.365845, 0.000000, 0.000000, 3.399925, -1, -1);
    bolka = CreateDynamicObject(6959, -1795.893433, -2002.355103, 1504.125610, 90.000000, 90.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 18029, "genintintsmallrest", "GB_restaursmll10", 0xFFFFFFFF);
    bolka = CreateDynamicObject(2255, -1793.980225, -1997.002686, 1501.255371, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14853, "gen_pol_vegas", "mp_cop_whiteboard", 0);
    CreateDynamicObject(19071, -1796.987915, -2005.112671, 1505.136963, 0.000000, 90.000000, 180.000000, -1, -1);
    bolka = CreateDynamicObject(19446, -1796.000244, -2001.066040, 1498.917725, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14383, "burg_1", "hospital_wall2", 0);
    bolka = CreateDynamicObject(2255, -1794.940552, -1997.002686, 1501.255371, 0.000000, 0.000000, 0.000000, -1, -1);
    SetDynamicObjectMaterial(bolka, 0, 14853, "gen_pol_vegas", "mp_cop_pinboard", 0);
    CreateDynamicObject(2132, -1794.950562, -1996.943726, 1499.785278, 0.000000, 0.000000, 0.000000, -1, -1);
    CreateDynamicObject(14438, -1799.388306, -2014.168579, 1505.732056, 0.000000, 0.000000, 180.000000, -1, -1);
    CreateDynamicObject(14438, -1799.388306, -2002.288086, 1505.732056, 0.000000, 0.000000, 180.000000, -1, -1);
    //Dataran
    tmpobjid = CreateDynamicObject(18980, 2087.867431, 1510.764038, 9.771875, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2125.867431, 1522.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2150.867431, 1522.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2175.867431, 1522.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2200.867431, 1522.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2224.867431, 1522.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2236.867431, 1509.764038, 9.771875, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2236.867431, 1484.764038, 9.771875, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2236.867431, 1484.764038, 9.771875, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2087.867431, 1485.764038, 9.771875, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2087.867431, 1460.764038, 9.771875, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2087.867431, 1435.764038, 9.771875, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2087.867431, 1410.764038, 9.771875, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2087.867431, 1395.764038, 9.771875, 90.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2100.468017, 1383.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2125.468017, 1383.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2150.468017, 1383.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2175.468017, 1383.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2200.468017, 1383.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2224.867919, 1383.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2236.867919, 1396.764038, 9.771875, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2236.867919, 1421.764038, 9.771875, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2241.590087, 1456.485107, 9.620311, 0.000000, 96.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(19379, 2241.590087, 1454.085083, 9.620311, 0.000000, 96.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2155.340087, 1495.437011, 7.220314, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2161.340087, 1495.437011, 7.220314, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2166.239990, 1500.236938, 7.220314, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2161.440185, 1505.136962, 7.220314, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2155.440673, 1505.136962, 7.220314, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2150.539306, 1500.236938, 7.220314, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2160.940185, 1500.336914, 12.420312, 0.000000, 90.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2155.839599, 1500.336914, 12.420312, 0.000000, 90.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2155.440673, 1505.136962, 13.220314, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2161.440917, 1505.136962, 13.220314, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2155.839599, 1500.336914, 18.420312, 0.000000, 90.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(19378, 2161.039794, 1500.336914, 18.420312, 0.000000, 90.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 16093, "a51_ext", "ws_trans_concr", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2166.913085, 1494.736083, 6.506248, -27.000000, 0.000000, 46.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8480, "csrspalace01", "black32", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2150.913085, 1494.636108, 6.506248, -27.000000, 0.000000, -36.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 8480, "csrspalace01", "black32", 0x00000000);
    tmpobjid = CreateDynamicObject(19483, 2157.968505, 1505.015625, 16.506250, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterialText(tmpobjid, 0, "PENTAS", 40, "Ariel", 35, 1, 0xFFFF0000, 0x00000000, 0);
    tmpobjid = CreateDynamicObject(19483, 2160.968505, 1505.015625, 15.106250, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
    SetDynamicObjectMaterialText(tmpobjid, 0, "HYBRID", 40, "Ariel", 35, 1, 0xCC000000, 0x00000000, 0);
    tmpobjid = CreateDynamicObject(19481, 2142.436035, 1387.696044, 10.220314, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "H Y", 20, "Ariel", 20, 0, 0xFFFFF000, 0x00000000, 0);
    tmpobjid = CreateDynamicObject(19481, 2142.436035, 1387.696044, 10.220314, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterialText(tmpobjid, 0, "H Y", 20, "Ariel", 20, 0, 0xFFFFF000, 0x00000000, 0);
    tmpobjid = CreateDynamicObject(18980, 2236.867919, 1436.764038, 9.771875, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    tmpobjid = CreateDynamicObject(18980, 2236.867431, 1473.764038, 9.771875, 90.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 9514, "711_sfw", "mono1_sfe", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(8446, 2147.603515, 1613.218017, 9.741985, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8446, 2152.403320, 1453.218017, 9.741985, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(18980, 2100.867431, 1522.764038, 9.771875, 90.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19550, 2173.993652, 1459.762695, 10.220314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19550, 2150.894287, 1459.762695, 10.220314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19550, 2150.894287, 1446.762695, 10.220314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19550, 2173.893066, 1446.762695, 10.220314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19279, 2161.126953, 1388.435302, 10.220314, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19279, 2161.126953, 1388.435302, 10.220314, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19279, 2146.126953, 1388.435302, 10.220314, 0.000000, 0.000000, 230.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19279, 2146.126953, 1388.435302, 10.220314, 0.000000, 0.000000, 230.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19611, 2158.421875, 1497.661743, 12.506250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19610, 2158.421875, 1497.661743, 14.106250, 35.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(18749, 2163.718017, 1497.068115, 14.506250, 0.000000, 0.000000, -45.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, 2150.949707, 1495.081665, 10.720314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, 2153.949707, 1495.081665, 10.720314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, 2156.949707, 1495.081665, 10.720314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, 2159.949707, 1495.081665, 10.720314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, 2162.949707, 1495.081665, 10.720314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, 2165.949707, 1495.081665, 10.720314, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19149, 2162.828125, 1497.979125, 15.506250, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19149, 2162.828125, 1497.979125, 15.506250, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19149, 2154.328369, 1498.179077, 15.506250, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19149, 2154.328369, 1498.179077, 15.506250, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(18075, 2158.591308, 1499.369750, 17.506250, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(14407, 2148.572265, 1497.849243, 9.620311, 0.000000, 0.000000, -180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19550, 2319.894287, 1459.762695, 9.620313, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19550, 2319.894287, 1444.762695, 9.620313, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(9901, 2290.707275, 1455.662109, 27.820312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1522.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1507.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1492.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1477.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1507.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1524.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1522.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1520.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1522.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1509.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1494.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1479.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1492.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1505.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1490.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1475.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1477.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1507.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1492.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1477.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1437.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1422.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1407.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3510, 2239.653076, 1392.070922, 9.671875, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1437.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1435.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1437.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1439.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1424.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1409.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1394.224853, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1422.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1407.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2237.481689, 1392.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1420.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1405.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2239.581298, 1390.024902, 10.420312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1422.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1407.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(970, 2241.681396, 1392.124877, 10.420312, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3876, 2210.098632, 1504.811279, 10.220312, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    //Wangan 
    tmpobjid = CreateDynamicObject(19550, -6327.693359, -443.207672, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 4829, "airport_las", "fancy_slab128", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6335.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6327.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6319.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6311.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6303.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6295.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6287.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6279.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6343.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6351.243164, -500.320892, 0.618942, 0.000000, 0.000000, 110.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6384.243164, -496.320892, 0.618942, 0.000000, 0.000000, 206.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6384.243164, -488.320892, 0.618942, 0.000000, 0.000000, 206.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6384.243164, -480.320892, 0.618942, 0.000000, 0.000000, 206.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6384.243164, -472.320892, 0.618942, 0.000000, 0.000000, 206.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    tmpobjid = CreateDynamicObject(3578, -6384.243164, -464.320892, 0.618942, 0.000000, 0.000000, 206.000000, -1, -1, -1, 1000.00, 1000.00); 
    SetDynamicObjectMaterial(tmpobjid, 0, 3899, "hospital2", "airportdoor1", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(8172, -3321.293457, -212.685974, 1.549394, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -2998.893554, -212.685974, 1.549394, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -3159.893554, -212.685974, 1.549394, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8344, -3416.553710, -236.862762, 1.533769, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -3453.293457, -319.685974, 1.549394, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19454, -2916.440185, -227.792312, 0.983626, 0.000000, -75.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19454, -2916.440185, -218.192337, 0.983626, 0.000000, -75.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19454, -2916.440185, -208.592361, 0.983626, 0.000000, -75.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19454, -2916.440185, -198.992355, 0.983626, 0.000000, -75.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -2933.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -2964.059814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -2994.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3024.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3054.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3084.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3114.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3144.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3174.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3204.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3234.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3264.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3294.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3324.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3354.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3384.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3404.559814, -197.031021, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3423.559814, -198.031021, 2.633769, 0.000000, 0.000000, 105.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3436.259521, -201.031021, 2.633769, 0.000000, 0.000000, 115.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3456.259521, -213.631027, 2.633769, 0.000000, 0.000000, 135.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3469.259521, -229.631027, 2.633769, 0.000000, 0.000000, 155.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3473.559814, -254.031021, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3473.559814, -284.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3473.559814, -314.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3473.559814, -344.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3473.559814, -374.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8343, -3477.447021, -424.792724, 1.533769, 0.000000, 0.000000, -180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -3548.293457, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -3708.293457, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(10018, -3693.754882, -444.594879, 5.533770, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -3869.792968, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(10018, -3913.754882, -444.594879, 5.533770, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -4031.192871, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -4192.192871, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -4353.192871, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -4514.192871, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(9623, -4440.620117, -448.683776, 4.533770, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -2933.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -2963.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -2993.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3023.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3053.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3083.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3113.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3143.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3173.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3203.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3233.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3263.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3293.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3323.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3353.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3383.559814, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3384.259521, -226.731002, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3412.259521, -228.731002, 2.633769, 0.000000, 0.000000, 97.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3432.459472, -244.330978, 2.633769, 0.000000, 0.000000, 159.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3437.760009, -273.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3437.760009, -303.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3437.760009, -333.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3437.760009, -363.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3437.760009, -393.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3440.760009, -423.031005, 2.633769, 0.000000, 0.000000, 165.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3452.760009, -449.031005, 2.633769, 0.000000, 0.000000, 145.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3472.760009, -462.031005, 2.633769, 0.000000, 0.000000, 115.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3472.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3502.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3532.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3562.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3592.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3622.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3652.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3682.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3712.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3742.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3772.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3802.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3832.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3862.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3892.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3922.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3952.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3982.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4012.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4042.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4072.760009, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4102.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4132.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4162.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4192.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4222.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4252.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4282.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4312.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4342.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4372.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4402.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4432.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4462.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4492.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4522.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4552.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4552.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4522.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4492.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4462.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4432.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4402.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4372.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4342.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4312.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4282.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4252.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4222.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4192.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4162.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4132.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4102.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4072.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4042.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4012.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3982.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3952.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3922.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3892.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3862.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3832.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3802.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3772.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3742.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3712.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3682.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3652.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3622.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3592.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3562.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3532.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3502.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3492.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3473.559814, -402.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3473.559814, -414.031005, 2.633769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -3488.459960, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2918.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2929.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2941.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2952.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2964.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2975.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2987.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2998.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3010.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3021.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3033.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3044.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3056.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2918.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2929.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2941.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2952.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2964.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2975.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2987.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -2998.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3010.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3021.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3033.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3044.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3056.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3067.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3079.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3090.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3754, -3208.549560, -211.616912, 6.533770, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3754, -3452.378173, -309.292480, 6.033770, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3754, -4202.193847, -445.238891, 6.033770, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -4675.192871, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(11132, -4613.405761, -384.004760, -1.466228, 0.000000, 0.000000, 450.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(979, -4573.250976, -430.837951, 2.533770, 0.000000, 0.000000, 205.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3067.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3079.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3090.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3102.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3113.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3125.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3136.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3148.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3159.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3171.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3182.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3194.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3205.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3217.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3228.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3240.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3251.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3263.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3274.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3286.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3102.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3297.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3113.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3125.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3136.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3148.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3159.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3171.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3309.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3182.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3194.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3205.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3217.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3228.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3240.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3320.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3251.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3263.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3274.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3286.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3332.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3297.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3309.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3320.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3332.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3343.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3355.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3366.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3378.452636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3343.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3355.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3387.952636, -226.672866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3366.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3419.952636, -197.172866, 4.133769, 0.000000, 0.000000, 15.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3378.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3389.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3401.452636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3407.952636, -197.172866, 4.133769, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3429.952636, -199.872848, 4.133769, 0.000000, 0.000000, 15.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3439.952636, -202.872848, 4.133769, 0.000000, 0.000000, 25.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3449.952636, -206.872848, 4.133769, 0.000000, 0.000000, 45.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4595.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4582.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4625.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4655.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4685.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4715.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4582.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4612.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4642.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4745.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4775.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4805.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4835.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4672.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4702.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4732.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4762.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -4835.192871, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4792.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4822.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4852.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4882.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4865.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4895.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4925.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4925.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4955.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4985.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4912.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4942.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -4996.592773, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -4972.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5002.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5032.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5015.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5045.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5075.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5062.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5105.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5092.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5122.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1284, -4766.454101, -437.137756, 6.533770, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -5157.592773, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5122.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5152.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5182.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5212.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5242.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5272.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5242.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1284, -4949.331542, -452.323028, 6.833769, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -5318.990234, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5135.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5165.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5195.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5225.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5225.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5255.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5302.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5285.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5315.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5345.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5332.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5375.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5405.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5362.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5392.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -5480.390136, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(3818, -5196.757324, -444.782745, 6.533770, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5422.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5452.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5482.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5512.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5542.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -5641.790527, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(10018, -5513.754882, -444.594879, 5.533770, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5435.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5465.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5495.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5525.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5555.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5585.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5615.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5645.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5675.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5705.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8172, -5803.189941, -444.685974, 1.549394, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3456.852539, -213.772842, 4.133769, 0.000000, 0.000000, 45.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5572.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5602.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5632.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5662.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5692.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5722.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3463.852539, -220.772842, 4.133769, 0.000000, 0.000000, 45.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5752.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5782.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5812.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5842.759765, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3468.852539, -228.772842, 4.133769, 0.000000, 0.000000, 65.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5868.560058, -460.031005, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -239.172866, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5735.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5765.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3396.952636, -226.572875, 4.133769, 0.000000, 0.000000, 7.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5795.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5825.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5855.759765, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -5868.659667, -429.531036, 2.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3406.952636, -227.772888, 4.133769, 0.000000, 0.000000, 7.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3414.952636, -228.772857, 4.133769, 0.000000, 0.000000, 7.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -239.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -250.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -262.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -273.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3427.252441, -230.772857, 4.133769, 0.000000, 0.000000, 69.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -285.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -296.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -308.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -319.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3430.751953, -239.772857, 4.133769, 0.000000, 0.000000, 69.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -331.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3434.151367, -248.672851, 4.133769, 0.000000, 0.000000, 69.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -342.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -354.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -365.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -377.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -259.372894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -388.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -400.172851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -270.872894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -411.672851, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -282.372894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -293.872894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -305.372894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3473.952636, -418.172821, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -316.872894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -328.372894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -339.872894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3485.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3496.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3508.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3519.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -351.372894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -362.872894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -374.372894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -385.872894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3437.952636, -397.372894, 4.133769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3436.952636, -408.372894, 4.133769, 0.000000, 0.000000, 75.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3438.852539, -415.372894, 4.133769, 0.000000, 0.000000, 75.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3531.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3542.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3440.852539, -422.372894, 4.133769, 0.000000, 0.000000, 75.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3554.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3565.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3577.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3442.852539, -430.372894, 4.133769, 0.000000, 0.000000, 75.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3588.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3446.852539, -440.372894, 4.133769, 0.000000, 0.000000, 55.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3600.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3611.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3623.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3634.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3646.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3657.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3669.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3680.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3692.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3703.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3715.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3726.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3738.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3749.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3761.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3772.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3784.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3795.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3451.852539, -447.372894, 4.133769, 0.000000, 0.000000, 55.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3807.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3458.852539, -455.372894, 4.133769, 0.000000, 0.000000, 25.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3818.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3830.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3841.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3853.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3478.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3864.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3876.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3887.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3489.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3501.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3899.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3512.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3910.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3524.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3922.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3933.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3535.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3547.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3558.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3945.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3570.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3956.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3581.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3968.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3979.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3991.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4002.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4014.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4025.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4037.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4048.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3593.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3604.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3616.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3627.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3639.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3650.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3662.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3673.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3685.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3696.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3708.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3719.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3731.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3742.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3754.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3765.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3777.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3788.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3800.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3811.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3823.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3834.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3846.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3857.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3869.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3880.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3892.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3903.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3915.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3926.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3938.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3949.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3961.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3972.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3984.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -3995.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4007.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4018.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4030.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4041.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4053.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4060.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4071.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(4131, -5792.239257, -446.745635, -0.138953, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4083.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4094.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4106.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4117.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4129.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4140.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4152.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4163.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4175.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4064.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4076.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4186.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4087.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4099.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4110.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4198.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4122.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4133.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4145.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4156.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4168.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4179.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4209.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4191.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4202.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4214.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4225.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4237.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4221.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4248.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4232.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4244.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4260.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4271.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4255.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4283.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4294.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4306.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4267.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4278.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4317.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4290.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4329.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4301.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4340.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4352.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4363.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4313.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4375.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4386.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4398.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4324.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4409.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4421.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4432.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4444.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4455.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4467.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4336.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4478.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4347.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4490.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4501.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4359.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4513.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4524.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4370.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4382.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4393.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4405.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4536.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4547.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4559.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4416.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4570.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4428.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4439.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4451.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4462.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4474.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4485.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4497.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4508.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4520.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4531.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4582.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4593.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4605.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4616.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4543.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4554.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4566.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4592.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4603.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4615.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(4131, -4892.239257, -446.745635, -0.138953, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4626.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4638.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4730.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4649.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4661.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4672.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4684.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4695.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4707.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4718.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4741.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4628.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4753.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4764.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4639.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4779.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4651.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4662.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4791.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4674.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4685.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4802.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4697.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4708.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4720.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4814.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4731.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4743.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4754.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4766.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4825.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4777.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4789.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4800.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4812.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4823.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4835.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4846.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4858.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4904.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(5147, -5962.158691, -445.728942, 11.133768, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(979, -5883.722656, -433.132904, 2.533768, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(979, -5883.722656, -458.232910, 2.533768, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(979, -5883.722656, -458.232910, 1.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(979, -5883.722656, -433.132904, 1.633769, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(5333, -6187.510742, -445.797912, 10.100955, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6265.560058, -471.031005, 1.433768, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6265.560058, -490.430999, 1.433768, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6280.560058, -505.230987, 1.433768, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6310.560058, -505.230987, 1.433768, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6340.259765, -505.230987, 1.433768, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6374.060058, -505.230987, 1.433768, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6374.959960, -505.230987, 1.433768, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6389.759765, -489.630950, 1.433768, 0.000000, 0.000000, 360.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6389.759765, -459.630981, 1.433768, 0.000000, 0.000000, 360.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6389.759765, -429.630981, 1.433768, 0.000000, 0.000000, 360.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6389.759765, -399.630981, 1.433768, 0.000000, 0.000000, 360.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6389.759765, -395.930999, 1.433768, 0.000000, 0.000000, 360.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6374.159667, -381.130981, 1.433768, 0.000000, 0.000000, 450.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6344.159667, -381.130981, 1.433768, 0.000000, 0.000000, 450.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6314.159667, -381.130981, 1.433768, 0.000000, 0.000000, 450.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6284.159667, -381.130981, 1.433768, 0.000000, 0.000000, 450.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6280.459472, -381.130981, 1.433768, 0.000000, 0.000000, 450.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6265.659667, -396.730987, 1.433768, 0.000000, 0.000000, 540.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8650, -6265.659667, -420.830963, 1.433768, 0.000000, 0.000000, 540.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4837.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4848.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4860.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4871.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4883.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4894.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4906.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4917.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4869.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4881.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4892.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4929.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4915.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4940.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4927.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4938.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4950.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4952.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4961.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4963.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4973.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4975.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4984.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4996.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4986.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5007.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -4998.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5009.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5021.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5032.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5044.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5055.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5067.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5078.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5090.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5101.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5113.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5124.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5019.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5136.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5030.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5147.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5042.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5053.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5159.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5170.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5182.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5065.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5193.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5076.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5088.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5099.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5111.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5205.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5122.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5134.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5216.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5145.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5228.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5157.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5239.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5168.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5180.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5251.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5262.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5191.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5274.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5285.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5203.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5297.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5214.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5308.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5226.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5320.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5331.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5343.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5354.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5366.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5237.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5249.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5260.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5377.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5377.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5272.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5283.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5295.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5306.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5318.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5329.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5341.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5352.952148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5364.452148, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5389.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5400.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5412.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5375.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5387.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5423.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5398.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5410.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5421.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5433.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5444.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5435.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5446.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5456.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5458.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5467.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5479.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5469.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5490.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5502.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5513.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5525.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5481.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5536.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5548.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5492.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5559.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5504.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5515.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5527.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5538.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5571.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5550.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5582.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5561.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5573.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5594.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5605.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5584.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5617.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5596.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5607.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5619.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5630.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5642.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5653.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5628.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5665.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5640.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5651.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5663.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5674.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5676.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5686.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5697.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5688.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5709.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5699.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5720.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5711.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5732.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5743.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5755.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5722.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5734.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5766.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5778.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5789.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5745.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5801.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5757.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5812.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5824.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5768.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5835.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5847.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5780.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5858.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5870.452636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5791.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5881.952636, -459.872802, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5803.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5814.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5826.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5837.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5849.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5860.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5872.452148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19912, -5883.952148, -429.672790, 4.133769, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1676, -6353.302734, -424.751831, 2.918941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(5409, -6377.214355, -433.800964, 5.718942, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1676, -6355.502929, -436.051788, 2.918941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1676, -6353.202636, -436.051788, 2.918941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1676, -6355.502929, -424.751831, 2.918941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1676, -6355.603027, -430.351776, 2.918941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1676, -6353.203125, -430.351776, 2.918941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(7312, -6383.266113, -432.917633, 3.318942, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6348.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1568, -6265.450683, -452.987915, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1568, -6265.450683, -438.487915, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.501464, -457.602966, 1.318941, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.501464, -467.602966, 1.318941, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.501464, -477.602966, 1.318941, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.501464, -487.602966, 1.318941, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.501464, -497.602966, 1.318941, 0.000000, 0.000000, 180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6273.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6354.940429, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6283.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6293.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6303.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6313.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6323.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6333.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6343.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6353.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6363.501464, -505.302978, 2.218941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6373.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6383.501464, -505.302978, 1.318941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -499.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -489.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -479.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -469.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -459.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -449.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -439.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -429.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -419.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -409.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -399.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6389.801269, -389.302978, 1.318941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6381.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6371.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6361.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6351.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6341.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6331.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6321.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6311.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6301.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6291.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6281.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6271.801269, -381.102996, 1.318941, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.601074, -387.102996, 1.318941, 0.000000, 0.000000, -180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.601074, -397.102996, 1.318941, 0.000000, 0.000000, -180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.601074, -407.102996, 1.318941, 0.000000, 0.000000, -180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.601074, -417.102996, 1.318941, 0.000000, 0.000000, -180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1223, -6265.601074, -427.102996, 1.318941, 0.000000, 0.000000, -180.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(4268, 2668.510009, -2105.725585, 3.966749, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6360.863769, -504.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6345.340820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(7504, -6313.393554, -508.605010, 1.304878, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6335.740722, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6326.340820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6316.840820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6307.340820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6297.840820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6288.340820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6340.863769, -504.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6278.840820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6320.863769, -504.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6300.863769, -504.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(19447, -6271.840820, -507.348022, 1.218942, 0.000000, 90.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6280.863769, -504.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6266.363281, -504.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6338.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6266.363281, -484.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6266.363281, -464.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6266.363281, -424.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6266.363281, -404.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6266.363281, -404.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6266.363281, -384.426025, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6281.363281, -381.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6301.363281, -381.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6321.363281, -381.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6341.363281, -381.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6361.363281, -381.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6381.363281, -381.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6389.063964, -396.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6389.063964, -416.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6389.063964, -446.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6389.063964, -466.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6389.063964, -486.826049, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1235, -6374.063964, -504.526031, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6328.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6318.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6308.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6298.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6288.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1280, -6278.517578, -505.976654, 1.818941, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, -6356.052734, -504.932586, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8614, -6360.708007, -509.278472, 0.004879, 0.000000, 0.000000, -90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1215, -6358.252929, -504.932586, 1.818941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(8572, -6266.098144, -508.660308, 0.004879, 0.000000, 0.000000, 90.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6327.121582, -388.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1340, -6327.046386, -383.386352, 2.318942, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1340, -6322.046386, -383.386352, 2.318942, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1340, -6317.046386, -383.386352, 2.318942, 0.000000, 0.000000, 270.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6324.121582, -388.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6321.121582, -388.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6318.121582, -388.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6315.121582, -388.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6317.121582, -392.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6320.121582, -392.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6323.121582, -392.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6326.121582, -392.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6329.121582, -392.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00); 
    tmpobjid = CreateDynamicObject(1432, -6314.121582, -392.063140, 1.418941, 0.000000, 0.000000, 0.000000, -1, -1, -1, 1000.00, 1000.00);
	//Mapping Lesen
	tmpobjid = CreateDynamicObject(18880, 1282.306030, 1286.166748, 9.734000, 0.000000, 90.300003, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "sl_vicbrikwall01", 0x00000000);
    tmpobjid = CreateDynamicObject(18739, 1352.051513, 1381.710571, 6.019333, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    SetDynamicObjectMaterial(tmpobjid, 1, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    /////////////////////////////////////////////////////////////////////////////////////////////////////////////////
    tmpobjid = CreateDynamicObject(19966, 1284.163696, 1286.293823, 8.904678, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19955, 1287.228515, 1286.297729, 8.728633, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19966, 1284.393676, 1310.973388, 8.904678, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19483, 1317.433105, 1256.382690, 13.400312, 0.000000, 0.000000, 89.899986, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19483, 1315.562866, 1256.385864, 13.400312, 0.000000, 0.000000, 89.899986, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1363.246337, 1236.662109, 13.691755, 0.000000, 0.000000, 178.200088, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1283.984375, 1237.428222, 13.691755, 0.000000, 0.000000, 179.200088, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3819, 1310.637451, 1289.448974, 10.646289, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(8353, 1347.380004, 1393.219970, 7.851560, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1353.361938, 1251.989990, 13.691755, 0.000000, 0.000000, 177.700057, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(8353, 1347.380004, 1451.609863, 7.891561, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1285.220214, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1295.130249, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1305.000244, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1314.890014, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1324.849853, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(8150, 1279.166259, 1300.345947, 12.820300, 0.000000, 0.000000, -90.300003, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(8150, 1368.509155, 1299.459960, 12.820300, 0.000000, 0.000000, 89.939903, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.171142, 1287.713134, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.221557, 1287.686401, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.249511, 1290.866210, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.199340, 1290.943359, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.226440, 1294.084228, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.254150, 1297.224243, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.281250, 1300.354248, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.308715, 1303.484252, 9.783396, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.337036, 1306.693847, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.277343, 1294.045410, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.305541, 1297.205200, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.333251, 1300.385131, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.360839, 1303.555053, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.388549, 1306.705200, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3578, 1285.722412, 1292.741943, 9.140297, 0.000000, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.364746, 1309.853637, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.392333, 1313.023437, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.392333, 1313.023437, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.416137, 1309.834960, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.443847, 1312.995117, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3578, 1285.807128, 1302.522705, 9.140297, 0.000000, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3383, 1285.897338, 1310.045410, 8.908701, -86.500015, 4.199996, 4.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.419921, 1316.163574, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.447143, 1319.303833, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.474243, 1322.423950, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.501586, 1325.544311, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.529052, 1328.673828, 9.783397, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1285.970458, 1313.803100, 10.359802, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.471435, 1316.135009, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.498657, 1319.295043, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.526245, 1322.435058, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.554321, 1325.645385, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.582641, 1328.794311, 9.793997, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.557250, 1331.913574, 9.783396, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1285.970458, 1316.543579, 10.359802, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1285.970458, 1319.053588, 10.359802, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1285.970458, 1321.514282, 10.359802, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1285.970458, 1323.875122, 10.359802, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3383, 1286.058105, 1325.112304, 8.925584, -86.500015, 4.199996, 4.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1328.151977, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(8150, 1279.634887, 1390.444824, 12.820300, 0.000000, 0.000000, -90.300003, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(8150, 1368.652465, 1390.620605, 12.820300, 0.000000, 0.000000, 89.939903, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1329.032226, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1329.732299, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1330.382568, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1331.052734, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1331.692626, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1332.392944, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1333.033081, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1333.703125, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1214, 1285.396728, 1334.353393, 9.672719, 0.000000, 89.499992, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11111, 1298.373779, 1314.239013, 9.942070, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.610839, 1332.013916, 9.793996, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1284.585327, 1335.103515, 9.783396, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.638793, 1335.213867, 9.793996, -0.199900, 0.000000, 89.500000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3383, 1286.122924, 1335.432861, 8.903767, -86.500015, 4.199996, 4.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1285.199951, 1338.122802, 9.785595, -0.199900, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1288.222412, 1338.157592, 10.005364, -0.199900, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1288.224731, 1338.156005, 10.015672, 178.500106, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1288.210571, 1338.161254, 9.823458, -5.199901, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1286.380004, 1341.118408, 9.785595, -0.199900, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1287.534179, 1344.049194, 9.785595, -0.199900, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1288.719726, 1347.060668, 9.955969, -0.199900, -4.899998, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1289.384033, 1341.106933, 10.005364, -0.199900, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1290.535034, 1344.028442, 10.005364, -0.199900, 0.000000, 68.500022, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11505, 1298.484741, 1375.625976, 14.266515, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1334.789672, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1344.699951, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1354.479492, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11111, 1298.373779, 1367.209472, 9.942070, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(4639, 1293.573608, 1376.017578, 11.603632, 0.000000, 0.000000, 91.100028, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(4639, 1303.181274, 1376.165161, 11.603632, 0.000000, 0.000000, -92.199958, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1422, 1302.353393, 1372.887207, 10.301926, 0.000000, 0.000000, -88.600006, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1422, 1294.352539, 1372.812011, 10.301926, 0.000000, 0.000000, -88.600006, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1298.374023, 1375.536621, 10.396782, 0.000000, 0.000000, 90.100006, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1298.377807, 1373.447021, 10.396782, 0.000000, 0.000000, 90.100006, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1298.358886, 1371.080566, 10.393953, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1302.339233, 1370.870361, 10.473953, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1294.408935, 1370.870361, 10.473953, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1294.408935, 1378.540405, 10.473953, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1302.399169, 1378.540405, 10.473953, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.361206, 1398.950439, 9.786330, 0.000097, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.982788, 1449.647827, 9.786337, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1354.089477, 1446.537841, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1354.072753, 1443.327026, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1354.056518, 1440.196899, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1354.039672, 1437.016967, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1354.022460, 1433.746337, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1354.005493, 1430.566040, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.989257, 1427.416381, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.973144, 1424.256225, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.956542, 1421.116455, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.940185, 1417.976684, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.923828, 1414.836791, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.907470, 1411.687500, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.890869, 1408.477783, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.874633, 1405.327636, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.858032, 1402.117431, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1353.841674, 1398.936889, 9.786341, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1295.514160, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1305.073974, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1298.703735, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1301.883666, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1308.203857, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1311.404296, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1314.544067, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1317.693847, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1320.903686, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1324.114013, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1327.324096, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1330.583740, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1333.673828, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1336.923461, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1340.003540, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1343.183593, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1346.373535, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1349.593750, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1352.533691, 1451.225585, 9.786342, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1354.105957, 1449.708129, 9.786342, 0.000096, 0.000000, -90.299942, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1304.965942, 1403.594116, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1320.903686, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.383178, 1402.110229, 9.786330, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1320.903686, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.525634, 1426.920654, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1308.125610, 1403.621704, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.525634, 1426.920654, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.524536, 1426.635498, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.355468, 1402.386230, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.548461, 1430.120239, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.503295, 1423.681152, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.569458, 1433.230468, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.480834, 1420.510375, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.591674, 1436.410400, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.458496, 1417.300903, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.440185, 1414.651855, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1303.611206, 1437.720581, 9.786328, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1317.623779, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1314.473510, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1311.283935, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1308.094116, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1306.874145, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1324.103637, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1327.313598, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1330.613647, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1333.773437, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1336.953735, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1340.173583, 1442.165283, 9.786332, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1304.468872, 1440.698730, 9.786328, 0.000096, 0.000000, 59.500049, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.546508, 1429.815551, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.568115, 1432.965087, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.590454, 1436.125244, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.611450, 1439.024291, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1311.316040, 1403.649780, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.502075, 1423.415527, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.479858, 1420.206298, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.457763, 1417.035278, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.421264, 1414.695556, 9.786252, 0.000096, 0.000000, 89.500053, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1343.190795, 1441.393676, 9.786332, 0.000096, 0.000000, -30.599954, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1317.643798, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1314.443969, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1311.213500, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1308.053710, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1304.924194, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1324.043701, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1327.223388, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1330.413940, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1333.552856, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1336.703002, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1339.892700, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1342.901977, 1413.085205, 9.786285, 0.000096, 0.000000, 0.000048, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1318.398681, 1449.286621, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1318.411865, 1447.446044, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1318.435180, 1444.125854, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1320.065185, 1444.137207, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1321.775268, 1444.149047, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1321.759643, 1446.379272, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1320.049194, 1446.397216, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1320.028808, 1449.297241, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3852, 1321.739013, 1449.319458, 10.263057, 0.000000, 0.000000, 90.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1226, 1319.833007, 1443.579711, 15.392946, 0.000000, 0.000000, -89.499992, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1226, 1320.129272, 1449.882446, 15.392946, 0.000000, 0.000000, 91.100028, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1317.448852, 1443.977661, 11.766327, 0.000096, 0.000000, 90.500068, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1317.421142, 1447.127319, 11.766327, 0.000096, 0.000000, 90.500068, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1317.401123, 1449.427246, 11.766327, 0.000096, 0.000000, 90.500068, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1322.741333, 1449.473999, 11.766317, 0.000096, 0.000000, 90.500068, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1322.768920, 1446.334228, 11.766317, 0.000096, 0.000000, 90.500068, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1322.789306, 1444.014038, 11.766317, 0.000096, 0.000000, 90.500068, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1314.496215, 1403.677246, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1317.636108, 1403.704711, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1320.835937, 1403.732421, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1323.975585, 1403.759765, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1327.085449, 1403.786743, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1330.265625, 1403.814697, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1333.435424, 1403.842407, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1336.605224, 1403.870117, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1339.745239, 1403.897583, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1342.915161, 1403.925170, 9.786330, 0.000096, 0.000000, 0.500041, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1344.333251, 1399.136596, 9.786252, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.630737, 1399.018676, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.652465, 1402.158569, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.674926, 1405.389038, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.697387, 1408.569335, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.718872, 1411.669311, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.741088, 1414.849365, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.762939, 1418.009399, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.807128, 1424.419311, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.785034, 1421.179565, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.829223, 1427.599243, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.850830, 1430.718627, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.872558, 1433.858398, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.894165, 1437.008056, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11111, 1348.903930, 1367.209472, 9.942070, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.916503, 1440.198120, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.938842, 1443.388183, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19425, 1293.961425, 1446.577758, 9.786338, 0.000096, 0.000000, 89.600044, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1363.489990, 1453.560180, 13.691755, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1363.254638, 1251.592651, 13.691755, 0.000000, 0.000000, 177.700057, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1353.340942, 1236.973266, 13.691755, 0.000000, 0.000000, 178.200088, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2990, 1284.222900, 1254.506469, 13.691755, 0.000000, 0.000000, 179.200088, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3819, 1310.637451, 1298.039550, 10.646289, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1301.174682, 1413.036621, 10.366783, 0.000000, 0.000000, 178.600021, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19954, 1300.142333, 1413.036987, 7.734720, 0.000000, 0.000000, -1.600000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19954, 1302.221557, 1412.978881, 7.734720, 0.000000, 0.000000, -1.600000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(970, 1346.518188, 1413.049438, 10.366783, 0.000000, 0.000000, 178.600021, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19953, 1347.583984, 1413.003662, 7.718379, 0.000000, 0.000000, 177.899963, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19953, 1345.484863, 1413.060546, 7.718379, 0.000000, 0.000000, 177.899963, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1483, 1311.642822, 1288.566894, 12.338836, 0.000000, 0.000000, 179.799987, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1483, 1311.664916, 1295.066528, 12.338836, 0.000000, 0.000000, 179.799987, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1483, 1311.678588, 1299.016601, 12.338836, 0.000000, 0.000000, 179.799987, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(16362, 1362.539062, 1282.730590, 12.843239, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(11547, 1361.097900, 1314.410522, 12.665185, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1294, 1307.511230, 1285.061523, 9.566353, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1294, 1307.511230, 1302.481445, 9.566353, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19718, 1301.001708, 1378.285766, 10.892782, 0.000000, 0.000000, 87.199966, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19718, 1300.869384, 1370.663208, 10.892782, 0.000000, 0.000000, 87.199966, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19718, 1351.194702, 1412.997802, 10.910316, 0.000000, 0.000000, 89.700012, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1303.322143, 1397.344482, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.622192, 1397.344482, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.622192, 1403.565307, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.622192, 1410.095458, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.712280, 1416.445556, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.752319, 1422.765502, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.812377, 1429.185424, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.852416, 1435.435424, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.892456, 1441.785400, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.922485, 1448.106079, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1293.982543, 1451.226196, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1300.302612, 1451.226196, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1306.613037, 1451.226196, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1313.563476, 1451.126098, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1326.664428, 1451.176147, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1332.104980, 1451.176147, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1338.455322, 1451.176147, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1344.745483, 1451.176147, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1351.006103, 1451.176147, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1354.085937, 1451.176147, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1354.055908, 1444.915649, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1354.055908, 1438.595703, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1354.005859, 1432.145751, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1353.965820, 1425.806152, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1353.925781, 1419.586181, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1353.795654, 1412.935546, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1353.845703, 1406.855102, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1353.845703, 1397.254760, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1303.382202, 1403.604492, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1309.672241, 1403.604492, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1315.782348, 1403.614501, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1322.132690, 1403.714599, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1328.632934, 1403.784667, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1335.043212, 1403.844726, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1341.323364, 1403.884887, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1344.343505, 1403.874877, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1344.343505, 1397.385498, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1303.382202, 1413.064819, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1303.442382, 1418.905151, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1303.512451, 1425.274780, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1303.552490, 1431.675415, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1303.622558, 1439.315795, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1305.262451, 1442.095458, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1313.502197, 1442.095458, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1326.722656, 1442.145507, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1331.803222, 1442.145507, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1338.532592, 1442.135620, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1341.742675, 1442.135620, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1344.542358, 1440.565429, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1344.542358, 1426.024780, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1344.362182, 1413.084228, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1328.782226, 1413.084228, 10.323943, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1287.211059, 1286.282226, 10.359802, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1284.151123, 1286.282226, 10.359802, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1287.542114, 1325.944458, 10.403944, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1284.452148, 1326.044555, 10.403944, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1284.362060, 1310.994018, 10.403944, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1287.322143, 1310.953979, 10.403944, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1284.632324, 1336.415039, 10.403944, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19121, 1287.562133, 1336.334960, 10.403944, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1425, 1353.155029, 1383.900634, 10.343943, 0.000000, 0.000000, -165.800109, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1425, 1350.916015, 1383.334838, 10.343943, 0.000000, 0.000000, -165.800109, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19975, 1351.984863, 1382.590820, 9.773945, 0.000000, 0.000000, -165.499969, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19974, 1350.858276, 1382.026611, 9.833944, 0.000000, 0.000000, -139.900039, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1352.094848, 1383.595581, 10.363945, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1238, 1350.196289, 1383.127807, 10.193946, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1238, 1349.566162, 1382.737426, 10.193946, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1282, 1349.354980, 1381.821777, 10.473944, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1228, 1348.913452, 1380.290771, 10.283934, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1228, 1348.878051, 1377.875976, 10.298486, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1228, 1348.884033, 1375.198486, 10.284280, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1238, 1348.975830, 1376.557006, 10.193946, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1238, 1348.975830, 1373.416992, 10.193946, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1282, 1349.798339, 1372.309448, 10.473944, 0.000000, 0.000000, 56.700004, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1282, 1351.168823, 1371.408935, 10.473944, 0.000000, 0.000000, 56.700004, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1282, 1352.623046, 1370.453735, 10.473944, 0.000000, 0.000000, 56.700004, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1351.814575, 1370.805541, 10.363945, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19124, 1350.334106, 1371.755493, 10.363945, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1238, 1348.975830, 1379.057006, 10.193946, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(3502, 1352.462768, 1376.727905, 9.445071, 3.400002, 0.000000, -166.799957, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(900, 1350.839599, 1373.798706, 5.700512, 0.000000, 0.000000, -96.199989, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2060, 1350.712768, 1379.789428, 9.866890, 0.000000, 0.000000, -92.199996, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2060, 1350.303100, 1379.805175, 9.866890, 0.000000, 0.000000, -92.199996, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2060, 1350.907592, 1380.663940, 9.866890, 0.000000, 0.000000, -98.799995, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2060, 1350.423217, 1380.738647, 9.866890, 0.000000, 0.000000, -98.799995, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2060, 1351.025878, 1381.478759, 9.866890, 0.000000, 0.000000, -8.399998, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(2060, 1352.621948, 1381.633544, 9.866890, 0.000000, 0.000000, -70.400009, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19989, 1284.415649, 1317.752319, 9.614533, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19966, 1284.473754, 1326.043823, 8.904678, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19966, 1284.643920, 1336.423828, 8.904678, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19964, 1287.573730, 1336.327026, 8.978948, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1352, 1291.036376, 1345.279907, 9.045984, 0.000000, 0.000000, -25.199996, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19976, 1289.296020, 1348.453002, 10.010231, 0.000000, 0.000000, -27.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19951, 1302.919799, 1370.481323, 9.831818, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19952, 1293.896850, 1370.545410, 9.861250, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19966, 1294.722290, 1378.508178, 9.919927, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19964, 1328.765380, 1413.080932, 9.953879, 0.000000, 0.000000, -88.999992, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19963, 1328.761596, 1413.079467, 9.196894, 0.000000, 0.000000, -85.699974, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19949, 1328.629028, 1403.801635, 9.774602, 0.000000, 0.000000, -87.199989, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1352, 1344.264282, 1413.122314, 9.375290, 0.000000, 0.000000, -88.399986, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19956, 1353.859741, 1406.872070, 9.744339, 0.000000, 0.000000, -89.400001, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19986, 1353.934082, 1391.586425, 9.946975, 0.000000, 0.000000, 179.800033, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1294, 1352.897460, 1379.091064, 12.622636, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19952, 1293.096313, 1294.248046, 9.900904, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19966, 1293.199462, 1314.219970, 9.917860, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19966, 1303.519531, 1314.219970, 9.917860, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19989, 1293.230224, 1324.266845, 9.817001, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19964, 1293.228027, 1334.242065, 9.833350, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19956, 1293.641845, 1410.103759, 9.843669, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19952, 1300.292968, 1451.202392, 10.148219, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19966, 1322.684814, 1450.848632, 11.714805, 0.000000, 0.000000, -88.899986, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19952, 1354.071533, 1444.915527, 10.072336, 0.000000, 0.000000, -89.499992, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19964, 1353.977050, 1425.811157, 9.853383, 0.000000, 0.000000, 178.400009, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(1352, 1353.937744, 1413.098876, 9.399871, 0.000000, 0.000000, 179.699996, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19948, 1344.438720, 1413.172363, 9.850374, 0.000000, 0.000000, 179.099990, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19950, 1343.823730, 1337.376464, 9.770057, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    tmpobjid = CreateDynamicObject(19950, 1354.043823, 1337.376464, 9.770057, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00);
    return 1;
}

Function RemoveBuilding(playerid)
{
    //Dataran
    RemoveBuildingForPlayer(playerid, 9072, 2113.129, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 8694, 2113.129, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9070, 2111.320, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9074, 2111.320, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 8502, 2134.149, 1483.119, 21.484, 0.250);
    RemoveBuildingForPlayer(playerid, 8501, 2160.270, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9075, 2160.270, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9071, 2158.419, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9073, 2158.419, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 8852, 2162.139, 1483.250, 10.781, 0.250);
    RemoveBuildingForPlayer(playerid, 8855, 2181.580, 1483.229, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2182.050, 1503.229, 12.523, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2181.989, 1500.439, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2180.080, 1521.439, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1341, 2175.090, 1523.410, 10.734, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2169.679, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2168.540, 1514.079, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2161.919, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2157.510, 1514.079, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2153.850, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2148.919, 1522.079, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 8854, 2161.760, 1522.520, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2119.500, 1522.079, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2121.729, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2117.050, 1514.079, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2110.889, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 8853, 2107.189, 1522.520, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2101.570, 1514.079, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2099.810, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2088.479, 1522.079, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2087.610, 1503.229, 12.523, 0.250);
    RemoveBuildingForPlayer(playerid, 8851, 2086.810, 1483.229, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2087.610, 1463.250, 12.523, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2088.889, 1439.589, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2088.889, 1426.479, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2099.810, 1447.979, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2100.989, 1452.160, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 8856, 2107.189, 1443.989, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2110.889, 1447.979, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2117.330, 1452.160, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2121.729, 1447.979, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2121.840, 1443.229, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1341, 2125.129, 1442.079, 10.703, 0.250);
    RemoveBuildingForPlayer(playerid, 1340, 2144.639, 1441.930, 10.851, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2147.659, 1443.229, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 8843, 2163.530, 1444.619, 9.859, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2157.070, 1452.160, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2169.580, 1452.160, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2181.919, 1443.229, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2181.989, 1458.709, 10.226, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2182.050, 1463.250, 12.523, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2147.159, 1424.739, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2171.870, 1424.640, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 1344, 2178.219, 1418.839, 10.625, 0.250);
    RemoveBuildingForPlayer(playerid, 1344, 2181.560, 1418.839, 10.625, 0.250);
    RemoveBuildingForPlayer(playerid, 8839, 2162.479, 1403.439, 14.656, 0.250);
    RemoveBuildingForPlayer(playerid, 8931, 2162.479, 1403.439, 14.656, 0.250);
    RemoveBuildingForPlayer(playerid, 8840, 2162.790, 1401.410, 14.375, 0.250);
    RemoveBuildingForPlayer(playerid, 8842, 2217.750, 1477.660, 31.679, 0.250);
    RemoveBuildingForPlayer(playerid, 8930, 2217.750, 1477.660, 31.679, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2236.360, 1402.130, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 8866, 2237.479, 1471.359, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2116.360, 1384.329, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2098.379, 1384.319, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 3516, 2074.600, 1423.369, 12.992, 0.250);
    RemoveBuildingForPlayer(playerid, 8446, 2152.379, 1453.229, 9.742, 0.250);
    RemoveBuildingForPlayer(playerid, 8605, 2152.379, 1453.229, 9.742, 0.250);
    RemoveBuildingForPlayer(playerid, 8664, 2162.389, 1453.229, 9.742, 0.250);
    RemoveBuildingForPlayer(playerid, 8755, 2162.389, 1453.229, 9.742, 0.250);
    RemoveBuildingForPlayer(playerid, 8865, 2215.090, 1522.520, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 8390, 2307.370, 1453.180, 29.125, 0.250);
    RemoveBuildingForPlayer(playerid, 8695, 2307.370, 1453.180, 29.125, 0.250);
    RemoveBuildingForPlayer(playerid, 1294, 2251.639, 1463.319, 14.304, 0.250);
	return 1;
}