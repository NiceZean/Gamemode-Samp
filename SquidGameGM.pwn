/* 												| SQUID GAME GAMEMODE 2022 |
											 | SCRIPTER : BOSS DANIAL & Zack |
												  | MAPPER : MOHD ANNAS |
*/

//====== INCLUDES ======												  
#include <a_samp>
#include <dini>
#include <dudb>
#include <zcmd>
#include <sscanf2>
#include <streamer>			 

//====== PRAGMAS ======
#pragma unused ret_memcpy
#pragma unused strtok

native IsValidVehicle(vehicleid);
//====== DEFINES DIALOG ======
#define DIALOG_DAFTAR 						1
#define DIALOG_LOGIN 						2
#define DIALOG_CHOOSELANGUAGE 				3
//====== COMMON COLORS ======
#define COL_WHITE 			"{FFFFFF}"
#define COL_YELLOW 			"{F8FF00}"
#define COL_BYELLOW        	"{FFFF80}"
#define COL_RED 			"{FF0000}"
#define COL_LRED 			"{B00000}"
#define COL_GREEN       	"{00FF16}"
#define COL_LBLUE   		"{00FFFF}"
#define COL_LIGHTBLUE      	"{00C0FF}"
#define COL_BLUE        	"{001AFF}"
#define COL_PINK        	"{FF00BD}"
#define COL_PURPLE 			"{C2A2DA}"
#define COL_DBLUE			"{0013A1}"
#define COL_LGREEN  		"{3FFF4C}"
#define COL_OREN  			"{FFA000}"
#define COL_DC  			"{9739E3}"
#define COL_CYAN 			"{11F0F7}"
#define COL_ORANGE 			"{ff0000}"
#define COL_LIME            "{B7FF00}"

//======= COL ROLE =======
#define COL_OWNER 			"{E7DD10}"
#define COL_DEV 			"{CE79E4}"
#define COL_MODERATOR 		"{F08C05}"
#define COL_ADMIN 			"{9BEA9B}"
#define COL_STAFF 			"{26EC26}"
#define COL_VIP 			"{ECFF00}"					

//====== COLOR ROLE ======
#define COLOR_OWNER 		0xE7DD10FF
#define COLOR_DEV 			0xCE79E4FF
#define COLOR_MODERATOR 	0xF08C05FF
#define COLOR_ADMIN 		0x9BEA9BFF
#define COLOR_STAFF 		0x26EC26FF
#define COLOR_VIP 			0xECFF0000	

//====== EXTRA COLORS ======
#define COLOR_AFK	 		0xFF0000FF
#define COLOR_BITEM 		0xE1B0B0FF
#define COLOR_GRAD1 		0xB4B5B7FF
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_RED 			0xFF0000FF
#define COLOR_BLACK         0x000001FF
#define COLOR_BLUE 			0x007BD0FF
#define ACTION_COLOR 	    0xC2A2DAAA
#define COLOR_LIGHTORANGE 	0xFFA100FF
#define COLOR_FLASH 		0xFF000080
#define COLOR_LIGHTRED 		0xB00000FF
#define COLOR_LIGHTBLUE 	0x00FFFFFF
#define COLOR_LIGHTGREEN 	0x3FFF4CFF
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_OREN 		    0xFFA000FF
#define COLOR_LIGHTYELLOW	0xFFFF91FF
#define COLOR_YELLOW2 		0xF5DEB3AA
#define COLOR_WHITE 		0xFFFFFFFF
#define COLOR_FADE1 		0xE6E6E6E6
#define COLOR_FADE2 		0xC8C8C8C8
#define COLOR_FADE3 		0xAAAAAAAA
#define COLOR_FADE4 		0x8C8C8C8C
#define COLOR_FADE5 		0x6E6E6E6E
#define COLOR_PURPLE 		0xC2A2DAAA
#define COLOR_DBLUE 		0x2641FEAA
#define COLOR_DOC 			0xFF8282AA
#define COLOR_DCHAT 		0xF0CC00FF
#define COLOR_NEWS 			0xFFA500AA
#define COLOR_OOC 			0xE0FFFFAA
#define NEWBIE_COLOR 		0x7DAEFFFF
#define SAMP_COLOR			0xAAC4E5FF
#define COLOR_NICERED 		0xFF0000FF
#define COLOR_NICEGREEN 	0x00FF00FF
#define TEAM_TAXI_COLOR 	0xFFFF5000

#define COLOR_CAR 			0x7DAEFFFF
#define COL_FORUM 			0x808000C8
#define COLOR_TAN 			0xD2B48CFF
#define COLOR_CHAT1 		0xF9B7FFAA
#define COLOR_CHAT2 		0xE6A9ECAA
#define COLOR_CHAT3 		0xC38EC7AA
#define COLOR_CHAT4 		0xD2B9D3AA
#define COLOR_CHAT5 		0xC6AEC7AA
#define COLOR_DBLUE 		0x2641FEAA
#define COLOR_DOC 			0xFF8282AA
#define COLOR_DCHAT 		0xF0CC00FF
#define COLOR_NEWS 			0xFFA500AA
#define COLOR_OOC 			0xE0FFFFAA
#define COLOR_ORANGE 		0xFF9900AA

#define ADMINCHAT           0x00FF00FF
#define ILLEGAL 		    0xE1B0B0FF
#define GREY1 			  	0xB4B5B7FF
#define GREY2 			    0xBFC0C2FF
#define GREY3 			  	0xCBCCCEFF
#define GREY4 				0xD8D8D8FF
#define GREY5 			 	0xE3E3E3FF
#define GREY6 			 	0xF0F0F0FF
#define GREY				0xAFAFAFFF
#define GREEN 			 	0x33AA33FF
#define RED 				0xAA3333FF
#define BLACK         	 	0x000001FF
#define BLUE 				0x007BD0FF
#define LIGHTORANGE 		0xFFA100FF
#define FLASH 			 	0xFF000080
#define LIGHTRED 			0xFF6347FF
#define LIGHTBLUE 		 	0x33CCFFFF
#define LIGHTGREEN		 	0x9ACD32FF
#define YELLOW 			 	0xFFFF00FF
#define FADE1 		 	 	0xE6E6E6E6
#define FADE2 		 	 	0xC8C8C8C8
#define FADE3 			 	0xAAAAAAFF
#define FADE4 			 	0x8C8C8C8C
#define FADE5 			 	0x6E6E6E6E

//====== EXTRA DEFINES ======
#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//======== GLOBAL VARIABLES ============
new LoggedIn[MAX_PLAYERS];
new RegisteredPlayer[MAX_PLAYERS];
new InGame[MAX_PLAYERS];
new PassedGame[MAX_PLAYERS];
new DontMove[MAX_PLAYERS];
new godmode[MAX_PLAYERS];
new SQUIDGAMELOBBYTIMER;
new SQUIDGAMEFIRSTMAPTIMER[2];
new LobbyTimerCountMinute;
new LobbyTimerCountSecond;
new SQUIDGAMEFIRSTGAMEMAPSTATUE;
new SQUIDGAMEFIRSTGAMEMAPGLASS[2];
new FirstGameCountMinute;
new FirstGameCountSecond;
new CountVariable;
new FirstMapCountVariable;

new Text:GUARDREDGREENLIGHTTD[7];
new Text:REDGREENLIGHT[2];

enum pdata
{
	pPass,
    pScore,
    pLevel,
    pExp,
    pAdmin,
    pSkin,
    pMoney,
    pLanguage,
};
new PlayerInfo[MAX_PLAYERS][pdata];

new Float:LoggedInSpawn[][] =
{
	{1356.0795,1516.9381,-32.9132},
	{1308.0881,1518.0413,-32.8532},
	{1361.7438,1541.5491,-32.8532},
	{1362.1973,1557.1584,-32.8532},
	{1309.9891,1556.7642,-32.8532},
	{1329.5956,1550.7711,-32.9132},
	{1347.9695,1530.2146,-32.9132}
};
//====== STOCKS =========
stock GetName(playerid)
{
    new name[24];
    GetPlayerName(playerid, name, sizeof(name));
    str_replace(name, '_', ' ');
    return name;
}

stock str_replace(string[], find, replace)
{
    for(new i=0; string[i]; i++) { if(string[i] == find) { string[i] = replace; } }
}

stock StartFirstMatch()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(RegisteredPlayer[i] == 1)
		{
			SetPlayerPos(i, -71.4841,2482.2202,16.4844);
			SetPlayerInterior(i, 0);
			SetPlayerVirtualWorld(i, 0);
			ShowGuardRedGreenLightTD(i);
			InGame[i] = 1;
			if(PlayerInfo[i][pLanguage] == 1)
			{
				SendClientMessage(i, -1, ""COL_CYAN"Selamat Datang"COL_WHITE"Ke Match Pertama Anda. Game Anda Akan Bermula Lagi 15 Saat. Bersiap Sedia.");
			}
			else if(PlayerInfo[i][pLanguage] == 2)
			{
				SendClientMessage(i, -1, ""COL_CYAN"Welcome "COL_WHITE"To The First Match. Your Game Will Start In 15 Seconds. Be Prepared.");
			}
			SetTimer("StartFirstMatchTimer", 15000, false);
		}
	}
	return 1;
}

stock IsPlayerNearPlayer(playerid, targetid, Float:radius)
{
	new Float:x, Float:y, Float:z;
	GetPlayerPos(targetid, x, y, z);
	if(IsPlayerInRangeOfPoint(playerid, radius ,x, y, z))
	{
	    return 1;
	}
	return 0;
}


//===============================
main()
{
	print("\n----------------------------------");
	print(" | SQUID GAME PROJECT 2022|");
	print("----------------------------------\n");
}

public OnGameModeInit()
{
	SetGameModeText("SQUID GAME | PROJECT");
	AddPlayerClass(1, 1643.1893,-2238.3225,13.4943, 0.0, 0, 0, 0, 0, 0, 0);
	SetNameTagDrawDistance(30.0);
    AllowInteriorWeapons(1);
	ShowPlayerMarkers(0);
	DisableInteriorEnterExits();
	LobbyTimerCountMinute = 4;
	LobbyTimerCountSecond = 59;
	FirstGameCountMinute = 2;
	FirstGameCountSecond = 59;
	CountVariable = SetTimer("CountTimer", 1000, true);
	//MAPPING
	new SQUIDGAMELOBBY;
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.697143, 1554.354248, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1331.226684, 1554.354248, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1352.185791, 1554.354248, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1352.185791, 1544.723266, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.706665, 1544.723266, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1331.205810, 1544.723266, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1331.205810, 1535.121459, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.677490, 1535.121459, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1352.167358, 1535.121459, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1352.167358, 1525.511108, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.687255, 1525.511108, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1331.206909, 1525.511108, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1331.206909, 1515.889892, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.686523, 1515.889892, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1352.197753, 1515.889892, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1362.697021, 1515.889892, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1362.656982, 1525.490234, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1362.656982, 1535.080322, -33.999134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1362.656982, 1544.691284, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1362.656982, 1554.320922, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1320.787353, 1554.320922, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1320.787353, 1544.689697, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1320.787353, 1535.059082, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1320.787353, 1525.439941, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1320.787353, 1515.821411, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1310.316650, 1515.821411, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1310.306640, 1525.440429, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1310.296630, 1535.060668, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1310.276611, 1544.690307, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1310.286621, 1554.330688, -33.939136, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 15041, "bigsfsave", "AH_flroortile5", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.202148, 1558.278564, -33.253204, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1355.791748, 1558.278564, -33.233234, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1365.411010, 1558.278564, -33.243213, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1324.850585, 1558.278564, -33.273185, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.251831, 1558.278564, -33.283180, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.681396, 1558.278564, -33.273170, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.681396, 1511.078979, -33.233184, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1328.331176, 1564.427978, -33.353183, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.861328, 1564.428588, -33.283206, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19360, 1334.711914, 1564.429199, -28.743192, 0.000000, 0.000000, 89.699897, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19360, 1334.712280, 1564.419189, -25.263200, 0.000000, 0.000000, 89.699897, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19360, 1335.472290, 1564.415161, -28.743192, 0.000000, 0.000000, 89.699897, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19360, 1335.462646, 1564.415649, -25.263200, 0.000000, 0.000000, 89.699897, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.272094, 1511.078979, -33.233169, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1324.892089, 1511.078979, -33.203186, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1334.491455, 1511.078979, -33.203186, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1344.071411, 1511.078979, -33.193172, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1353.700927, 1511.078979, -33.183181, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1363.310546, 1511.078979, -33.173171, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.976928, 1515.747070, -33.163166, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.976928, 1525.376586, -33.173252, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.976928, 1535.006225, -33.193225, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.976928, 1544.625976, -33.193244, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.976928, 1554.225463, -33.193260, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.474121, 1563.015380, -33.283233, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1329.724121, 1563.015380, -33.283233, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.115844, 1554.225463, -33.233169, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.115844, 1544.626098, -33.223163, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.115844, 1534.997192, -33.233165, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.115844, 1525.367309, -33.253208, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.115844, 1515.727539, -33.233188, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.186035, 1515.485961, -33.923160, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.186035, 1515.485961, -33.073158, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.186035, 1515.485961, -32.273155, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.186035, 1515.485961, -31.423177, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.186035, 1515.485961, -30.593172, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-10-percent", 0x00000000);
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(7313, 1335.584228, 1564.319335, -30.501852, 0.000000, 0.000000, -0.399993, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMELOBBY, 0, "{ff0000} WELCOME TO SQUID GAME", 110, "courier", 35, 1, 0x00000000, 0x00000001, 1);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1311.945678, 1515.457397, -33.923160, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1311.945678, 1515.457397, -33.063125, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1311.945678, 1515.457397, -32.223114, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1311.945678, 1515.457397, -31.443113, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1311.974487, 1515.458007, -30.703123, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.694213, 1515.429809, -33.873126, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.694213, 1515.429809, -33.023117, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.694213, 1515.429809, -32.183124, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.694213, 1515.429809, -31.283124, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.736816, 1519.479614, -33.933097, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.736816, 1519.479614, -33.103096, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.736816, 1519.479614, -32.263103, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.736816, 1519.479614, -31.453113, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.137207, 1519.506225, -31.453113, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.137207, 1519.506225, -30.673120, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.137207, 1519.506225, -32.273136, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.137207, 1519.506225, -33.113147, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.137207, 1519.506225, -33.933128, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.427734, 1519.534057, -33.933128, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.427734, 1519.534057, -33.123107, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.427734, 1519.534057, -32.313095, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.427734, 1519.534057, -31.473100, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.427734, 1519.534057, -30.653112, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.775878, 1523.169555, -33.933097, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.775878, 1523.169555, -33.103080, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.775878, 1523.169555, -32.233066, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.775878, 1523.169555, -31.393064, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.166870, 1523.195922, -33.883018, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.166870, 1523.195922, -33.092987, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.166870, 1523.195922, -32.243000, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.166870, 1523.195922, -31.402996, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.166870, 1523.195922, -30.732999, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.557373, 1523.223022, -30.732999, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.557373, 1523.223022, -31.393003, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.557373, 1523.223022, -32.233013, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.557373, 1523.223022, -33.083019, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.557373, 1523.223022, -33.842990, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.597045, 1526.952880, -33.842990, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.207031, 1526.925537, -33.842990, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1526.898315, -33.842990, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1526.898315, -33.022983, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1526.898315, -32.192970, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1526.898315, -31.442968, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1526.925292, -31.442968, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1526.925292, -32.152969, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1526.925292, -33.022968, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1526.952026, -33.022968, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1526.952026, -32.192962, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1526.952026, -31.472976, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1526.952026, -30.822982, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.208251, 1526.924804, -30.822982, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.640502, 1530.932250, -33.012966, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.640502, 1530.932250, -32.172969, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.546997, 1534.866455, -33.842990, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.156982, 1534.839111, -33.842990, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.640502, 1530.932250, -33.772983, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.766967, 1534.811889, -33.842990, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.766967, 1534.811889, -33.022983, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.766967, 1534.811889, -32.192970, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.766967, 1534.811889, -31.442968, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.138061, 1534.838867, -32.152969, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.138061, 1534.838867, -33.022968, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -33.022968, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -32.192962, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -31.472976, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -30.822982, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.158203, 1534.838378, -30.822982, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.640502, 1530.932250, -31.412988, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.640502, 1530.932250, -30.602979, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.546997, 1534.866455, -33.842990, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.156982, 1534.839111, -33.842990, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.204956, 1530.878173, -33.842990, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.766967, 1534.811889, -33.022983, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.766967, 1534.811889, -32.192970, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.766967, 1534.811889, -31.442968, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.138061, 1534.838867, -31.482959, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.138061, 1534.838867, -33.022968, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -33.022968, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -32.192962, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -31.482982, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.558349, 1534.865600, -30.822982, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.158203, 1534.838378, -30.822982, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.204956, 1530.878173, -33.022987, -0.000001, 0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.279907, 1530.904785, -32.172969, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.280639, 1530.904663, -31.412988, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.280639, 1530.904663, -30.562986, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.597045, 1538.663696, -33.842990, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.207031, 1538.636352, -33.842990, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1538.609130, -33.842990, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1538.609130, -33.022983, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1538.609130, -32.192970, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1538.609130, -31.442968, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1538.636108, -31.442968, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1538.636108, -32.152969, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1538.636108, -33.022968, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1538.662841, -33.022968, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1538.662841, -32.192962, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1538.662841, -31.472976, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1538.662841, -30.822982, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.208251, 1538.635620, -30.822982, -0.000002, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.780761, 1530.878295, -33.852973, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.597045, 1542.583496, -33.842990, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.207031, 1542.556152, -33.842990, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1542.528930, -33.842990, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1542.528930, -33.022983, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1542.528930, -32.192970, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1542.528930, -31.442968, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1542.555908, -31.442968, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1542.555908, -32.152969, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1542.555908, -33.022968, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1542.582641, -33.022968, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1542.582641, -32.192962, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1542.582641, -31.472976, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1542.582641, -30.822982, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.208251, 1542.555419, -30.822982, -0.000005, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.780761, 1530.878295, -33.002960, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.780761, 1530.878295, -32.212959, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.780761, 1530.878295, -31.382961, 0.000000, 0.000000, 89.399986, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.597045, 1546.463745, -33.842990, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.207031, 1546.436401, -33.842990, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1546.409179, -33.842990, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1546.409179, -33.022983, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1546.409179, -32.192970, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1546.409179, -31.442968, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1546.436157, -31.442968, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1546.436157, -32.152969, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1546.436157, -33.022968, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1546.462890, -33.022968, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1546.462890, -32.192962, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1546.462890, -31.472976, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1546.462890, -30.822982, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.208251, 1546.435668, -30.822982, -0.000007, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.597045, 1550.093750, -33.842990, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.207031, 1550.066406, -33.842990, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1550.039184, -33.842990, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1550.039184, -33.022983, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1550.039184, -32.192970, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1550.039184, -31.442968, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1550.066162, -31.442968, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1550.066162, -32.152969, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1550.066162, -33.022968, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1550.092895, -33.022968, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1550.092895, -32.192962, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1550.092895, -31.472976, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1550.092895, -30.822982, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.208251, 1550.065673, -30.822982, -0.000010, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.597045, 1553.733764, -33.842990, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.207031, 1553.706420, -33.842990, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1553.679199, -33.842990, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1553.679199, -33.022983, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1553.679199, -32.192970, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1314.817016, 1553.679199, -31.442968, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1553.706176, -31.442968, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1553.706176, -32.152969, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.188110, 1553.706176, -33.022968, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1553.732910, -33.022968, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1553.732910, -32.192962, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1553.732910, -31.472976, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1309.608398, 1553.732910, -30.822982, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1312.208251, 1553.705688, -30.822982, -0.000012, -0.000000, 89.399971, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.848999, 1555.950927, -33.843036, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.240112, 1556.028564, -33.865718, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.631225, 1556.105957, -33.888401, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.623901, 1556.103271, -33.068431, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.616699, 1556.100585, -32.238452, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.609985, 1556.098144, -31.488485, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.237792, 1556.020629, -31.465639, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.244140, 1556.022949, -32.175609, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.251708, 1556.025756, -33.045570, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.830322, 1555.949340, -33.023147, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.823120, 1555.946655, -32.193176, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.816650, 1555.944335, -31.473222, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.811035, 1555.942016, -30.823257, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.212280, 1556.019287, -30.845855, 0.497849, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.744750, 1551.854125, -33.842990, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.134643, 1551.867797, -33.842990, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.524536, 1551.881347, -33.842990, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.524536, 1551.881347, -33.022983, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.524536, 1551.881347, -32.192970, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.524536, 1551.881347, -31.442968, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.153564, 1551.868164, -31.442968, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.153564, 1551.868164, -33.022968, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.733398, 1551.854858, -33.022968, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.733398, 1551.854858, -32.192962, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.733398, 1551.854858, -31.472976, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.733398, 1551.854858, -30.822982, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.133422, 1551.868530, -30.822982, -0.000007, -0.000000, -90.299995, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1547.880371, -33.843036, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1547.958007, -33.865718, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1548.035400, -33.888401, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1548.032714, -33.068431, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1548.030029, -32.238452, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1548.027587, -31.488485, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1547.950073, -31.465639, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1547.952392, -32.175609, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1547.955200, -33.045570, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1547.878784, -33.023147, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1547.876098, -32.193176, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1547.873779, -31.473222, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1547.871459, -30.823257, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1547.948730, -30.845855, 0.497851, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1544.010375, -33.843036, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1544.088012, -33.865718, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1544.165405, -33.888401, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1544.162719, -33.068431, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1544.160034, -32.238452, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1544.157592, -31.488485, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1544.080078, -31.465639, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1544.082397, -32.175609, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1544.085205, -33.045570, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1544.008789, -33.023147, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1544.006103, -32.193176, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1544.003784, -31.473222, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1544.001464, -30.823257, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1544.078735, -30.845855, 0.497854, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1328.331176, 1564.427978, -22.873195, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1540.270263, -33.843036, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1540.347900, -33.865718, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1540.425292, -33.888401, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1540.422607, -33.068431, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1540.419921, -32.238452, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1540.417480, -31.488485, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1540.339965, -31.465639, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1540.342285, -32.175609, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1540.345092, -33.045570, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1540.268676, -33.023147, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1540.265991, -32.193176, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1540.263671, -31.473222, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1540.261352, -30.823257, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1540.338623, -30.845855, 0.497856, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1536.179931, -33.843036, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1536.257568, -33.865718, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1536.334960, -33.888401, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1536.332275, -33.068431, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1536.329589, -32.238452, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1536.327148, -31.488485, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1536.249633, -31.465639, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1536.251953, -32.175609, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1536.254760, -33.045570, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1536.178344, -33.023147, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1536.175659, -32.193176, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1536.173339, -31.473222, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1536.171020, -30.823257, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1536.248291, -30.845855, 0.497859, 0.205232, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1532.150024, -33.843036, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1532.227661, -33.865718, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1532.305053, -33.888401, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1532.302368, -33.068431, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1532.299682, -32.238452, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1532.297241, -31.488485, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1532.219726, -31.465639, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1532.222045, -32.175609, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1532.224853, -33.045570, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1532.148437, -33.023147, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1532.145751, -32.193176, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1532.143432, -31.473222, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1532.141113, -30.823257, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1532.218383, -30.845855, 0.497861, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1528.299682, -33.843036, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1528.377319, -33.865718, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1528.454711, -33.888401, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1528.452026, -33.068431, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1528.449340, -32.238452, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1528.446899, -31.488485, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1528.369384, -31.465639, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1528.371704, -32.175609, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1528.374511, -33.045570, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1528.298095, -33.023147, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1528.295410, -32.193176, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1528.293090, -31.473222, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1528.290771, -30.823257, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1528.368041, -30.845855, 0.497864, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1524.250000, -33.843036, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1524.327636, -33.865718, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1524.405029, -33.888401, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1524.402343, -33.068431, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1524.399658, -32.238452, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1524.397216, -31.488485, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1524.319702, -31.465639, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1524.322021, -32.175609, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1524.324829, -33.045570, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1524.248413, -33.023147, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1524.245727, -32.193176, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1524.243408, -31.473222, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1524.241088, -30.823257, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1524.318359, -30.845855, 0.497866, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1520.399536, -33.843036, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1520.477172, -33.865718, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1520.554565, -33.888401, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1520.551879, -33.068431, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1520.549194, -32.238452, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1520.546752, -31.488485, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1520.469238, -31.465639, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1520.471557, -32.175609, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1520.474365, -33.045570, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1520.397949, -33.023147, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1520.395263, -32.193176, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1520.392944, -31.473222, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1520.390625, -30.823257, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1520.467895, -30.845855, 0.497869, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.871459, 1564.427978, -22.873195, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.241821, 1558.247436, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1355.842041, 1558.247436, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1365.461669, 1558.247436, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.021606, 1558.247436, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.411743, 1558.247436, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.811645, 1558.247436, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.811645, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.441528, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.010864, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1334.640991, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1344.261108, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1353.870483, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1363.500244, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.788940, 1516.289550, -33.843036, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.180053, 1516.367187, -33.865718, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.571166, 1516.444580, -33.888401, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.563842, 1516.441894, -33.068431, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.556640, 1516.439208, -32.238452, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1358.549926, 1516.436767, -31.488485, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.177734, 1516.359252, -31.465639, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.184082, 1516.361572, -32.175609, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.191650, 1516.364379, -33.045570, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.770263, 1516.287963, -33.023147, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.763061, 1516.285278, -32.193176, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.756591, 1516.282958, -31.473222, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1363.750976, 1516.280639, -30.823257, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(2302, 1361.152221, 1516.357910, -30.845855, 0.497876, 0.205233, -91.701789, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 1, 10101, "2notherbuildsfe", "ferry_build14", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1373.010131, 1510.987426, -22.823225, 0.000000, 0.000000, 89.999961, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1329.724121, 1563.015380, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1341.504638, 1563.015380, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.975097, 1553.365722, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.975097, 1543.776000, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.975097, 1534.276000, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.975097, 1524.686157, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.975097, 1515.075805, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.194213, 1515.075805, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.194213, 1524.695434, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.194213, 1534.305419, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.194213, 1543.905517, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1305.194213, 1553.505249, -22.763240, 0.000000, 0.000000, 179.999923, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19360, 1335.462646, 1564.415649, -21.783199, 0.000000, 0.000000, 89.699897, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19360, 1334.752441, 1564.419311, -21.783199, 0.000000, 0.000000, 89.699897, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 9514, "711_sfw", "ws_carpark2", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1336.207153, 1559.584594, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.697631, 1559.584594, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.237792, 1559.584594, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1304.698120, 1559.584594, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.707885, 1559.584594, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1357.197631, 1559.584594, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.666381, 1559.584594, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.666381, 1549.955078, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1357.227294, 1549.955078, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.766723, 1549.955078, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1336.277343, 1549.955078, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.787963, 1549.955078, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.298461, 1549.955078, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1304.797851, 1549.955078, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "blue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1304.797851, 1540.365478, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.257202, 1540.365478, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.747436, 1540.365478, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1336.257568, 1540.365478, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.757324, 1540.365478, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1357.247680, 1540.365478, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.737548, 1540.365478, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.737548, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1357.257324, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.767578, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1336.307617, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1336.307617, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.827880, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.317260, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1304.807250, 1530.716186, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "lightblue", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1304.807250, 1521.087280, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.287719, 1521.087280, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.788696, 1521.087280, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1336.258666, 1521.087280, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.758789, 1521.087280, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1357.260131, 1521.087280, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.739746, 1521.087280, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1367.739746, 1511.477661, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1357.249755, 1511.477661, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1346.780395, 1511.477661, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1336.300537, 1511.477661, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1325.799926, 1511.477661, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1315.319580, 1511.477661, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19379, 1304.759277, 1511.477661, -24.689134, 0.000000, 90.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMELOBBY = CreateDynamicObject(19428, 1335.632324, 1558.105468, -28.675909, -101.400032, -90.000007, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMELOBBY, 0, 18646, "matcolours", "grey-95-percent", 0x00000000);
	SQUIDGAMELOBBYTIMER = CreateDynamicObject(19482, 1337.579833, 1557.814331, -29.588712, 0.000000, -11.999997, -89.999977, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMELOBBYTIMER, 0, "{FF0000} 5.00", 80, "courier", 20, 1, 0x00000000, 0x00000000, 0);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	SQUIDGAMELOBBY = CreateDynamicObject(14410, 1339.377319, 1557.320678, -36.399379, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(14410, 1335.436645, 1557.320678, -36.399379, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(14410, 1331.596191, 1557.320678, -36.399379, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(18756, 1335.174804, 1562.568847, -31.389553, 0.000000, 0.000000, -90.100021, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(18756, 1335.094360, 1566.387939, -31.419555, 0.000000, 0.000000, 89.900039, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(8397, 1335.593139, 1564.409667, -23.563190, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(2229, 1332.288818, 1558.240966, -29.545570, -7.499991, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(2229, 1339.558471, 1558.240966, -29.545570, -7.499991, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(2229, 1368.135864, 1557.985351, -27.255796, -0.199991, 0.000000, -40.800010, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(2229, 1367.688964, 1510.829223, -27.200361, 0.000000, 0.000000, -138.400024, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(2229, 1304.904907, 1511.092895, -26.675764, 0.000000, 0.000000, 138.899993, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(2229, 1305.437866, 1558.417846, -26.715631, 0.000000, 0.000000, 42.800014, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(19121, 1332.820800, 1563.837036, -32.723197, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(19121, 1337.770874, 1563.837036, -32.723197, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(19482, 1335.149169, 1549.373901, -29.403797, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(19143, 1350.500366, 1536.946166, -24.653162, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(3785, 1333.626098, 1557.925781, -28.653202, 0.000000, 0.000000, 275.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(3785, 1337.702026, 1557.808959, -28.653202, 0.000000, 0.000000, 275.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(19143, 1350.500366, 1536.946166, -24.653162, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(19143, 1320.729614, 1536.946166, -24.653162, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMELOBBY = CreateDynamicObject(19143, 1320.729614, 1536.946166, -24.653162, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 

	new SQUIDGAMEFIRSTGAMEMAP;
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -74.324897, 2523.054931, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -74.324897, 2513.455322, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -74.324897, 2503.836181, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -74.324897, 2494.328857, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -74.324897, 2484.776855, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -59.993469, 2527.845214, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -50.373485, 2527.827148, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -40.753479, 2527.807373, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -69.656929, 2480.020996, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -69.573471, 2527.882568, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -59.986927, 2480.003662, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -50.376930, 2479.986328, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -40.796913, 2479.970214, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -36.015018, 2523.054931, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.798995, 2523.054931, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.819084, 2523.054931, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -36.015018, 2503.815917, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -36.015018, 2484.567382, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.339031, 2523.054931, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.309066, 2523.054931, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.798995, 2513.445556, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.298976, 2513.445556, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.818950, 2513.445556, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.328941, 2513.445556, 15.394640, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.328941, 2503.875000, 15.394640, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.818965, 2503.875000, 15.394640, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.309013, 2503.875000, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.809005, 2503.875000, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.809005, 2494.255615, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.328990, 2494.255615, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.848995, 2494.255615, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.368965, 2494.255615, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.368965, 2484.635742, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.848983, 2484.635742, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.318996, 2484.635742, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.808998, 2484.635742, 15.394639, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2489.480712, 17.214372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2489.480712, 20.704368, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2489.480712, 24.194358, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2499.151855, 24.194358, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2499.151855, 20.704359, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2499.151855, 17.234355, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2508.663574, 17.234355, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2508.663574, 20.684364, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2508.663574, 24.134361, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2518.234375, 24.134361, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2518.234375, 20.654346, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2518.234375, 24.204359, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -74.274429, 2518.234375, 17.194349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2518.234375, 20.754356, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2518.234375, 17.264364, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2518.234375, 13.784362, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2508.632324, 13.784362, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2508.632324, 17.264358, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2508.632324, 20.764350, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2508.632324, 24.184352, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2499.093261, 24.184352, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2499.093261, 20.704345, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2499.093261, 17.224348, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2499.093261, 13.684349, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2489.283203, 24.184354, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2489.283203, 20.694351, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -36.024387, 2489.283203, 17.234354, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.701988, 2479.993408, 17.234354, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.701988, 2479.993408, 20.724353, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.701988, 2479.993408, 24.184352, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.191925, 2480.026611, 24.184352, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.191925, 2480.026611, 20.684360, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.191925, 2480.026611, 17.184368, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.831871, 2480.058837, 17.184368, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.831871, 2480.058837, 20.654367, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.831871, 2480.058837, 24.164363, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.665206, 2527.801757, 24.164363, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.665206, 2527.801757, 20.694362, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.665206, 2527.801757, 17.204362, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.188964, 2484.635742, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.188964, 2494.205322, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.188964, 2503.834716, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.188964, 2513.445556, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -41.188964, 2523.064697, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.688964, 2523.064697, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.688964, 2513.424804, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.688964, 2503.814208, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.688964, 2494.204345, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -51.688964, 2484.564697, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.138988, 2484.564697, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.138988, 2494.194091, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.138988, 2503.812988, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.138988, 2513.442382, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -62.138988, 2523.082763, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.628997, 2523.082763, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.628997, 2513.462890, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.628997, 2503.854248, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.628997, 2494.224609, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -72.628997, 2484.594726, 25.854660, 0.000000, 89.999984, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18835, "mickytextures", "metal013", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -31.123493, 2527.789794, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -37.863639, 2479.995117, 20.850543, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -31.123493, 2527.789794, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -21.563520, 2527.772949, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -11.953528, 2527.754638, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -2.393546, 2527.737304, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 7.196439, 2527.720947, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 7.196439, 2527.720947, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 16.776424, 2527.704833, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 26.326406, 2527.686523, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 35.956367, 2527.671142, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -69.211029, 2480.057861, 25.045816, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -72.711029, 2480.064697, 25.039699, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.245258, 2527.767822, 24.164363, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -41.343685, 2480.002197, 20.844459, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -31.207202, 2479.819580, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -44.843708, 2480.008544, 20.838346, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -21.597221, 2479.802246, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -48.333713, 2480.016601, 20.832256, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -11.967234, 2479.784667, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -51.823730, 2480.024169, 20.826156, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -2.387249, 2479.767333, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -55.323719, 2480.031738, 20.820047, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 7.252735, 2479.750488, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -58.793720, 2480.038330, 20.813989, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 16.872716, 2479.732910, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -62.283718, 2480.044921, 20.807893, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 26.492700, 2479.715820, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.245258, 2527.767822, 20.694360, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 36.072704, 2479.699462, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 45.566394, 2527.653076, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 55.136386, 2527.635986, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -69.213684, 2480.058105, 20.795801, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -72.703651, 2480.064697, 20.789707, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -62.241039, 2480.046142, 25.057973, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 64.696365, 2527.618896, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -58.741039, 2480.039062, 25.064075, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 74.346389, 2527.601074, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -55.311046, 2480.032714, 25.070053, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 83.956344, 2527.583984, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -51.811050, 2480.025878, 25.076162, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 93.566299, 2527.566650, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -48.321067, 2480.019775, 25.082246, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 103.186264, 2527.549072, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -44.871051, 2480.012939, 25.088275, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 103.186264, 2527.549072, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 118.556259, 2527.520751, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -41.371070, 2480.006347, 25.094377, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 123.357826, 2522.702148, 20.684360, 0.000000, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 123.357826, 2522.702148, 20.684360, 0.000000, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 123.341056, 2513.092773, 20.684360, 0.000000, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 123.324340, 2503.511230, 20.684360, 0.000000, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 45.662708, 2479.681396, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 55.292690, 2479.663085, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 64.922653, 2479.644775, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 74.592658, 2479.626708, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 84.182640, 2479.608886, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 93.792587, 2479.591796, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 103.402565, 2479.574218, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 113.042526, 2479.557128, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -37.861068, 2479.999267, 25.100503, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 122.582473, 2479.539794, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 123.307762, 2494.021972, 20.684360, 0.000000, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -37.845684, 2479.999267, 16.290510, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 123.290969, 2484.392333, 20.684360, 0.000000, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -41.325675, 2480.005615, 16.284439, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 108.217887, 2522.730712, 10.524415, -0.899999, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1975, "texttest", "kb_red", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -44.805686, 2480.012695, 16.278364, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -48.285682, 2480.019287, 16.272300, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -51.785675, 2480.026367, 16.266197, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -55.285671, 2480.032226, 16.260089, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -58.765686, 2480.038818, 16.254009, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -62.245693, 2480.045410, 16.247936, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -65.745613, 2480.062988, 16.241821, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -69.195655, 2480.058349, 16.235816, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19439, -72.675636, 2480.064941, 16.229743, -90.099998, -1.899999, 87.999984, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "red-3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 108.201103, 2513.102539, 10.373152, -0.899999, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1975, "texttest", "kb_red", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 108.184196, 2503.398681, 10.311994, 0.099999, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1975, "texttest", "kb_red", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -40.836887, 2480.026611, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -50.466888, 2480.043945, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -60.066917, 2480.061035, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, -69.666908, 2480.078369, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 4835, "airoads_las", "grassdry_128HV", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 108.167427, 2493.788818, 10.328770, 0.099999, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1975, "texttest", "kb_red", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 108.150642, 2484.178955, 10.345543, 0.099999, 0.000000, 179.900024, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1975, "texttest", "kb_red", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.245258, 2527.767822, 17.194372, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.575325, 2527.735595, 17.194372, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.575325, 2527.735595, 20.684370, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.575325, 2527.735595, 24.184368, 0.000000, 0.000000, -90.199951, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.741718, 2480.075195, 20.514371, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.741718, 2480.075195, 24.004379, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -45.741718, 2480.075195, 17.044363, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.161689, 2480.091308, 20.724367, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.161689, 2480.091308, 17.244361, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -55.161689, 2480.091308, 24.234369, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.851669, 2480.108398, 24.234369, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.851669, 2480.108398, 20.764369, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.851669, 2480.108398, 17.314369, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19433, -64.851669, 2480.108398, 13.884372, 0.000000, 0.000000, -90.099952, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18646, "matcolours", "grey-93-percent", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19448, 122.877365, 2519.251220, 22.834100, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 3899, "hospital2", "black", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19377, 112.826225, 2527.531250, 20.684360, 0.000000, 0.000000, 89.900016, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 1675, "wshxrefhse", "duskyblue_128", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19448, 122.877365, 2509.660888, 22.874111, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 3899, "hospital2", "black", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19448, 122.877365, 2509.660888, 19.374094, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 3899, "hospital2", "black", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19482, -36.106872, 2503.214355, 20.892187, 0.000000, 0.000000, 179.999969, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0x00000000);
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTGAMEMAP, 0, "{FFFFFF} STAGE", 30, "Calibri", 20, 0, 0x00000000, 0x00000000, 0);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19448, 122.877365, 2519.260986, 19.374094, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 3899, "hospital2", "black", 0x00000000);
	SQUIDGAMEFIRSTMAPTIMER[0] = CreateDynamicObject(19360, 122.848190, 2518.882324, 21.661514, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTMAPTIMER[0], 0, "{ED1111}5", 10, "Ariel", 40, 0, 0x00000000, 0x00000000, 2);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19360, 122.848190, 2516.332031, 21.661514, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTGAMEMAP, 0, "{ED1111}.", 10, "Ariel", 40, 0, 0x00000000, 0x00000000, 1);
	SQUIDGAMEFIRSTMAPTIMER[1] = CreateDynamicObject(19360, 122.848190, 2515.013916, 21.661514, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTMAPTIMER[1], 0, "{ED1111}59", 10, "Ariel", 40, 0, 0x00000000, 0x00000000, 2);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19482, -36.177322, 2502.808593, 19.814371, 0.000000, 0.000000, 178.599975, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTGAMEMAP, 0, "{FFFF01} 1", 10, "Ariel", 20, 0, 0x00000000, 0x00000000, 0);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19482, -35.895889, 2504.361328, 23.714378, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTGAMEMAP, 0, "{FFEEBB} KALAH", 20, "Calibri", 20, 1, 0x00000000, 0x00000000, 0);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19482, -35.883785, 2503.969238, 22.454372, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTGAMEMAP, 0, "{FFEEBB} JANGAN", 20, "Calibri", 20, 1, 0x00000000, 0x00000000, 0);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19482, -35.849845, 2504.517822, 20.944375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTGAMEMAP, 0, "{FFEEBB} NANGIS", 40, "courier", 20, 1, 0x00000000, 0x00000000, 0);
	SQUIDGAMEFIRSTGAMEMAPGLASS[0] = CreateDynamicObject(19377, -36.015018, 2514.354492, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); // CERMIN TUNGGU 15 SAAT
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAPGLASS[0], 0, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAPGLASS[1] = CreateDynamicObject(19377, -36.015018, 2494.741455, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); // CERMIN TUNGGU 15 SAAT
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAPGLASS[1], 0, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19448, -36.059638, 2494.173828, 23.984378, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18787, "matramps", "grating3", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19448, -36.059638, 2513.912841, 23.984378, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAP, 0, 18787, "matramps", "grating3", 0x00000000);
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
	//SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(14467, 108.916381, 2500.735595, 18.154382, 0.000000, 0.000000, 630.000000, -1, -1, -1, 300.00, 300.00); // Redlightstatue
	SQUIDGAMEFIRSTGAMEMAPSTATUE = CreateDynamicObject(14467, 109.506362, 2501.256103, 18.154382, 0.000000, 0.000000, 810.000000, -1, -1, -1, 300.00, 300.00); // GreenLightStatue
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19425, -36.136016, 2491.699462, 15.484375, 0.000000, 0.000000, 89.899971, -1, -1, -1, 300.00, 300.00); 
	//SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(1946, 106.461563, 2507.605224, 15.644375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); // nearwinball
	//SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(1946, 108.351539, 2507.605224, 15.644375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); // passedgameball
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19425, -36.130245, 2495.008789, 15.484375, 0.000000, 0.000000, 89.899971, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19425, -36.124473, 2498.308837, 15.484375, 0.000000, 0.000000, 89.899971, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19425, -36.102199, 2511.078613, 15.484375, 0.000000, 0.000000, 89.899971, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19425, -36.096488, 2514.349365, 15.484375, 0.000000, 0.000000, 89.899971, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(19425, -36.090778, 2517.620605, 15.484375, 0.000000, 0.000000, 89.899971, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(715, 113.113594, 2500.376953, 23.544363, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2232, -36.500846, 2527.276611, 16.114364, 0.000000, 0.000000, -43.299983, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2232, -36.505577, 2480.524169, 16.044330, -0.799999, 0.000000, -140.999984, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2232, -73.717819, 2480.639648, 16.024368, 0.000000, 0.000000, 129.700012, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2232, -73.819686, 2527.387207, 16.082168, 0.000000, 0.000000, 38.499984, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -46.482330, 2489.410156, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -56.972339, 2489.410156, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -67.422302, 2489.410156, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -67.422302, 2499.012207, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -67.422302, 2508.653076, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -67.422302, 2518.313476, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -57.022315, 2518.313476, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -46.462333, 2518.313476, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -46.462333, 2508.633789, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2026, -46.462333, 2499.032958, 25.824375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(1508, -74.212821, 2503.742675, 17.064380, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2985, 108.664932, 2497.471679, 15.484375, 0.000000, 0.000000, -178.699996, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2985, 108.805313, 2491.280517, 15.484375, 0.000000, 0.000000, -178.699996, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2985, 108.408752, 2508.756347, 15.484375, 0.000000, 0.000000, -178.699996, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2985, 108.271949, 2514.785400, 15.484375, 0.000000, 0.000000, -178.699996, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2985, -35.565086, 2503.799804, 15.484375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2985, -35.565086, 2484.409912, 15.484375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 
	SQUIDGAMEFIRSTGAMEMAP = CreateDynamicObject(2985, -35.565086, 2522.607666, 15.484375, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); 

	//END OF MAPPING

	//TEXTDRAW
	GUARDREDGREENLIGHTTD[0] = TextDrawCreate(119.000000, 259.000000, "Preview_Model");
	TextDrawFont(GUARDREDGREENLIGHTTD[0], 5);
	TextDrawLetterSize(GUARDREDGREENLIGHTTD[0], 0.600000, 2.000000);
	TextDrawTextSize(GUARDREDGREENLIGHTTD[0], 112.500000, 150.000000);
	TextDrawSetOutline(GUARDREDGREENLIGHTTD[0], 0);
	TextDrawSetShadow(GUARDREDGREENLIGHTTD[0], 0);
	TextDrawAlignment(GUARDREDGREENLIGHTTD[0], 1);
	TextDrawColor(GUARDREDGREENLIGHTTD[0], -1);
	TextDrawBackgroundColor(GUARDREDGREENLIGHTTD[0], 0);
	TextDrawBoxColor(GUARDREDGREENLIGHTTD[0], 255);
	TextDrawUseBox(GUARDREDGREENLIGHTTD[0], 0);
	TextDrawSetProportional(GUARDREDGREENLIGHTTD[0], 1);
	TextDrawSetSelectable(GUARDREDGREENLIGHTTD[0], 0);
	TextDrawSetPreviewModel(GUARDREDGREENLIGHTTD[0], 22);
	TextDrawSetPreviewRot(GUARDREDGREENLIGHTTD[0], -10.000000, 0.000000, 21.000000, 1.000000);
	TextDrawSetPreviewVehCol(GUARDREDGREENLIGHTTD[0], 1, 1);

	GUARDREDGREENLIGHTTD[1] = TextDrawCreate(295.000000, 292.000000, "_");
	TextDrawFont(GUARDREDGREENLIGHTTD[1], 1);
	TextDrawLetterSize(GUARDREDGREENLIGHTTD[1], 0.600000, 10.300003);
	TextDrawTextSize(GUARDREDGREENLIGHTTD[1], 298.500000, 195.000000);
	TextDrawSetOutline(GUARDREDGREENLIGHTTD[1], 1);
	TextDrawSetShadow(GUARDREDGREENLIGHTTD[1], 0);
	TextDrawAlignment(GUARDREDGREENLIGHTTD[1], 2);
	TextDrawColor(GUARDREDGREENLIGHTTD[1], -1);
	TextDrawBackgroundColor(GUARDREDGREENLIGHTTD[1], 255);
	TextDrawBoxColor(GUARDREDGREENLIGHTTD[1], -16711681);
	TextDrawUseBox(GUARDREDGREENLIGHTTD[1], 1);
	TextDrawSetProportional(GUARDREDGREENLIGHTTD[1], 1);
	TextDrawSetSelectable(GUARDREDGREENLIGHTTD[1], 0);

	GUARDREDGREENLIGHTTD[2] = TextDrawCreate(238.000000, 269.000000, "SQUARE GUARD :");
	TextDrawFont(GUARDREDGREENLIGHTTD[2], 1);
	TextDrawLetterSize(GUARDREDGREENLIGHTTD[2], 0.308333, 1.800003);
	TextDrawTextSize(GUARDREDGREENLIGHTTD[2], 298.500000, 140.000000);
	TextDrawSetOutline(GUARDREDGREENLIGHTTD[2], 1);
	TextDrawSetShadow(GUARDREDGREENLIGHTTD[2], 0);
	TextDrawAlignment(GUARDREDGREENLIGHTTD[2], 2);
	TextDrawColor(GUARDREDGREENLIGHTTD[2], -1);
	TextDrawBackgroundColor(GUARDREDGREENLIGHTTD[2], 255);
	TextDrawBoxColor(GUARDREDGREENLIGHTTD[2], -16711681);
	TextDrawUseBox(GUARDREDGREENLIGHTTD[2], 0);
	TextDrawSetProportional(GUARDREDGREENLIGHTTD[2], 1);
	TextDrawSetSelectable(GUARDREDGREENLIGHTTD[2], 0);

	GUARDREDGREENLIGHTTD[3] = TextDrawCreate(196.000000, 291.000000, "The player can move if the doll says Green Light and stop when it says Red Light. If a player moves when the");
	TextDrawFont(GUARDREDGREENLIGHTTD[3], 1);
	TextDrawLetterSize(GUARDREDGREENLIGHTTD[3], 0.237500, 1.800003);
	TextDrawTextSize(GUARDREDGREENLIGHTTD[3], 399.500000, 203.000000);
	TextDrawSetOutline(GUARDREDGREENLIGHTTD[3], 1);
	TextDrawSetShadow(GUARDREDGREENLIGHTTD[3], 0);
	TextDrawAlignment(GUARDREDGREENLIGHTTD[3], 1);
	TextDrawColor(GUARDREDGREENLIGHTTD[3], -1);
	TextDrawBackgroundColor(GUARDREDGREENLIGHTTD[3], 255);
	TextDrawBoxColor(GUARDREDGREENLIGHTTD[3], -16711681);
	TextDrawUseBox(GUARDREDGREENLIGHTTD[3], 0);
	TextDrawSetProportional(GUARDREDGREENLIGHTTD[3], 1);
	TextDrawSetSelectable(GUARDREDGREENLIGHTTD[3], 0);

	GUARDREDGREENLIGHTTD[4] = TextDrawCreate(298.000000, 323.000000, "doll turns around or");
	TextDrawFont(GUARDREDGREENLIGHTTD[4], 1);
	TextDrawLetterSize(GUARDREDGREENLIGHTTD[4], 0.237500, 1.800003);
	TextDrawTextSize(GUARDREDGREENLIGHTTD[4], 399.500000, 203.000000);
	TextDrawSetOutline(GUARDREDGREENLIGHTTD[4], 1);
	TextDrawSetShadow(GUARDREDGREENLIGHTTD[4], 0);
	TextDrawAlignment(GUARDREDGREENLIGHTTD[4], 1);
	TextDrawColor(GUARDREDGREENLIGHTTD[4], -1);
	TextDrawBackgroundColor(GUARDREDGREENLIGHTTD[4], 255);
	TextDrawBoxColor(GUARDREDGREENLIGHTTD[4], -16711681);
	TextDrawUseBox(GUARDREDGREENLIGHTTD[4], 0);
	TextDrawSetProportional(GUARDREDGREENLIGHTTD[4], 1);
	TextDrawSetSelectable(GUARDREDGREENLIGHTTD[4], 0);

	GUARDREDGREENLIGHTTD[5] = TextDrawCreate(196.000000, 338.000000, "does not cross the finish line within the given time limit, they will automatically get shot and eliminated from the game");
	TextDrawFont(GUARDREDGREENLIGHTTD[5], 1);
	TextDrawLetterSize(GUARDREDGREENLIGHTTD[5], 0.237500, 1.800003);
	TextDrawTextSize(GUARDREDGREENLIGHTTD[5], 399.500000, 203.000000);
	TextDrawSetOutline(GUARDREDGREENLIGHTTD[5], 1);
	TextDrawSetShadow(GUARDREDGREENLIGHTTD[5], 0);
	TextDrawAlignment(GUARDREDGREENLIGHTTD[5], 1);
	TextDrawColor(GUARDREDGREENLIGHTTD[5], -1);
	TextDrawBackgroundColor(GUARDREDGREENLIGHTTD[5], 255);
	TextDrawBoxColor(GUARDREDGREENLIGHTTD[5], -16711681);
	TextDrawUseBox(GUARDREDGREENLIGHTTD[5], 0);
	TextDrawSetProportional(GUARDREDGREENLIGHTTD[5], 1);
	TextDrawSetSelectable(GUARDREDGREENLIGHTTD[5], 0);

	GUARDREDGREENLIGHTTD[6] = TextDrawCreate(361.000000, 259.000000, "Preview_Model");
	TextDrawFont(GUARDREDGREENLIGHTTD[6], 5);
	TextDrawLetterSize(GUARDREDGREENLIGHTTD[6], 0.600000, 2.000000);
	TextDrawTextSize(GUARDREDGREENLIGHTTD[6], 112.500000, 150.000000);
	TextDrawSetOutline(GUARDREDGREENLIGHTTD[6], 0);
	TextDrawSetShadow(GUARDREDGREENLIGHTTD[6], 0);
	TextDrawAlignment(GUARDREDGREENLIGHTTD[6], 1);
	TextDrawColor(GUARDREDGREENLIGHTTD[6], -1);
	TextDrawBackgroundColor(GUARDREDGREENLIGHTTD[6], 0);
	TextDrawBoxColor(GUARDREDGREENLIGHTTD[6], 255);
	TextDrawUseBox(GUARDREDGREENLIGHTTD[6], 0);
	TextDrawSetProportional(GUARDREDGREENLIGHTTD[6], 1);
	TextDrawSetSelectable(GUARDREDGREENLIGHTTD[6], 0);
	TextDrawSetPreviewModel(GUARDREDGREENLIGHTTD[6], 22);
	TextDrawSetPreviewRot(GUARDREDGREENLIGHTTD[6], -10.000000, 0.000000, -23.000000, 1.000000);
	TextDrawSetPreviewVehCol(GUARDREDGREENLIGHTTD[6], 1, 1);

	REDGREENLIGHT[0] = TextDrawCreate(312.000000, 44.000000, "GREEN LIGHT");
	TextDrawFont(REDGREENLIGHT[0], 1);
	TextDrawLetterSize(REDGREENLIGHT[0], 0.341666, 2.300003);
	TextDrawTextSize(REDGREENLIGHT[0], 298.500000, 110.000000);
	TextDrawSetOutline(REDGREENLIGHT[0], 1);
	TextDrawSetShadow(REDGREENLIGHT[0], 0);
	TextDrawAlignment(REDGREENLIGHT[0], 2);
	TextDrawColor(REDGREENLIGHT[0], -1);
	TextDrawBackgroundColor(REDGREENLIGHT[0], 255);
	TextDrawBoxColor(REDGREENLIGHT[0], 16711915);
	TextDrawUseBox(REDGREENLIGHT[0], 1);
	TextDrawSetProportional(REDGREENLIGHT[0], 1);
	TextDrawSetSelectable(REDGREENLIGHT[0], 0);

	REDGREENLIGHT[1] = TextDrawCreate(312.000000, 44.000000, "RED LIGHT");
	TextDrawFont(REDGREENLIGHT[1], 1);
	TextDrawLetterSize(REDGREENLIGHT[1], 0.341666, 2.300003);
	TextDrawTextSize(REDGREENLIGHT[1], 298.500000, 110.000000);
	TextDrawSetOutline(REDGREENLIGHT[1], 1);
	TextDrawSetShadow(REDGREENLIGHT[1], 0);
	TextDrawAlignment(REDGREENLIGHT[1], 2);
	TextDrawColor(REDGREENLIGHT[1], -1);
	TextDrawBackgroundColor(REDGREENLIGHT[1], 255);
	TextDrawBoxColor(REDGREENLIGHT[1], -16776981);
	TextDrawUseBox(REDGREENLIGHT[1], 1);
	TextDrawSetProportional(REDGREENLIGHT[1], 1);
	TextDrawSetSelectable(REDGREENLIGHT[1], 0);

	//END OF TEXTDRAW
	return 1;
}
CMD:go(playerid, params[])
{
	SetPlayerPos(playerid, 1333.626098, 1557.925781, -28.653202);
	return true;
}
CMD:rules(playerid, params[])
{
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Rules Server", ""COL_RED"Rules Server:\n"COL_WHITE"Do Not Use Any Cheat"COL_RED"(Permenant Ban)\n"COL_WHITE"Watch Your Word When Talking To Other People.\n\n"COL_YELLOW"(c) Squid Game Project 2022", "Okay", "Tutup");
	return true;
}
public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
	SetPlayerPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraPos(playerid, 1958.3783, 1343.1572, 15.3746);
	SetPlayerCameraLookAt(playerid, 1958.3783, 1343.1572, 15.3746);
	PlayAudioStreamForPlayer(playerid, "http://www.mboxdrive.com/LobbySoundDanial.mp3");
	new file[60], name[MAX_PLAYER_NAME];
	GetPlayerName(playerid, name, sizeof(name));
	format(file, sizeof(file), "UserData/%s.ini", name);
	if(!dini_Exists(file))
	{
		new string[180];
		format(string, sizeof(string), ""COL_WHITE"Welcome To Squid Game Project\nAccount Name: "COL_GREEN"%s\n\n"COL_PURPLE"Attention:\n"COL_WHITE"Password Must Contain At Least 5 To 20 Character(Strong Password)", GetName(playerid));
		ShowPlayerDialog(playerid, DIALOG_DAFTAR, DIALOG_STYLE_INPUT, "Register Account", string, "Register", "Exit");
	}
	if(dini_Exists(file))
	{
		new string[180];
		format(string, sizeof(string), ""COL_WHITE"Welcome To Squid Game Project\nAccount Name: "COL_GREEN"%s\n\n"COL_YELLOW"(c) Squid Game Project 2022", GetName(playerid));
		ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Login Account", string, "Login", "Exit");
	}
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, -1, "Loaded GM Latest");
	RegisteredPlayer[playerid] = 0;
	LoggedIn[playerid] = 0;
	InGame[playerid] = 0;
	DontMove[playerid] = 0;
	godmode[playerid] = 0;
	return 1; 
}

public OnPlayerDisconnect(playerid, reason)
{
	return 1;
}
CMD:playsong(playerid, params[])
{
	PlayAudioStreamForPlayer(playerid, "http://www.mboxdrive.com/LobbySoundDanial.mp3");
	return true;
}

CMD:mutemusic(playerid, params[])
{
	StopAudioStreamForPlayer(playerid);
	return true;
}

public OnPlayerSpawn(playerid)
{
	StopAudioStreamForPlayer(playerid);
	PlayAudioStreamForPlayer(playerid, "http://www.mboxdrive.com/LobbySoundDanial.mp3");
	LoggedIn[playerid] = 1;
	RegisteredPlayer[playerid] = 0;
	InGame[playerid] = 0;
	new randSpawn = random(sizeof(LoggedInSpawn));
	SetPlayerSkin(playerid, 45);
	SetPlayerPos(playerid, LoggedInSpawn[randSpawn][0], LoggedInSpawn[randSpawn][1], LoggedInSpawn[randSpawn][2]);
	SetPlayerCheckpoint(playerid, 1335.2927,1563.6414,-32.2119, 2.0);
    TogglePlayerControllable(playerid, false);
    SetTimerEx("UnFreeze", 3000, false, "i", playerid);
	if(PlayerInfo[playerid][pAdmin] == 5)
	{
		if(PlayerInfo[playerid][pLanguage] == 1)
		{
			new string[180];
			format(string, sizeof(string), ""COL_OWNER"[OWNER]"COL_WHITE"%s Telah Menyertai Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
		else if(PlayerInfo[playerid][pLanguage] == 2)
		{
			new string[180];
			format(string, sizeof(string), ""COL_OWNER"[OWNER]"COL_WHITE"%s Has Joined The Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
	}
	else if(PlayerInfo[playerid][pAdmin] == 4)
	{
		if(PlayerInfo[playerid][pLanguage] == 1)
		{
			new string[180];
			format(string, sizeof(string), ""COL_DEV"[DEVELOPER]"COL_WHITE"%s Telah Menyertai Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
		else if(PlayerInfo[playerid][pLanguage] == 2)
		{
			new string[180];
			format(string, sizeof(string), ""COL_DEV"[DEVELOPER]"COL_WHITE"%s Has Joined The Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
	}
	else if(PlayerInfo[playerid][pAdmin] == 3)
	{
		if(PlayerInfo[playerid][pLanguage] == 1)
		{
			new string[180];
			format(string, sizeof(string), ""COL_MODERATOR"[MODERATOR]"COL_WHITE"%s Telah Menyertai Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
		else if(PlayerInfo[playerid][pLanguage] == 2)
		{
			new string[180];
			format(string, sizeof(string), ""COL_MODERATOR"[MODERATOR]"COL_WHITE"%s Has Joined The Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
	}
	else if(PlayerInfo[playerid][pAdmin] == 2)
	{
		if(PlayerInfo[playerid][pLanguage] == 1)
		{
			new string[180];
			format(string, sizeof(string), ""COL_ADMIN"[ADMIN]"COL_WHITE"%s Telah Menyertai Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
		else if(PlayerInfo[playerid][pLanguage] == 2)
		{
			new string[180];
			format(string, sizeof(string), ""COL_ADMIN"[ADMIN]"COL_WHITE"%s Has Joined The Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
	}
	else if(PlayerInfo[playerid][pAdmin] == 1)
	{
		if(PlayerInfo[playerid][pLanguage] == 1)
		{
			new string[180];
			format(string, sizeof(string), ""COL_STAFF"[STAFF]"COL_WHITE"%s Telah Menyertai Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
		else if(PlayerInfo[playerid][pLanguage] == 2)
		{
			new string[180];
			format(string, sizeof(string), ""COL_STAFF"[STAFF]"COL_WHITE"%s Has Joined The Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
	}
	else if(PlayerInfo[playerid][pAdmin] == 0)
	{
		if(PlayerInfo[playerid][pLanguage] == 1)
		{
			new string[180];
			format(string, sizeof(string), ""COL_WHITE"[PLAYER]"COL_WHITE"%s Telah Menyertai Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
		else if(PlayerInfo[playerid][pLanguage] == 2)
		{
			new string[180];
			format(string, sizeof(string), ""COL_WHITE"[PLAYER]"COL_WHITE"%s Has Joined The Server.", GetName(playerid));
			SendClientMessageToAll(-1, string);
		}
	}
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	RegisteredPlayer[playerid] = 0;
	InGame[playerid] = 0;
	PassedGame[playerid] = 0;
	DontMove[playerid] = 0;
	HideAllTD(playerid);
	return 1;
}

public OnVehicleSpawn(vehicleid)
{
	return 1;
}

public OnVehicleDeath(vehicleid, killerid)
{
	return 1;
}

public OnPlayerText(playerid, text[])
{
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	if (strcmp("/mycommand", cmdtext, true, 10) == 0)
	{
		// Do something here
		return 1;
	}
	return 0;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
	return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	if(IsPlayerInRangeOfPoint(playerid, 2.0, 1335.2927,1563.6414,-32.2119))
	{
		RegisteredPlayer[playerid] = 1;
		DisablePlayerCheckpoint(playerid);
		if(PlayerInfo[playerid][pLanguage] == 1)
		{
			SendClientMessage(playerid, -1, ""COL_YELLOW"[System]:"COL_WHITE"Anda Telah Register Untuk Menyertai Game.");
		}
		else if(PlayerInfo[playerid][pLanguage] == 2)
		{
			SendClientMessage(playerid, -1, ""COL_YELLOW"[System]:"COL_WHITE"You Had Registered To Join The Game.");
		}
	}
	return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
	return 1;
}

public OnPlayerEnterRaceCheckpoint(playerid)
{
	return 1;
}

public OnPlayerLeaveRaceCheckpoint(playerid)
{
	return 1;
}

public OnRconCommand(cmd[])
{
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	SendClientMessage(playerid, -1, ""COL_RED"You Must Login/Register To Spawn!");
	return 0;
}

public OnObjectMoved(objectid)
{
	return 1;
}

public OnPlayerObjectMoved(playerid, objectid)
{
	return 1;
}

public OnPlayerPickUpPickup(playerid, pickupid)
{
	return 1;
}

public OnVehicleMod(playerid, vehicleid, componentid)
{
	return 1;
}

public OnVehiclePaintjob(playerid, vehicleid, paintjobid)
{
	return 1;
}

public OnVehicleRespray(playerid, vehicleid, color1, color2)
{
	return 1;
}

public OnPlayerSelectedMenuRow(playerid, row)
{
	return 1;
}

public OnPlayerExitedMenu(playerid)
{
	return 1;
}

public OnPlayerInteriorChange(playerid, newinteriorid, oldinteriorid)
{
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
	if(FirstGameCountSecond == 0 && FirstGameCountMinute == 0)
	{
		ResetAllTimer();
		if(RegisteredPlayer[playerid] == 1 && InGame[playerid] == 1 && PassedGame[playerid] == 0)
		{
			new string[180];
			format(string, sizeof(string), ""COL_RED"%s Has Been Eliminated"COL_YELLOW"[Not Enough Time]", GetName(playerid));
			SetPlayerHealth(playerid, 0);
			SendClientMessage(playerid, -1, string);
		}
	}
	if(RegisteredPlayer[playerid] == 1 && InGame[playerid] == 1)
	{
		if(PassedGame[playerid] == 0)
		{
			new Float:x, Float:y, Float:z;
			GetPlayerPos(playerid, x, y, z);
			if(x >= 106.461563)
			{
				PassedGame[playerid] = 1;
				new string[180];
				format(string, sizeof(string), ""COL_GREEN"[PASSED]:"COL_WHITE"%s Has Passed The First Game!", GetName(playerid));
				SendClientMessageToAll(-1, string);
			}
		}
		if(InGame[playerid] == 1 && DontMove[playerid] == 1 && PassedGame[playerid] == 0)
		{
			if(IsPlayerMoving(playerid))
			{
				if(godmode[playerid] == 0)
				{
					SetPlayerHealth(playerid, 0);
					RegisteredPlayer[playerid] = 0;
					InGame[playerid] = 0;
					new string[180];
					format(string, sizeof(string), ""COL_YELLOW"[ELIMINATED]:"COL_WHITE"%s Moved!", GetName(playerid));
					SendClientMessageToAll(-1, string);
				}
			}
		}
	}
	return 1;
}

public OnPlayerStreamIn(playerid, forplayerid)
{
	return 1;
}

public OnPlayerStreamOut(playerid, forplayerid)
{
	return 1;
}

public OnVehicleStreamIn(vehicleid, forplayerid)
{
	return 1;
}

public OnVehicleStreamOut(vehicleid, forplayerid)
{
	return 1;
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
	if(dialogid == DIALOG_DAFTAR)
	{
		if(!response) return Kick(playerid);
		if (!strlen(inputtext))
		{
			new string[180];
			format(string, sizeof(string), ""COL_WHITE"Welcome To Squid Game Project\nAccount Name: "COL_GREEN"%s\n\n"COL_PURPLE"Attention:\n"COL_WHITE"Password Must Contain At Least 5 To 20 Character(Strong Password)\nYour Account's Password Is Permenant, So Don't Forget It.\n\n"COL_RED"Rules Server:\n"COL_WHITE"Do Not Use Any Cheat"COL_RED"(Permenant Ban)\n"COL_WHITE"Watch Your Word When Talking To Other People.\n\n"COL_YELLOW"(c) Squid Game Project 2022", GetName(playerid));
			ShowPlayerDialog(playerid, DIALOG_DAFTAR, DIALOG_STYLE_INPUT, "Register Account", string, "Register", "Exit");
		}
		new file[60], name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		format(file, sizeof(file), "UserData/%s.ini", name);
		dini_Create(file);
        dini_IntSet(file, "pPass", udb_hash(inputtext));
        dini_IntSet(file, "pScore", PlayerInfo[playerid][pScore] = 0);
        dini_IntSet(file, "pLevel", PlayerInfo[playerid][pLevel] = 0);
        dini_IntSet(file, "pExp", PlayerInfo[playerid][pExp] = 0);
        dini_IntSet(file, "pAdmin", PlayerInfo[playerid][pAdmin] = 0);
        dini_IntSet(file, "pSkin", PlayerInfo[playerid][pSkin] = 45);
        dini_IntSet(file, "pMoney", PlayerInfo[playerid][pMoney] = 10000);
        dini_IntSet(file, "pLanguage", PlayerInfo[playerid][pLanguage] = 2);
        ResetPlayerMoney(playerid);
        SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
        SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
        GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
        ShowPlayerDialog(playerid, DIALOG_CHOOSELANGUAGE, DIALOG_STYLE_LIST, "Choose Language", "Malay Language\nEnglish Language", "Choose", "");
	}
	if(dialogid == DIALOG_LOGIN)
	{
		if(!response) return Kick(playerid);
		if(!strlen(inputtext))
		{
			new string[180];
			format(string, sizeof(string), ""COL_WHITE"Welcome To Squid Game Project\nAccount Name: "COL_GREEN"%s\n\n"COL_RED"Rules Server:\n"COL_WHITE"Do Not Use Any Cheat"COL_RED"(Permenant Ban)\n"COL_WHITE"Watch Your Word When Talking To Other People.\n\n"COL_YELLOW"(c) Squid Game Project 2022", GetName(playerid));
			ShowPlayerDialog(playerid, DIALOG_LOGIN, DIALOG_STYLE_INPUT, "Login Account", string, "Login", "Exit");
		}
		new file[60], name[MAX_PLAYER_NAME];
		GetPlayerName(playerid, name, sizeof(name));
		format(file, sizeof(file), "UserData/%s.ini", name);
		new tmp;
        tmp = dini_Int(file, "pPass");
        if(udb_hash(inputtext) == tmp)
       	{
       		PlayerInfo[playerid][pScore] = dini_Int(file, "pScore");
       		PlayerInfo[playerid][pLevel] = dini_Int(file, "pLevel");
       		PlayerInfo[playerid][pExp] = dini_Int(file, "pExp");
       		PlayerInfo[playerid][pAdmin] = dini_Int(file, "pAdmin");
       		PlayerInfo[playerid][pSkin] = dini_Int(file, "pSkin");
       		PlayerInfo[playerid][pMoney] = dini_Int(file, "pMoney");
       		PlayerInfo[playerid][pLanguage] = dini_Int(file, "pLanguage");
       		ResetPlayerMoney(playerid);
        	SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
        	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
        	GivePlayerMoney(playerid, PlayerInfo[playerid][pMoney]);
       		SpawnPlayer(playerid);
       	}
	}
	if(dialogid == DIALOG_CHOOSELANGUAGE)
	{
		if(response)
		{
			if(listitem == 0)
			{
				new file[60], name[MAX_PLAYER_NAME];
				GetPlayerName(playerid, name, sizeof(name));
				format(file, sizeof(file), "UserData/%s.ini", name);
				dini_IntSet(file, "pLanguage", PlayerInfo[playerid][pLanguage] = 1);
				SpawnPlayer(playerid);
			}
			if(listitem == 1)
			{
				new file[60], name[MAX_PLAYER_NAME];
				GetPlayerName(playerid, name, sizeof(name));
				format(file, sizeof(file), "UserData/%s.ini", name);
				dini_IntSet(file, "pLanguage", PlayerInfo[playerid][pLanguage] = 2);
				SpawnPlayer(playerid);
			}
		}
	}
	return 1;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}
CMD:skip(playerid, params[])
{
	LobbyTimerCountSecond = 10;
	LobbyTimerCountMinute = 0;
	return true;
}

CMD:god(playerid, params[])
{
	godmode[playerid] = 1;
	return true;
}
//================ FORWARDS ===================
//ALL FORWARDS
forward bool:IsPlayerMoving(playerid);
public bool:IsPlayerMoving(playerid)
{
    new Float:Velocity[3];
    GetPlayerVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
    if(Velocity[0] == 0 && Velocity[1] == 0 && Velocity[2] == 0) return false;
    return true;
}

forward bool:IsVehicleMoving(playerid);
public bool:IsVehicleMoving(playerid)
{
    new Float:Velocity[3];
    GetVehicleVelocity(playerid, Velocity[0], Velocity[1], Velocity[2]);
    if(Velocity[0] == 0 && Velocity[1] == 0 && Velocity[2] == 0) return false;
    return true;
}

forward UnFreeze(playerid);
public UnFreeze(playerid)
{
	TogglePlayerControllable(playerid, true);
	return true;
}
// ========= FORWARD TIMER
forward CountTimer();
public CountTimer()
{
	LobbyTimerCountSecond -= 1;
	if(LobbyTimerCountSecond == 0)
	{
		if(LobbyTimerCountMinute == 0)
		{
			LobbyTimerCountMinute = 5;
			LobbyTimerCountSecond = 0;
			StartFirstMatch();
			KillTimer(CountVariable);
		}
		LobbyTimerCountSecond = 59;
		LobbyTimerCountMinute -= 1;
	}
	new string[60];
	format(string, sizeof(string), "{FF0000} %d.%d", LobbyTimerCountMinute, LobbyTimerCountSecond);
	SetDynamicObjectMaterialText(SQUIDGAMELOBBYTIMER, 0, string, 80, "courier", 20, 1, 0x00000000, 0x00000000, 0);
	return true;
}

forward FirstMapCountTimer();
public FirstMapCountTimer()
{
	FirstGameCountSecond -= 1;
	if(FirstGameCountSecond == 0)
	{
		if(FirstGameCountMinute == 0)
		{
			KillTimer(FirstMapCountVariable);
		}
		FirstGameCountSecond = 59;
		FirstGameCountMinute -= 1;
	}
	new string[180];
	format(string, sizeof(string), "{ED1111}%d", FirstGameCountMinute);
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTMAPTIMER[0], 0, string, 10, "Ariel", 40, 0, 0x00000000, 0x00000000, 2);
	format(string, sizeof(string), "{ED1111}%d", FirstGameCountSecond); 
	SetDynamicObjectMaterialText(SQUIDGAMEFIRSTMAPTIMER[1], 0, string, 10, "Ariel", 40, 0, 0x00000000, 0x00000000, 2);
	return true;
}

forward StartFirstMatchTimer();
public StartFirstMatchTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(RegisteredPlayer[i] == 1 && InGame[i] == 1)
		{
			StopAudioStreamForPlayer(i);
			HideGuardRedGreenLightTD(i);
			ShowGreenLightTD(i);
			SetTimer("GreenLightTimer", 3000, false);
			FirstMapCountVariable = SetTimer("FirstMapCountTimer", 1000, true);
			SetTimer("DestroyGlassFirstMapTimer", 3000, false);
			DontMove[i] = 0;
		}
	}
	return true;
}

forward ResetAllTimer();
public ResetAllTimer()
{
	KillTimer(FirstMapCountVariable);
	CountVariable = SetTimer("CountTimer", 1000, true);
	return 1;
}

forward DestroyGlassFirstMapTimer();
public DestroyGlassFirstMapTimer()
{
	DestroyDynamicObject(SQUIDGAMEFIRSTGAMEMAPGLASS[0]);
	DestroyDynamicObject(SQUIDGAMEFIRSTGAMEMAPGLASS[1]);
	SetTimer("RebuildGlassFirstMapTimer", 20000, false);
	return true;
}

forward RebuildGlassFirstMapTimer();
public RebuildGlassFirstMapTimer()
{
	SQUIDGAMEFIRSTGAMEMAPGLASS[0] = CreateDynamicObject(19377, -36.015018, 2514.354492, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); // CERMIN TUNGGU 15 SAAT
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAPGLASS[0], 0, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
	SQUIDGAMEFIRSTGAMEMAPGLASS[1] = CreateDynamicObject(19377, -36.015018, 2494.741455, 20.684360, 0.000000, 0.000000, 0.000000, -1, -1, -1, 300.00, 300.00); // CERMIN TUNGGU 15 SAAT
	SetDynamicObjectMaterial(SQUIDGAMEFIRSTGAMEMAPGLASS[1], 0, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
	return true;
}

forward RedLightTimer();
public RedLightTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(RegisteredPlayer[i] == 1 && InGame[i] == 1)
		{
			HideGuardRedGreenLightTD(i);
			HideGreenLightTD(i);
			SetDynamicObjectPos(SQUIDGAMEFIRSTGAMEMAPSTATUE, 108.916381, 2500.735595, 18.154382);
			ShowRedLightTD(i);
			SetTimer("GreenLightTimer", 3000, false);
			DontMove[i] = 1;
		}
	}
	return true;
}

forward GreenLightTimer();
public GreenLightTimer()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(RegisteredPlayer[i] == 1 && InGame[i] == 1)
		{
			StopAudioStreamForPlayer(i);
			PlayAudioStreamForPlayer(i, "http://www.mboxdrive.com/dbc437ab-ed85-4b13-b44c-1bbefe7cfd43.mp3");
			HideGuardRedGreenLightTD(i);
			SetDynamicObjectPos(SQUIDGAMEFIRSTGAMEMAPSTATUE, 109.506362, 2501.256103, 18.154382);
			ShowGreenLightTD(i);
			HideRedLightTD(i);
			SetTimer("RedLightTimer", 5000, false);
			DontMove[i] = 0;
		}
	}
	return true;
}
//TIMER END
//========== FORWARDS TEXTDRAW ===============
forward HideAllTD(playerid);
public HideAllTD(playerid)
{
	HideGuardRedGreenLightTD(playerid);
	HideRedLightTD(playerid);
	HideGreenLightTD(playerid);
	return true;
}

forward ShowGuardRedGreenLightTD(playerid);
public ShowGuardRedGreenLightTD(playerid)
{
		TextDrawShowForPlayer(playerid, GUARDREDGREENLIGHTTD[0]);
		TextDrawShowForPlayer(playerid, GUARDREDGREENLIGHTTD[1]);
		TextDrawShowForPlayer(playerid, GUARDREDGREENLIGHTTD[2]);
		TextDrawShowForPlayer(playerid, GUARDREDGREENLIGHTTD[3]);
		TextDrawShowForPlayer(playerid, GUARDREDGREENLIGHTTD[4]);
		TextDrawShowForPlayer(playerid, GUARDREDGREENLIGHTTD[5]);
		TextDrawShowForPlayer(playerid, GUARDREDGREENLIGHTTD[6]);
		return true;
}

forward HideGuardRedGreenLightTD(playerid);
public HideGuardRedGreenLightTD(playerid)
{
		TextDrawHideForPlayer(playerid, GUARDREDGREENLIGHTTD[0]);
		TextDrawHideForPlayer(playerid, GUARDREDGREENLIGHTTD[1]);
		TextDrawHideForPlayer(playerid, GUARDREDGREENLIGHTTD[2]);
		TextDrawHideForPlayer(playerid, GUARDREDGREENLIGHTTD[3]);
		TextDrawHideForPlayer(playerid, GUARDREDGREENLIGHTTD[4]);
		TextDrawHideForPlayer(playerid, GUARDREDGREENLIGHTTD[5]);
		TextDrawHideForPlayer(playerid, GUARDREDGREENLIGHTTD[6]);
		return true;
}

forward ShowRedLightTD(playerid);
public ShowRedLightTD(playerid)
{
	TextDrawShowForPlayer(playerid, REDGREENLIGHT[1]);
	return true;
}

forward HideRedLightTD(playerid);
public HideRedLightTD(playerid)
{
	TextDrawHideForPlayer(playerid, REDGREENLIGHT[1]);
	return true;
}

forward ShowGreenLightTD(playerid);
public ShowGreenLightTD(playerid)
{
	TextDrawShowForPlayer(playerid, REDGREENLIGHT[0]);
	return true;
}

forward HideGreenLightTD(playerid);
public HideGreenLightTD(playerid)
{
	TextDrawHideForPlayer(playerid, REDGREENLIGHT[0]);
	return true;
}
