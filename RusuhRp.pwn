#include <a_samp>
#include <dini>
#include <dudb>
#include <zcmd>
#include <discord-connector>
#include <discord-cmd>
#include <sscanf2>
#include <foreach>
#include <crashdetect>
#include <streamer>
#include <progress2> //https://www.youtube.com/watch?v=72yfjZoM4dk 
#include <sampvoice>
#include <mSelection>
#include <zones>
#include <file>
#include <real_timer>
#include <easyDialog>

#define RandomEx(%0,%1)          random((%1 - %0 + 1)) + %0

#define loop(%0,%1,%2) for(new %0 = %2; %0 < %1; %0++)

#define IsPlayerAndroid(%0)  GetPVarInt(%0, "NotAndroid") == 0

//=========================DEFINE DIALOG

#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2

#define COLOR_DEV      		0x00FFC7FF 
#define COLOR_ADEV      	0x00FFC7FF
#define COLOR_ADMIN      	0x00FFC7FF
#define COLOR_STAFF      	0x00FFC7FF
#define COLOR_HELPER 		0x00FFC7FF
#define COLOR_POLICE	 	0x001EFFFF
#define COLOR_MEDIC	 		0xFF00BDFF
#define COLOR_SURUHANJAYA	0x0013A1FF
#define COLOR_YAKUZA 		0x393939FF
#define COLOR_SCAR77	    0x7CFC00FF
#define COLOR_TAILONG		0x03cafcFF
#define COLOR_VIP 			0xFFF700FF
#define COLOR_WHITE 		0xFFFFFF96
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_RED 			0xAA3333AA
#define COLOR_BLACK         0x000001FF
#define COLOR_BLUE 			0x007BD0FF
#define COLOR_OOC 			0xE0FFFFAA
#define RED			 		0xAA333396
#define WHITE			 	0xFFFFFF96
#define Red                 0xAA333396
#define BLUE                0x007BD0FF
#define Yellow              0xe6f542FF
#define COLOR_MAFIA         0x4d0434

#define COL_DADAH           "{1303fc}"
#define COL_SYSTEM          "{13fc03}"

#define COL_Kkm             "{FF00BD}"
#define COL_Pdrm            "{001EFF}"
#define COL_HDRD            "{0013A1}"
#define COL_WHITE 			"{FFFFFF}"
#define COL_YELLOW 			"{F8FF00}"
#define COL_RED 			"{FF0000}"
#define COL_GREEN       	"{00FF16}"
#define COL_LBLUE   		"{00C3FF}"
#define COL_BLUE        	"{001AFF}"
#define COL_PINK        	"{FF00BD}"
#define COL_DBLUE			"{0013A1}"
#define COL_LGREEN  		"{3FFF4C}"
#define COL_OREN  			"{FFA200}"
#define	COL_DC              "{FFFFFF}"

#define ACTION_COLOR	 		0xFF0000FF

#define COLOR_AFK	 		0xFF0000FF
#define COLOR_OWNER         0xfc0303FF
#define COLOR_BITEM 		0xE1B0B0FF
#define COLOR_GRAD1 		0xB4B5B7FF
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF
#define COLOR_GREY 			0xAFAFAFAA
#define COLOR_GREEN   		0x33AA33AA
#define COLOR_RED 			0xAA3333AA
#define COLOR_BLACK         0x000001FF
#define COLOR_BLUE 			0x007BD0FF
#define COLOR_LIGHTORANGE 	0xFFA100FF
#define COLOR_FLASH 		0xFF000080
#define COLOR_LIGHTRED 		0xFF6347AA
#define COLOR_LIGHTBLUE 	0x33CCFFAA
#define COLOR_LIGHTGREEN 	0x9ACD32AA
#define COLOR_YELLOW 		0xFFFF00AA
#define COLOR_LIGHTYELLOW	0xFFFF91FF
#define COLOR_YELLOW2 		0xF5DEB3AA
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
#define TEAM_BLUE_COLOR 	0x8D8DFF00
#define TEAM_GROVE_COLOR 	0x00AA00FF
#define TEAM_AZTECAS_COLOR 	0x01FCFFC8
#define NEWBIE_COLOR 		0x7DAEFFFF
#define SAMP_COLOR			0xAAC4E5FF
#define COLOR_AFK	 		0xFF0000FF
#define COLOR_KAPAK         0xFF0F0F
#define COLOR_PURPLE        0xC2A2DAAA

#define         white               "{FFFFFF}"
#define         lightblue           "{33CCFF}"
#define         grey                "{AFAFAF}"
#define         oren                "{FF8000}"
#define         black               "{2C2727}"
#define         red                 "{FF0000}"
#define         green               "{33CC33}"
#define         blue                "{0080FF}"
#define         purple              "{D526D9}"
#define         pink                "{FF80FF}"
#define         brown               "{A52A2A}"
#define         cyan                "{00ff00}"

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

//------------------------------------------------------------------------------
#define NOTADMIN ""COL_RED"[MYBOT]"COL_WHITE" Anda tidak dibenarkan untuk menggunakan command ini"
#define NOACCBANK ""COL_RED"[MYBOT]"COL_WHITE" ANDA HARUS LAH BUAT ACC BANK DI KAUNTER SANA TERIMA KASIH"
#define NOVIP ""COL_RED"[MYBOT]"COL_WHITE" ANDA TIDAK DIBERNARKAN UNTUK MENGGUNAKAN COMMAND VIP"
#define XONDUTY ""COL_RED"[MYBOT]"COL_WHITE" ANDA HARUSLAH KENA ONDUTY DLU SBLM MENGGUNAKAN COMMAND INI "
#define XDESULTAN ""COL_RED"[MYBOT]"COL_WHITE" ANDA TIDAK MEMPUNYAI KENDERAAN INI  "

#define Function:%0(%1) forward %0(%1); public %0(%1)

#define DIALOG_REGISTER         1
#define DIALOG_LOGIN            2
#define SIMPANAN                3
#define KELUARAN                4
#define BANK                    5
#define DIALOG_VOTE             6
#define SPAWN                   7
#define ANNOUNCEMENT            8
#define RB                      9
#define WAZESYSTEM              10
#define PHONE                   11
#define TWITTER                 12
#define SHARELOC                13
#define CMDADMIN                14
//#define kosong
#define SpawnVehicle            16
#define SpawnMotorsikal         17 
#define SpawnCars               18
#define SpawnFreeCars           19
#define SpawnVehicleGodsideRoles 20
#define Helpcommand             21
#define BuyVehicle              22
#define BuyCars                 23
#define BuyMotorcycle           24
#define ListPrice               25
#define DIALOG_VCMDS            26
#define DIALOG_VATT             27
#define DIALOG_VFSTYLE          28
#define DIALOG_EDITID           29
#define DIALOG_EDIT             30
#define DIALOG_EDITPRICE        31
#define DIALOG_EDITINTERIOR     32
#define DIALOG_CMDS             33
#define LesenKeretaMotorDll     34
#define ModiItems               35
#define ModiPaintJobs           36
#define ModiWheels              37
#define ModiSpoilers            38
#define ModiRearbumbers         39
#define ModiFrontbumbers        40
#define ModiSideSkirts          41
#define ModiRoofs               42
#define ModiExhausts            43
#define ModiNitros              44
#define ModiColours             45
#define SpawnVehicleBadsideRoles 46

#define DIALOG_STYLE_TABLIST_HEADERS 5

#define DIALOG_NOTWHITELIST     15002
#define DIALOG_WHITELIST        15000
#define DIALOG_REMOVE           15001

#define    COLOR_LIGHTERRED   0xFF6B6BFF
#define    COLOR_ORANGE       0xFF8921FF

#define RandomEx(%0,%1)          random((%1 - %0 + 1)) + %0

#define MAX_ROADBLOCKS      100
#define MAX_PAKU            100
#define MAX_DYNAMIC_CARS    500
#define MAX_HOUSES          1000

#pragma unused ret_memcpy
#pragma unused strtok
#pragma tabsize 0

new PlayerLogin[MAX_PLAYERS];
new Onduty[MAX_PLAYERS];
new SkinLama[MAX_PLAYERS];
new Injured[MAX_PLAYERS];
new HelmetEnabled[MAX_PLAYERS];
new MaskEnabled[MAX_PLAYERS];
new afk[MAX_PLAYERS];
new TengahPaintball[MAX_PLAYERS];
new CooldownHidup[MAX_PLAYERS];
new MatiPaintball[MAX_PLAYERS];
new ScorePaintball[MAX_PLAYERS];

new SV_GSTREAM:gstream = SV_NULL;
new SV_LSTREAM:lstream[MAX_PLAYERS] = { SV_NULL, ... };

new Text:ann_1;
new Text:ann_2;
new Text:ann_3;

new gSpectateID[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];

new Text:ke1;
new Text:ke2;
new Text:ke3;
new Text:ke4;
new Text:ke5;
new Text:ke6;

new Text:HYRP1;
new Text:HYRP2;
new Text:HYRP3;
new Text:HYRP4;
new Text:HYRP5;
new Text:HYRP6;
new Text:HYRP7;
new Text:HYBRID8;
new Text:HYRP9;
new Text:HYRP10;
new Text:HYRP11;
new Text:HYRP12;
new Text:HYRP13;
new Text:HYRP14;
new Text:HYRP15;

new Text:textstring;
new Text3D:label[MAX_PLAYERS];

new houseid;
new InHouse[MAX_PLAYERS][MAX_HOUSES];
new hid;

new PintuRobbank;
new Kapal;
new gatemechanic;
new Gatewhite;
new Pintu7E;
new Pintu7E2;
new gateyakuza1;
new gateyakuza2;
new gateadmin;
new gateKapak;
new gatemafia;
new pintucd1;
new pintucd2;
new pintucd3;
new pintucd4;
new tollv;
new tolls;
new gateKongsi;
new PalangBalai;
new GatePenjaraBesar;
new GateMasukPenjara;
new GateGym;
new Masuk1;
new Masuk2;

//CAR
new engine;
new lights;
new alarm;
new doors;
new bonnet;
new boot;
new objective;

//ZONE
new GreenZone;
new YakuzaZone;
new SCAR77Zone;
new KongsiZone;
//new KapakZone;

//VIP
new AttEnabled[MAX_PLAYERS];

//==============ANIMS
new gPlayerUsingLoopingAnim[MAX_PLAYERS];
new gPlayerAnimLibsPreloaded[MAX_PLAYERS];

native SendClientCheck(playerid, type, arg, offset, size);

#define IsPlayerAndroid(%0)                 GetPVarInt(%0, "NotAndroid") == 0
#define IsPlayerPC(%0)                 GetPVarInt(%0, "NotAndroid") == 1

new Text:txtAnimHelper;

//LAPARHAUS
new sendername[MAX_PLAYERS];

new Text:LAPARHAUS[5];
new PlayerBar:LAPARHAUSBAR[MAX_PLAYERS][2];

new Text:BAGLAPARHAUS[23];
new Text:BAGLAPARHAUSSKIN[MAX_PLAYERS];

new DCC_Channel:join_Discord_Chat;
new DCC_Channel:leave_Discord_Chat;
new DCC_Channel:PanelServer;
new DCC_Channel:ServerRestart;
new DCC_Channel:g_Discord_Whitelist;
new DCC_Channel:g_Discord_Blacklist;
new DCC_Channel:Robbank_Info;
new DCC_Channel:PizzaJob_Info;
new DCC_Channel:BasJob_Info;
new DCC_Channel:LoriSampah_Info;
new DCC_Channel:Bayar_Info;
new DCC_Channel:Info_Kkm;
new DCC_Channel:Info_Pdrm;
new DCC_Channel:Info_HDRD;
new DCC_Channel:Chat_Ingame;
new DCC_Channel:Info_Server;
new DCC_Channel:Info_Mati;
new DCC_Channel:Server_Log_Admin;
new DCC_Channel:Report;
new DCC_Channel:Admin_Panel;

new realchat = 1;
new vehEngine[MAX_VEHICLES];

new jumlahmedkit;
new jumlahrepairkit;

new Robbank;//GLobal Variables

new PlayerText:cWspeedo[MAX_PLAYERS][10];
new Text:PublicTD[8];

//JAM
new Text:TextTime, Text:TextDate;

//====//====//====//====//====//====//====//==== JOBS
new PizzaJob[MAX_PLAYERS],
    BasJob[MAX_PLAYERS],
    LesenMotor[MAX_PLAYERS],
    LesenKereta[MAX_PLAYERS],
    LesenGDL[MAX_PLAYERS],
    LoriSampah[MAX_PLAYERS],
    Sweeper[MAX_PLAYERS];

new InCountDown,
    TimerCountDown[MAX_PLAYERS];

//=====================DEFINE SENDCLIENTMESSAGE========================//
#define SCM SendClientMessage
#define SCMToAll SendClientMessageToAll

//============define job========================//
#define sweeper1 1385.8462,-1869.3508,13.3828
#define sweeper2 1571.4288,-1871.3323,13.3828
#define sweeper3 1679.3580,-1865.7036,13.3906
#define sweeper4 1688.0276,-1740.8510,13.3922
#define sweeper5 1686.7993,-1591.1556,13.3796
#define sweeper6 1621.6189,-1592.1088,13.5469
#define sweeper7 1533.5122,-1593.8903,13.3906
#define sweeper8 1530.0806,-1727.0490,13.3828
#define sweeper9 1429.7169,-1732.3339,13.3828
#define sweeper10 1321.4786,-1732.5089,13.3828
#define sweeper11 1385.6345,-1786.6182,13.3828
#define sweeper12 1386.0244,-1863.0781,13.3828
#define sweeper13 1301.4504,-1851.6816,13.3828
#define sweeper14 1294.9595,-1872.2278,13.5469

new Float:RandomSpawn[][3] =
{
	{ 1177.0215, -1293.4910, 17.9119 },
    { 1176.8373, -1300.0928, 17.9119 },
    { 1172.5018, -1293.7610, 17.9119 },
    { 1166.6144, -1300.5728, 17.9043 },
    { 1165.5642, -1293.4384, 17.9123 }
};

new Float:SpawnJail[][3] =
{
	{ 258.3567, 194.3637, 1042.1980 },
    { 254.8820, 200.5768, 1042.1980 },
    { 258.4473, 200.6590, 1042.1980 },
    { 258.2459, 194.1635, 1042.1980 },
    { 251.5912, 193.7422, 1042.1980 },
    { 255.3566, 194.5558, 1042.1980 }
};

enum pData
{
	pPassword[130],
    pBackupPass[130],
    //================ROLES=====================//
	pAdmin,
    pScore,
	pLeader,
	pRole,
	pLevel,
    //==========================DATABASE LAIN II====================================//
    pDeath,
	pSkin,
	pCash,
    pDuitBank,
    pVip,
    pDraggedBy,
    pWanted,
    //==============================BRG HARAM===============================//
    pDadah,
    pGanja,
    pKetum,
    //=========================NO COMMENT================================//
	pDuty,
    pRoadblockpdrm,
    pCuff,
    //=============================LESEN==================================//
    pLesenkereta,
    pLesenmotor,
    pLesengdl,
    pLesenUdara,
    //==============================TUNE SULTAN============================//
    pSultanTayar,
    pSultanSpoiler,
    pSultanSideskirt,
    pSultanPaintjob,
	pSultanExhaust,
    pSultanRoof,
	pSultanRearbumper,
    pSultanNitro,
    SultanFuel,
    ElegyFuel,
    SabreFuel,
    //====================TUNE ELEGY=============================//
    pElegyTayar,
    pElegySpoiler,
    pElegySideskirt,
    pElegyPaintjob,
	pElegyExhaust,
    pElegyRoof,
	pElegyRearbumper,
	pElegyFrontbumper,
    pElegyNitro,
    //
	pJail,
	//============================KERETA============================//
	pSultan,
	pInfernus,
	pGTSUPER,
	pElegy,
	pFlash,
	pFeltzer,
	pRemington,
	pSlamvan,
	pBlade,
    pZr350,
    pCheetah,
    pBullet,
    pBurrito,
    pTampa,
    pSaber,
    pJester,
    pFcr,
	//=========================MOTOR==================================//
	pNRG500,
	pBF400,
    pWayfarer,
    pSanchez,
    pInterior,
    Float:pHealth,
    Float:pArmour,
    Float:pFacingAngle,
    Float:pLastX,
    Float:pLastY,
    Float:pLastZ,
    pFreeway,
    //===============================JOB==========================//
    pPizza,
    pLorisampah,
    pBasjob,
    //==================WEAPON=============================//
    pDeserteagle,
    pM4,
    pUzi,
    //====================LAIN2=============================//
    pMinyak,
    pAccBank,
    pVehicleid,
    Float:pSultanX,
    Float:pSultanY,
    Float:pSultanZ,
    pSultanPosAngle,
    pMedkit,
    pRepairkit,
    //======================COLOUR KERETA==========================//
    pSultanColor,
    pElegyColor,
    pWarn,
    pCarry,
    pLapar,
    pHaus,
    pBun,
    pBiskut,
    pMeggiCup,
    pMineral,
    p100Plus,
    pCoffee,
}
new PlayerInfo[MAX_PLAYERS][pData];

enum hInfo
{
    hPrice,
    hInterior,
    hOwned,
    hLocked,
    hPick,
    hMapicon,
    Text3D:hLabel,
    hOwner[MAX_PLAYER_NAME],
    Float:hX,
    Float:hY,
    Float:hZ,
    Float:hEnterX,
    Float:hEnterY,
    Float:hEnterZ
}
new HouseInfo[MAX_HOUSES][hInfo];

enum rInfo
{
    sCreated,
    Float:sX,
    Float:sY,
    Float:sZ,
    sObject,
}
new Roadblocks[MAX_ROADBLOCKS][rInfo];

enum vData
{
    vInGarage,
    vModelID,
    Float:vX,
    Float:vY,
    Float:vZ,
    Float:vA,
    vColor[2],
    vLocked,
    vOwner,
    vEngine,
    vFuel,
    vPlate[60],
    vComponent[14],

};
new VehicleInfo[MAX_VEHICLES][vData];

enum cInfo
{
    cCreated,
    Float:cX,
    Float:cY,
    Float:cZ,
    cObject,
};
new Spikes[MAX_PAKU][cInfo];

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

enum KeretaSpawn
{
	Vehicles
};
new pemain[MAX_PLAYERS][KeretaSpawn];

static DCC_Channel:commandChannel;

main()
{
	print("\n|=========================================GM LOADED==========================================================|");
	print("|                                      RUSUH ROLEPLAY                                                       |");
	print("|=======================================RUSUH RP V1=========================================================|\n");

    AntiDeAMX();
}

new RandomMSG[][] =
{
    "{E88300}[MYBOT]{FFFFFF}Anda boleh beli VIP dengan {FF0000}Zahier_Hazwan",
    "{E88300}[MYBOT]{FFFFFF}Sekiranya Anda Ternampak Hacker Atau Terjumpa Sebarang Bug Di Server Ini Anda Boleh Report Di Discord Rusuh Roleplay"
};

new const modelNames[212][] = 
{
    "Landstalker", "Bravura", "Buffalo", "Linerunner", "Perrenial", "Sentinel", "Dumper", "Firetruck", "Trashmaster",
    "Stretch", "Manana", "Infernus", "Voodoo", "Pony", "Mule", "Cheetah", "Ambulance", "Leviathan", "Moonbeam",
    "Esperanto", "Taxi", "Washington", "Bobcat", "Whoopee", "BF Injection", "Hunter", "Premier", "Enforcer",
    "Securicar", "Banshee", "Predator", "Bus", "Rhino", "Barracks", "Hotknife", "Article Trailer", "Previon", "Coach",
    "Cabbie", "Stallion", "Rumpo", "RC Bandit", "Romero", "Packer", "Monster", "Admiral", "Squalo", "Seasparrow",
    "Pizzaboy", "Tram", "Article Trailer 2", "Turismo", "Speeder", "Reefer", "Tropic", "Flatbed", "Yankee", "Caddy", "Solair",
    "Berkley's RC Van", "Skimmer", "PCJ-600", "Faggio", "Freeway", "RC Baron", "RC Raider", "Glendale", "Oceanic",
    "Sanchez", "Sparrow", "Patriot", "Quad", "Coastguard", "Dinghy", "Hermes", "Sabre", "Rustler", "ZR-350", "Walton",
    "Regina", "Comet", "BMX", "Burrito", "Camper", "Marquis", "Baggage", "Dozer", "Maverick", "News Chopper", "Rancher",
    "FBI Rancher", "Virgo", "Greenwood", "Jetmax", "Hotring", "Sandking", "Blista Compact", "Police Maverick",
    "Boxville", "Benson", "Mesa", "RC Goblin", "Hotring Racer A", "Hotring Racer B", "Bloodring Banger", "Rancher",
    "Super GT", "Elegant", "Journey", "Bike", "Mountain Bike", "Beagle", "Cropduster", "Stuntplane", "Tanker", "Roadtrain",
    "Nebula", "Majestic", "Buccaneer", "Shamal", "Hydra", "FCR-900", "NRG-500", "HPV1000", "Cement Truck", "Tow Truck",
    "Fortune", "Cadrona", "SWAT Truck", "Willard", "Forklift", "Tractor", "Combine", "Feltzer", "Remington", "Slamvan",
    "Blade", "Streak", "Freight", "Vortex", "Vincent", "Bullet", "Clover", "Sadler", "Firetruck", "Hustler", "Intruder",
    "Primo", "Cargobob", "Tampa", "Sunrise", "Merit", "Utility", "Nevada", "Yosemite", "Windsor", "Monster", "Monster",
    "Uranus", "Jester", "Sultan", "Stratum", "Elegy", "Raindance", "RC Tiger", "Flash", "Tahoma", "Savanna", "Bandito",
    "Freight Flat", "Streak Carriage", "Kart", "Mower", "Dune", "Sweeper", "Broadway", "Tornado", "AT-400", "DFT-30",
    "Huntley", "Stafford", "BF-400", "News Van", "Tug", "Petrol Trailer", "Emperor", "Wayfarer", "Euros", "Hotdog", "Club",
    "Freight Box", "Article Trailer 3", "Andromada", "Dodo", "RC Cam", "Launch", "LSPD Car", "SFPD Car", "LVPD Car",
    "Police Rancher", "Picador", "S.W.A.T", "Alpha", "Phoenix", "Glendale", "Sadler", "Luggage", "Luggage", "Stairs",
    "Boxville", "Tiller", "Utility Trailer"
};

public OnGameModeInit()
{
	SetGameModeText("SAKURA REMAKE GM NOT OFFICIAL GM");
 	SetNameTagDrawDistance(15.0);
    AllowInteriorWeapons(1);
	UsePlayerPedAnims();
	ShowPlayerMarkers(0);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
    
    AntiDeAMX();
    LoadMap();
    LoadHouses();
    Textdraw();

    Streamer_TickRate(60);
	Streamer_VisibleItems(STREAMER_TYPE_OBJECT, 10000);
	Streamer_VisibleItems(STREAMER_OBJECT_TYPE_DYNAMIC, 10000);
//=======================================================================ZONE
    GreenZone = GangZoneCreate(1015, -2121.5, 1995, -1099.5);
    SCAR77Zone = GangZoneCreate(2360, 1404.5, 2677, 1667.5);
    YakuzaZone = GangZoneCreate(1275, 586.5, 1822, 860.5);
    KongsiZone = GangZoneCreate(1075, 2489.5, 2061, 2918.5);

    //=======================================================================
	Robbank = 0;
    PintuRobbank = 0;

    //===========================TIMER GLOBAL==============================//
    SetTimer("ScoreSystem",1800000,true);
	SetTimer("SendRandomMesg",120000,1);
    SetTimer("settime",1000,true);
    SetTimer("UpdateFuel", 120000, true);
    SetTimer("OnFuel", 30000, true);
    SetTimer("OnLapar", 60000, true);
    SetTimer("UpdateHaus", 120000, true);
    SetTimer("OnHaus", 60000, true);
    SetTimer("settime",1000,true);

    //====//====//====//====//====//====//====//==== DC CONNECT
    join_Discord_Chat = DCC_FindChannelById("1018889764897816666");       //JOIN INFO
    leave_Discord_Chat = DCC_FindChannelById("1018889766999171082");      //LEAVE INFO
    PanelServer = DCC_FindChannelById("1018889749869637663");             //PANELSERVER INFO
    ServerRestart = DCC_FindChannelById("1018889749869637663");           //restart INFO
    g_Discord_Whitelist = DCC_FindChannelById("1018889752159727627");     //WHITELIST INFO
	g_Discord_Blacklist = DCC_FindChannelById("1018889753669672970");     //BLACKLIST INFO
	Robbank_Info = DCC_FindChannelById("1018889758937714819");            //ROBBANK INFO
	PizzaJob_Info = DCC_FindChannelById("1018889749869637663");           //PIZZAJOB INFO
    BasJob_Info = DCC_FindChannelById("1018889749869637663");             //BASJOB INFO
    Bayar_Info = DCC_FindChannelById("1018889769817735309");              //BAYAR INFO
    Info_Kkm = DCC_FindChannelById("1018889749869637663");                //Kkm INFO
    Info_Pdrm = DCC_FindChannelById("1018889749869637663");               //Pdrm INFO
    Info_HDRD = DCC_FindChannelById("1018889749869637663");               //INFO LESEN
    Chat_Ingame = DCC_FindChannelById("1018889749869637663");             //CHAT INGAME
    LoriSampah_Info = DCC_FindChannelById("1018889749869637663");         
    Info_Server = DCC_FindChannelById("1018889749869637663");             
    Server_Log_Admin = DCC_FindChannelById("1018889749869637663");        
    Info_Mati = DCC_FindChannelById("1018889768303599666");               
    Report = DCC_FindChannelById("1018889998285668492");                  //CMD REPORT
    Admin_Panel = DCC_FindChannelById("1018889788897640478");

    
    return 1;
}

public OnGameModeExit()
{
    InCountDown = 0;

    TextDrawDestroy(LAPARHAUS[0]);
    TextDrawDestroy(LAPARHAUS[1]);
    TextDrawDestroy(LAPARHAUS[2]);
    TextDrawDestroy(LAPARHAUS[3]);
    TextDrawDestroy(LAPARHAUS[4]);
    //=====//=====//=====//=====//=====//=====//=====/
    TextDrawDestroy(BAGLAPARHAUS[0]);
    TextDrawDestroy(BAGLAPARHAUS[1]);
    TextDrawDestroy(BAGLAPARHAUS[2]);
    TextDrawDestroy(BAGLAPARHAUS[3]);
    TextDrawDestroy(BAGLAPARHAUS[4]);
    TextDrawDestroy(BAGLAPARHAUS[5]);
    TextDrawDestroy(BAGLAPARHAUS[6]);
    TextDrawDestroy(BAGLAPARHAUS[7]);
    TextDrawDestroy(BAGLAPARHAUS[8]);
    TextDrawDestroy(BAGLAPARHAUS[9]);
    TextDrawDestroy(BAGLAPARHAUS[10]);
    TextDrawDestroy(BAGLAPARHAUS[11]);
    TextDrawDestroy(BAGLAPARHAUS[12]);
    TextDrawDestroy(BAGLAPARHAUS[13]);
    TextDrawDestroy(BAGLAPARHAUS[14]);
    TextDrawDestroy(BAGLAPARHAUS[15]);
    TextDrawDestroy(BAGLAPARHAUS[16]);
    TextDrawDestroy(BAGLAPARHAUS[17]);
    TextDrawDestroy(BAGLAPARHAUS[18]);
    TextDrawDestroy(BAGLAPARHAUS[19]);
    TextDrawDestroy(BAGLAPARHAUS[20]);
    TextDrawDestroy(BAGLAPARHAUS[21]);
    TextDrawDestroy(BAGLAPARHAUS[22]);

    SaveData();
	return 1;
}

public OnPlayerRequestClass(playerid, classid)
{
    new file[256], pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid,pname,sizeof(pname));
    format(file, sizeof(file), "users/%s.ini", pname);
    if (!dini_Exists(file))
    {
        ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "PENDAFTARAN", "{FFFFFF}SELAMAT DATANG!\n\n{FFFFFF}STATUS AKAUN:{FFFFFF}BELUM DIDAFTARKAN\n\n{FFFFFF}SILA MASUKKAN KATA LALUAN ANDA UNTUK MENDAFTAR", "Daftar", "Keluar");
    }
    if(fexist(file))
    {
        //ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD, "LOGIN", "{FFFFFF}SELAMAT DATANG!\n\n{FFFFFF}STATUS AKAUN: {FFFFFF}SUDAH DIDAFTARKAN\n\n{FFFFFF}SILA MASUKKAN KATA LALUAN UNTUK LOGIN", "Login", "Keluar");

        new string[500];
 		format(string, sizeof(string), "%s", GetRPName(playerid));
		TextDrawSetString(HYBRID8, string);

        TextDrawShowForPlayer(playerid, HYRP1);
        TextDrawShowForPlayer(playerid, HYRP2);
        TextDrawShowForPlayer(playerid, HYRP3);
        TextDrawShowForPlayer(playerid, HYRP4);
        TextDrawShowForPlayer(playerid, HYRP5);
        TextDrawShowForPlayer(playerid, HYRP6);
        TextDrawShowForPlayer(playerid, HYRP7);
        TextDrawShowForPlayer(playerid, HYBRID8);
        TextDrawShowForPlayer(playerid, HYRP9);
        TextDrawShowForPlayer(playerid, HYRP10);
        TextDrawShowForPlayer(playerid, HYRP11);
        TextDrawShowForPlayer(playerid, HYRP12);
        TextDrawShowForPlayer(playerid, HYRP13);
        TextDrawShowForPlayer(playerid, HYRP14);
        TextDrawShowForPlayer(playerid, HYRP15);
        SelectTextDraw(playerid, 0xFF0000FF);
    }
    SetPlayerPos(playerid, 837.5961, -2053.7974, 13.6893);
    SetPlayerCameraPos(playerid, 837.6729, -2089.9614, 40.8432);
	SetPlayerCameraLookAt(playerid, 837.6396, -2088.9675, 40.4183);
	InterpolateCameraPos(playerid, 1404.4121, -743.4493, 120.0028, 1589.2531, -1805.1190, 130.7828, 30000, CAMERA_MOVE);
	InterpolateCameraLookAt(playerid, 1406.2599, -815.0958, 110.0028, 1406.1498, -818.4944, 110.0028, 10000, CAMERA_MOVE);
    SetPlayerFacingAngle(playerid, 0); SetPlayerInterior(playerid, 0);
    GameTextForPlayer(playerid, "~r~RUSUH ROLEPLAY", 5000, 1);
	return 1;
}

public OnPlayerRequestSpawn(playerid)
{
	SCM(playerid, -1, "[MYBOT]: {FFFFFF}ANDA MESTILAH LOGIN TERLEBIH DAHALU SEBELUM MASUK K");
	return 0;
}

public OnPlayerTimeUpdate(playerid)
{
    if(IsPlayerInAnyVehicle(playerid) && GetPlayerState(playerid) == PLAYER_STATE_DRIVER) // Making sure the player is in a vehicle as driver
    {
        new vehicle = GetPlayerVehicleID(playerid);
        new Float:H;
        GetVehicleHealth(vehicle, H);

        new speed[24];
        format(speed, sizeof(speed), "%.0f", GetVehicleSpeed(vehicle));
        PlayerTextDrawSetString(playerid, cWspeedo[playerid][3], speed);

        new vehfuel[24];
        format(vehfuel, sizeof(vehfuel), "%dL", PlayerInfo[playerid][pMinyak]);
        PlayerTextDrawSetString(playerid, cWspeedo[playerid][6], vehfuel);

        new vehiclehealth[24];
        format(vehiclehealth, sizeof(vehiclehealth), "%.1f", H);
        PlayerTextDrawSetString(playerid, cWspeedo[playerid][8], vehiclehealth);
    }
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	new string[500];
	if(!success) 
	{
		format(string, sizeof(string), ""COL_DC"[DISCORD]"COL_RED"IP : %s "COL_WHITE"Telah Login Rcon Dengan Password Yang Salah! Password : %s", ip, password);
        SendAdminMessage(COLOR_RED, string);
    }
	return 1;
}

public OnPlayerConnect(playerid)
{
	SendClientMessage(playerid, COLOR_BLUE, "Rusuh RolePlay");
    PlayAudioStreamForPlayer(playerid, "https://www.mboxdrive.com/hybrid.mp3");
    RemoveBuilding(playerid);

    ResetPlayerVariable(playerid);
    Meter(playerid);
    TogglePlayerClock(playerid, 1); // Show the clock
    
	//======DISCORD CONNECTOR
    new string[200];
    new ip[32];

    GetPlayerIp(playerid, ip, sizeof(ip));
    format(string, sizeof string, " :speedboat: *[INFO JOIN]* \n ``` ~%s telah Mendarat Ke Negara!(IP: %s )...~``` ", GetRPName(playerid), ip);
    DCC_SendChannelMessage(join_Discord_Chat, string);


    //new name[MAX_PLAYER_NAME+1];
	//GetPlayerName(playerid, name, sizeof(name));
	//new player[200];
	//format(player,sizeof(player),"/users/%s.ini",name);
	//if(!dini_Exists(player))
	//{
	//    ShowPlayerDialog(playerid,DIALOG_NOTWHITELIST,DIALOG_STYLE_MSGBOX, "{55ff00}WHITELIST RUSUH ROLEPLAY", "{ffffff}AKAUN INI BELUM DI WHITELIST LAGI, SILA RUJUK DI DISCORD HYBRID https://discord.gg/6esDqM5N\n\n\n\n", "Terima", "Tolak");
	//    KickWithMessage(playerid,0xff0000FF, "[RUSUH RP INFO]: AKAUN INI BELUM DI WHITELIST, ANDA BOLEH KE DISCORD RUSUH RP UNTUK DAFTAR WHITELIST! ");
   	//}
   	//else
   	//{
    //    // Allow player to log in.
   	//}

    if(SvGetVersion(playerid) == SV_NULL)
    {
        SendClientMessage(playerid, Red,"ANDA TIDAK MEMPUNYAI PLUGINS VOICE");
    }
    else if(SvHasMicro(playerid) == SV_FALSE)
    {
        SendClientMessage(playerid, Red,"CLIENT ANDA TIDAK SUPPORT FEATURES VOICE CHAT");
    }
    else if((lstream[playerid] = SvCreateDLStreamAtPlayer(50.0, SV_INFINITY, playerid, 0xff0000ff, "LOCAL")))
    {
        SendClientMessage(playerid, COLOR_BLUE,"[INFO VOICE] {FFFFFF}TEKAN B UNTUK VOICE");
        if(gstream) SvAttachListenerToStream(gstream, playerid);
        SvAddKey(playerid, 0x42);
        SvAddKey(playerid, 0x5A);
    }

    //=====//=====//=====//=====//=====//=====//=====//====
    LAPARHAUSBAR[playerid][0] = CreatePlayerProgressBar(playerid, 517.000000, 106.000000, 36.500000, 3.000000, -8388353, 100.000000, 0);
    LAPARHAUSBAR[playerid][1] = CreatePlayerProgressBar(playerid, 557.000000, 106.000000, 36.500000, 3.000000, 16777215, 100.000000, 0);
    SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][0], PlayerInfo[playerid][pLapar]);//LAPAR
    SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][1], PlayerInfo[playerid][pHaus]);//HAUS

    SendClientCheck(playerid, 0x48, 0, 0, 2);
    
    gPlayerUsingLoopingAnim[playerid] = 0;
	gPlayerAnimLibsPreloaded[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
    new string[500];
    switch(reason)
    {
        case 0: format(string,sizeof(string),"%s telah keluar dari server. {00F1FF}(Crash / Force Close)",GetRPName(playerid));
        case 1: format(string,sizeof(string),"%s telah keluar dari server. {00F1FF}(Gerak Luu)",GetRPName(playerid));
        case 2: format(string,sizeof(string),"%s telah keluar dari server. {00F1FF}(Kena Tendang)",GetRPName(playerid));
    }
    SendClientMessageToAll(WHITE, string);
    StopAudioStreamForPlayer(playerid);    
    DestroyVehicle(pemain[playerid][Vehicles]);
	pemain[playerid][Vehicles] = 0;
    ResetPlayerVariable(playerid);
    //=============save database
    SaveStatsPlayer(playerid);
    //======JAM
    TextDrawHideForPlayer(playerid, TextTime), TextDrawHideForPlayer(playerid, TextDate);
    //======DISCORD CONNECTOR
    format(string, sizeof string, " :speedboat: *[INFO LEAVE]* \n ```\n~%s Telah Keluar daripada Server!... ~\n``` ", GetRPName(playerid));
    DCC_SendChannelMessage(leave_Discord_Chat, string);
    for(new i = 0; i < 10; i ++)
    {
        PlayerTextDrawDestroy(playerid, cWspeedo[playerid][i]);
		cWspeedo[playerid][i] = PlayerText:INVALID_TEXT_DRAW;
	}
    DestroyPlayerProgressBar(playerid, LAPARHAUSBAR[playerid][0]);
    DestroyPlayerProgressBar(playerid, LAPARHAUSBAR[playerid][1]);
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(newstate == PLAYER_STATE_DRIVER)
	{
        new vehicleid = GetPlayerVehicleID(playerid);
        new vstr[30];
		format(vstr, sizeof(vstr), "%s", GetVehicleName(vehicleid));
		PlayerTextDrawSetString(playerid, cWspeedo[playerid][4], vstr);
 
        PlayerTextDrawSetPreviewModel(playerid, cWspeedo[playerid][2], GetVehicleModel(GetPlayerVehicleID(playerid)));
	    PlayerTextDrawShow(playerid, cWspeedo[playerid][2]);
		if(!IsAbicycle(vehicleid))
		{
			for(new i = 0; i < 10; i++) 
            {
				PlayerTextDrawShow(playerid, cWspeedo[playerid][i]);
			}
		}
	}
	else if(oldstate == PLAYER_STATE_DRIVER)
	{
        for(new i = 0; i < 10; i++) {
			PlayerTextDrawHide(playerid, cWspeedo[playerid][i]);
		}
	}
	return 1;
}

public DCC_OnMessageCreate(DCC_Message:message)
{
    new realMsg[170];
    DCC_GetMessageContent(message, realMsg, 100);
    new DCC_Channel:channel;
 	DCC_GetMessageChannel(message, channel);
	//new DCC_Channel:channel;
	DCC_GetMessageChannel(message, commandChannel);
	//if(channel != commandChannel) return 1;
    if(channel != Admin_Panel) return 1;

	new DCC_User:author;
	DCC_GetMessageAuthor(message, author);

	new bool:isBot;
    new bool:IsBot;
    DCC_IsUserBot(author, IsBot);
	DCC_IsUserBot(author, isBot);
	if(isBot) { return 1; }

	new str[900];
    new command[32], params[128];

    DCC_GetMessageContent(message, str);


    sscanf(str, "s[32]s[128]", command, params);

    //====//====//====//====//====//====//====//====//====//====//====//====
    //====//====//====//====//====//==== nak buat cmd sambung bawah ni je
    if(strcmp(command, "/wl", true) == 0)
	{
        new msg[128], pass[128];
        sscanf(params, "s[128]s[128]", msg, pass);
        new file[256];
        new string[900];
        format(file,sizeof(file),"users/%s.ini",msg);
        {
        	if(!dini_Exists(file))
            {
                dini_Create(file);
                dini_IntSet(file, "Password", udb_hash(pass));
                dini_Set(file, "BackupPass", pass);
                dini_IntSet(file, "Admin", 0);
                dini_IntSet(file, "Score", 0);
                dini_IntSet(file, "Minyak", 100);
                dini_IntSet(file, "Leader", 0);
                dini_IntSet(file, "Death", 0);
                dini_IntSet(file, "Lesenmotor", 0);
                dini_IntSet(file, "Lesenkereta", 0);
                dini_IntSet(file, "Lesengdl", 0);
                dini_IntSet(file, "LesenUdara", 0);
                dini_IntSet(file, "Role", 0);
                dini_IntSet(file, "Level", 0);
                dini_IntSet(file, "Vip", 0);
                dini_IntSet(file, "Jail", 0);
                dini_IntSet(file, "Roadblockpdrm", 0);
                dini_IntSet(file, "Skin", 239);//SKIN PERMULAAN DAFTAR
                dini_IntSet(file, "Cash", 10000);//DUIT PERMULAAN DAFTAR
                dini_IntSet(file, "DuitBank", 5000);
                dini_IntSet(file, "SultanSpoiler", 0);
                dini_IntSet(file, "SultanTayar", 0); //SULTAN
                dini_IntSet(file, "SultanPaintjob", 0);
                dini_IntSet(file, "SultanRearbumper", 0);
                dini_IntSet(file, "SultanRoof", 0);
                dini_IntSet(file, "SultanSideskirt", 0);
                dini_IntSet(file, "SultanNitro", 0);
                dini_IntSet(file, "ElegyTayar", 0); //ELEGY
                dini_IntSet(file, "ElegyPaintjob", 0);
                dini_IntSet(file, "ElegyRearbumper", 0);
                dini_IntSet(file, "ElegyFrontbumper", 0);
                dini_IntSet(file, "ElegyRoof", 0);
                dini_IntSet(file, "ElegySideskirt", 0);
                dini_IntSet(file, "ElegyNitro", 0);
                dini_IntSet(file, "Sultan", 0);
                dini_IntSet(file, "Infernus", 0);
                dini_IntSet(file, "Cheetah", 0);
                dini_IntSet(file, "Bullet", 0);
                dini_IntSet(file, "Tampa", 0);
                dini_IntSet(file, "Saber", 0);
                dini_IntSet(file, "Zr350", 0);
                dini_IntSet(file, "GTSUPER", 0);
                dini_IntSet(file, "Elegy", 0);
                dini_IntSet(file, "Flash", 0);
                dini_IntSet(file, "NRG500", 0);
                dini_IntSet(file, "BF400", 0);
                dini_IntSet(file, "Sultan", 0);
                dini_IntSet(file, "Sanchez", 0);
                dini_IntSet(file, "Wayfarer", 0);
                dini_IntSet(file, "Pizza", 0);
                dini_IntSet(file, "Medkit", 0);
                dini_IntSet(file, "Deserteagle", 0);
                dini_IntSet(file, "M4", 0);
                dini_IntSet(file, "Uzi", 0);
                dini_IntSet(file, "AccBank", 0);
                dini_FloatSet(file, "LastX", 1130.9756);
                dini_FloatSet(file, "LastY", -2036.7576);
                dini_FloatSet(file, "LastZ", 69.0078);
                dini_IntSet(file, "Vehicleid", 0);
                dini_IntSet(file, "Cuff", 0);
                dini_IntSet(file, "Repairkit", 0);
                dini_IntSet(file, "SultanColor", 0);
                dini_IntSet(file, "ElegyColor", 0);
                dini_IntSet(file, "Warn", 0);
                dini_IntSet(file, "Jester", 0);
                dini_IntSet(file, "SultanFuel", 100);
                dini_IntSet(file, "ElegyFuel", 100);
                dini_IntSet(file, "SabreFuel", 100);
                dini_IntSet(file, "Lapar", 100);
                dini_IntSet(file, "Haus", 100);
                dini_IntSet(file, "Bun", 1);
                dini_IntSet(file, "Biskut", 1);
                dini_IntSet(file, "MeggiCup",1);
                dini_IntSet(file, "Mineral", 1);
                dini_IntSet(file, "100Plus", 1);
                dini_IntSet(file, "Coffee", 1);

                DCC_DeleteMessage(message);

                new DCC_Embed:whitelist = DCC_CreateEmbed();
                DCC_SetEmbedTitle(whitelist, "Info Whitelist");
                format(string, sizeof string, ":white_check_mark:__\n***WHITELISTED***__\nNama:%s \nTelah Di Whitelist Di Server Ini", msg); 
                DCC_SetEmbedDescription(whitelist, string);
                DCC_SendChannelEmbedMessage(g_Discord_Whitelist, whitelist);
            }
        	else 
            {
                //format(string,sizeof(string),"```\n%s Sudah Ada di dalam Record Whitelist```",msg); 
                //DCC_SendChannelMessage(commandChannel,string);
                new DCC_Embed:embed = DCC_CreateEmbed();
                DCC_SetEmbedTitle(embed, "Info Whitelist");
                format(string,sizeof(string),"%s Sudah Ada di dalam Record Whitelist",msg); 
                DCC_SetEmbedDescription(embed, string);
                DCC_SendChannelEmbedMessage(g_Discord_Whitelist, embed);
            }
        }
        return 1;
    }
    if(strcmp(command, "/bl", true) == 0)
	{
        new msg[128];
        sscanf(params, "s[128]",msg);
        new file[256];
        new string[900];
        format(file,sizeof(file),"users/%s.ini",msg);
        {
        	if(dini_Exists(file)) 
            {
                dini_Remove(file); 
                //format(string, sizeof string, ":x:__\n***BLACKLISTED***__\nNama:%s \nSudah Di Blacklist Dari Server :bangbang:", msg); 
                //DCC_SendChannelMessage(g_Discord_Blacklist,string);

                new DCC_Embed:blacklist = DCC_CreateEmbed();
                DCC_SetEmbedTitle(blacklist, "Info Blacklist");
                format(string, sizeof string, ":x:__\n***BLACKLISTED***__\nNama:%s \nSudah Di Blacklist Dari Server :bangbang:", msg); 
                DCC_SetEmbedDescription(blacklist, string);
                DCC_SendChannelEmbedMessage(g_Discord_Blacklist, blacklist);
            }
        	else 
            {
                format(string,sizeof(string),"```\n%s Tidak Ada Di Dalam Record Whitelist```",msg); 
                DCC_SendChannelMessage(commandChannel,string);
            }
        }
        return 1;
    }
    if(channel == Chat_Ingame && !IsBot)
    {
        new user_name[32 + 1], string[152];
        DCC_GetUserName(author, user_name, 32);
        format(string, sizeof(string), ""COL_DC"[FROM DISCORD]"COL_WHITE"%s", realMsg);
        SCMToAll(COLOR_YELLOW, string);
    }
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        SetPlayerPosFindZ(playerid, fX, fY, fZ);
        SetVehiclePos(playerid, fX, fY, fZ);
        TogglePlayerControllable(playerid, false);
        SetTimerEx("Unfreeze", 5000, false, "i", playerid);
    }
    return 1;
}

Function:settime(playerid)
{
    new string[256],year,month,day,hours,minutes,seconds;
    getdate(year, month, day), gettime(hours, minutes, seconds);
    format(string, sizeof string, "%d/%s%d/%s%d", day, ((month < 10) ? ("0") : ("")), month, (year < 10) ? ("0") : (""), year);
    TextDrawSetString(TextDate, string);
    format(string, sizeof string, "%s%d:%s%d:%s%d", (hours < 10) ? ("0") : (""), hours, (minutes < 10) ? ("0") : (""), minutes, (seconds < 10) ? ("0") : (""), seconds);
    TextDrawSetString(TextTime, string);
}

public OnPlayerSpawn(playerid)
{
	SetPlayerMapIcon(playerid,0,1555.5023,-1675.6263,16.1953,30,1,MAPICON_GLOBAL);//Pdrm ICON
	SetPlayerMapIcon(playerid,1,1172.0774,-1325.3436,15.4074,22,1,MAPICON_GLOBAL);//Kkm ICON
	SetPlayerMapIcon(playerid,2,1653.9277,-1654.7585,22.5156,20,1,MAPICON_GLOBAL);//HDRD ICON
	SetPlayerMapIcon(playerid,3,1456.1322,2773.4058,10.8203,23,1,MAPICON_GLOBAL);//Kongsi ICON
	SetPlayerMapIcon(playerid,4,1455.3027,750.7111,11.0234,43,1,MAPICON_GLOBAL);//YAKUZA ICON
	SetPlayerMapIcon(playerid,5,2481.5891,1525.6466,11.7174,44,1,MAPICON_GLOBAL);//SCAR77 ICON
	SetPlayerMapIcon(playerid,6,2098.0720,-1808.8424,13.5541,29,1,MAPICON_GLOBAL);//pizza job ICON
	SetPlayerMapIcon(playerid,7,1626.49915,-1859.32251,15.02630,27,1,MAPICON_GLOBAL);//FNF ICON
	SetPlayerMapIcon(playerid,8,955.5948, -1728.5149, 13.9325,55,1,MAPICON_GLOBAL);//CAR DEALER ICON
    SetPlayerMapIcon(playerid,9,1524.1123,-2172.7297,23.6328,52,1,MAPICON_GLOBAL);//BANK ICON
    SetPlayerMapIcon(playerid,10,2788.7690,-1089.8362,94.1871,16,1,MAPICON_GLOBAL);//CITYHALL
    
    GangZoneShowForPlayer(playerid, GreenZone, 0x00FF0099);
    GangZoneShowForPlayer(playerid, YakuzaZone, 0x39393999);
    GangZoneShowForPlayer(playerid, SCAR77Zone, 0x7CFC0099);
    GangZoneShowForPlayer(playerid, KongsiZone, 0xFFF36999);

	Onduty[playerid] = 0;
	
	//Script untuk spawn
	StopAudioStreamForPlayer(playerid);
	SetPlayerColor(playerid,COLOR_WHITE);
	//====//====//====//==== SPAWN

    new SpawnRandom = random(sizeof(RandomSpawn));
    if(PlayerInfo[playerid][pDeath] == 1) 
    { //MATI
        SetPlayerPos(playerid,
		RandomSpawn[SpawnRandom][0],
		RandomSpawn[SpawnRandom][1],
		RandomSpawn[SpawnRandom][2]);
        PlayerInfo[playerid][pDeath] = 0;
        TolakDuitPlayer(playerid, 100);
        SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
        SetPlayerHealth(playerid, 100);
        SendClientMessage(playerid, -1,"{e617db}[INFO Kkm] {FFFFFF}Duit Anda Telah Ditolak Sebanyak RM100 Untuk Membayar Kos Perubatan");
        freezeplayer(playerid);
        return 1;    
    }

    TextDrawShowForPlayer(playerid, LAPARHAUS[0]);
    TextDrawShowForPlayer(playerid, LAPARHAUS[1]);
    TextDrawShowForPlayer(playerid, LAPARHAUS[2]);
    TextDrawShowForPlayer(playerid, LAPARHAUS[3]);
    TextDrawShowForPlayer(playerid, LAPARHAUS[4]);
    ShowPlayerProgressBar(playerid, LAPARHAUSBAR[playerid][0]);
    ShowPlayerProgressBar(playerid, LAPARHAUSBAR[playerid][1]);

    new targetid, Float:X, Float:Y, Float:Z;
    new vw = GetPlayerVirtualWorld(playerid);
    new interior = GetPlayerInterior(playerid);
    TogglePlayerSpectating(targetid, 0);
    SetPlayerPos(targetid, X+1, Y+1, Z);
    SetPlayerVirtualWorld(playerid, vw);
    SetPlayerInterior(targetid, interior);

    if(!gPlayerAnimLibsPreloaded[playerid])
	{
	    PreloadAnimLib(playerid,"AIRPORT");
		PreloadAnimLib(playerid,"Attractors");
		PreloadAnimLib(playerid,"BAR");
		PreloadAnimLib(playerid,"BASEBALL");
		PreloadAnimLib(playerid,"BD_FIRE");
		PreloadAnimLib(playerid,"benchpress");
        PreloadAnimLib(playerid,"BF_injection");
        PreloadAnimLib(playerid,"BIKED");
        PreloadAnimLib(playerid,"BIKEH");
        PreloadAnimLib(playerid,"BIKELEAP");
        PreloadAnimLib(playerid,"BIKES");
        PreloadAnimLib(playerid,"BIKEV");
        PreloadAnimLib(playerid,"BIKE_DBZ");
        PreloadAnimLib(playerid,"BMX");
        PreloadAnimLib(playerid,"BOX");
        PreloadAnimLib(playerid,"BSKTBALL");
        PreloadAnimLib(playerid,"BUDDY");
        PreloadAnimLib(playerid,"BUS");
        PreloadAnimLib(playerid,"CAMERA");
        PreloadAnimLib(playerid,"CAR");
        PreloadAnimLib(playerid,"CAR_CHAT");
        PreloadAnimLib(playerid,"CASINO");
        PreloadAnimLib(playerid,"CHAINSAW");
        PreloadAnimLib(playerid,"CHOPPA");
        PreloadAnimLib(playerid,"CLOTHES");
        PreloadAnimLib(playerid,"COACH");
        PreloadAnimLib(playerid,"COLT45");
        PreloadAnimLib(playerid,"COP_DVBYZ");
        PreloadAnimLib(playerid,"CRIB");
        PreloadAnimLib(playerid,"DAM_JUMP");
        PreloadAnimLib(playerid,"DANCING");
        PreloadAnimLib(playerid,"DILDO");
        PreloadAnimLib(playerid,"DODGE");
        PreloadAnimLib(playerid,"DOZER");
        PreloadAnimLib(playerid,"DRIVEBYS");
        PreloadAnimLib(playerid,"FAT");
        PreloadAnimLib(playerid,"FIGHT_B");
        PreloadAnimLib(playerid,"FIGHT_C");
        PreloadAnimLib(playerid,"FIGHT_D");
        PreloadAnimLib(playerid,"FIGHT_E");
        PreloadAnimLib(playerid,"FINALE");
        PreloadAnimLib(playerid,"FINALE2");
        PreloadAnimLib(playerid,"Flowers");
        PreloadAnimLib(playerid,"FOOD");
        PreloadAnimLib(playerid,"Freeweights");
        PreloadAnimLib(playerid,"GANGS");
        PreloadAnimLib(playerid,"GHANDS");
        PreloadAnimLib(playerid,"GHETTO_DB");
        PreloadAnimLib(playerid,"goggles");
        PreloadAnimLib(playerid,"GRAFFITI");
        PreloadAnimLib(playerid,"GRAVEYARD");
        PreloadAnimLib(playerid,"GRENADE");
        PreloadAnimLib(playerid,"GYMNASIUM");
        PreloadAnimLib(playerid,"HAIRCUTS");
        PreloadAnimLib(playerid,"HEIST9");
        PreloadAnimLib(playerid,"INT_HOUSE");
        PreloadAnimLib(playerid,"INT_OFFICE");
        PreloadAnimLib(playerid,"INT_SHOP");
        PreloadAnimLib(playerid,"JST_BUISNESS");
        PreloadAnimLib(playerid,"KART");
        PreloadAnimLib(playerid,"KISSING");
        PreloadAnimLib(playerid,"KNIFE");
        PreloadAnimLib(playerid,"LAPDAN1");
        PreloadAnimLib(playerid,"LAPDAN2");
        PreloadAnimLib(playerid,"LAPDAN3");
        PreloadAnimLib(playerid,"LOWRIDER");
        PreloadAnimLib(playerid,"MD_CHASE");
        PreloadAnimLib(playerid,"MEDIC");
        PreloadAnimLib(playerid,"MD_END");
        PreloadAnimLib(playerid,"MISC");
        PreloadAnimLib(playerid,"MTB");
        PreloadAnimLib(playerid,"MUSCULAR");
        PreloadAnimLib(playerid,"NEVADA");
        PreloadAnimLib(playerid,"ON_LOOKERS");
        PreloadAnimLib(playerid,"OTB");
        PreloadAnimLib(playerid,"PARACHUTE");
        PreloadAnimLib(playerid,"PARK");
        PreloadAnimLib(playerid,"PAULNMAC");
        PreloadAnimLib(playerid,"PED");
        PreloadAnimLib(playerid,"PLAYER_DVBYS");
        PreloadAnimLib(playerid,"PLAYIDLES");
        PreloadAnimLib(playerid,"POLICE");
        PreloadAnimLib(playerid,"POOL");
        PreloadAnimLib(playerid,"POOR");
        PreloadAnimLib(playerid,"PYTHON");
        PreloadAnimLib(playerid,"QUAD");
        PreloadAnimLib(playerid,"QUAD_DBZ");
        PreloadAnimLib(playerid,"RIFLE");
        PreloadAnimLib(playerid,"RIOT");
        PreloadAnimLib(playerid,"ROB_BANK");
        PreloadAnimLib(playerid,"ROCKET");
        PreloadAnimLib(playerid,"RUSTLER");
        PreloadAnimLib(playerid,"RYDER");
        PreloadAnimLib(playerid,"SCRATCHING");
        PreloadAnimLib(playerid,"SHAMAL");
        PreloadAnimLib(playerid,"SHOTGUN");
        PreloadAnimLib(playerid,"SILENCED");
        PreloadAnimLib(playerid,"SKATE");
        PreloadAnimLib(playerid,"SPRAYCAN");
        PreloadAnimLib(playerid,"STRIP");
        PreloadAnimLib(playerid,"SUNBATHE");
        PreloadAnimLib(playerid,"SWAT");
        PreloadAnimLib(playerid,"SWEET");
        PreloadAnimLib(playerid,"SWIM");
        PreloadAnimLib(playerid,"SWORD");
        PreloadAnimLib(playerid,"TANK");
        PreloadAnimLib(playerid,"TATTOOS");
        PreloadAnimLib(playerid,"TEC");
        PreloadAnimLib(playerid,"TRAIN");
        PreloadAnimLib(playerid,"TRUCK");
        PreloadAnimLib(playerid,"UZI");
        PreloadAnimLib(playerid,"VAN");
        PreloadAnimLib(playerid,"VENDING");
        PreloadAnimLib(playerid,"VORTEX");
        PreloadAnimLib(playerid,"WAYFARER");
        PreloadAnimLib(playerid,"WEAPONS");
        PreloadAnimLib(playerid,"WUZI");
        PreloadAnimLib(playerid,"SNM");
        PreloadAnimLib(playerid,"BLOWJOBZ");
        PreloadAnimLib(playerid,"SEX");
   		PreloadAnimLib(playerid,"BOMBER");
   		PreloadAnimLib(playerid,"RAPPING");
    	PreloadAnimLib(playerid,"SHOP");
   		PreloadAnimLib(playerid,"BEACH");
   		PreloadAnimLib(playerid,"SMOKING");
    	PreloadAnimLib(playerid,"FOOD");
    	PreloadAnimLib(playerid,"ON_LOOKERS");
    	PreloadAnimLib(playerid,"DEALER");
		PreloadAnimLib(playerid,"CRACK");
		PreloadAnimLib(playerid,"CARRY");
		PreloadAnimLib(playerid,"COP_AMBIENT");
		PreloadAnimLib(playerid,"PARK");
		PreloadAnimLib(playerid,"INT_HOUSE");
		PreloadAnimLib(playerid,"FOOD");
		gPlayerAnimLibsPreloaded[playerid] = 1;
	}
	return 1;
}

Function:freezeplayer(playerid)
{
    GameTextForPlayer(playerid, "~g~-SILA TUNGGU SEBENTAR~n~~b~-SEDANG LOAD MAP", -3000, 1);
    TogglePlayerControllable(playerid, false);
    SetTimerEx("UnFreezeJob", 7000, false, "i", playerid);
    return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{   
    new string[500]; 
    if(TengahPaintball[playerid] == 0) 
    {  
        StopAudioStreamForPlayer(playerid);
        PlayerInfo[playerid][pDeath] = 1;
        GameTextForPlayer(playerid, "~g~-ARWAH BAIK ORANGNYE", -3000, 1);
        format(string, sizeof string, " *[INFO MATI]* \n **~%s Telah Mati Dibunuh Oleh %s... ~** ", GetRPName(playerid), GetRPName(killerid));
        DCC_SendChannelMessage(Info_Mati, string); 

        if(gPlayerUsingLoopingAnim[playerid]) 
        {
            gPlayerUsingLoopingAnim[playerid] = 0;
            TextDrawHideForPlayer(playerid,txtAnimHelper);
    	}
    }
    if(TengahPaintball[playerid] == 1) 
    {  
        MatiPaintball[playerid] = 1;
        ScorePaintball[killerid] += 1;
        format(string, sizeof(string), "{F9EB11}[PAINTBALL]{FFFFFF}%s Telah Mati Dibunuh Oleh %s,Score : %d", GetRPName(playerid), GetRPName(killerid), ScorePaintball[killerid]);
        SendClientMessageToAll(COLOR_LIGHTBLUE, string);
        SetPlayerPos(playerid, -959.2236,1859.6760,9.0000);
        SetPlayerInterior(playerid, 0);
    }
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if (realchat)
	{
	    new string[500];
		format(string, sizeof(string), "[%s] [%d] : %s", GetRPName(playerid), playerid, text);
  		ProxDetector(30.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		format(string, sizeof(string), "%s", text);
		SetPlayerChatBubble(playerid,string,COLOR_WHITE,5.0,5000);
		ApplyAnimation(playerid, "PED", "IDLE_chat", 4.100, 0, 1, 1, 1, 1, 1);

        new DCC_Embed:chat = DCC_CreateEmbed();
        DCC_SetEmbedTitle(chat, "Info Chat");
        format(string, sizeof string, " :speaking_head: *[CHAT INGAME]* \n%s : `` %s ``", GetRPName(playerid), text);
        DCC_SetEmbedDescription(chat, string);
        DCC_SendChannelEmbedMessage(Chat_Ingame, chat);
		return 0;
	}
	return 1;
}

IsAbicycle(vehid)
{
	switch(GetVehicleModel(vehid))
	{
		case 481, 509, 510: return true;
	}
	return false;
}

GetVehicleName(vehicleid)
{
	new
		modelid = GetVehicleModel(vehicleid),
		name[32];
 
	if(400 <= modelid <= 611)
	    strcat(name, modelNames[modelid - 400]);
	else
	    name = "Unknown";
 
	return name;
}

//============================================================================ALL COMMAND TEXT===================================================================================//

//=========//=========//=========//=========//========= ADMIN CMD
CMD:makeowner(playerid, params[])
{
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");
    if(IsPlayerAdmin(playerid) || strfind(IsPlayerName(playerid), "Zahier", true) != -1) 
    {
        PlayerInfo[playerid][pAdmin] = 6; 
        SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: Anda Telah Mendapat Owner Server");
        SaveStatsPlayer(playerid);
    }
    return 1;
}

CMD:savedata(playerid, params[])
{
    SaveStatsPlayer(playerid);
    SendClientMessage(playerid, COLOR_RED, "Anda Telah Save Database Anda");
    return 1;
}

CMD:saveallplayerdata(playerid, params[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        SaveStatsPlayer(playerid);
    }
    SendClientMessageToAll(COLOR_RED, "Kesemua Database Player Telah Di Save Oleh Admin");
    return 1;
}

CMD:lastspawn(playerid,params[])
{
    SetPlayerPos(playerid, PlayerInfo[playerid][pLastX], PlayerInfo[playerid][pLastY], PlayerInfo[playerid][pLastZ]);
    return 1;
}

CMD:acuff(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new targetid;
            if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /cuff [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            if(IsPlayerConnected(targetid))
            {
                new str[512];
                new name[MAX_PLAYER_NAME];
                GetPlayerName(playerid, name, sizeof(name));
                new target[MAX_PLAYER_NAME];
                PlayerInfo[targetid][pCuff] = 1;
                GetPlayerName(targetid, target, sizeof(target));
                format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah mengari %s",GetRPName(targetid));
                SendClientMessage(playerid, 0xE01B1B, str);
                format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah digari oleh %s", GetRPName(playerid));
                SendClientMessage(targetid, 0xE01B1B, str);
                format(str, sizeof(str), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" %s telah mengari %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(0xE01B1B, str);
                TogglePlayerControllable(targetid,false);
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:auncuff(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)   
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new targetid;
            if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /uncuff [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            if(IsPlayerConnected(targetid))
            {  
                new str[512];
                new name[MAX_PLAYER_NAME];
                GetPlayerName(playerid, name, sizeof(name));
                new target[MAX_PLAYER_NAME];
                GetPlayerName(targetid, target, sizeof(target));
                format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah membuang gari %s!", GetRPName(targetid));
                SendClientMessage(playerid, 0xE01B1B, str);
                PlayerInfo[targetid][pCuff] = 0;
                TogglePlayerControllable(targetid,1);
                format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Gari Anda Telah Dibuang oleh %s!", GetRPName(playerid));
                SendClientMessage(targetid, 0xE01B1B, str);
                format(str, sizeof(str), ""COL_HDRD"[INFO HDRD]"COL_WHITE" %s telah membuang gari %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(0xE01B1B, str);
                return 1;
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:warning(playerid, params[])
{
    new targetid, amount;
    new string[256];
    if(sscanf(params, "ud", targetid, amount)) return SendClientMessage(playerid, -1, "USAGE: /warning [playerid] [amount]");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xAA3333AA,"Player itu Offline");
    if(PlayerInfo[playerid][pAdmin] >= 5)
    {
        PlayerInfo[targetid][pWarn] += 1;
        format(string, 128, "{FF0000}[INFO WARN]{FFFFFF} ADMIN %s TELAH MEMBERIKAN AMARAN KERAS KEPADA %s SEBANYAK [%d/3]", GetRPName(playerid), GetRPName(targetid), PlayerInfo[playerid][pWarn]);
        SendClientMessageToAll(COLOR_RED, string);
    }
    else return SendClientMessage(playerid, -1, "ANDA TIDAK BOLEH MENGGUNAKAN CMD INI");
    return 1;
}

CMD:v(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 3 || strfind(IsPlayerName(playerid), "Zahier", true) != -1)
    {
        new target, car, string[128];
        if(sscanf(params, "ud", target, car))
        {
            SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /v [playerid] [carid]"); 
            return 1;
        }
        if(car < 400 || car > 611) { SendClientMessage(playerid, COLOR_GREY, ""COL_RED"[MYBOT]"COL_WHITE" Jangan kurang daripada 400 atau lebih daripada 611"); return 1; }
        if(IsPlayerConnected(target))
        {
            if(target!= INVALID_PLAYER_ID)
            {
                CreateVehicleEx(target, car, -1, -1);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah memberi kereta %d kepada %s!", car, GetRPName(target));
                SendClientMessage(playerid, COLOR_GRAD1, string);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Admin %s telah memberi anda kereta %d ",GetRPName(playerid),car);
                SendClientMessage(playerid, COLOR_GRAD1, string);
            }
        }
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:setcuaca(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
    {
		new amount, string[128];
	    if(sscanf(params,"i", amount)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setcuaca [weather id]");
	    SetWeather(amount);
	    format(string, sizeof(string), ""COL_DC"[DISCORD]:"COL_WHITE" Admin %s Telah Menukar Cuaca", GetRPName(playerid));
		SendClientMessageToAll(-1, string);
	}
	else return SendClientMessage(playerid, -1, ""COL_RED"[DISCORD]"COL_WHITE" Command Ini Hanya Orang Tertentu Sahaja Boleh Guna");
	return 1;
}

CMD:makeadmin(playerid, params[])
{
    new targetid, amount;
    if(PlayerInfo[playerid][pAdmin] >= 5)
    {
        if(sscanf(params, "ud", targetid, amount)) return SendClientMessage(playerid, -1, "[MYBOT]: /makeadmin [playerid] [level]");
        if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
        if(amount < 0 || amount > 7) return SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Boleh Set Level Admin Hanya Dari 1 Hingga 7 Sahaja");
        else
        {
            new string[500];
            format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Admin Level %d Kepada %s", amount, GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "[MYBOT]: Owner %s Telah Memberikan Anda Role Admin Level %d",GetRPName(playerid), amount); SendClientMessage(targetid, COLOR_WHITE, string);
            PlayerInfo[targetid][pAdmin] = amount;
            SaveStatsPlayer(targetid);
        }
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:aonduty(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
    {
        new string[248];
        PlayerInfo[playerid][pDuty] = 1;
        SetPlayerSkin(playerid, 217);
        SetPlayerColor(playerid,COLOR_RED);
        format(string,sizeof(string),"[MYBOT]: {FFFFFF}%s TELAH ONDUTY SEBAGAI {ff0000}ADMIN",GetRPName(playerid));
        SendClientMessageToAll(COLOR_RED,string);
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:sonduty(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        new string[248];
        PlayerInfo[playerid][pDuty] = 1;
        SetPlayerSkin(playerid, 217);
        format(string,sizeof(string),"[MYBOT]: {FFFFFF}%s TELAH ONDUTY SEBAGAI {ff0000}STAFF",GetRPName(playerid));
        SendClientMessageToAll(COLOR_RED,string);
    }
    return 1;
}

CMD:aoffduty(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        new string[248];
        PlayerInfo[playerid][pDuty] = 0;
        SetPlayerSkin(playerid, pSkin);
        format(string,sizeof(string),"[MYBOT]: {FFFFFF}%s TELAH OFFDUTY SEBAGAI {ff0000}ADMIN",GetRPName(playerid));
        SendClientMessageToAll(COLOR_RED,string);
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:cekbadan(playerid, params[])
{
    new targetid, string[180];
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");
    if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[INFO]: /cekbadan [playerid]"); 
    {
        format(string, sizeof(string), "NAMA:%s\nLEVEL:%d\nDUIT:RM%d\nDUIT BANK:RM%d\nMEDKIT:%d\nDADAH:%d\nKETUM:%d\nGANJA:%d",
        GetRPName(targetid), 
        GetPlayerScore(targetid), 
        GetPlayerMoney(targetid), 
        PlayerInfo[targetid][pDuitBank], 
        PlayerInfo[targetid][pMedkit], 
        PlayerInfo[targetid][pDadah],
        PlayerInfo[targetid][pKetum],
        PlayerInfo[targetid][pGanja]);
        ShowPlayerDialog(playerid, 96,  DIALOG_STYLE_MSGBOX, "INVENTORY", string, "", "BACK");
    }
    return 1;
}

CMD:sp(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
    {
        new specplayerid;
        if(!IsPlayerConnected(specplayerid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
        if(sscanf(params,"u", specplayerid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /spec [playerid]");
        {
            new Float:X, Float:Y, Float:Z;
            GetPlayerPos(playerid, X, Y, Z);
            PlayerInfo[playerid][pLastX] = X;
            PlayerInfo[playerid][pLastY] = Y;
            PlayerInfo[playerid][pLastZ] = Z;
            TogglePlayerSpectating(playerid, 1);
            PlayerSpectatePlayer(playerid, specplayerid);
            SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
            gSpectateID[playerid] = specplayerid;
            gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
        }
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:spoff(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 3)
    {
		TogglePlayerSpectating(playerid, 0);
	    gSpectateID[playerid] = INVALID_PLAYER_ID;
	    gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
		SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pLastX], PlayerInfo[playerid][pLastY], PlayerInfo[playerid][pLastZ], PlayerInfo[playerid][pFacingAngle], 0, 0, 0, 0, 0, 0);
		SpawnPlayer(playerid);
	    SendClientMessage(playerid, -1, ""COL_RED"[BOT]"COL_WHITE" Spec off");
	}
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:setwaktu(playerid,params[])
{
    if(isnull(params)) return SendClientMessage(playerid,-1,"/setwaktu [0 - 23]");
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        new id, string[128];
        if(sscanf(params,"i", id)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setwaktu [0-23]");
        if(id < 0 || id > 23) return SendClientMessage(playerid, COLOR_WHITE, "Oi Bodo Tak Wujud Pukul Tu (0-23).");
        if (PlayerInfo[playerid][pAdmin] >= 3)
        if(IsPlayerConnected(i))
        {
            PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
            SetPlayerTime(i, id, 0);
            format(string, sizeof(string), ""COL_DC"[MYBOT]:"COL_WHITE"Admin %s Telah Set Waktu Kepada %d", GetRPName(playerid), id);
            SendClientMessageToAll(-1, string);
        }
    }
    return 1;
}

CMD:ajail(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        new sebab[128],targetid,string[300];
        new Float:x, Float:y, Float:z;
        new SpawnRandom = random(sizeof(SpawnJail));
        if(sscanf(params, "uz", targetid, sebab)) return SendClientMessage(playerid, 0xAA3333AA,"GUNAKAN : /ajail [playerid] [sebab]");
        if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xAA3333AA,"Player itu Offline");
        if(PlayerInfo[targetid][pJail] == 1) return SendClientMessage(playerid, 0xAA3333AA,"Player Itu Sudah Ada Didalam Penjara");
        if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z)) return SendClientMessage(playerid , -1,"Anda Perlulah Berdekatan Dengan Mangsa");
        if(PlayerInfo[playerid][pJail] == 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
        format(string, sizeof(string), "{FF0000}[INFO JAIL] {FFFFFF}Pegawai %s telah memenjarakan %s kerana {FF0000}%s", GetRPName(playerid), GetRPName(targetid),sebab);
        ResetPlayerWeapons(targetid);
        PlayerInfo[targetid][pDuty] = 0;
        SendClientMessageToAll(-1, string);
        SetPlayerPos(targetid,
        SpawnJail[SpawnRandom][0],
        SpawnJail[SpawnRandom][1],
        SpawnJail[SpawnRandom][2]);
        PlayerInfo[targetid][pJail] = 1;
        SetTimerEx("Unjail",1800000,false,"i",playerid);
        freezeplayer(targetid);
        format(string, sizeof string, " :chains: *[INFO JAIL]* \n**PEGAWAI:%s \nPESALAH:%s\nSEBAB:%s ** ", GetRPName(playerid), GetRPName(targetid),sebab);
        DCC_SendChannelMessage(Info_Pdrm, string);
    }
    return 1;
}

CMD:aunjail(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        new targetid,string[300];
        if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /unjail [playerid]");
        if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xAA3333AA,"Player itu Offline");
        if(PlayerInfo[targetid][pJail] == 0) return SendClientMessage(playerid, 0xAA3333AA,"Player Itu Tiada Di Dalam Penjara");
        SetPlayerPos(targetid, 244.8448,211.6833,1042.1980);
        PlayerInfo[targetid][pJail] = 0;
        SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
        format(string, sizeof(string), "{FF2400}[INFO UNJAIL] {FFFFFF}Admin %s telah membebaskan %s daripada penjara", GetRPName(playerid),GetRPName(targetid));
        SendClientMessageToAll(-1, string);
        SendClientMessage(targetid, -1,"{FF0000}Semoga Anda Menjadi Manusia Yang Berguna");
        format(string, sizeof string, " :chains: *[INFO UNJAIL]* \n**Admin: %s\nBANDUAN: %s** ", GetRPName(playerid), GetRPName(targetid));
        DCC_SendChannelMessage(Info_Pdrm, string);
    }
    return 1;
}

CMD:makevip(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 3)
    {
        new targetid;
        if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /makevip [playerid]");
        if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
        else
        {
            new string[500];
            format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Vip Kepada %s", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "[MYBOT]: Admin %s Telah Memberikan Anda Role Vip", GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
            PlayerInfo[targetid][pVip] = 1;
            SaveStatsPlayer(targetid);
        }
    }
    return 1;
}

CMD:vchat(playerid, params[])
{
	new string[500], text[500];
	if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /vchat [text]");
	if(PlayerInfo[playerid][pVip] > 0)
	{
        format(string, sizeof(string), ""COL_RED"[VIP CHAT]"COL_WHITE" %s : %s", GetRPName(playerid), text);
		SendVipMessage(-1, string);
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Command Ini Hanya Untuk "COL_RED"VIP "COL_WHITE"Sahaja");
	return 1;
}

CMD:stream(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        new string[500];
        if(isnull(params)) return SendClientMessage(playerid,-1,"/stream [link]");
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
            PlayAudioStreamForPlayer(i,params);
            SendClientMessage(i,COLOR_RED,"Admin Server Telah Memainkan Lagu Untuk Semua Pemain!");
        }
        //======DISCORD CONNECTOR
        format(string, sizeof string, " **[SERVER LOG ADMIN]** \n%s: TELAH MEMAINKAN LAGU ", GetRPName(playerid));
        DCC_SendChannelMessage(Server_Log_Admin, string);
    }
    return 1;
}

DCMD:ann(user, channel, params[])
{
    new string[500];
    if(isnull(params)) return DCC_SendChannelMessage(PanelServer, "GUNAKAN : !ann [text]");
    format(string,sizeof(string),"~w~%s",params);
    GameTextForAll(string,5000,3);
    return 1;
}

DCMD:restart(user, channel, params[])
{
    new string[500];
    if(isnull(params)) return DCC_SendChannelMessage(PanelServer, "GUNAKAN : !restart [text]");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    SendClientMessageToAll(RED,"[MYBOT]: {FFFFFF}Server Restart Dalam 30 Saat, Sila Keluar!");
    //GameTextForAll("~y~SERVER RESTART ~r~SILA KELUAR", 30000, 3);
    format(string,sizeof(string),"~y~SERVER RESTART ~r~SILA KELUAR~n~~b~%s",params);
    GameTextForAll(string,5000,3);
    DCC_SendChannelMessage(ServerRestart,"Server Restart @everyone!");
    return 1;
}

DCMD:online(user, channel, params[], string[128])
{
	if(isnull(params)) return DCC_SendChannelMessage(PanelServer, "GUNAKAN : !online [text]");
    format(string,sizeof(string),"%s",params);
	DCC_SendChannelMessage(ServerRestart, string);
	return 1;
}

CMD:kick(playerid, params[])
{
    new targetid;
    new sebab[128], string[500];
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");
    if(sscanf(params, "us[128]", targetid, sebab)) return SendClientMessage(playerid, -1, "[MYBOT]: /kick [playerid][sebab]");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[playerid][pAdmin] > 0) 
    {
        new logstring[256];
        format(string, sizeof(string), "{FF0000}[MYBOT]: {FFFFFF}%s Telah Di Kick Oleh %s Dari Server Kerana {FF0000}%s", GetRPName(targetid), GetRPName(playerid), sebab); SendClientMessageToAll(-1, string);
        SetTimerEx("Delay_Kick",100,false,"i",targetid);
        format(logstring, sizeof(logstring), "[ADMIN]: %s telah ditendang keluar oleh %s, kerana: %s (%d-%d-%d).", GetRPName(playerid), GetRPName(targetid), sebab);
        KickLog(logstring);
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:makeleader(playerid, params[])
{
    new targetid, amount;
    if(PlayerInfo[playerid][pAdmin] >= 3)
    {
        if(sscanf(params, "ud", targetid, amount))
        {   
            SendClientMessage(playerid, -1, "[MYBOT]: /makeleader [playerid] [Role Number]");
            SendClientMessage(playerid, -1, "[MYBOT]: Role Number 1: Police");
            SendClientMessage(playerid, -1, "[MYBOT]: Role Number 2: Suruhanjaya");
            SendClientMessage(playerid, -1, "[MYBOT]: Role Number 3: Medic");
            SendClientMessage(playerid, -1, "[MYBOT]: Role Number 4: FNF");
            SendClientMessage(playerid, -1, "[MYBOT]: Role Number 5: Tailong");
            SendClientMessage(playerid, -1, "[MYBOT]: Role Number 6: Mafia");
            return 1;
        }
        if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
        else
        {
            new string[500];
            format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Leader Level %d Kepada %s", amount, GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
            format(string, sizeof(string), "[MYBOT]: Owner %s Telah Memberikan Anda Role Leader Level %d",GetRPName(playerid), amount); SendClientMessage(targetid, COLOR_WHITE, string);
            PlayerInfo[targetid][pLeader] = amount;
            PlayerInfo[targetid][pRole] = amount;
            PlayerInfo[targetid][pLevel] = 5;
            SaveStatsPlayer(playerid);
        }
    }
    else
    {
        SendClientMessage(playerid, -1, ""COL_DC"[MYBOT]:"COL_WHITE" Level Anda Belum Cukup Tinggi Untuk Menggunakan Command Ini");
    }
    return 1;
}

CMD:ban(playerid, params[])
{
    new targetid;
    new sebab[128], string[500];
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");
    if(sscanf(params, "us[128]", targetid, sebab)) return SendClientMessage(playerid, -1, "[MYBOT]: /Ban [playerid][sebab]");
    if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[targetid][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda Tidak Dapat Ban Admin Lagi Tinggi Dari Anda");
    if(PlayerInfo[targetid][pAdmin] == 5) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda Tidak Dapat Ban Developer");
    if(PlayerInfo[playerid][pAdmin] > 0)
    {
        format(string, sizeof(string), "{FF0000}[MYBOT]: {FFFFFF}%s Telah Di Ban Dari Server Kerana {FF0000}%s", GetRPName(targetid), sebab); 
        SendClientMessageToAll(-1, string);
        Ban(targetid);
    }
    return 1;
}

CMD:slap(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] > 1) 
    {
        new targetid;
        new logstring[256];
        new sebab[128];
        if(sscanf(params, "us[128]", targetid, sebab)) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: /slap [playerid] [sebab]");
        if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "{FF0000}[MYBOT]: Pemain itu tidak online ");
        new string[500];
        new Float:x, Float:y, Float:z;
        GetPlayerPos(targetid,x,y,z); SetPlayerPos(targetid,x,y,z+30);
	    format(string, sizeof(string), "{FF0000}[MYBOT]: {FFFFFF}Admin %s Telah Slap %s Kerana : %s", GetRPName(playerid),GetRPName(targetid), sebab); SendClientMessageToAll(-1, string);
        format(logstring, sizeof(logstring), "[ADMIN]: %s telah dislap keluar oleh %s, kerana: %s.", GetRPName(playerid), GetRPName(targetid), sebab);
        SlapLog(logstring);
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:ann(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] > 0) 
    {
        new text[100],string[128];
        if(sscanf(params,"s[128]",text)) return SendClientMessage(playerid, -1, "[MYBOT]: /ann [text]");

        format(string,sizeof(string),"%s",text);
        TextDrawSetString(ann_2, string);

        TextDrawShowForAll(ann_1);
        TextDrawShowForAll(ann_2);
        TextDrawShowForAll(ann_3);

        SetTimerEx("Announcement", 10000,false,"i",playerid);

        PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
    }
    else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda bukan Admin ");
    return 1;
}

CMD:cc(playerid,params[],help)
{
    if(PlayerInfo[playerid][pAdmin] > 0)
    {
        for(new i = 0; i < 250; i++) SendClientMessageToAll(0x00000000," ");
    }
    else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda bukan Admin ");
    return 1;
}

CMD:goto(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        new targetid, str[256];
        if(sscanf(params,"u", targetid)) return SendClientMessage(playerid,-1,"/goto [playerid]");
        if(targetid == playerid) return SendClientMessage(playerid,-1,"Anda tidak boleh goto ke diri anda sendiri");
        if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
        if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Pemain itu tidak online");
        format(str,sizeof(str),"Anda telah goto kepada %s",GetRPName(targetid));
        SendClientMessage(playerid,-1,str);
		new Float:x,Float:y,Float:z;
        GetPlayerPos(targetid, x,y,z);
        SetPlayerPos(playerid, x,y,z);
        SetPlayerInterior(playerid,GetPlayerInterior(targetid));
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:givegun(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        new target, gun, string[128];
        if(sscanf(params, "ud", target, gun))
        {
            SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /givegun [playerid] [weaponid]"); 
            return 1;
        }
        if(gun < 1 || gun > 46) { SendClientMessage(playerid, COLOR_GREY, ""COL_RED"[MYBOT]"COL_WHITE" Jangan kurang daripada 1 atau lebih daripada 47"); return 1; }
        if(IsPlayerConnected(target))
        {
            if(target!= INVALID_PLAYER_ID)
            {
                if(gun == 21)
                {
                    SetPlayerSpecialAction(target, SPECIAL_ACTION_USEJETPACK);
                }
                GivePlayerWeapon(target, gun, 999999);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah memberi senjata %d kepada %s!", gun, GetRPName(target));
                SendClientMessage(playerid, COLOR_GRAD1, string);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Admin %s telah memberi anda senjata %d ",GetRPName(playerid),gun);
                SendClientMessage(playerid, COLOR_GRAD1, string);
            }
        }
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:gotoint(playerid, params[])
{
    new Interior, Float: X, Float: Y, Float: Z;
    if( sscanf( params, "dfff", Interior, X, Y, Z ) )
    {
        if (PlayerInfo[playerid][pAdmin] >= -0)
        {
            SendClientMessage( playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE" /gotoint [Interior ID] [x point] [y point] [z point]" );
        }
    }
    else
    {
        if (PlayerInfo[playerid][pAdmin] > 0)
        {
            SetPlayerPos( playerid, X, Y, Z );
            SetPlayerInterior( playerid, Interior );
            SendClientMessage( playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda telah teleport ke tempat anda mahukan");
        }
    }
    return 1;
}

CMD:cmdadmin(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        ShowPlayerDialog(playerid, CMDADMIN, DIALOG_STYLE_LIST, ""COL_WHITE"CMD ADMIN", ""COL_WHITE"FIXCAR\nTARIKSEMUA\nANNOUNCEMENT\nHEAL ALL\nCLEAR ALL CAR", "Pilih", "Tutup");
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:givemoney(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 3)
    {
        new string[128], targetid, money;
        if(sscanf(params, "ud", targetid, money)) return SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /givemoney [playerid] [jumlah]");
        if(IsPlayerConnected(targetid))
        {
            PlayerInfo[playerid][pCash] = money;
            GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = money);
            format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah memberi duit kepada %s sebanyak "COL_GREEN"RM%d.",GetRPName(targetid),money);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string),""COL_RED"[MYBOT]"COL_WHITE" Admin %s telah memberi anda duit sebanyak RM%d", GetRPName(playerid),money);
            SendClientMessage(targetid,COLOR_GRAD2,string);
            new ip[32], ipex[32];
            new i_dateTime[2][3];
            gettime(i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2]);
            getdate(i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2]);
            GetPlayerIp(playerid, ip, sizeof(ip));
            GetPlayerIp(targetid, ipex, sizeof(ipex));
            format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s (IP:%s) telah membayar $%d kepada %s (IP:%s)", i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2], i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2], GetRPName(playerid), ip, money, GetRPName(targetid), ipex);
            PayLog(string);
            PlayerInfo[playerid][pCash] = money;

        }
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:setscore(playerid, params[])
{
    if (PlayerInfo[playerid][pAdmin] >= 3)
    {
        new string[128], targetid, amount;
        if(sscanf(params, "ud", targetid, amount)) return SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setlevel [playerid] [jumlah]");

        if(IsPlayerConnected(targetid))
        {
            PlayerInfo[playerid][pScore] = amount;
            SetPlayerScore(targetid,PlayerInfo[targetid][pScore] = amount);
            format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah set score kepada %s sebanyak "COL_GREEN"%d.",GetRPName(targetid),amount);
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, sizeof(string),""COL_RED"[MYBOT]"COL_WHITE" Admin %s telah set score anda sebanyak %d", GetRPName(playerid),amount);
            SendClientMessage(targetid,COLOR_GRAD2,string);
            PlayerInfo[playerid][pScore] = amount;
        }
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:setarmor(playerid, params[])
{
    new string[128], playa, health;
    if(sscanf(params, "ud", playa, health))
    {
        SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setarmor [playerid] [armor]");
        return 1;
    }
    if(health < 0 || health > 120) return SendClientMessage(playerid, COLOR_GREY, ""COL_RED"[MYBOT]"COL_WHITE" Anda Boleh Set Armor Player Dari 0 Hingga 120 Sahaja");
    if(PlayerInfo[playa][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda tidak dapat set armor admin level lebih tinggi daripada anda");
    if (PlayerInfo[playerid][pAdmin] >= 3)
    {
        if(IsPlayerConnected(playa))
        {
            if(playa!= INVALID_PLAYER_ID)
            {
                SetPlayerArmour(playa, health);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah set armor %s kepada %d.", GetRPName(playa), health);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" %s telah set armor anda kepada %d.", GetRPName(playerid), health);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            }
        }
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:sethp(playerid, params[])
{
    new string[128], playa, health;
    if(sscanf(params, "ud", playa, health))
    {
        SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /sethp [playerid] [health]");
        return 1;
    }
    if(health < 0 || health > 120) return SendClientMessage(playerid, COLOR_GREY, ""COL_RED"[MYBOT]"COL_WHITE" Anda Boleh Set Nyawa Player Dari 0 Hingga 120 Sahaja");
    if(PlayerInfo[playa][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda tidak dapat set nyawa admin level lebih tinggi daripada anda");
    if (PlayerInfo[playerid][pAdmin] >= 3) {
        if(IsPlayerConnected(playa)) {
            if(playa != INVALID_PLAYER_ID)
            {
                SetPlayerHealth(playa, health);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah set nyawa %s kepada %d.", GetRPName(playa), health);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" %s telah set nyawa anda kepada %d.", GetRPName(playerid), health);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            }
        }
        else SendClientMessage(playerid, COLOR_GRAD1, ""COL_RED"[MYBOT]"COL_WHITE" Pemain itu tidak online");
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:setskin(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
    {
		new targetid, skinid, string[128];
	 	if(sscanf(params, "ui", targetid, skinid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setskin [playerid] [skinid]");
		if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, "Player Itu Offline!");
	 	if(skinid < 1 || skinid > 311) { SendClientMessage(playerid, COLOR_GREY, ""COL_RED"[MYBOT]"COL_WHITE" Jangan kurang daripada 1 atau lebih daripada 311 [skin 0 tidak diterima"); return 1; }
		SetPlayerSkin(targetid, skinid);
	 	format(string, 128, ""COL_RED"[MYBOT]"COL_WHITE" Admin %s telah set skin anda kepada skin %d.", GetRPName(playerid), skinid);
	  	SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
	   	format(string, 128, ""COL_RED"[MYBOT]"COL_WHITE" Anda telah set skin %s kepada skin %d.", GetRPName(targetid), skinid);
	   	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	   	PlayerInfo[targetid][pSkin] = skinid;
	}
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
	return 1;
}

CMD:tarik(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new targetid, Float:x, Float:y, Float:z;
            new vw = GetPlayerVirtualWorld(playerid);
            if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /tarik [playerid]");
            else if(playerid == targetid) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda tidak boleh tarik diri anda sendiri");
            if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
            new interior = GetPlayerInterior(playerid);
            GetPlayerPos(playerid, x, y, z);
            SetPlayerPos(targetid, x+1, y+1, z);
            GetPlayerVirtualWorld(playerid);
            SetPlayerVirtualWorld(targetid, vw);
            SetPlayerInterior(targetid, interior);
        }
        else return SendClientMessage(playerid, COLOR_GRAD2, XONDUTY);
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:givemoneyall(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 3)
    {
        new amount;
        if(sscanf(params, "d",amount)) return SendClientMessage(playerid, -1, "USAGE: /givemoneyall [amount]");
        new string[128];
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
            if(IsPlayerConnected(i))
            {
                PlayerPlaySound(i,1057,0.0,0.0,0.0);
                GiveMoneyPayday(i, amount);
            }
        }
        format(string,sizeof(string),"{FF0000}[MYBOT]{FFFFFF}Admin %s Telah Memberi Duit Kepada Semua Pemain Sebanyak RM %d !", GetRPName(playerid), amount);
        return SendClientMessageToAll(-1, string);
    }
    //else return SendClientMessage(playerid, COLOR_GRAD2, NOTADMIN);
    return 1;
}

CMD:kapalgo(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
    {
        if(IsPlayerInRangeOfPoint(playerid,10,303.3682,-1906.8201,7.4977)) 
        {
            MoveDynamicObject(Kapal, 302.8391, -1938.1990, 15.3045, 5.00);
        }
    }
    return 1;
}

CMD:kapalbalik(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
    {
        if(IsPlayerInRangeOfPoint(playerid,10,304.2813, -3344.5247, 12.7482)) 
        {
            MoveDynamicObject(Kapal, 302.8391, -3312.5679, 20.0245, 5.00);
        }
    }
    return 1;
}

CMD:delveh(playerid, params[])
{
    if(IsPlayerConnected(playerid))
    {
        if(PlayerInfo[playerid][pAdmin] >= 3)
        {
            SendClientMessage(playerid, -1, ""COL_DC"[MYBOT]"COL_WHITE" Command Ini Hanya Orang Tertentu Sahaja Boleh Guna");
            return 1;
        }
        if(IsPlayerInAnyVehicle(playerid))
        {
            DestroyVehicle(GetPlayerVehicleID(playerid));
            SendClientMessage(playerid, COLOR_GREY, ""COL_DC"[MYBOT]:"COL_WHITE" Kenderaan Telah Dibuang");
        }
    }
    return 1;
}

//======================================CMD MAFIA=====================================================//

CMD:deserteagle(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] > 2)
    if(PlayerInfo[playerid][pRole] == 9)
    {
        new targetid;
        if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /deserteagle [playerid]");
        if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
     
        if(PlayerInfo[targetid][pDeserteagle] == 1) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu sudah mempunyai deserteagle ");
        PlayerInfo[targetid][pDeserteagle] = 1;
        GivePlayerWeapon(targetid, 24, 500);
        GivePlayerMoney(targetid,-100000);
        GivePlayerMoney(playerid,100000);
        new string[500];
        format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Senjata Kepada %s", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
        format(string, sizeof(string), "[MYBOT]: Admin %s Telah Memberikan Anda deserteagle",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
    }
    return 1;
}

CMD:m4(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] > 2)
    if(PlayerInfo[playerid][pRole] == 9)
    {
        new targetid;
        if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /deserteagle [playerid]");
        if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
     
        if(PlayerInfo[targetid][pM4] == 1) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu sudah mempunyai m4 ");
        PlayerInfo[targetid][pM4] = 1;
        GivePlayerWeapon(targetid, 31, 500);
        GivePlayerMoney(targetid,-150000);
        GivePlayerMoney(playerid,150000);
        new string[500];
        format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Senjata Kepada %s", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
        format(string, sizeof(string), "[MYBOT]: Admin %s Telah Memberikan Anda deserteagle",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
    }
    return 1;
}

CMD:uzi(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 9 || PlayerInfo[playerid][pAdmin] >= 2)
    {
        new targetid;
        if(sscanf(params, "ud", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /uzi [playerid]");
        if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
     
        if(PlayerInfo[targetid][pUzi] == 1) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu sudah mempunyai uzi ");
        PlayerInfo[targetid][pUzi] = 1;
        GivePlayerWeapon(targetid, 28, 500);
        GivePlayerMoney(targetid,-120000);
        GivePlayerMoney(playerid,120000);
        new string[500];
        format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Senjata Kepada %s", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
        format(string, sizeof(string), "[MYBOT]: Admin %s Telah Memberikan Anda uzi",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
    }
    return 1;
}

CMD:weaponuzi(playerid, params[])
{
    if(PlayerInfo[playerid][pUzi] == 1)
    {
        GivePlayerWeapon(playerid, 28, 500);
    }
    return 1;
}

CMD:weaponm4(playerid, params[])
{
    if(PlayerInfo[playerid][pM4] == 1)
    {
        GivePlayerWeapon(playerid, 31, 500);
    }
    return 1;
}

CMD:weapondesert(playerid, params[])
{
    if(PlayerInfo[playerid][pDeserteagle] == 1)
    {
        GivePlayerWeapon(playerid, 24, 500);
    }
    return 1;
}

//=========//=========//=========//=========//========= LEADER CMD
CMD:invite(playerid, params[])
{
    new targetid,level;
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");
    if(sscanf(params, "ud", targetid,level)) return SendClientMessage(playerid, -1, "[MYBOT]: /invite [playerid] [level]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[playerid][pLeader] == 1) 
    { //ROLE Police
        if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 0) 
        {
	        PlayerInfo[targetid][pRole] = 1;
	        PlayerInfo[targetid][pLevel] = level;
            SaveStatsPlayer(playerid);
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Police Level %d Kepada %s", level, GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Memberikan Role Police Level %d Kepada Anda",GetRPName(playerid), level); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu sudah mempunyai role");
	}
	if(PlayerInfo[playerid][pLeader] == 2) 
    { //ROLE Suruhanjaya
	    if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 0) 
        {
	        PlayerInfo[targetid][pRole] = 2;
	        PlayerInfo[targetid][pLevel] = level;
            SaveStatsPlayer(playerid);
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Suruhanjaya Level %d Kepada %s", level, GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Memberikan Role Suruhanjaya Level %d Kepada Anda",GetRPName(playerid), level); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu sudah mempunyai role");
	}
	if(PlayerInfo[playerid][pLeader] == 3) 
    { //ROLE Medic
	    if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 0) 
        {
	        PlayerInfo[targetid][pRole] = 3;
	        PlayerInfo[targetid][pLevel] = level;
            SaveStatsPlayer(playerid);
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Medic Level %d Kepada %s", level, GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Memberikan Role Medic Level %d Kepada Anda",GetRPName(playerid), level); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu sudah mempunyai role");
    }
	if(PlayerInfo[playerid][pLeader] == 4) 
    { //ROLE Tailong
	    if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 0) 
        {
	        PlayerInfo[targetid][pRole] = 4;
	        PlayerInfo[targetid][pLevel] = level;
            SaveStatsPlayer(playerid);
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Tailong Level %d Kepada %s", level, GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Memberikan Role Tailong Level %d Kepada Anda",GetRPName(playerid), level); SendClientMessage(targetid, COLOR_WHITE, string);
		}
       	else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu sudah mempunyai role");
    }
	if(PlayerInfo[playerid][pLeader] == 5) 
    { //ROLE Mafia
	    if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 0) 
        {
	        PlayerInfo[targetid][pRole] = 5;
	        PlayerInfo[targetid][pLevel] = level;
            SaveStatsPlayer(playerid);
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan Role Mafia Level %d Kepada %s", level, GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Memberikan Role Mafia Level %d Kepada Anda",GetRPName(playerid), level); SendClientMessage(targetid, COLOR_WHITE, string);
		}
        else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu sudah mempunyai role");
    }
	return 1;
}

CMD:uninvite(playerid, params[])
{
    new targetid;
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /uninvite [playerid]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[playerid][pLeader] == 1) 
    { //ROLE Police
        if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 1) 
        {
	        PlayerInfo[targetid][pRole] = 0;
	        PlayerInfo[targetid][pLevel] = 0;
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Kick %s Dari Role Police", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Kick Anda Dari Role Police",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda tidak dibenarkan kick role lain");
	}
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /uninvite [playerid]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[playerid][pLeader] == 2) 
    { //ROLE Suruhanjaya
        if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 2) 
        {
	        PlayerInfo[targetid][pRole] = 0;
	        PlayerInfo[targetid][pLevel] = 0;
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Kick %s Dari Role Suruhanjaya", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Kick Anda Dari Role Suruhanjaya",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda tidak dibenarkan kick role lain");
	}
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /uninvite [playerid]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[playerid][pLeader] == 3) 
    { //ROLE Medic
        if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 3) 
        {
	        PlayerInfo[targetid][pRole] = 0;
	        PlayerInfo[targetid][pLevel] = 0;
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Kick %s Dari Role Medic", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Kick Anda Dari Role Medic",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda tidak dibenarkan kick role lain");
	}
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /uninvite [playerid]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[playerid][pLeader] == 4) 
    { //ROLE Tailong
        if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 4) 
        {
	        PlayerInfo[targetid][pRole] = 0;
	        PlayerInfo[targetid][pLevel] = 0;
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Kick %s Dari Role Tailong", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Kick Anda Dari Role Tailong",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda tidak dibenarkan kick role lain");
	}
    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /uninvite [playerid]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(PlayerInfo[playerid][pLeader] == 5) 
    { //ROLE Mafia
        if(PlayerInfo[targetid][pLeader] > 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Player itu Adalah Leader Role ");
        if(PlayerInfo[targetid][pRole] == 5) 
        {
	        PlayerInfo[targetid][pRole] = 0;
	        PlayerInfo[targetid][pLevel] = 0;
	        new string[500];
		    format(string, sizeof(string), "[MYBOT]: Anda Telah Kick %s Dari Role Mafia", GetRPName(targetid)); SendClientMessage(playerid, COLOR_WHITE, string);
		    format(string, sizeof(string), "[MYBOT]: Leader %s Telah Kick Anda Dari Role Mafia",GetRPName(playerid)); SendClientMessage(targetid, COLOR_WHITE, string);
		}
		else return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda tidak dibenarkan kick role lain");
	}
	return 1;
}

//QUOTES
CMD:wb(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbg(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK GAY!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbo(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK OWNER!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbf(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK {00FF16}FOUNDER!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbd(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK DEVELOPER!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbad(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK A.DEVELOPER!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbm(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK MODERATOR!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wba(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK ADMIN!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbs(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK STAFF!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wbsayang(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WELCOME BACK SAYANG!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:ty(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}THANK YOU!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:tyg(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}THANK YOU GAY!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:tys(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}THANK YOU SAYANG!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:aslm(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}ASSALAMUALAIKUM!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:wslm(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}WAALAIKUMSALAM!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:haha(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}HAHAHAHAHAHA!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:bye(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}BYEE!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:gay(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}ADALAH TERPALING GAY DIDUNIA!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:rusuh(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}RUSUH NI KOK DILAWAN!!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:admin1(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}KALAU KETEMU ADMIN HYRBID JANGAN DILAWAN!!NANTI CAIR!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

CMD:zahier1(playerid,params[])
{
    new string[128], playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid, playername, sizeof(playername));
    format(string, sizeof(string), "{FFFFFF}%s: {f5ed0a}SCRIPTER RUSUH NI BOSS, JNGN DI LAWAN!",playername);
    SendClientMessageToAll(0xFF0000C8, string);
    return 1;
}

//=========//=========//=========//=========//========= RAKYAT CMD
CMD:menu(playerid, params[])
{
	ShowPlayerDialog(playerid, Helpcommand, DIALOG_STYLE_LIST, ""COL_WHITE"Command", ""COL_WHITE"General Command\nPdrm Command\nHDRD Command\nKkm Command\nFNF Command\nADMIN command", "Pilih", "Tutup");
    return 1;
}

CMD:tutupwaze(playerid, params[])
{
    DisablePlayerCheckpoint(playerid);
    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Anda Telah Menutup Waze.Jika Anda Mahu Melihat Waze Semula Taip /waze");
    return 1;
}

CMD:duduk(playerid, params[])
{
    ApplyAnimation(playerid,"PED","SEAT_idle",4.0, 1, 0, 0, 0, 0, 1);
    CreateRp(playerid, "sedang duduk.");
    return 1;
}

CMD:kordinat(playerid, params[])
{
    new Float:x, Float:y, Float:z, Float:Angle, string[400];
    GetPlayerPos(playerid,x, y, z);
    GetPlayerFacingAngle(playerid, Angle);
    format(string, sizeof(string), ""COL_DC"[MYBOT]:"COL_WHITE"Kordinat - X: %f Y: %f Z: %f Angle: %f = %s Siap!", x, y, z, Angle, GetRPName(playerid));
    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    return 1;
}

CMD:transfer(playerid, params[])
{
    new targetid, jumlah, string[MAX_PLAYERS];
    if(PlayerInfo[playerid][pAccBank] == 1)
    {
        if(PlayerInfo[playerid][pDuitBank] >= 1 )
        {
            if(sscanf(params, "ud", targetid, jumlah)) return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" GUNAKAN: /transfer [playerid][jumlah]");
            if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid,-1,""COL_DC"[MYBOT]:"COL_WHITE" Player Ini Tidak Online");
            if(jumlah < 0 || jumlah > PlayerInfo[playerid][pDuitBank]) return SendClientMessage(playerid,-1,""COL_LGREEN"[CIMB BANK]"COL_WHITE" Anda Tidak Mempunyai Duit Sebanyak Itu Di Akaun Bank Anda");
            format(string, sizeof(string), ""COL_LGREEN"[CIMB BANK]"COL_WHITE" Anda Telah Mentransferkan Duit "COL_RED"RM%d Kepada Akaun Bank %s", jumlah, GetRPName(targetid));
            SendClientMessage(playerid, -1, string);
            format(string, sizeof(string), ""COL_LGREEN"[CIMB BANK]"COL_WHITE" %s Telah Mentransfer Duit Sebanyak "COL_LGREEN"RM%d "COL_WHITE"Kepada Akaun Bank Anda",GetRPName(playerid), jumlah);
            SendClientMessage(targetid, -1, string);
            PlayerInfo[playerid][pDuitBank] -= jumlah;
            PlayerInfo[targetid][pDuitBank] += jumlah;
        }
        else SendClientMessage(playerid, -1, ""COL_RED"[MYBOT]"COL_WHITE" Anda Tidak Mempunyai Wang Yang Cukup Di Akaun Bank Anda!");
    }
    else SendClientMessage(playerid, -1, ""COL_RED"[MYBOT]"COL_WHITE" Anda Tidak Mempunyai Account Bank");
    return 1;
}

CMD:l(playerid, params[])
{
	new string[128];
	if (isnull(params))
	return SendClientMessage(playerid, -1, "USAGE: (/l)ow [local chat]");
	format(string, sizeof(string), "%s Bercakap Perlahan: %s", GetRPName(playerid), params);
	ProxDetector(10.0, playerid, string, COLOR_FADE1, COLOR_FADE1, COLOR_FADE1, COLOR_FADE1, COLOR_FADE2);
	return 1;
}

CMD:s(playerid, params[])
{
	new string[128];
	if (isnull(params))
	return SendClientMessage(playerid, -1, "USAGE: (/s)hout [local chat]");
	format(string, sizeof(string), "%s Menjerit: %s!", GetRPName(playerid), params);
	ProxDetector(30.0, playerid, string, COLOR_WHITE, COLOR_WHITE, COLOR_WHITE, COLOR_FADE1, COLOR_FADE2);
	ApplyAnimation(playerid, "ON_LOOKERS", "shout_01", 4.0,1,0,0,0,0,1);
	return 1;
}

CMD:bank(playerid, param[])
{
    if(IsPlayerInRangeOfPoint(playerid, 2, 1516.3513,-2171.4417,13.6328) ||
    IsPlayerInRangeOfPoint(playerid, 2, 1516.3506,-2167.4072,13.6328) ||
    IsPlayerInRangeOfPoint(playerid, 2, 1516.3510,-2163.3494,13.6328))
    {
        if(PlayerInfo[playerid][pAccBank] == 0)
        {
            new string[500];
            PlayerInfo[playerid][pAccBank] = 1;
            TolakDuitPlayer(playerid, 100);
            format(string, sizeof(string), COL_RED"[MYBOT]: " COL_WHITE"ANDA TELAH MEMBUAT ACC BANK DAN DITOLAK SEBANYAK RM100",GetRPName(playerid)); SendClientMessage(playerid, COLOR_WHITE, string);
        }
        else SendClientMessage(playerid, 0xCECECEFF, "ANDA TELAH MEMPUNYAI ACC BANK");
    }
    return 1;
}

CMD:joinpb(playerid, params[])
{
    if(PlayerToPoint(2, playerid, 1954.6350,-2319.7412,13.5469))
    { 
        new string[248];
        format(string, sizeof(string), "{F9EB11}[PAINTBALL]: {ffffff}%s Telah Menyertai Paintball Dan Anti Spawn Killing Diaktifkan Selama 5 Saat.", GetRPName(playerid)); 
        SendClientMessageToAll(-1, string);
        TengahPaintball[playerid] = 1;
        RandomPaintballSpawn(playerid);
    }
    return 1;
}

CMD:exitpb(playerid, params[])
{
    if(TengahPaintball[playerid] == 1)
    { 
        new string[248];
        format(string, sizeof(string), "{F9EB11}[PAINTBALL]: {ffffff}%s Telah Keluar Daripada Paintball.", GetRPName(playerid)); 
        SendClientMessageToAll(-1, string);
        TengahPaintball[playerid] = 0;
        ScorePaintball[playerid] = 0;
        MatiPaintball[playerid] = 0;
        ResetPlayerWeapons(playerid);
        SetPlayerPos(playerid, 1209.7698,-2037.6718,69.0078);
        SetPlayerInterior(playerid, 0);
    }
    else return SendClientMessage(playerid, -1,"{FF0000}[ERROR] {FFFFFF}Anda Tidak Pernah Menyertai Paintball");
    return 1;
}

CMD:mykad(playerid,params[])
{
    new role[60],admin[60],lesenkereta[60],lesenmotor[60],lesenlori[60],string[500];
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");

    if(PlayerInfo[playerid][pRole] == 0){ role = "RAKYAT"; }
    if(PlayerInfo[playerid][pRole] == 1){ role = "PDRM"; }
    if(PlayerInfo[playerid][pRole] == 2){ role = "JPJ"; }
    if(PlayerInfo[playerid][pRole] == 3){ role = "KKM"; }
    if(PlayerInfo[playerid][pRole] == 4){ role = "MECHANIC"; }
    if(PlayerInfo[playerid][pRole] == 5){ role = "KONGSI"; }
    if(PlayerInfo[playerid][pRole] == 6){ role = "YAKUZA"; }
    if(PlayerInfo[playerid][pRole] == 7){ role = "SCAR77"; }
    if(PlayerInfo[playerid][pRole] == 8){ role = "Kapak"; }
    if(PlayerInfo[playerid][pRole] == 9){ role = "MAFIA"; }

    if(PlayerInfo[playerid][pAdmin] == 0){ admin = "TIADA"; }
    if(PlayerInfo[playerid][pAdmin] == 1){ admin = "STAFF"; }
    if(PlayerInfo[playerid][pAdmin] == 2){ admin = "ADMIN"; }
    if(PlayerInfo[playerid][pAdmin] == 3){ admin = "MODERATOR"; }
    if(PlayerInfo[playerid][pAdmin] == 4){ admin = "A.DEVELOPER"; }
    if(PlayerInfo[playerid][pAdmin] == 5){ admin = "DEVELOPER"; }
    if(PlayerInfo[playerid][pAdmin] == 6){ admin = "OWNER"; }
    if(PlayerInfo[playerid][pAdmin] == 7){ admin = "FOUNDER"; }
    

    if(PlayerInfo[playerid][pLesenkereta] == 0){ lesenkereta = "TIADA MEMPUNYAI LESEN KERETA(DA)"; }
    if(PlayerInfo[playerid][pLesenkereta] == 1){ lesenkereta = "SUDAH MEMPUNYAI LESEN KERETA(DA)"; }

    if(PlayerInfo[playerid][pLesenmotor] == 0){ lesenmotor = "TIADA MEMPUNYAI LESEN MOTOR(B)"; }
    if(PlayerInfo[playerid][pLesenmotor] == 1){ lesenmotor = "SUDAH MEMPUNYAI LESEN MOTOR(B)"; }

    if(PlayerInfo[playerid][pLesengdl] == 0){ lesenlori = "TIADA MEMPUNYAI LESEN LORI(GDL)"; }
    if(PlayerInfo[playerid][pLesengdl] == 1){ lesenlori = "SUDAH MEMPUNYAI LESEN LORI(GDL)"; }

    format(string, sizeof(string), "{FFFFFF} Nama : %s \nDuit : RM%d \nLevel: %d \nRole: %s \nAdmin : %s \nLesenKereta : %s \nLesenMotor : %s \nLesenGdl : %s", 
    GetRPName(playerid), GetPlayerMoney(playerid), GetPlayerScore(playerid), role, admin, lesenkereta, lesenmotor, lesenlori);
    ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "MyKad", string, "Tutup", "");
    return 1;
}

CMD:tunjukic(playerid,params[])
{
    new role[60],admin[60],lesenkereta[60],lesenmotor[60],lesenlori[60],string[500];
    new targetid;
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");

    if(PlayerInfo[playerid][pRole] == 0){ role = "RAKYAT"; }
    if(PlayerInfo[playerid][pRole] == 1){ role = "PDRM"; }
    if(PlayerInfo[playerid][pRole] == 2){ role = "JPJ"; }
    if(PlayerInfo[playerid][pRole] == 3){ role = "KKM"; }
    if(PlayerInfo[playerid][pRole] == 4){ role = "MECHANIC"; }
    if(PlayerInfo[playerid][pRole] == 5){ role = "KONGSI"; }
    if(PlayerInfo[playerid][pRole] == 6){ role = "YAKUZA"; }
    if(PlayerInfo[playerid][pRole] == 7){ role = "SCAR77"; }
    if(PlayerInfo[playerid][pRole] == 8){ role = "Kapak"; }
    if(PlayerInfo[playerid][pRole] == 9){ role = "MAFIA"; }

    if(PlayerInfo[playerid][pAdmin] == 0){ admin = "TIADA"; }
    if(PlayerInfo[playerid][pAdmin] == 1){ admin = "STAFF"; }
    if(PlayerInfo[playerid][pAdmin] == 2){ admin = "ADMIN"; }
    if(PlayerInfo[playerid][pAdmin] == 3){ admin = "MODERATOR"; }
    if(PlayerInfo[playerid][pAdmin] == 4){ admin = "A.DEVELOPER"; }
    if(PlayerInfo[playerid][pAdmin] == 5){ admin = "DEVELOPER"; }
    if(PlayerInfo[playerid][pAdmin] == 6){ admin = "OWNER"; }
    if(PlayerInfo[playerid][pAdmin] == 7){ admin = "FOUNDER"; }
    

    if(PlayerInfo[playerid][pLesenkereta] == 0){ lesenkereta = "TIADA MEMPUNYAI LESEN KERETA(DA)"; }
    if(PlayerInfo[playerid][pLesenkereta] == 1){ lesenkereta = "SUDAH MEMPUNYAI LESEN KERETA(DA)"; }

    if(PlayerInfo[playerid][pLesenmotor] == 0){ lesenmotor = "TIADA MEMPUNYAI LESEN MOTOR(B)"; }
    if(PlayerInfo[playerid][pLesenmotor] == 1){ lesenmotor = "SUDAH MEMPUNYAI LESEN MOTOR(B)"; }

    if(PlayerInfo[playerid][pLesengdl] == 0){ lesenlori = "TIADA MEMPUNYAI LESEN LORI(GDL)"; }
    if(PlayerInfo[playerid][pLesengdl] == 1){ lesenlori = "SUDAH MEMPUNYAI LESEN LORI(GDL)"; }

    format(string, sizeof(string), "{FFFFFF} Nama : %s \nDuit : RM%d \nLevel: %d \nRole: %s \nAdmin : %s \nLesenKereta : %s \nLesenMotor : %s \nLesenGdl : %s \nDADAH: %d \nKETUM: %d \nGANJA: %d ",
    GetRPName(playerid), GetPlayerMoney(playerid), GetPlayerScore(playerid), role, admin, lesenkereta, lesenmotor, lesenlori, PlayerInfo[playerid][pDadah], PlayerInfo[playerid][pKetum], PlayerInfo[playerid][pGanja]);
    ShowPlayerDialog(targetid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "MyKad", string, "Tutup", "");
    return 1;
}

CMD:cmc(playerid, params[])
{
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    SendClientMessage(playerid,COLOR_WHITE," ");
    return 1;
}

CMD:carry(playerid, params[])
{
    new string[500], targetid;
    if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" /carry [playerid]");
    if(!IsPlayerNearPlayer(playerid, targetid, 3)) return SendClientMessage(playerid, -1, ""COL_DC"[DISCORD]:"COL_WHITE" Pemain Itu Terlalu Jauh Daripada Anda");
    format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Carry Anda", GetRPName(playerid));
	SendClientMessage(targetid, COLOR_RED, string);
	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Carry %s", GetRPName(targetid));
	SendClientMessage(targetid, COLOR_RED, string);
    TogglePlayerSpectating(targetid, 1);
    PlayerSpectatePlayer(targetid, playerid);
    PlayerInfo[targetid][pCarry] = 1;
	SetPlayerInterior(targetid, GetPlayerInterior(playerid));
    SaveStatsPlayer(targetid);
	return 1;
}

CMD:uncarry(playerid, params[])
{
    new string[500], targetid, Float:X, Float:Y, Float:Z;
    if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" /uncarry [playerid]");
    format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Uncarry Anda", GetRPName(playerid));
	SendClientMessage(targetid, COLOR_RED, string);
	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Uncarry %s", GetRPName(targetid));
	SendClientMessage(targetid, COLOR_RED, string);
    GetPlayerPos(playerid, X, Y, Z);
    new vw = GetPlayerVirtualWorld(playerid);
    new interior = GetPlayerInterior(playerid);
    TogglePlayerSpectating(targetid, 0);
    SetPlayerPos(targetid, X+1, Y+1, Z);
    SetPlayerVirtualWorld(playerid, vw);
    SetPlayerInterior(targetid, interior);
    PlayerInfo[targetid][pCarry] = 0;
	return 1;
}

CMD:shareloc(playerid,params[])
{
	new string[128],targetid;
	new Float:x, Float:y, Float:z;
	if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /shareloc [playerid]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    GetPlayerPos(playerid, x, y, z);
    SetPlayerCheckpoint(targetid, x, y, z, 5.0);
    format(string, 128, "{6aed28}[INFO SHARELOC]{FFFFFF} Anda Telah Shareloc Location Anda Kepada %s", GetRPName(targetid));
 	SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
 	format(string, 128, "{6aed28}[INFO SHARELOC]{FFFFFF} %s Telah Shareloc Location Kepada Anda", GetRPName(playerid));
 	SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
    return 1;
}

CMD:stats(playerid, params[])
{
    new string[200];
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");
    {
        format(string, sizeof(string), "NAMA:%s\nSCORE:%d\nDUIT:%d\nPING:%d\nSULTAN:%d\nELEGY:%d\nROLE:%d\nLESEN KERETA:%d\nLESEN MOTOR:%d\nLESEN GDL:%d", GetRPName(playerid), GetPlayerScore(playerid), GetPlayerMoney(playerid), GetPlayerPing(playerid), PlayerInfo[playerid][pSultan], PlayerInfo[playerid][pElegy], PlayerInfo[playerid][pRole], PlayerInfo[playerid][pLesenkereta], PlayerInfo[playerid][pLesenmotor], PlayerInfo[playerid][pLesengdl]);
        ShowPlayerDialog(playerid, 0,  DIALOG_STYLE_MSGBOX, "STATS PLAYER", string, "CONTINUE", "BACK");
    }
    return 1;
}

CMD:tunjuklesen(playerid,params[])
{
    new string[682];
    new targetid;
    format(string, sizeof(string), "{FFFFFF}Lesen Kereta : %d \nLesen Motor : %d \nLesen GDL : %d", PlayerInfo[playerid][pLesenkereta], PlayerInfo[playerid][pLesenmotor], PlayerInfo[playerid][pLesengdl]);
    ShowPlayerDialog(targetid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "MyKad", string, "Tutup", "");
    return 1;
}

CMD:tutupgps(playerid,params[])
{
	DisablePlayerCheckpoint(playerid);
	SendClientMessage(playerid, -1,"{6aed28}[INFO GPS] {FFFFFF}Anda Telah Menutup GPS");
	return 1;
}

CMD:mask(playerid)
{
    if (MaskEnabled[playerid] == 1)
    {
        MaskEnabled[playerid] = 0;
        RemovePlayerAttachedObject(playerid, 2);
    }
    else if (MaskEnabled[playerid] == 0)
    {
        MaskEnabled[playerid] = 1;
        SetPlayerAttachedObject(playerid,2,18918,2,0.087000,0.037999,-0.003000,-91.600013,1.599993,-85.799972,1.000000,1.000000,1.000000);
    }
    return 1;
}

CMD:pm(playerid, params[])
{
    new PmPlayer, Message[124], String[124], PlayerName[MAX_PLAYER_NAME], PlayerName2[MAX_PLAYER_NAME], PmSent[50];
    new targetid;
    if(sscanf(params, "us[140]", PmPlayer, Message)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /pm [Playerid] [Message]");
    if(!IsPlayerConnected(PmPlayer)) return SendClientMessage(playerid, COLOR_RED, "Player Itu Offline.");
    if(strlen(Message) < 1) return SendClientMessage(playerid, COLOR_RED, "Error: You've got to type more than 1 letter.");
    else
    {
        GetPlayerName(playerid, PlayerName, sizeof(PlayerName));
        GetPlayerName(PmPlayer, PlayerName2, sizeof(PlayerName2));
        format(PmSent, sizeof(PmSent), "~PM sent to %s", PlayerName2);
        SendClientMessage(playerid, COLOR_GREEN, PmSent);
        format(String, sizeof(String), "~ [PM] Mesege Daripada Id[%d] %s: %s",playerid, PlayerName, Message);
        SendClientMessage(PmPlayer, COLOR_YELLOW, String);
        format(String, sizeof(String), "~ [PM] Mesege Untuk Id [%d] %s: %s",targetid, GetRPName(targetid), Message);
        SendClientMessage(playerid, COLOR_YELLOW, String);
        GameTextForPlayer(PmPlayer, "~n~~n~~n~~n~~n~~n~~n~~n~~y~New message", 3000, 3);
        printf("%s to %s, %s", PlayerName, PlayerName2, Message);
    }
    return 1;
}

CMD:pizzajob(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid,1,2098.2363,-1808.7677,13.5543))
    {
        PizzaJob[playerid] = 1;
	    SetPlayerCheckpoint(playerid, 2307.0071,-1673.2721,14.1145, 5.0);// CP PERTAMA
	    SkinLama[playerid] = GetPlayerSkin(playerid);
	    SetPlayerSkin(playerid, 155);
	    CreateVehicleEx(playerid, 448, -1, -1);
	    new string[500];
 	    format(string, sizeof(string), "{FF0000}[MYBOT]: {FFFFFF}%s Telah Memulakan Kerja Pizza ", GetRPName(playerid)); SendClientMessageToAll(-1, string);
        //======DISCORD CONNECTOR
        format(string, sizeof string, " :pizza: *[INFO PIZZAJOB]* \n **~%s Telah Memulakan Job Pizza!** ", GetRPName(playerid));
        DCC_SendChannelMessage(PizzaJob_Info, string);
    }
    return 1;
}

CMD:basjob(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid,1,1783.8710,-1908.6765,13.0965))
    {
        BasJob[playerid] = 1;
        SetPlayerCheckpoint(playerid, 1811.6798,-1893.0508,13.1154, 5.0);// CP PERTAMA
        SkinLama[playerid] = GetPlayerSkin(playerid);
        SetPlayerSkin(playerid, 17);
        CreateVehicleEx(playerid, 437, -1, -1);
        new string[500];
        format(string, sizeof(string), "{FF0000}[MYBOT]: {FFFFFF}%s Telah Memulakan Kerja Bas ", GetRPName(playerid)); SendClientMessageToAll(-1, string);
        //======DISCORD CONNECTOR
        format(string, sizeof string, " :bus: *[INFO BASJOB]* \n **~%s Telah Memulakan Job Bas!** ", GetRPName(playerid));
        DCC_SendChannelMessage(BasJob_Info, string);
    }
    return 1;
}

CMD:lorisampah(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid,1,1650.7465,-1835.4329,13.5462))
    {
        LoriSampah[playerid] = 1;
        SetPlayerCheckpoint(playerid, 1803.4048,-1720.9279,13.5343, 5.0); //cp pertama
        SetPlayerSkin(playerid, 17);
        CreateVehicleEx(playerid, 408, -1, -1);
        new string[500];
        format(string, sizeof(string), "{FF0000}[MYBOT]: {FFFFFF}%s Telah Memulakan Kerja Lori Sampah", GetRPName(playerid)); SendClientMessageToAll(-1, string);
        //============DISCORD CONNECTER
        format(string, sizeof string, " :truck: *[INFO LORI SAMPAH]* \n **~%s Telah Memulakan Job LoriSampah!** ", GetRPName(playerid));
        DCC_SendChannelMessage(LoriSampah_Info, string);
    }
    return 1;
}

CMD:sweeper(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid,1,1296.6884,-1871.5569,13.5469))
    {
        Sweeper[playerid] = 1;
        SetPlayerCheckpoint(playerid, sweeper1, 5.0); //cp pertama
        CreateVehicleEx(playerid, 574, -1, -1);
        new string[500];
        format(string, sizeof(string), "{FF0000}[MYBOT]: {FFFFFF}%s Telah Memulakan Kerja Sweeper", GetRPName(playerid)); SendClientMessageToAll(-1, string);
        //============DISCORD CONNECTER
        format(string, sizeof string, " :truck: *[INFO LORI SAMPAH]* \n **~%s Telah Memulakan Job Sweeper!** ", GetRPName(playerid));
        DCC_SendChannelMessage(LoriSampah_Info, string);
    }
    return 1;
}

CMD:ca(playerid, params[])
{
	new string[160];
    if(PlayerLogin[playerid] == 0) return SendClientMessage(playerid, -1, "[MYBOT]: Anda Mestilah Login Untuk Menggunakan Cmd Ini");
	if(isnull(params)) return SendClientMessage(playerid, -1,""COL_OREN"[INFO]"COL_WHITE"GUNAKAN: /ca [chat]");
	else
	{
		format(string,160,""COL_RED"[CHAT ALL]"COL_WHITE"%s: %s", GetRPName(playerid), params);
        SCMToAll(COLOR_OOC,string);
		printf(""COL_RED"[CHAT ALL]"COL_WHITE"%s: %s", GetRPName(playerid), string);
        format(string, sizeof string, " :speaking_head: *[CHAT ALL]* \n%s:%s", GetRPName(playerid), params);
        DCC_SendChannelMessage(Chat_Ingame, string);
        TolakDuitPlayer(playerid, 1);
	}
	return 1;
}

CMD:report(playerid, params[])
{
	new string[500], targetid, text[128];
    if(sscanf(params,"uz",targetid, text)) return SendClientMessage(playerid, -1,""COL_RED"[INFO]"COL_WHITE" GUNAKAN: /report [playerid] [sebab]");
	if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" Pemain Ini Tidak Online");
    {
        SendClientMessage(playerid, -1,"anda telah menghantar report di dc");
        format(string, sizeof(string), ""COL_RED"[REPORT]"COL_WHITE" %s Telah Mereport %s Kerana : %s ", GetRPName(playerid), GetRPName(targetid), text);
        SendAdminMessage(-1, string);
        printf("[REPORT][NAME: %s][ID: %d]: TELAH MEREPORT %s KERANA : %s", GetRPName(playerid), playerid, GetRPName(targetid), string);

        //format(string, sizeof string, " :speaking_head: *[REPORT]* \n%s Telah Mereport %s Kerana : %s" , GetRPName(playerid), GetRPName(targetid), text);
        //DCC_SendChannelMessage(Report, string);

        new DCC_Embed:report = DCC_CreateEmbed();
        DCC_SetEmbedTitle(report, "Reports Dari Game!!!");
        format(string, sizeof string, " :speaking_head: *[REPORT]* \n%s Telah Mereport %s Kerana : %s" , GetRPName(playerid), GetRPName(targetid), text);
        DCC_SetEmbedDescription(report, string);
        DCC_SendChannelEmbedMessage(Report, report);
	}
	return 1;
}

CMD:me(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_WHITE,"GUNAKAN: /me [action]");
    new string[128];
    format(string, sizeof(string), "* %s %s", GetPlayerNameEx(playerid), params);
    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}

CMD:do(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_WHITE,"GUNAKAN: /do [action]");
    else if(strlen(params) > 100) return SendClientMessage(playerid, COLOR_RED,"Panjang Mesej Hanya 99 Perkataan Sahaja");
    new string[128];
    format(string, sizeof(string), "* %s (( %s ))", params, GetPlayerNameEx(playerid));
    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}

CMD:b(playerid, params[])
{
    if(isnull(params)) return SendClientMessage(playerid, COLOR_WHITE,"GUNAKAN : /b [local ooc chat]");
    new string[128];
    format(string, sizeof(string), "[OOC] : %s berkata: (( %s ))", GetPlayerNameEx(playerid), params);
    ProxDetector(20.0, playerid, string,COLOR_FADE1,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
    return 1;
}

CMD:mafia(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pRole] == 9 || PlayerInfo[i][pLeader] == 9)
        {
            format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
            strcat(String, Str);
            ContAdmin++;
        }
    }
    if(ContAdmin == 0) { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}MAFIA OFFLINE", "{ffffff}TIADA MAFIA YANG ON WAKTU INI!", "Ok", #); 
    }
    else { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}MAFIA ONLINE", String, "Ok", #); 
    }
    return 1;
}

CMD:pdrm(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pRole] == 1 || PlayerInfo[i][pLeader] == 1)
        {
            format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
            strcat(String, Str);
            ContAdmin++;
        }
    }
    if(ContAdmin == 0) { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}PDRM OFFLINE", "{ffffff}TIADA PDRM YANG ON WAKTU INI!", "Ok", #); 
    }
    else { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}PDRM ONLINE", String, "Ok", #); 
    }
}

CMD:jpj(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pRole] == 2 || PlayerInfo[i][pLeader] == 2)
        {
            format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
            strcat(String, Str);
            ContAdmin++;
        }
    }
    if(ContAdmin == 0) { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}JPJ OFFLINE", "{ffffff}TIADA JPJ YANG ON WAKTU INI!", "Ok", #); 
    }
    else { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}JPJ ONLINE", String, "Ok", #); 
    }
}

CMD:kkm(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pRole] == 3 || PlayerInfo[i][pLeader] == 3)
        {
            format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
            strcat(String, Str);
            ContAdmin++;
        }
    }
    if(ContAdmin == 0) { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}KKM OFFLINE", "{ffffff}TIADA KKM YANG ON WAKTU INI!", "Ok", #); 
    }
    else { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}KKM ONLINE", String, "Ok", #); 
    }
}

CMD:fnf(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pRole] == 4 || PlayerInfo[i][pLeader] == 4)
        {
            format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
            strcat(String, Str);
            ContAdmin++;
        }
    }
    if(ContAdmin == 0) { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}FNF OFFLINE", "{ffffff}TIADA FNF YANG ON WAKTU INI!", "Ok", #); 
    }
    else { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}FNF ONLINE", String, "Ok", #); 
    }
}
 
CMD:kapak(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pRole] == 8 || PlayerInfo[i][pLeader] == 8)
        {
            format(Str, sizeof(Str), "%s || [%i]\n", GetRPName(i), i);
            strcat(String, Str);
            ContAdmin++;
        }
    }
    if(ContAdmin == 0) { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}Kapak OFFLINE", "{ffffff}TIADA Kapak YANG ON WAKTU INI!", "Ok", #); 
    }
    else { 
        ShowPlayerDialog(playerid, 9999, DIALOG_STYLE_MSGBOX, "{ffffff}Kapak ONLINE", String, "Ok", #); 
    }
}

CMD:admin(playerid, params[])
{
    new ContAdmin = 0, String[1000], Str[128];
    new Admin[50];

    if(PlayerInfo[playerid][pAdmin] == 1){ Admin = "STAFF"; }
    if(PlayerInfo[playerid][pAdmin] == 2){ Admin = "ADMIN"; }
    if(PlayerInfo[playerid][pAdmin] == 3){ Admin = "MODERATOR"; }
    if(PlayerInfo[playerid][pAdmin] == 4){ Admin = "A.DEV"; }
    if(PlayerInfo[playerid][pAdmin] == 5){ Admin = "DEVELOPER"; }
    if(PlayerInfo[playerid][pAdmin] == 6){ Admin = "OWNER"; }
    if(PlayerInfo[playerid][pAdmin] == 7){ Admin = "FOUNDER"; }
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(IsPlayerConnected(i) && PlayerInfo[i][pAdmin] > 0)
        {
            format(Str, sizeof(Str), "%s || [%i] (%s)\n", GetRPName(i), i, Admin);
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
}

CMD:fixspawn(playerid, params[])
{
    if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
	SetPlayerPos(playerid,1130.9756,-2036.7576,69.0078);
	SetPlayerInterior(playerid,0);
    TolakDuitPlayer(playerid, 100);
    GameTextForPlayer(playerid, "~g~-RM100", -100, 1);
    SendClientMessage(playerid, -1,"Anda Telah Fixspawn");
	PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	return 1;
}

CMD:culik(playerid, params[])
{
    new string[500], targetid;
    if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" /culik [playerid]");
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            if(!IsPlayerNearPlayer(playerid, targetid, 3)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]: Pemain Itu Terlalu Jauh Daripada Anda");
            new vehid = GetPlayerVehicleID(playerid);
            PutPlayerInVehicle(targetid, vehid, 1);
            GameTextForPlayer(targetid, "~r~ ANDA TELAH DICULIK!", 2000, 1);
            TogglePlayerControllable(targetid, 1);
            format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menculik Anda", GetRPName(playerid));
            SendClientMessage(targetid, COLOR_RED, string);
            format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menculik %s", GetRPName(targetid));
            SendClientMessage(targetid, COLOR_RED, string);
            format(string, sizeof(string), "* %s Mengangkat %s Dan Menghumban Masuk Kedalam Kenderaannya", GetRPName(playerid), GetRPName(targetid));
            ProxDetector(30.0, playerid, string, ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR);
            format(string, sizeof(string), "*[WARN!]: %s Telah Menculik %s Dan Bawak Lari Di Tempat Tertutup!", GetRPName(playerid), GetRPName(targetid));
            SendClientMessageToAll(COLOR_RED, string);
        }
        else SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" Anda Haruslah Berada Didalam Kenderaan");
    }
    return 1;
}

CMD:lock(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        new State=GetPlayerState(playerid);
        if(State!=PLAYER_STATE_DRIVER)
        {
            SendClientMessage(playerid, Red,"Hanya pemandu sahaja boleh menggunakan cmd ini");
            PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
            return 1;
        }
        new i;
        for(i=0;i<MAX_PLAYERS;i++)
        {
            if(i != playerid)
            {
                SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 1);
            }
        }
        GameTextForPlayer(playerid,"~y~Kenderaan Dikunci",2000,5);
        new Float:pX, Float:pY, Float:pZ;
        GetPlayerPos(playerid,pX,pY,pZ);
        PlayerPlaySound(playerid,1056,pX,pY,pZ);
        CreateRp(playerid,"Sedang Mengunci Kenderaan.");
    }
    else
    {
        SendClientMessage(playerid, Red,"Anda harus berada di dalam kenderaan");
        PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
    }
    return 1;
}

CMD:unlock(playerid, params[])
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        new State=GetPlayerState(playerid);
        if(State!=PLAYER_STATE_DRIVER)
        {
            SendClientMessage(playerid, Red,"Hanya pemandu sahaja boleh menggunakan cmd ini.");
            PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
            return 1;
        }
        new i;
        for(i=0;i<MAX_PLAYERS;i++)
        {
            SetVehicleParamsForPlayer(GetPlayerVehicleID(playerid),i, 0, 0);
        }
        SendClientMessage(playerid, Red,"Kenderaan unlock");
        new Float:pX, Float:pY, Float:pZ;
        GetPlayerPos(playerid,pX,pY,pZ);
        PlayerPlaySound(playerid,1057,pX,pY,pZ);
        CreateRp(playerid,"Sedang Membuka Kunci Kenderaan.");
    }
    else
    {
        SendClientMessage(playerid, Red,"Anda harus berada di dalam kenderaan");
        PlayerPlaySound(playerid,1139,0.0,0.0,0.0);
    }
    return 1;
}

CMD:en(playerid, params[])
{
    new vid = GetPlayerVehicleID(playerid);
    new string[1000];
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(vid != INVALID_VEHICLE_ID)
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,-1,""COL_OREN"[ENJIN]"COL_WHITE" Anda Mestilah Menaiki Kenderaan Untuk Guna Command Ini");
    if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid,-1,""COL_OREN"[ENJIN]"COL_WHITE" Hanya Pemandu Sahaja Boleh Guna Cmd Ini");
    if(engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET)
    {
        vehEngine[vid] = 1;
        SetTimerEx("EnjinTimer", 3000, false, "i", playerid);
        GameTextForPlayer(playerid, "~g~Enjin Kenderaan Sedang Dihidupkan...", 3000, 1);
    }
    else if(engine == VEHICLE_PARAMS_ON)
    {
        vehEngine[vid] = 0;
        SendClientMessage(playerid, -1, ""COL_OREN"[ENJIN]"COL_WHITE" Anda Telah Mematikan Enjin Kenderaan.Taip /en Untuk Membuka Enjin");
        format(string, sizeof(string), "* %s Telah Mematikan Enjin Kenderaan", GetRPName(playerid));
        ProxDetector(30.0, playerid, string, ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR);
        SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
    }
    return 1;
}

CMD:helm(playerid)
{
	if (HelmetEnabled[playerid] == 1)
	{
		HelmetEnabled[playerid] = 0;
		RemovePlayerAttachedObject(playerid, 1);
	}
	else if (HelmetEnabled[playerid] == 0)
	{
		HelmetEnabled[playerid] = 1;
		SetPlayerAttachedObject(playerid, 1, 18645, 2, 0.065999, 0.025000, 0.000000, 88.400024, 84.900009, 0.000000, 1.000000, 1.000000, 1.000000);
	}
	return 1;
}

CMD:shh(playerid, params[])
{
    StopAudioStreamForPlayer(playerid);
    return 1;
}

CMD:showcoordinate(playerid, params[])
{
    new Float:x, Float:y, Float:z, string[180];
    GetPlayerPos(playerid, x, y, z);
    format(string, sizeof(string), "Coordinate X : ( %d ) Coordinate Y : ( %d ) Coordinate Z : ( %d ) Interior ID : ( %d )", x, y, z, GetPlayerInterior(playerid));
    SendClientMessage(playerid, COLOR_RED, string);
    return 1;
}

CMD:afk(playerid, params[])
{
    new string[133],reason;
	if(afk[playerid] == 0)
	{
	    if(IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE" Anda Tidak Dapat AFK Di Dalam Kenderaan.");
		if(sscanf(params,"s[128]",reason)) return SendClientMessage(playerid,0xFF0000FF,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /afk [sebab]");
		format(string,sizeof(string),""COL_RED"[AFK]"COL_WHITE" %s Telah Menjauhi Daripada Server Kerana:"COL_RED" %s",GetRPName(playerid),reason);
		SendClientMessageToAll(playerid,string);
		TogglePlayerControllable(playerid, 0);
		label[playerid] = Create3DTextLabel("[AFK]",COLOR_AFK,30.0,40.0,50.0,40.0,0);
		Attach3DTextLabelToPlayer(label[playerid], playerid, 0.0, 0.0, 0.7);
		SetPVarInt(playerid, "afk", 1);
		afk[playerid] = 1;
		SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Jika Anda Ingin Kembali Bermain Semula, Sila Taip /afk");
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	}
	else
	{
		TogglePlayerControllable(playerid, 1);
		format(string,sizeof(string),""COL_RED"[AFK]"COL_WHITE" %s Telah Kembali Bermain Semula!",GetRPName(playerid));
		SendClientMessageToAll(playerid,string);
		DeletePVar(playerid, "afk");
		Delete3DTextLabel(Text3D:label[playerid]);
		afk[playerid] = 0;
		TextDrawHideForPlayer(playerid, textstring);
		PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
	}
	return 1;
}

CMD:bayar(playerid, params[])
{
	new string[158], targetid, amount;
    if(sscanf(params, "ui", targetid, amount)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /bayar [playerid] [jumlah]");
 	if(amount <= 0) return SendClientMessage(playerid, -1, ""COL_RED"[MYBOT]"COL_WHITE" Anda tidak boleh membayar kurang daripada RM0");
    if(amount > PlayerInfo[playerid][pCash]) return SendClientMessage(playerid, -1, ""COL_RED"[MYBOT]"COL_WHITE" Duit anda tidak mencukupi");
    if(playerid == targetid) return SendClientMessage(playerid, -1, ""COL_RED"[MYBOT]"COL_WHITE" Anda tidak boleh memberi duit kapada diri sendiri");
    if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
    if(!IsPlayerNearPlayer(playerid, targetid, 3)) return SendClientMessage(playerid, -1, ""COL_RED"[MYBOT]"COL_WHITE" Pemain itu terlalu jauh daripada anda");
    {
        PlayerInfo[playerid][pCash] -= amount;
        GivePlayerMoney(playerid, -amount);
        PlayerInfo[targetid][pCash] += amount;
        GivePlayerMoney(targetid, amount);
        format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah memberi %s duit sebanyak "COL_RED"RM%d", GetRPName(targetid), amount);
        SendClientMessage(playerid, -1, string);
        format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" %s telah memberi anda duit sebanyak "COL_GREEN"RM%d", GetRPName(playerid), amount);
        SendClientMessage(targetid,-1, string);
        //======DISCORD CONNECTOR
        format(string, sizeof string, " :dollar: *[INFO PEMBAYARAN]* \n **PEMBERI:%s\nPENERIMA:%s\nJUMLAH:RM%d** ", GetRPName(playerid), GetRPName(targetid), amount);
        DCC_SendChannelMessage(Bayar_Info, string);
    }
    return 1;
}

//===============================CHEN
CMD:playerhax(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:Menggunakan Apk Chen", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(Menggunakan Apk Chen)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:modsa(playerid, params[])
{
    SendClientMessageToAll(COLOR_LIGHTRED, "Gta Rusuh Roleplay SILENTKICK: Budak Bocah Telahpun Di Kick reason: BUTO NK MAIN CLEO,MAIN KAT FREEROAM KIMAK");
    SendClientMessage(playerid, COLOR_LIGHTBLUE, "SOK KERAS ANJIM MAIN CLEO");
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return 1;
}

CMD:jetpack(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:Jetpack", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(Jetpack)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:speedhack(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:speedhack", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(speedhack)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather1(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather2(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather3(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather4(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather5(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather6(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather7(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather8(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

CMD:weather9(playerid,params[])
{
    new str[256];
    format(str,sizeof(str),":bar_chart:[SERVER LOG]\n%s Telah Dikick Dari Server~\nSEBAB:hack weather", GetRPName(playerid));
    DCC_SendChannelMessage(Info_Server,str);
    format(str,sizeof(str),"[SERVER]: {FFFFFF}%s telah dikick secara automatik. {ff0000}(hack weather)", GetRPName(playerid));
    SendClientMessageToAll(COLOR_YELLOW,str);
    SetTimerEx("Delay_Kick",100,false,"i",playerid);
    return true;
}

//================================================================================ROBBANK
CMD:robbank(playerid, params[])
{
    if(PlayerToPoint(2, playerid, 1502.2317,-2182.4446,13.6328)) {
        if(Robbank == 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}Bank ini telah di rob sila tunggu selama 30 minit");
        Robbank = 1;
        SendClientMessage(playerid, -1, ""COL_YELLOW"[INFO BANK]: Anda telah berjaya robbank sila tunggu");
        SendClientMessageToAll(RED,""COL_YELLOW"[INFO BANK]: {FFFFFF}Bank Telah Dirompak!!Sila Jauhkan Diri Anda Dari Bank Dengan Segera!!");
        SetTimerEx("RobbankMoney", 5000, false, "i", playerid);//set your time
        //======DISCORD CONNECTOR
        new string[148];
        format(string, sizeof string, " :moneybag: *[INFO ROBBANK]* \n **~%s Telah Memulakan Robbank!!** ", GetRPName(playerid));
        DCC_SendChannelMessage(Robbank_Info,string);    
    }
    SetTimer("ResetRobbank", 1800000, false);//set your time
    return 1;
}

CMD:letakbomb(playerid, params[])
{
    if(IsPlayerInRangeOfPoint(playerid, 2, 1502.4315,-2164.5339,13.6328)) 
    {
        if(PintuRobbank == 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}Sila Tunggu Selama 30 Minit");
        PintuRobbank = 1;
        SendClientMessage(playerid, RED, "{FF0000}[MYBOT] {FFFFFF}Bomb Sudah Diletakkan!!Sila Menjauh");
        ApplyAnimation(playerid, "bomber", "bom_plant", 4.100, 0, 1, 1, 1, 1, 1);
        SetTimer("StopAnim", 3000, false);
        SetTimer("LetakBomb", 10000, false);
        //======DISCORD CONNECTOR=====================//
        new string[148];
        format(string, sizeof string, " :moneybag: *[INFO ROBBANK]* \n **~%s Telah Memecahkan Pintu Bank!!** ", GetRPName(playerid));
        DCC_SendChannelMessage(Robbank_Info,string);
        //MoveDynamicObject(PintuRobbank,1496.0811, -2168.2449, 15.1600,5.0);
    }    
    SetTimer("BolehRob", 1820000, false);
    return 1;
}
//=========//=========//=========//=========//========= Pdrm CMD===========================================//

CMD:jail(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 1)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new sebab[128],targetid,string[300];
            new Float:x, Float:y, Float:z;
            new SpawnRandom = random(sizeof(SpawnJail));
            if(sscanf(params, "uz", targetid, sebab)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /jail [playerid] [sebab]");
            if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xAA3333AA,"Player itu Offline");
            if(PlayerInfo[targetid][pJail] == 1) return SendClientMessage(playerid, 0xAA3333AA,"Player Itu Sudah Ada Didalam Penjara");
            if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z)) return SendClientMessage(playerid , -1,"Anda Perlulah Berdekatan Dengan Mangsa");
            if(PlayerInfo[playerid][pJail] == 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            format(string, sizeof(string), "{FF0000}[INFO JAIL] {FFFFFF}Pegawai %s telah memenjarakan %s kerana {FF0000}%s", GetRPName(playerid), GetRPName(targetid),sebab);
            SendClientMessageToAll(-1, string);
            ResetPlayerWeapons(targetid);
            SetPlayerSkin(targetid, 154);
            PlayerInfo[targetid][pDuty] = 0;
            SetPlayerPos(targetid,
			SpawnJail[SpawnRandom][0],
			SpawnJail[SpawnRandom][1],
			SpawnJail[SpawnRandom][2]);
            PlayerInfo[targetid][pJail] = 1;
            freezeplayer(targetid);
            format(string, sizeof string, " :chains: *[INFO JAIL]* \n**PEGAWAI:%s \nPESALAH:%s\nSEBAB:%s ** ", GetRPName(playerid), GetRPName(targetid),sebab);
            DCC_SendChannelMessage(Info_Pdrm, string);
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:makewanted(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pAdmin] >= 2)
    {
        new targetid, level;
        new string[300];
        if(sscanf(params, "ui", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /makewanted [playerid] [level]");
        if(level < 1 || level > 6) return SendClientMessage(playerid, -1,""COL_RED"[INFO]"COL_WHITE" Level Hanya [1-6]");
        GameTextForPlayer(targetid,"~b~ANDA TELAH MASUK KEDALAM LIST ~n~ ~r~WANTED PDRM",3000,1);
        format(string, sizeof(string), ""COL_Pdrm"[INFO PDRM]"COL_WHITE" Pegawai %s Telah Memasukkan %s Kedalam List Wanted PDRM Level %d", GetRPName(playerid),GetRPName(targetid), level);
        SendClientMessageToAll(0xE01B1B, string);
        SetPlayerWantedLevel(targetid, level);
        PlayerInfo[targetid][pWanted] = level;
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Hanya PDRM Sahaja Yang Boleh Guna Command Ini");
    return 1;
}

CMD:jail1(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 1)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new sebab[128],targetid,string[300];
            new Float:x, Float:y, Float:z;
            if(sscanf(params, "uz", targetid, sebab)) return SendClientMessage(playerid, 0xAA3333AA,"GUNAKAN : /jail1 [playerid] [sebab]");
            if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xAA3333AA,"Player itu Offline");
            if(PlayerInfo[targetid][pJail] >= 1) return SendClientMessage(playerid, 0xAA3333AA,"Player Itu Sudah Ada Didalam Penjara");
            if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z)) return SendClientMessage(playerid , -1,"Anda Perlulah Berdekatan Dengan Mangsa");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            format(string, sizeof(string), "{FF0000}[INFO JAIL] {FFFFFF}Pegawai %s telah memenjarakan %s kerana {FF0000}%s", GetRPName(playerid), GetRPName(targetid),sebab);
            ResetPlayerWeapons(targetid);
            SetPlayerSkin(targetid, 154);
            PlayerInfo[targetid][pDuty] = 0;
            SendClientMessageToAll(-1, string);
            SetPlayerPos(targetid, 2777.8777,2717.2019,10.9062);
            PlayerInfo[targetid][pJail] = 2;
            freezeplayer(targetid);
            format(string, sizeof string, " :chains: *[INFO JAIL]* \n**PEGAWAI:%s \nPESALAH:%s\nSEBAB:%s ** ", GetRPName(playerid), GetRPName(targetid),sebab);
            DCC_SendChannelMessage(Info_Pdrm, string);
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:unjail(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 1)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
            new targetid,string[300];
            if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /unjail [playerid]");
            if(!IsPlayerInRangeOfPoint(playerid,10,254.1491,197.4772,1042.1980)) return SendClientMessage(playerid, 0xAA3333AA,"Anda Hanya Boleh Unjail Di Penjara Pdrm Sahaja");
            if(PlayerInfo[playerid][pJail] == 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xAA3333AA,"Player itu Offline");
            if(PlayerInfo[targetid][pJail] == 0) return SendClientMessage(playerid, 0xAA3333AA,"Player Itu Tiada Di Dalam Penjara");
            SetPlayerPos(targetid, 244.8448,211.6833,1042.1980);
            PlayerInfo[targetid][pJail] = 0;
            SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
            format(string, sizeof(string), "{FF2400}[INFO UNJAIL] {FFFFFF}Pegawai %s telah membebaskan %s daripada penjara", GetRPName(playerid),GetRPName(targetid));
            SendClientMessageToAll(-1, string);
            SendClientMessage(targetid, -1,"{FF0000}Semoga Anda Menjadi Manusia Yang Berguna");
            format(string, sizeof string, " :chains: *[INFO UNJAIL]* \n**PEGAWAI:%s\nBANDUAN:%s** ", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_Pdrm, string);
            freezeplayer(targetid);
     	}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:unjail1(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 1)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
            new targetid,string[300];
            if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /unjail1 [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, 0xAA3333AA,"Player itu Offline");
            if(PlayerInfo[targetid][pJail] == 0) return SendClientMessage(playerid, 0xAA3333AA,"Player Itu Tiada Di Dalam Penjara");
            SetPlayerPos(targetid, 2799.6724,2706.0361,10.9062);
            PlayerInfo[targetid][pJail] = 0;
            SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
            format(string, sizeof(string), "{FF2400}[INFO UNJAIL] {FFFFFF}Pegawai %s telah membebaskan %s daripada penjara", GetRPName(playerid),GetRPName(targetid));
            SendClientMessageToAll(-1, string);
            SendClientMessage(targetid, -1,"{FF0000}Semoga Anda Menjadi Manusia Yang Berguna");
            format(string, sizeof string, " :chains: *[INFO UNJAIL]* \n**PEGAWAI:%s\nBANDUAN:%s** ", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_Pdrm, string);
     	}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:cuff(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 1)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid;
		    if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /cuff [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
		    if(IsPlayerConnected(targetid))
			{
				new Float:x, Float:y, Float:z;
		     	GetPlayerPos(playerid, x, y, z);
		    	if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z))
			    {
		       		new str[512];
		         	new name[MAX_PLAYER_NAME];
		     		GetPlayerName(playerid, name, sizeof(name));
		      		new target[MAX_PLAYER_NAME];
                    PlayerInfo[targetid][pCuff] = 1;
		          	GetPlayerName(targetid, target, sizeof(target));
		         	format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah mengari %s",GetRPName(targetid));
		          	SendClientMessage(playerid, 0xE01B1B, str);
		         	format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah digari oleh %s", GetRPName(playerid));
			       	SendClientMessage(targetid, 0xE01B1B, str);
			       	format(str, sizeof(str), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" %s telah mengari %s", GetRPName(playerid), GetRPName(targetid));
			       	SendClientMessageToAll(0xE01B1B, str);
					TogglePlayerControllable(targetid,false);
			       	return 1;
			   	}
			}
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
	return 1;
}

CMD:uncuff(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 1)   
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new targetid;
            if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /uncuff [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            if(IsPlayerConnected(targetid))
            {
                new Float:x, Float:y, Float:z;
                GetPlayerPos(playerid, x, y, z);
                if(IsPlayerInRangeOfPoint(targetid, 5.0, x, y, z))
                {                    
                    new str[512];
                    new name[MAX_PLAYER_NAME];
                    GetPlayerName(playerid, name, sizeof(name));
                    new target[MAX_PLAYER_NAME];
                    GetPlayerName(targetid, target, sizeof(target));
                    format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Anda telah membuang gari %s!", GetRPName(targetid));
                    SendClientMessage(playerid, 0xE01B1B, str);
                    PlayerInfo[targetid][pCuff] = 0;
                    TogglePlayerControllable(targetid,1);
                    format(str, sizeof(str), ""COL_RED"[MYBOT]"COL_WHITE" Gari Anda Telah Dibuang oleh %s!", GetRPName(playerid));
                    SendClientMessage(targetid, 0xE01B1B, str);
                    format(str, sizeof(str), ""COL_HDRD"[INFO HDRD]"COL_WHITE" %s telah membuang gari %s", GetRPName(playerid), GetRPName(targetid));
                    SendClientMessageToAll(0xE01B1B, str);
                    return 1;
                }
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:saman(playerid, params[])
{
    new targetid, amount;
    new string[500];
    if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pAdmin] >= 2)
    if(sscanf(params, "ud", targetid, amount)) return SendClientMessage(playerid, -1, "[MYBOT]: /saman [playerid] [amount]");
    if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
    if(!IsPlayerNearPlayer(playerid, targetid, 3)) return SendClientMessage(playerid, -1, ""COL_RED"[MYBOT]"COL_WHITE" Pemain itu terlalu jauh daripada anda");
    {
        TolakDuitPlayer(targetid, amount);
	    GivePlayerMoneyEx(playerid, amount);
        format(string, sizeof(string), "[MYBOT]: Anda Telah Memberikan saman Kepada %s, Sebanyak RM%d", GetRPName(targetid), amount); 
        SendClientMessage(playerid, COLOR_WHITE, string);
        format(string, sizeof(string), "[MYBOT]: Pdrm %s Telah Memberikan Anda saman sebanyak RM%d",GetRPName(playerid), amount); 
        SendClientMessage(targetid, COLOR_WHITE, string);
    }
    return 1;
}

//=========//=========//=========//=========//========= HDRD CMD

CMD:rb(playerid,params[])
{
    if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 1)
    {
        ShowPlayerDialog(playerid, RB, DIALOG_STYLE_LIST, "ROADBLOCK", "Roadblock Kecil\nRoadblock Sederhana\nPaku tayar", "PILIH", "TUTUP");
    }
    return 1;
}

CMD:buangrb(playerid,params[])
{
    if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 1)
    {
        DeleteClosestRoadblock(playerid);
        DeletePakuBerdekatan(playerid);
        GameTextForPlayer(playerid,"~w~Roadblock ~r~Telah Dipadam!", 3000,1);
    }
    return 1;
}

CMD:buangallrb(playerid,params[])
{
    if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 1)
    {
        for(new i = 0; i < MAX_PLAYERS; i++) 
        {
            DeleteAllRoadblocks(i);
            DeletePakuBerdekatan(i);
        }
        GameTextForPlayer(playerid,"~b~Semua ~w~Roadblocks ~r~Dipadam!", 3000,1);
    }
    return 1;
}

CMD:hargalesen(playerid, params[])
{
	IsPlayerInRangeOfPoint(playerid, 2, 293.1374,179.3099,1007.1719);
	{
		new str[520];
		strcat(str, ""COL_OREN"Lesen B"COL_WHITE" - RM1500\n");
		strcat(str, ""COL_OREN"Lesen DA"COL_WHITE" - RM2500\n");
		strcat(str, ""COL_OREN"Lesen GDL"COL_WHITE" - RM5000\n");
		strcat(str, ""COL_OREN"Lesen Udara"COL_WHITE" - RM20000\n");
		ShowPlayerDialog(playerid,DIALOG_VCMDS, DIALOG_STYLE_MSGBOX, "Harga Lesen", str, "Tutup", "");
	}
	return 1;
}

CMD:belilesen(playerid, params[])
{
	IsPlayerInRangeOfPoint(playerid, 2, 236.0903,166.0293,1003.0300);
	{
		BeliLesen(playerid);
	}
	return 1;
}

CMD:lesenkereta(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
   	        new targetid, string [300];
	        if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /lesenkereta [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            PlayerInfo[targetid][pLesenkereta] = 1;
            format(string, sizeof(string), ""COL_HDRD"[INFO HDRD]"COL_WHITE" Tahniah, Anda Telah Mendapat Lesen Kereta");
	        SendClientMessage(targetid, -1, string);
	        format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Memberi Lesen Kenderaan Kepada %s", GetRPName(targetid));
	        SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :police_car: *[INFO LESEN]* \n**PEGAWAI:%s\nPENERIMA:%s\nLESEN:KERETA**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
	return 1;
}

CMD:lesenmotor(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /lesenmotor [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
            PlayerInfo[targetid][pLesenmotor] = 1;
		    format(string, sizeof(string), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" Tahniah, Anda Telah Mendapat Lesen Motor");
		    SendClientMessage(targetid, -1, string);
		    format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Memberi Lesen Kenderaan Kepada %s", GetRPName(targetid));
		    SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :police_car: *[INFO LESEN]* \n**PEGAWAI:%s\nPENERIMA:%s\nLESEN:MOTOR**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");    
    return 1;
}

CMD:lesengdl(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /lesengdl [playerid]");
            PlayerInfo[targetid][pLesengdl] = 1;
		    format(string, sizeof(string), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" Tahniah, Anda Telah Mendapat Lesen GDL");
		    SendClientMessage(targetid, -1, string);
		    format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Memberi Lesen Kenderaan Kepada %s", GetRPName(targetid));
		    SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :police_car: *[INFO LESEN]* \n**PEGAWAI:%s\nPENERIMA:%s\nLESEN:GDL**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:lesenudara(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /lesenudara [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
		    PlayerInfo[targetid][pLesenUdara] = 1;
		    format(string, sizeof(string), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" Tahniah, Anda Telah Mendapat Lesen Udara");
		    SendClientMessage(targetid, -1, string);
		    format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Memberi Lesen Kenderaan Kepada %s", GetRPName(targetid));
		    SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :police_car: *[INFO LESEN]* \n**PEGAWAI:%s\nPENERIMA:%s\nLESEN:SEMUA**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:tariklesenkereta(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /tariklesenkereta [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
		    PlayerInfo[targetid][pLesenkereta] = 0;
		    format(string, sizeof(string), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" Lesen Kereta Anda Telah Ditarik Oleh %s", GetRPName(playerid));
		    SendClientMessage(targetid, -1, string);
		    format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Menarik Lesen Kereta %s", GetRPName(targetid));
		    SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :pencil: *[INFO TARIK LESEN]* \n**PEGAWAI:%s\nPESALAH:%s\nLESEN:KERETA**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:tariklesenmotor(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /tariklesenmotor [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
		    PlayerInfo[targetid][pLesenmotor] = 0;
		    format(string, sizeof(string), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" Lesen Motor Anda Telah Ditarik Oleh Pegawai %s", GetRPName(playerid));
		    SendClientMessage(targetid, -1, string);
		    format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Menarik Lesen Motor %s", GetRPName(targetid));
		    SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :pencil: *[INFO TARIK LESEN]* \n**PEGAWAI:%s\nPESALAH:%s\nLESEN:MOTOR**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:tariklesenudara(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /tariklesenudara [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
		    PlayerInfo[playerid][pLesenUdara] = 0;
		    format(string, sizeof(string), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" Semua Lesen Anda Telah Ditarik Oleh Pegawai %s", GetRPName(playerid));
		    SendClientMessage(targetid, -1, string);
		    format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Menarik Semua Lesen %s", GetRPName(targetid));
		    SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :pencil: *[INFO TARIK LESEN]* \n**PEGAWAI:%s\nPESALAH:%s\nLESEN:SEMUA**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}

CMD:tariklesengdl(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /tariklesengdl [playerid]");
            if(PlayerInfo[playerid][pJail] >= 1) return SendClientMessage(playerid, -1, "{FF0000}[MYBOT]: {FFFFFF}ANDA TIDAK DIBENARKAN MENGGUNAKAN CMD SEMASA DI JAIL");
		    PlayerInfo[targetid][pLesengdl] = 0;
		    format(string, sizeof(string), ""COL_Pdrm"[INFO Pdrm]"COL_WHITE" Lesen Lori Anda Telah Ditarik Oleh Pegawai %s", GetRPName(playerid));
		    SendClientMessage(targetid, -1, string);
		    format(string, sizeof(string), ""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Menarik Lesen %s", GetRPName(targetid));
		    SendClientMessage(playerid, -1, string);
            format(string, sizeof string, " :pencil: *[INFO TARIK LESEN]* \n**PEGAWAI:%s\nPESALAH:%s\nLESEN:GDL**", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_HDRD, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");  
    return 1;
}

//=========//=========//=========//=========//========= FNF CMD

CMD:repair(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 4)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
        	new targetid, string[248];
        	new Float:x, Float:y, Float:z;
        	if(sscanf(params,"ud", targetid)) return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE"GUNAKAN: /repair [playerid]");
        	if(IsPlayerInRangeOfPoint(targetid, 2,x, y, z)) return SendClientMessage(playerid, COLOR_WHITE,"{FF0000}[MYBOT]{FFFFFF}Anda Mestilah Berdekatan Dengan Player Tersebut");
            if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
			GetPlayerPos(targetid, x, y, z);
			RepairVehicle(GetPlayerVehicleID(targetid));
			format(string, 128, "{2be3f0}[INFO REPAIR]{FFFFFF} Anda Telah Repair Kenderaan Milik %s", GetRPName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, 128, "{2be3f0}[INFO REPAIR]{FFFFFF} FNF %s Telah Repair Kenderaan Milik Anda", GetRPName(playerid));
            SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}
//SULTAN
CMD:sultan(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new string[128], item[32], targetid;
            if(sscanf(params, "s[32] ", item))
            {
                SendClientMessage(playerid, -1, ""COL_RED"[INFO]: "COL_WHITE"/sultan [component] [playerid]");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Nitro]: "COL_WHITE"nitro1, nitro2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Tyre]: "COL_WHITE"tyre1, tyre2, tyre3, tyre4, tyre5, tyre6");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Paintjob]: "COL_WHITE"paintjob1, paintjob2, paintjob3");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Spoiler]: "COL_WHITE"spoiler1, spoiler2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Sideskirt]: "COL_WHITE"sideskirt1, sideskirt2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Exhaust]: "COL_WHITE"exhaust1, exhaust2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Roof]: "COL_WHITE"roof1, roof2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[RearBumper]: "COL_WHITE"rearbumper1, rearbumper2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Color]: "COL_WHITE"color1, color2");
                return 1;
            }
            if(strcmp(item,"nitro1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan nitro1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanNitro] = 1;
                GivePlayerMoney(targetid, -2000);
                GivePlayerMoney(playerid, 1000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Nitro Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"nitro2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan nitro2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanNitro] = 2;
                GivePlayerMoney(targetid, -2000);
                GivePlayerMoney(playerid, 1000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Nitro Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan tyre1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanTayar] = 1;
                GivePlayerMoney(targetid, -3000);
                GivePlayerMoney(playerid, 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Tyres Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan tyre2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanTayar] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Tyres Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre3",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan tyre3 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanTayar] = 3;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Tyres Style 3 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre4",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan tyre4 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanTayar] = 4;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Tyres Style 4 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre5",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan tyre5 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanTayar] = 5;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Tyres Style 5 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre6",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan tyre6 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanTayar] = 6;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Tyres Style 6 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"paintjob1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan paintjob1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanPaintjob] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 10000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 5000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Paintjob Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"paintjob2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan paintjob2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanPaintjob] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 10000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 5000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Paintjob Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"paintjob3",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan paintjob3 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanPaintjob] = 3;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 10000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 5000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Paintjob Style 3 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"spoiler1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan spoiler1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanSpoiler] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 7500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 3750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Spoiler Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"spoiler2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan spoiler2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanSpoiler] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 7500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 3750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Spoiler Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"sideskirt1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan sideskirt1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanSideskirt] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 5000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Sideskirt Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"sideskirt2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan sideskirt2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanSideskirt] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 5000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Sideskirt Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"exhaust1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan exhaust1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanExhaust] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 4000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Exhaust Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"exhaust2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan exhaust2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanExhaust] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 4000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Exhaust Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"roof1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan roof1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanRoof] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 3500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Roof Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"roof2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan roof2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanRoof] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 3500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Roof Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"rearbumper1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan rearbumper1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanRearbumper] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan RearBumper Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"rearbumper2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan rearbumper2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanRearbumper] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan RearBumper Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"color1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan color1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanColor] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Color Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"color2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sultan color2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pSultanColor] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] -= 4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Color Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}
//========================================MODIFY ELEGY====================================================
CMD:elegy(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new string[128], item[32], targetid;
            if(sscanf(params, "s[32] ", item)) 
            {
                SendClientMessage(playerid, -1, ""COL_RED"[INFO]: "COL_WHITE"/elegy [component] [playerid]");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Nitro]: "COL_WHITE"nitro1, nitro2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Tyre]: "COL_WHITE"tyre1, tyre2, tyre3, tyre4, tyre5, tyre6");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Paintjob]: "COL_WHITE"paintjob1, paintjob2, paintjob3");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Spoiler]: "COL_WHITE"spoiler1, spoiler2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Sideskirt]: "COL_WHITE"sideskirt1, sideskirt2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Exhaust]: "COL_WHITE"exhaust1, exhaust2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Roof]: "COL_WHITE"roof1, roof2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[RearBumper]: "COL_WHITE"rearbumper1, rearbumper2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[FrontBumper]: "COL_WHITE"frontbumper1, frontbumper2");
                SendClientMessage(playerid, -1, ""COL_YELLOW"[Color]: "COL_WHITE"color1, color2");
                return 1;
            }
            if(strcmp(item,"nitro1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy nitro1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyNitro] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -2000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Nitro Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"nitro2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy nitro2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyNitro] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -2000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Nitro Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy tyre1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyTayar] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Tyres Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy tyre2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyTayar] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Tyres Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre3",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy tyre3 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyTayar] = 3;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Tyres Style 3 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre4",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy tyre4 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyTayar] = 4;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Tyres Style 4 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre5",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy tyre5 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyTayar] = 5;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Tyres Style 5 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"tyre6",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy tyre6 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyTayar] = 6;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Tyres Style 6 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"paintjob1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy paintjob1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyPaintjob] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -10000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 5000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Paintjob Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"paintjob2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy paintjob2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyPaintjob] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -10000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 5000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Paintjob Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"paintjob3",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy paintjob3 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyPaintjob] = 3;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -10000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 5000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Paintjob Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"spoiler1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy spoiler1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegySpoiler] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -7500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 3750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Spoiler Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"spoiler2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy spoiler2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegySpoiler] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -7500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 3750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Spoiler Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"sideskirt1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy sideskirt1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegySideskirt] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -5000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Sideskirt Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"sideskirt2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy sideskirt2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegySideskirt] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -5000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2500);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Sideskirt Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"exhaust1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy exhaust1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyExhaust] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Exhaust Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"exhaust2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy exhaust2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyExhaust] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4000);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2000);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Exhaust Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"roof1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy roof1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyRoof] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Sideskirt Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"roof2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy roof2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyRoof] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -3500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1750);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Roof Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"rearbumper1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy rearbumper1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyRearbumper] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Rearbumper Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"rearbumper2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy rearbumper2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyRearbumper] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Rearbumper Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"frontbumper1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy frontbumper1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyFrontbumper] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Frontbumper Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"frontbumper2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy frontbumper2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyFrontbumper] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Elegy Frontbumper Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"color1",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy color1 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyColor] = 1;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Color Style 1 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
            else if(strcmp(item,"color2",true) == 0) 
            {
                if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /elegy color2 [playerid]");
                if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
                PlayerInfo[targetid][pElegyColor] = 2;
                GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -4500);
                GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 2250);
                format(string, 128, "{2be3f0}[INFO TUNE]{FFFFFF} FNF %s Telah Menjual Sultan Color Style 2 Kepada %s", GetRPName(playerid), GetRPName(targetid));
                SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            }
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
    return 1;
}
//=========//=========//=========//=========//========= Kkm CMD
CMD:revive(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 3 || PlayerInfo[playerid][pAdmin] >= 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string[300];
			if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, -1, "[MYBOT]: /revive [playerid]");
			if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
			if(Injured[targetid] == 0) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain ini tidak injured ");
			if(targetid == playerid) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda tidak boleh revive diri sendiri ");
			new Float:HP;
		    GetPlayerHealth(targetid, HP);
		    SetPlayerHealth(targetid, HP+20);
		    Injured[targetid] = 0;
		    ClearAnimations(targetid);
            format(string, sizeof string, " :ambulance: *[INFO REVIVE]* \n**DOKTOR:%s \nPESAKIT:%s ** ", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_Kkm, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");    
	return 1;
}

CMD:heal(playerid, params[])
{
	if(PlayerInfo[playerid][pRole] == 3 || PlayerInfo[playerid][pAdmin] > 2)
	{
	    if(PlayerInfo[playerid][pDuty] == 1)
	    {
			new targetid, string [128];
			new name[MAX_PLAYER_NAME];
			GetPlayerName(playerid, name, 24);
			GetPlayerName(targetid, name, 24);
	        if(sscanf(params,"i", targetid)) return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE"GUNAKAN: /heal [playerid]");
	        GivePlayerMoney(targetid,PlayerInfo[targetid][pCash] = -2000);
			GivePlayerMoney(playerid,PlayerInfo[playerid][pCash] = 1000);
		    format(string, sizeof(string), ""COL_Kkm"[INFO Kkm]"COL_WHITE" %s telah menyembuhkan anda", GetRPName(playerid));
	        SendClientMessage(targetid, -1, string);
	        SetPlayerHealth(targetid,100);
		    format(string, sizeof(string), ""COL_Kkm"[INFO Kkm]"COL_WHITE" %s telah menyembuhkan %s", GetRPName(playerid), GetRPName(targetid));
	        SendClientMessageToAll(-1, string);
            format(string, sizeof string, " :ambulance: *[INFO HEAL]* \n**DOKTOR:%s \nPESAKIT:%s ** ", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_Kkm, string);
		}
		else
		{
		    SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda haruslah onduty terlebih dahulu untuk menggunakan command ini");
		}
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, anda tidak dapat menggunakan command ini");   
    return 1;
}

//=======================================================SYSTEM MEDKIT=======================================//

CMD:jualmedkit(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 3 || PlayerInfo[playerid][pAdmin] > 2)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new bayaran = jumlahmedkit * 500;
            new targetid, string [128];
            new target;
            //new amount;
            new name[MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, 24);
            GetPlayerName(targetid, name, 24);
            if(sscanf(params, "ud", targetid, jumlahmedkit)) return SendClientMessage(playerid, -1, "[MYBOT]: /jualmedkit [playerid] [jumlah]");
            GivePlayerMoney(target,-bayaran);
            GivePlayerMoney(playerid, 250);
            format(string, sizeof(string), ""COL_Kkm"[INFO Kkm]"COL_WHITE" %s telah menjual medkit kepada anda", GetRPName(playerid));
            SendClientMessage(targetid, -1, string);
            PlayerInfo[targetid][pMedkit] += jumlahmedkit;
            format(string, sizeof(string), ""COL_Kkm"[INFO Kkm]"COL_WHITE" %s telah menjual medkit kepada %s", GetRPName(playerid), GetRPName(targetid));
            SendClientMessageToAll(-1, string);
            format(string, sizeof string, " :ambulance: *[INFO JUAL MEDKIT]* \n**PEMBERI : %s \nPENERIMA : %s ** ", GetRPName(playerid), GetRPName(targetid));
            DCC_SendChannelMessage(Info_Kkm, string);
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda haruslah onduty terlebih dahulu untuk menggunakan command ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, anda tidak dapat menggunakan command ini");   
    return 1;
}

CMD:gunamedkit(playerid, params[])
{
    if(PlayerInfo[playerid][pMedkit] >= 1)
    {
        new Float:health;
        GetPlayerHealth(playerid, health);
	    if(health < 120)
        {
            SetPlayerHealth(playerid,100);
            PlayerInfo[playerid][pMedkit] -= 1;
            SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Menggunakan 1 Medkit");
        }
        else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" NYAWA ANDA MASIH PENUH LAGI");
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" ANDA TIDAK MEMPUNYAI MEDKIT SILA BELI DNGN Kkm");
    return 1;   
}

//=================================SYSTEM REPAIRKIT========================================//

CMD:jualrepairkit(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 4 || PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(PlayerInfo[playerid][pDuty] == 1)
        {
            new bayaran = jumlahrepairkit * 500;
            new targetid, string[248];
            new target;
            //new amount;
            new name[MAX_PLAYER_NAME];
            GetPlayerName(playerid, name, 24);
            GetPlayerName(targetid, name, 24);
            if(sscanf(params, "ud", targetid, jumlahrepairkit)) return SendClientMessage(playerid, -1, "[MYBOT]: /jualrepairkit [playerid] [jumlah]");
            GivePlayerMoney(target,-bayaran);
            GivePlayerMoney(playerid, bayaran);
            PlayerInfo[targetid][pRepairkit] += jumlahrepairkit;
			format(string, 128, "{2be3f0}[INFO REPAIR]{FFFFFF} Anda Telah Menjual RepairKit Kepada %s", GetRPName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            format(string, 128, "{2be3f0}[INFO REPAIR]{FFFFFF} FNF %s Telah Memberi RepairKit Kepada Anda", GetRPName(playerid));
            SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
        }
        else
        {
            SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda haruslah onduty terlebih dahulu untuk menggunakan command ini");
        }
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, anda tidak dapat menggunakan command ini");   
    return 1;
}

CMD:baiki(playerid, params[])
{
    if(PlayerInfo[playerid][pRepairkit] >= 1)
    {
        if(IsPlayerInAnyVehicle(playerid))
        {
            new Float:health;
            new vehicleid = GetPlayerVehicleID(playerid);
            GetVehicleHealth(vehicleid, health);
            if(health <= 1000.0)
            {
                SetVehicleHealth(vehicleid, 1000.0);
                RepairVehicle(vehicleid);
                PlayerInfo[playerid][pRepairkit] -= 1;
                SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Anda Telah Menggunakan 1 Repairkit");
            }
            else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" KENDERAAN ANDA BELUM ROSAK");
        }
        else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" ANDA MESTILAH BERADA DI DLM KENDERAAN ANDA");
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" ANDA TIDAK MEMPUNYAI REPAIRKIT SILA BELI DNGN FNF");
    return 1;   
}


//========================VIP===========================//
CMD:vhelp(playerid,params[],help)
{
	if(PlayerInfo[playerid][pVip] >= 1)
	{
		new str[520];
		strcat(str, ""COL_OREN"/fstyle"COL_WHITE" - fighting style\n");
		strcat(str, ""COL_OREN"/varmor"COL_WHITE" - Memakai armor\n");
		strcat(str, ""COL_OREN"/vgun"COL_WHITE" - Mengambil senjata\n");
		strcat(str, ""COL_OREN"/att"COL_WHITE" - Memakai attachment\n");
		ShowPlayerDialog(playerid,DIALOG_VCMDS, DIALOG_STYLE_MSGBOX, "Vip Command", str, "Tutup", "");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOVIP);
	return 1;
}

CMD:att(playerid)
{
	if(PlayerInfo[playerid][pVip] == 1)
	{
		ShowPlayerDialog(playerid, DIALOG_VATT, DIALOG_STYLE_LIST, "Attachment", "Api ditangan\nBag duit\nBag gunung\nKepala ayam\nGuitar\nAK7", "Pilih", "Tutup");
	}
	if(PlayerInfo[playerid][pVip] == 0)
	{
	    SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
	}
	return 1;
}

CMD:fstyle(playerid)
{
	if(PlayerInfo[playerid][pVip] == 1)
	{
		ShowPlayerDialog(playerid,DIALOG_VFSTYLE, DIALOG_STYLE_LIST, "Fighting Style", "Boxing\nKungFu\nKneehead\nGrabkick\nElbow", "Pilih", "Tutup");
	}
	if(PlayerInfo[playerid][pVip] == 0)
	{
	    SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
	}
	return 1;
}

CMD:vgun(playerid)
{
	if(PlayerInfo[playerid][pVip] == 1)
	{
	    GivePlayerWeapon(playerid,4,1);
	    GivePlayerWeapon(playerid,5,1);
	    GivePlayerWeapon(playerid,14,1);
	    GivePlayerWeapon(playerid,31,999999999);
	    GivePlayerWeapon(playerid,32,999999999);
	    GivePlayerWeapon(playerid,43,999999999);
	}
	if(PlayerInfo[playerid][pVip] == 0)
	{
	    SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
	}
	return 1;
}

CMD:varmor(playerid)
{
	if(PlayerInfo[playerid][pVip] == 1)
	{
		SetPlayerArmour(playerid,100);
	}
	if(PlayerInfo[playerid][pVip] == 0)
	{
	    SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Maaf, command ini khas untuk vip sahaja!");
	}
	return 1;
}
//=====================================================================================BRG TERLARANG=============================//
CMD:jualdadah(playerid,params[])
{
    if(PlayerInfo[playerid][pRole] >= 6)
    {
        new id,jumlah,str[256];
        if(sscanf(params,"ud",id,jumlah)) return SendClientMessage(playerid,COLOR_YELLOW,"INFO: {FFFFFF}/jualdadah [playerid] [jumlah]");
        if(jumlah > 5) return SendClientMessage(playerid,COLOR_YELLOW,"INFO: {FFFFFF}Anda tidak boleh jual lebih daripada 5!");
        format(str,sizeof(str),"%s telah menjual dadah sebanyak %d kepada %s",GetRPName(playerid),jumlah,GetRPName(id));
        SendClientMessageToAll(COLOR_LIGHTGREEN,str); 
        GameTextForPlayer(id,"~r~+DADAH",3000,1);
        PlayerInfo[playerid][pDadah] += jumlah;
    }
    else return SendClientMessage(playerid, -1,""COL_RED"[MYBOT]: {FFFFFF}Anda Tidak Dibenarkan Mengunakan Command Ini");
    return 1;
}

CMD:isapdadah(playerid,params[])
{
    if(PlayerInfo[playerid][pDadah] >= 1) 
    {
        PlayerInfo[playerid][pDadah] -= 1;
        ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
        CreateRp(playerid, "SEDANG MINUM KETUM");
        SetTimerEx("Segar", 5000, false, "i", playerid);
    }
    else return SCM(playerid, -1, ""COL_RED"[MYBOT]: " COL_WHITE"ANDA TIDAK MEMPUNYA DADAH");
    return 1;
}

CMD:jualketum(playerid,params[])
{   
    if(PlayerInfo[playerid][pRole] == 5)
    {
        new id,jumlah,str[256];
        if(sscanf(params,"ud",id,jumlah)) return SendClientMessage(playerid,COLOR_YELLOW,"INFO: {FFFFFF}/jualketum [playerid] [jumlah]");
        if(jumlah > 5) return SendClientMessage(playerid,COLOR_YELLOW,"INFO: {FFFFFF}Anda tidak boleh jual lebih daripada 5!");
        format(str,sizeof(str),"%s telah menjual ketum sebanyak %d kepada %s",GetRPName(playerid),jumlah,GetRPName(id));
        SCM(playerid, COLOR_LIGHTGREEN,str);
        PlayerInfo[playerid][pKetum] += jumlah;
        CreateDo(playerid, "menjual ketum kepada org depan");
    }
    else return SendClientMessage(playerid, -1,""COL_RED"[MYBOT]: {FFFFFF}Anda Tidak Dibenarkan Mengunakan Command Ini");
    return 1;
}

CMD:minumketum(playerid, params[])
{
    if(PlayerInfo[playerid][pKetum] >= 1)
    {
        PlayerInfo[playerid][pKetum] -= 1;
        ApplyAnimation(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
        CreateRp(playerid, "SEDANG MINUM KETUM");
        SetTimerEx("Segar", 5000, false, "i", playerid);
    }
    else return SCM(playerid, -1, ""COL_RED"[MYBOT]: " COL_WHITE"ANDA TIDAK MEMPUNYAI KETUM");
    return 1;
}

CMD:jualganja(playerid,params[])
{
    if(PlayerInfo[playerid][pRole] >= 7)
    {
        new id,jumlah,str[256];
        if(sscanf(params,"ud",id,jumlah)) return SendClientMessage(playerid,COLOR_YELLOW,"INFO: {FFFFFF}/jualganja [playerid] [jumlah]");
        format(str,sizeof(str),"%s telah menjual ganja sebanyak %d kepada %s",GetRPName(playerid),jumlah,GetRPName(id));
        SendClientMessageToAll(COLOR_LIGHTGREEN,str);
        PlayerInfo[playerid][pGanja] += jumlah;
    }
    else return SendClientMessage(playerid, -1,""COL_RED"[MYBOT]: {FFFFFF}Anda Tidak Dibenarkan Mengunakan Command Ini");
    return 1;
}

Function:Segar(playerid)
{
    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);
    CreateDo(playerid, "Telah Segar Dari Isap Barang");
}

//RADIO ADMIN
CMD:ar(playerid, params[])
{
    new string[128], text[128], ctext[60], pname[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, 0x46E850FF, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /ar [text]");
    if(PlayerInfo[playerid][pAdmin] > 0)
    {
        if(PlayerInfo[playerid][pAdmin] == 1){ ctext = "STAFF"; }
        if(PlayerInfo[playerid][pAdmin] == 2){ ctext = "ADMIN"; }
        if(PlayerInfo[playerid][pAdmin] == 3){ ctext = "MODERATOR"; }
        if(PlayerInfo[playerid][pAdmin] == 4){ ctext = "A.DEVELOPER"; }
        if(PlayerInfo[playerid][pAdmin] == 5){ ctext = "DEVELOPER"; }
        if(PlayerInfo[playerid][pAdmin] == 6){ ctext = "OWNER"; }
        if(PlayerInfo[playerid][pAdmin] == 7){ ctext = "FOUNDER"; }
        format(string, sizeof(string), "{deed11}[%s]"COL_WHITE"%s: %s", ctext, pname, text);
        if(PlayerInfo[playerid][pAdmin] > 0)
        {
            SendAdminMessage(COLOR_DEV, string);
        }
    }
    return 1;
}
//GATE MECHANIC
CMD:buka(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 4 || PlayerInfo[playerid][pAdmin] >= 2)
   	{
    	new string [248];
    	if(PlayerToPoint(5, playerid,1621.6006, -1862.0422, 13.1904)) 
        {
        	MoveDynamicObject(gatemechanic, 1637.1941, -1862.0757, 12.8847, 5.00);
        	format(string, sizeof(string), "{eff542}**BENGKEL TELAH PUN DIBUKA!!**");
        	SendClientMessageToAll(-1, string);
    	}
    }
    return 1;
}

CMD:tutup(playerid, params[])
{
    if(PlayerInfo[playerid][pRole] == 4 || PlayerInfo[playerid][pAdmin] >= 2)
   	{
   		new string [248];
		if(PlayerToPoint(5, playerid,1621.6006, -1862.0422, 13.1904)) 
        {
    		MoveDynamicObject(gatemechanic, 1626.5941, -1862.0757, 12.8847, 5.00);
    		format(string, sizeof(string), "{eff542}**BENGKEL TELAH PUN DITUTUP!!**");
    		SendClientMessageToAll(-1, string);
	    }
  	}
    return 1;
}

//RADIO ROLE
CMD:r(playerid, params[]) return cmd_radio(playerid, params);
CMD:radio(playerid, params[])
{
    new string[128], text[128], ctext[60], pname[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, 0x46E850FF, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /radio [text]");
    if(PlayerInfo[playerid][pRole] == 1)
    {
        if(PlayerInfo[playerid][pLevel] == 1){ ctext = "PELATIH"; }
        if(PlayerInfo[playerid][pLevel] == 2){ ctext = "KOPERAL"; }
        if(PlayerInfo[playerid][pLevel] == 3){ ctext = "SARJAN"; }
        if(PlayerInfo[playerid][pLevel] == 4){ ctext = "TIMBALAN"; }
        if(PlayerInfo[playerid][pLevel] == 5){ ctext = "KPN"; }
        format(string, sizeof(string), "{001EFF}[%s]"COL_WHITE"%s: %s", ctext, pname, text);
        if(PlayerInfo[playerid][pRole] > 0)
        {
            SendPoliceMessage(COLOR_POLICE, string);
        }
    }
    if(PlayerInfo[playerid][pRole] == 2)
    {
        if(PlayerInfo[playerid][pLevel] == 1){ ctext = "Level 1"; }
        if(PlayerInfo[playerid][pLevel] == 2){ ctext = "Level 2"; }
        if(PlayerInfo[playerid][pLevel] == 3){ ctext = "Level 3"; }
        if(PlayerInfo[playerid][pLevel] == 4){ ctext = "Level 4"; }
        if(PlayerInfo[playerid][pLevel] == 5){ ctext = "Level 5"; }
        format(string, sizeof(string), "{FF00BD}[%s]"COL_WHITE"%s: %s", ctext, pname, text);
        if(PlayerInfo[playerid][pRole] > 0)
        {
            SendSuruhanjayaMessage(COLOR_SURUHANJAYA, string);
        }
    }
    if(PlayerInfo[playerid][pRole] == 3)
    {
        if(PlayerInfo[playerid][pLevel] == 1){ ctext = "Level 1"; }
        if(PlayerInfo[playerid][pLevel] == 2){ ctext = "Level 2"; }
        if(PlayerInfo[playerid][pLevel] == 3){ ctext = "Level 3"; }
        if(PlayerInfo[playerid][pLevel] == 4){ ctext = "Level 4"; }
        if(PlayerInfo[playerid][pLevel] == 5){ ctext = "Level 5"; }
        format(string, sizeof(string), "{0013A1}[%s]"COL_WHITE"%s: %s", ctext, pname, text);
        if(PlayerInfo[playerid][pRole] > 0)
        {
            SendMedicMessage(COLOR_MEDIC, string);
        }
    }
    if(PlayerInfo[playerid][pRole] == 4)
    {
        if(PlayerInfo[playerid][pLevel] == 1){ ctext = "ADIK_ADIK"; }
        if(PlayerInfo[playerid][pLevel] == 2){ ctext = "PRAKTIKAL"; }
        if(PlayerInfo[playerid][pLevel] == 3){ ctext = "SENIOR"; }
        if(PlayerInfo[playerid][pLevel] == 4){ ctext = "CO MANAGER"; }
        if(PlayerInfo[playerid][pLevel] == 5){ ctext = "MANAGER"; }
        format(string, sizeof(string), "{03cafc}[%s]"COL_WHITE"%s: %s", ctext, pname, text);
        if(PlayerInfo[playerid][pRole] > 0)
        {
            SendTailongMessage(COLOR_TAILONG, string);
        }
    }
    if(PlayerInfo[playerid][pRole] == 5)
    {
        if(PlayerInfo[playerid][pLevel] == 1){ ctext = "PENJAGA"; }
        if(PlayerInfo[playerid][pLevel] == 2){ ctext = "FIGHTER"; }
        if(PlayerInfo[playerid][pLevel] == 3){ ctext = "RIDER"; }
        if(PlayerInfo[playerid][pLevel] == 4){ ctext = "TIMBALAN BOSS"; }
        if(PlayerInfo[playerid][pLevel] == 5){ ctext = "BOSS"; }
        format(string, sizeof(string), "{FFF369}[%s]"COL_WHITE"%s: %s", ctext, pname, text);
        if(PlayerInfo[playerid][pRole] > 0)
        {
            SendMafiaMessage(COLOR_MAFIA, string);
        }
    }
    return 1;
}

//================================================================================JOB CHECKPOINT
public OnPlayerEnterCheckpoint(playerid)
{
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 448) 
    {
		if(PizzaJob[playerid] == 1) 
        {
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
		if(PizzaJob[playerid] == 11) 
        {
		    PizzaJob[playerid] = 12;
            
            GiveMoneyPayday(playerid, 5000);
	        GameTextForPlayer(playerid, "~g~+RM ~w~5000", 5000, 1);
	        SendClientMessage(playerid, COLOR_WHITE, "{FF000}[MYBOT]: {FFFFFF}Anda telah mendapat gaji sebanyak RM5000 ");
            DestroyVehicle(playerid);
	        SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
	        DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }    
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 437) {
        if(BasJob[playerid] == 1) {
            BasJob[playerid] = 2;
            SetPlayerCheckpoint(playerid, 1824.4807,-1876.0956,13.0302, 5.0);// CP KEDUA
            return 1;
        }
        if(BasJob[playerid] == 2) {
            BasJob[playerid] = 3;
            SetPlayerCheckpoint(playerid, 1824.4092,-1750.7866,13.0875, 5.0);// CP KETIGA
            return 1;
        }
        if(BasJob[playerid] == 3) {
            BasJob[playerid] = 4;
            SetPlayerCheckpoint(playerid, 1824.4607,-1586.3704,13.0616, 5.0);// CP KEEMPAT
            return 1;
        }
        if(BasJob[playerid] == 4) {
            BasJob[playerid] = 5;
            SetPlayerCheckpoint(playerid, 1852.6488,-1480.8090,13.0896, 5.0);// CP KELIMA
            return 1;
        }
        if(BasJob[playerid] == 5) {
            BasJob[playerid] = 6;
            SetPlayerCheckpoint(playerid, 2100.4734,-1467.4814,23.5338, 5.0);// CP KEENAM
            return 1;
        }
        if(BasJob[playerid] == 6) {
            BasJob[playerid] = 7;
            SetPlayerCheckpoint(playerid, 2115.3474,-1396.5596,23.5319, 5.0);// CP KETUJUH
            return 1;
        }
        if(BasJob[playerid] == 7) {
            BasJob[playerid] = 8;
            SetPlayerCheckpoint(playerid, 2081.4973,-1380.8779,23.5324, 5.0);// CP KELAPAN
            return 1;
        }
        if(BasJob[playerid] == 8) {
            BasJob[playerid] = 9;
            SetPlayerCheckpoint(playerid, 2073.0654,-1276.7424,23.5337, 5.0);// CP KESEMBILAN
            return 1;
        }
        if(BasJob[playerid] == 9) {
            BasJob[playerid] = 10;
            SetPlayerCheckpoint(playerid, 1989.4987,-1259.0730,23.5254, 5.0);// CP KESEPULUH
            return 1;
        }
        if(BasJob[playerid] == 10) {
            BasJob[playerid] = 11;
            SetPlayerCheckpoint(playerid, 1972.4653,-1150.6375,25.5357, 5.0);// CP KESEBELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 11) {
            BasJob[playerid] = 12;
            SetPlayerCheckpoint(playerid, 1882.3372,-1133.6884,23.5753, 5.0);// CP DUABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 12) {
            BasJob[playerid] = 13;
            SetPlayerCheckpoint(playerid, 1846.2280,-1243.4026,14.1896, 5.0);// CP TIGABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 13) {
            BasJob[playerid] = 14;
            SetPlayerCheckpoint(playerid, 1845.7760,-1325.3733,13.0985, 5.0);// CP EMPATBELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 14) {
            BasJob[playerid] = 15;
            SetPlayerCheckpoint(playerid, 1844.7247,-1444.5876,13.1060, 5.0);// CP LIMABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 15) {
            BasJob[playerid] = 16;
            SetPlayerCheckpoint(playerid, 1819.0685,-1594.8047,13.0640, 5.0);// CP 16
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(BasJob[playerid] == 16) {
            BasJob[playerid] = 17;
            SetPlayerCheckpoint(playerid, 1818.9596,-1720.0763,13.0870, 5.0);// CP 17
            return 1;
        }
        if(BasJob[playerid] == 17) {
            BasJob[playerid] = 18;
            SetPlayerCheckpoint(playerid, 1819.0841,-1878.0001,13.1013, 5.0);// CP 18
            return 1;
        }
        if(BasJob[playerid] == 18) {
            BasJob[playerid] = 19;
            SetPlayerCheckpoint(playerid, 1783.8710,-1908.6765,13.0965, 5.0);// CP 19
            return 1;
        }
        if(BasJob[playerid] == 19) {
            BasJob[playerid] = 0;
            GiveMoneyPayday(playerid, 3000);
            GameTextForPlayer(playerid, "~g~+RM ~w~3000", 3000, 1);
            SendClientMessage(playerid, COLOR_WHITE, "{FF0000}[MYBOT]: {FFFFFF}Anda telah mendapat gaji sebanyak RM3000 ");
            DestroyVehicle(playerid);
			SetPlayerSkin(playerid,SkinLama[playerid]);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 408)
    {
        if(LoriSampah[playerid] == 1) {
            LoriSampah[playerid] = 2;
            SetPlayerCheckpoint(playerid, 1814.1633,-1735.4391,13.3828, 5.0);// CP KEDUA
            return 1;
        }
        if(LoriSampah[playerid] == 2) {
            LoriSampah[playerid] = 3;
            SetPlayerCheckpoint(playerid, 2081.8015,-1755.6530,13.3889, 5.0);// CP KETIGA
            return 1;
        }
        if(LoriSampah[playerid] == 3) {
            LoriSampah[playerid] = 4;
            SetPlayerCheckpoint(playerid, 2195.9055,-1651.8949,15.2985, 5.0);// CP KEEMPAT
            return 1;
        }
        if(LoriSampah[playerid] == 4) {
            LoriSampah[playerid] = 5;
            SetPlayerCheckpoint(playerid, 2473.4531,-1684.9153,13.4892, 5.0);// CP KELIMA
            return 1;
        }
        if(LoriSampah[playerid] == 5) {
            LoriSampah[playerid] = 6;
            SetPlayerCheckpoint(playerid, 2345.8474,-1726.9705,13.3876, 5.0);// CP KEENAM
            return 1;
        }
        if(LoriSampah[playerid] == 6) {
            LoriSampah[playerid] = 7;
            SetPlayerCheckpoint(playerid, 2225.0181,-1729.1362,13.3885, 5.0);// CP KETUJUH
            return 1;
        }
        if(LoriSampah[playerid] == 7) {
            LoriSampah[playerid] = 8;
            SetPlayerCheckpoint(playerid, 2223.9277,-1891.5386,13.3828, 5.0);// CP KELAPAN
            return 1;
        }
        if(LoriSampah[playerid] == 8) {
            LoriSampah[playerid] = 9;
            SetPlayerCheckpoint(playerid, 2316.2554,-1962.5043,13.3924, 5.0);// CP KESEMBILAN
            return 1;
        }
        if(LoriSampah[playerid] == 9) {
            LoriSampah[playerid] = 10;
            SetPlayerCheckpoint(playerid, 2406.9558,-1971.0171,13.4218, 5.0);// CP KESEPULUH
            return 1;
        }
        if(LoriSampah[playerid] == 10) {
            LoriSampah[playerid] = 11;
            SetPlayerCheckpoint(playerid, 2411.2715,-1742.9840,13.3828, 5.0);// CP KESEBELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(LoriSampah[playerid] == 11) {
            LoriSampah[playerid] = 12;
            SetPlayerCheckpoint(playerid, 2195.0481,-1732.2920,13.3918, 5.0);// CP DUABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(LoriSampah[playerid] == 12) {
            LoriSampah[playerid] = 13;
            SetPlayerCheckpoint(playerid, 2056.2368,-1914.9105,13.5469, 5.0);// CP TIGABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(LoriSampah[playerid] == 13) {
            LoriSampah[playerid] = 14;
            SetPlayerCheckpoint(playerid, 1822.4248,-1929.0608,13.3797, 5.0);// CP EMPATBELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(LoriSampah[playerid] == 14) {
            LoriSampah[playerid] = 15;
            SetPlayerCheckpoint(playerid, 1819.7145,-1850.8116,13.4141, 5.0);// CP LIMABELAS
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(LoriSampah[playerid] == 15) {
            LoriSampah[playerid] = 16;
            SetPlayerCheckpoint(playerid, 1699.5709,-1813.3723,13.3691, 5.0);// CP 16
            TogglePlayerControllable(playerid,false);
            SetTimerEx("UnFreezeJob", 5000, false, "i", playerid);
            GameTextForPlayer(playerid, "Sila Tunggu", 5000, 1);
            return 1;
        }
        if(LoriSampah[playerid] == 16) {
            LoriSampah[playerid] = 17;
            SetPlayerCheckpoint(playerid, 1685.8643,-1742.6007,13.3906, 5.0);// CP 17
            return 1;
        }
        if(LoriSampah[playerid] == 17) {
            LoriSampah[playerid] = 18;
            SetPlayerCheckpoint(playerid, 1806.0111,-1695.2529,13.5443, 5.0);// CP 18
            return 1;
        }
        if(LoriSampah[playerid] == 18) {
            LoriSampah[playerid] = 0;
            GiveMoneyPayday(playerid, 3000);
            GameTextForPlayer(playerid, "~g~+RM ~w~3000", 3000, 1);
            SendClientMessage(playerid, COLOR_WHITE, "{FF0000}[MYBOT]: {FFFFFF}Anda telah mendapat gaji sebanyak RM3000 ");
            DestroyVehicle(playerid);
            SetPlayerSkin(playerid,SkinLama[playerid]);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 462)
    {
        if(LesenMotor[playerid] == 1)
        {
            LesenMotor[playerid] = 2;
            SetPlayerCheckpoint(playerid, 1285.9130,1310.0024,10.8203, 5.0); //cp 2
            SendClientMessage(playerid, -1,"Berhati-Hati Bila Di Bonggol");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 2)
        {
            LesenMotor[playerid] = 3;
            SetPlayerCheckpoint(playerid, 1286.0553,1325.5052,10.8203, 5.0);
            SendClientMessage(playerid, -1,"SILA BAWA DNGN BERHATI II");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 3)
        {
            LesenMotor[playerid] = 4;
            SetPlayerCheckpoint(playerid, 1286.0018,1335.8344,10.8203, 5.0);
            SendClientMessage(playerid, -1,"SILA BAWA DNGN BERHATI II");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 4)
        {
            LesenMotor[playerid] = 5;
            SetPlayerCheckpoint(playerid, 1289.5876,1345.5326,11.0202, 5.0);
            SendClientMessage(playerid, -1,"SILA BAWA DNGN BERHATI II");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 5)
        {
            LesenMotor[playerid] = 6;
            SetPlayerCheckpoint(playerid, 1296.4725,1374.6884,10.8639, 5.0);
            SendClientMessage(playerid, -1,"SILA BAWA DNGN BERHATI II");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 6)
        {
            LesenMotor[playerid] = 7;
            SetPlayerCheckpoint(playerid, 1340.0183,1407.6471,10.8603, 5.0);
            SendClientMessage(playerid, -1,"SILA TUNGGU SEBENTAR");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 7)
        {
            LesenMotor[playerid] = 8;
            SetPlayerCheckpoint(playerid, 1351.6903,1387.8201,10.8639, 5.0);
            SendClientMessage(playerid, -1,"TUNGGU SEBENTAR");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 8)
        {
            LesenMotor[playerid] = 9;
            SetPlayerCheckpoint(playerid, 1351.6687,1340.1285,10.8639, 5.0);
            SendClientMessage(playerid, -1,"Jika Ada Kerosakan Dijalan Raya Sila Berhati-Hati");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenMotor[playerid] == 9)
        {
            LesenMotor[playerid] = 10;
            SetPlayerCheckpoint(playerid, 1328.8981,1279.2063,10.8203, 5.0);
        }
        if(LesenMotor[playerid] == 10) 
        {
            LesenMotor[playerid] = 0;
            SendClientMessage(playerid, COLOR_WHITE, "Tahniah!!Anda Telah Berjaya Mendapatkan Lesen B");
            PlayerInfo[playerid][pLesenmotor] = 1;
			PlayerInfo[playerid][pCash] = -1500;
            DestroyVehicle(playerid);
            SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 456)
    {
        if(LesenGDL[playerid] == 1)
        {
            LesenGDL[playerid] = 2;
            SetPlayerCheckpoint(playerid, 1339.1011,1410.9137,10.8603, 5.0); //cp 2
            SendClientMessage(playerid, -1,"Berhentikan Kenderaan Anda Sekiranya Lampu Isyarat Berwarna Merah");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenGDL[playerid] == 2)
        {
            LesenGDL[playerid] = 3;
            SetPlayerCheckpoint(playerid, 1351.6014,1391.0076,10.8639, 5.0);
            SendClientMessage(playerid, -1,"Jika Ada Kerosakan Dijalan Raya Sila Bawa Kenderaan Secara Perlahan-Lahan Dan Berhati-Hati");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenGDL[playerid] == 3)
        {
            LesenGDL[playerid] = 4;
            SetPlayerCheckpoint(playerid, 1362.9111,1297.6052,10.8203, 5.0);
            return 1;
        }
        if(LesenGDL[playerid] == 4) 
        {
            LesenGDL[playerid] = 0;
            SendClientMessage(playerid, COLOR_WHITE, "Tahniah!!Anda Telah Berjaya Mendapatkan Lesen GDL!");
            PlayerInfo[playerid][pLesengdl] = 1;
			PlayerInfo[playerid][pCash] -= 5000;
            DestroyVehicle(playerid);
            SetPlayerSkin(playerid,SkinLama[playerid]);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 507)
    {
        if(LesenKereta[playerid] == 1)
        {
            LesenKereta[playerid] = 2;
            SetPlayerCheckpoint(playerid, 1339.1011,1410.9137,10.8603, 5.0); //cp 2
            SendClientMessage(playerid, -1,"Berhentikan Kenderaan Anda Sekiranya Lampu Isyarat Berwarna Merah");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenKereta[playerid] == 2)
        {
            LesenKereta[playerid] = 3;
            SetPlayerCheckpoint(playerid, 1351.6014,1391.0076,10.8639, 5.0);
            SendClientMessage(playerid, -1,"Jika Ada Kerosakan Dijalan Raya Sila Bawa Kenderaan Secara Perlahan-Lahan Dan Berhati-Hati");
            TogglePlayerControllable(playerid,false);
	        SetTimerEx("UnFreezeJob", 10000, false, "i", playerid);
	        GameTextForPlayer(playerid, "Sila Tunggu", 10000, 1);
            return 1;
        }
        if(LesenKereta[playerid] == 3)
        {
            LesenKereta[playerid] = 4;
            SetPlayerCheckpoint(playerid, 1362.9111,1297.6052,10.8203, 5.0);
            return 1;
        }
        if(LesenKereta[playerid] == 4) 
        {
            LesenKereta[playerid] = 0;
            SendClientMessage(playerid, COLOR_WHITE, "Tahniah!!Anda Telah Berjaya Mendapatkan Lesen DA!");
            PlayerInfo[playerid][pLesenkereta] = 1;
			PlayerInfo[playerid][pCash] -= 2500;
            DestroyVehicle(playerid);
            SetPlayerSkin(playerid,SkinLama[playerid]);
            DisablePlayerCheckpoint(playerid);
            return 1;
        }
    }
    if(GetVehicleModel(GetPlayerVehicleID(playerid)) == 574)
    {
        if(Sweeper[playerid] == 1)
        {
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper1))
            {
                SetPlayerCheckpoint(playerid, sweeper2, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp kedua!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper2))
            {
                SetPlayerCheckpoint(playerid, sweeper3, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ketiga!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper3))
            {
                SetPlayerCheckpoint(playerid, sweeper4, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-4!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper4))
            {
                SetPlayerCheckpoint(playerid, sweeper5, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-5!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper5))
            {
                SetPlayerCheckpoint(playerid, sweeper6, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-6!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper6))
            {
                SetPlayerCheckpoint(playerid, sweeper7, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-7!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper7))
            {
                SetPlayerCheckpoint(playerid, sweeper8, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-8!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper8))
            {
                SetPlayerCheckpoint(playerid, sweeper9, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-9!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper9))
            {
                SetPlayerCheckpoint(playerid, sweeper10, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-10!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper10))
            {
                SetPlayerCheckpoint(playerid, sweeper11, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-11!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0, sweeper11))
            {
                SetPlayerCheckpoint(playerid, sweeper12, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-12!", 3000, 3);
            }
            if(IsPlayerInRangeOfPoint(playerid, 7.0, sweeper12))
            {
                SetPlayerCheckpoint(playerid, sweeper13, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-13!", 3000, 3);
            }
            if(IsPlayerInRangeOfPoint(playerid, 7.0, sweeper13))
            {
                SetPlayerCheckpoint(playerid, sweeper14, 7.0);
                GameTextForPlayer(playerid, "~g~Anda berjaya sila pergi ke cp ke-14!", 3000, 3);
            }
            if (IsPlayerInRangeOfPoint(playerid, 7.0,sweeper14))
            {
                new string[180], name[MAX_PLAYER_NAME];
                //new veh;
                GetPlayerName(playerid,name,MAX_PLAYER_NAME);
                GiveMoneyPayday(playerid, 1000);
                GameTextForPlayer(playerid, "~g~ANDA TELAH MENYELESAIKAN JOB SWEEPER", 10000, 3);
                SendClientMessage(playerid, -1, ""COL_RED"[JOBS]"COL_WHITE" Anda Mendapat Duit Sebanyak "COL_RED" RM1000 ");
                format(string, sizeof(string), ""COL_RED"[JOBS] "COL_WHITE"%s "COL_WHITE"Menyelesaikan Pekerjaan Sweeper.", name);
                SendClientMessageToAll(-1, string);
                DisablePlayerCheckpoint(playerid);
                //veh = GetPlayerVehicleID(playerid);
                DestroyVehicle(pemain[playerid][Vehicles]);
                Sweeper[playerid] = 0;
            }
        }
    }
    return 1;
}

public OnPlayerLeaveCheckpoint(playerid)
{
    new Float:x, Float:y, Float:z;
    if(IsPlayerInRangeOfPoint(playerid, 5, x, y, z))
    {
        DisablePlayerCheckpoint(playerid);
    }
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

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger)
	{
		if(IsABike(vehicleid))
		{
			if(PlayerInfo[playerid][pLesenmotor] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda belum mempunyai lesen Motor.Sila ambil lesen di Jabatan Pengangkutan Jalan!");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
			}
		}
	}
	if(!ispassenger)
	{
		if(IsAVehicle(vehicleid))
		{
			if(PlayerInfo[playerid][pLesenkereta] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda belum mempunyai lesen Kereta.Sila ambil lesen di Jabatan Pengangkutan Jalan!");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
			}
		}
	}
	if(!ispassenger)
	{
		if(IsAGdl(vehicleid))
		{
			if(PlayerInfo[playerid][pLesengdl] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_RED"[MYBOT]"COL_WHITE" Anda belum mempunyai lesen GDL.Sila ambil lesen di Jabatan Pengangkutan Jalan!");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
			}
		}
	}
    if(!ispassenger)
    {
        new vid = GetPlayerVehicleID(playerid);
        GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
        if(vid != INVALID_VEHICLE_ID)
        if(engine == VEHICLE_PARAMS_OFF || engine == VEHICLE_PARAMS_UNSET)
        {
            vehEngine[vid] = 1;
            SendClientMessage(playerid, -1, ""COL_OREN"[ENJIN]"COL_WHITE" Enjin Kenderaan Ini Sedang Hidup.Taip /en Untuk Menutup Enjin");
            SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
        }
        else if(engine == VEHICLE_PARAMS_ON)
        {
            vehEngine[vid] = 0;
            SendClientMessage(playerid, -1, ""COL_OREN"[ENJIN]"COL_WHITE" Enjin Kenderaan Ini Tidak Hidup.Taip /en Untuk Membuka Enjin");
            SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
        }
    }
	return 1;
}

public OnPlayerKeyStateChange(playerid, newkeys, oldkeys)
{
	if(PRESSED(KEY_YES))//InOut
	{
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1487.1653,-1725.0394,13.5469) ||        //DATARAN
        IsPlayerInRangeOfPoint(playerid, 2.0, 1549.4366,-2212.7119,13.5547) ||           //BANK
        IsPlayerInRangeOfPoint(playerid, 2.0, 1601.0554,-1609.1011,13.4746) ||         //POLIS
        IsPlayerInRangeOfPoint(playerid, 5.0, 1176.4408,-1308.0441,13.9626) ||        //KKM
        IsPlayerInRangeOfPoint(playerid, 2.0, 1659.9290,-1704.5850,20.4772) ||       //JPJ
        IsPlayerInRangeOfPoint(playerid, 2.0, 1535.0077,716.1779,10.8203) ||        //YAKUZA
        IsPlayerInRangeOfPoint(playerid, 2.0, 1479.7106,2841.7881,10.8203) ||      //Kongsi
        IsPlayerInRangeOfPoint(playerid, 2.0, 2498.4270,1538.1479,10.8203) ||     //SCAR77
        IsPlayerInRangeOfPoint(playerid, 2.0, 1778.8472,-1692.9858,13.4532) ||   //LORISAMPAH
        IsPlayerInRangeOfPoint(playerid, 2.0, 1817.5563,891.9930,9.8750) ||  //SPG
        IsPlayerInRangeOfPoint(playerid, 2.0, 2104.7385,-1774.7881,13.3920) ||  //PIZZA
        IsPlayerInRangeOfPoint(playerid, 2.0, 909.6874, -1728.8009, 13.2229) || //CARDEALER
        IsPlayerInRangeOfPoint(playerid, 2.0, 1612.8627,-1838.6803,13.5217) || //FNF
        IsPlayerInRangeOfPoint(playerid, 2.0, 1325.6984,1279.7039,10.8203) || //LESEN
        IsPlayerInRangeOfPoint(playerid, 2.0, 2827.9924,1290.8412,10.7693) || //mafia
        IsPlayerInRangeOfPoint(playerid, 2.0, 1242.8713,-806.8870,84.1406) ||  //ADMIN
        IsPlayerInRangeOfPoint(playerid, 2.0, 1257.1165,-2025.9359,59.5023))
        {
            SpawnKenderaan(playerid);
        }

        if(IsPlayerInRangeOfPoint(playerid, 1,1545.1193,-2167.0229,13.6328) || //BANK
        IsPlayerInRangeOfPoint(playerid, 1,1545.0988,-2169.0894,13.6328) ||
        IsPlayerInRangeOfPoint(playerid, 1,1545.0325,-2171.1853,13.6328) ||
        IsPlayerInRangeOfPoint(playerid, 1, 1545.0778,-2173.0942,13.6328) ||
        IsPlayerInRangeOfPoint(playerid, 1, 960.4462,-1740.9369,13.5471) || //CAR DEALER
        IsPlayerInRangeOfPoint(playerid, 1, 960.4365,-1743.0936,13.5471) ||
        IsPlayerInRangeOfPoint(playerid, 1, 960.5632,-1744.9399,13.5471))
        {
            ShowPlayerDialog(playerid, BANK, DIALOG_STYLE_LIST, "{FFFF00}BANK HYRP","{FFFFFF}Penyimpanan Duit\nPengeluaran Duit","OK","EXIT");
        }

        if(IsPlayerInRangeOfPoint(playerid,1,1259.6389,-785.6516,92.0313))//MASUK ADMIN
        {
            if(PlayerInfo[playerid][pAdmin] >= 1)
            {
                TogglePlayerControllable(playerid, false);
                SetTimerEx("Unfreeze", 5000, false, "d", playerid);
                GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
                SetPlayerInterior(playerid,5);
                SetPlayerPos(playerid,1260.6479,-785.4252,1091.9063);
            }
        }

        if(IsPlayerInRangeOfPoint(playerid,1,1260.6479,-785.4252,1091.9063))//KELUAR ADMIN
        {
            if(PlayerInfo[playerid][pAdmin] >= 1) 
            {
                TogglePlayerControllable(playerid, false);
                SetTimerEx("Unfreeze", 5000, false, "d", playerid);
                GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1259.6389,-785.6516,92.0313);
            }
        }

        if(IsPlayerInRangeOfPoint(playerid,1,1298.3988,-798.0410,84.1406))//MASUK ADMIN 2
        {
            if(PlayerInfo[playerid][pAdmin] >= 1)
            {
                TogglePlayerControllable(playerid, false);
                SetTimerEx("Unfreeze", 5000, false, "d", playerid);
                GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
                SetPlayerInterior(playerid,5);
                SetPlayerPos(playerid,1298.8469,-797.0021,1084.0078);
            }
        }

        if(IsPlayerInRangeOfPoint(playerid,1,1298.8469,-797.0021,1084.0078))//KELUAR ADMIN 2
        {
            if(PlayerInfo[playerid][pAdmin] >= 1)
            {
                TogglePlayerControllable(playerid, false);
                SetTimerEx("Unfreeze", 5000, false, "d", playerid);
                GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
                SetPlayerInterior(playerid,0);
                SetPlayerPos(playerid,1298.3988,-798.0410,84.1406);
            }
        }

	    if(IsPlayerInRangeOfPoint(playerid,1,1653.9015,-1654.7606,22.5156))//Masuk HDRD
	    {
	       TogglePlayerControllable(playerid, false);     
	       SetTimerEx("Unfreeze", 5000, false, "d", playerid);   
	       GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);  
		   SetPlayerInterior(playerid,3);   
	       SetPlayerPos(playerid,288.7600,168.2573,1007.1719);
	    }

	    if(IsPlayerInRangeOfPoint(playerid,1,288.8270,166.9302,1007.1719))//KELUAR HDRD
	    {
	       TogglePlayerControllable(playerid, false);
	       SetTimerEx("Unfreeze", 5000, false, "d", playerid);
	       GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
		   SetPlayerInterior(playerid,0);
	       SetPlayerPos(playerid,1653.9015,-1654.7606,22.5156);
	    }
        if(IsPlayerInRangeOfPoint(playerid,1,1172.7075,-1325.0419,15.4018))//masuk Kkm
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,1161.0968,-1309.1654,14.4256);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,1161.0968,-1309.1654,14.4256))//masuk guard
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,1546.8253,-1619.4619,13.5546);
        }

        if(IsPlayerInRangeOfPoint(playerid,1,1546.8253,-1619.4619,13.5546))//keluar guard
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);
            SetPlayerPos(playerid,1548.9636,-1619.4282,13.5469);
        }

	    if(IsPlayerInRangeOfPoint(playerid,1,1161.0968,-1309.1654,14.4256))//keluar Kkm
	    {
	        TogglePlayerControllable(playerid, false);
	        SetTimerEx("Unfreeze", 5000, false, "d", playerid);
	        GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
			SetPlayerInterior(playerid,0);
	        SetPlayerPos(playerid,1172.7075,-1325.0419,15.4018);
	    }
	    if(IsPlayerInRangeOfPoint(playerid,1,1456.1322,2773.4058,10.8203))//Masuk Kongsi
	    {
	        TogglePlayerControllable(playerid, false);
	        SetTimerEx("Unfreeze", 5000, false, "d", playerid);
	        GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
			SetPlayerInterior(playerid,5);
	        SetPlayerPos(playerid,140.17,1366.07,1083.65);
	    }
	    if(IsPlayerInRangeOfPoint(playerid,1,140.17,1366.07,1083.65))//Keluar Kongsi
	    {
	        TogglePlayerControllable(playerid, false);
	        SetTimerEx("Unfreeze", 5000, false, "d", playerid);
	        GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
			SetPlayerInterior(playerid,0);
	        SetPlayerPos(playerid,1456.1322,2773.4058,10.8203);
	    }
	    if(IsPlayerInRangeOfPoint(playerid,1,1455.3027,750.7111,11.0234))//Masuk YAKUZA
	    {
	        TogglePlayerControllable(playerid, false);
	        SetTimerEx("Unfreeze", 5000, false, "d", playerid);
	        GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
			SetPlayerInterior(playerid,6);
	        SetPlayerPos(playerid,886.9656, 1918.1494, -89.0902);
	    }
	    if(IsPlayerInRangeOfPoint(playerid,1,886.9656, 1918.1494, -89.0902))//Keluar YAKUZA
	    {
	        TogglePlayerControllable(playerid, false);
	        SetTimerEx("Unfreeze", 5000, false, "d", playerid);
	        GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
			SetPlayerInterior(playerid,0);
	        SetPlayerPos(playerid,1455.3027,750.7111,11.0234);
	    }
        if(IsPlayerInRangeOfPoint(playerid,1,2481.5891,1525.6466,11.7174))//Masuk SCAR77
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,7);
            SetPlayerPos(playerid,225.68,1021.45,1084.02 );
        }
        if(IsPlayerInRangeOfPoint(playerid,1,225.68,1021.45,1084.02))//Keluar SCAR77
        {    
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);    
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);   
            SetPlayerPos(playerid,2481.5891,1525.6466,11.7174);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,2793.6973,-1087.5923,30.7188))//Masuk cityhall
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerPos(playerid,231.2062,2348.4707,1017.1257);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,231.2062,2348.4707,1017.1257))//Keluar cityhall
        {    
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);    
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);   
            SetPlayerPos(playerid,2793.6973,-1087.5923,30.7188);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,1555.5009,-1675.7543,16.1953))//Masuk Pdrm
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerPos(playerid,245.7996,220.8039,1042.1980);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,245.7996,220.8039,1042.1980))//Keluar HPDP
        {    
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);    
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);   
            SetPlayerPos(playerid,1555.5009,-1675.7543,16.1953);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,937.7542,1734.5244,8.8516))//Masuk Pdrm
        {
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerPos(playerid,835.6981,-127.4484,1007.199);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,835.6981,-127.4484,1007.199))//Keluar HPDP
        {    
            TogglePlayerControllable(playerid, false);
            SetTimerEx("Unfreeze", 5000, false, "d", playerid);    
            GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
            SetPlayerInterior(playerid,0);   
            SetPlayerPos(playerid,937.7542,1734.5244,8.8516);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,1318.9351,1250.1371,10.8203))//Masuk LESEN
        {
           TogglePlayerControllable(playerid, false);     
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);   
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);  
           SetPlayerInterior(playerid,3);   
           SetPlayerPos(playerid,238.7829,138.8300,1003.0234);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,238.7829,138.8300,1003.0234))//KELUAR LESEN
        {
           TogglePlayerControllable(playerid, false);
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
           SetPlayerInterior(playerid,0);
           SetPlayerPos(playerid,1318.9351,1250.1371,10.8203);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,1123.0536,-1127.4014,23.8047))//Masuk Pawagam
        {
           TogglePlayerControllable(playerid, false);     
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);   
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);  
           SetPlayerInterior(playerid,3);   
           SetPlayerPos(playerid,1138.0483,-1080.4270,359.0731);
        }
        if(IsPlayerInRangeOfPoint(playerid,2,1138.0483,-1080.4270,359.0731))//KELUAR Pawagam
        {
           TogglePlayerControllable(playerid, false);
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
           SetPlayerInterior(playerid,0);
           SetPlayerPos(playerid,1123.0536,-1127.4014,23.8047);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,487.5220,-1639.1007,23.7031))//Dari G naik Ke T1
        {
           TogglePlayerControllable(playerid, false);
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
           SetPlayerInterior(playerid,0);
           SetPlayerPos(playerid,479.5371,-1643.5742,218.0884);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,479.5371,-1643.5742,218.0884))//Dari T1 Turun Ke G
        {
           TogglePlayerControllable(playerid, false);
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
           SetPlayerInterior(playerid,0);
           SetPlayerPos(playerid,487.5220,-1639.1007,23.7031);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,476.3571,-1635.9596,218.0884))//Dari T1 Naik ke T2
        {
           TogglePlayerControllable(playerid, false);
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
           SetPlayerInterior(playerid,0);
           SetPlayerPos(playerid,476.6425,-1635.8756,227.5184);
        }
        if(IsPlayerInRangeOfPoint(playerid,1,476.6425,-1635.8756,227.5184))//Dari T2 Turun Ke T1
        {
           TogglePlayerControllable(playerid, false);
           SetTimerEx("Unfreeze", 5000, false, "d", playerid);
           GameTextForPlayer(playerid,"~w~SILA TUNGGU",3000,3);
           SetPlayerInterior(playerid,0);
           SetPlayerPos(playerid,476.3571,-1635.9596,218.0884);
        }
        if(PlayerInfo[playerid][pRole] == 1)
        if(PlayerToPoint(2, playerid, 233.3081,200.5684,1042.1980)) //======ONDUTY Police
        { 
           OndutyPlayer(playerid);     
        }
        if(PlayerInfo[playerid][pRole] == 2)
        if(PlayerToPoint(2, playerid, 259.7326,191.6811,1008.1719)) //======ONDUTY Suruhanjaya
        {   
            OndutyPlayer(playerid);    
        }
        if(PlayerInfo[playerid][pRole] == 3)
        if(PlayerToPoint(2, playerid, 1160.6747,-1311.8544,17.9123)) //======ONDUTY Medic
        {   
            OndutyPlayer(playerid); 
        }
        if(PlayerInfo[playerid][pRole] == 4)    
        if(PlayerToPoint(2, playerid, 1629.7483,-1785.5486,13.5294)) //======ONDUTY Tailong
        {   
            OndutyPlayer(playerid);    
        }
        if(PlayerInfo[playerid][pRole] == 5)    
        if(PlayerToPoint(2, playerid, 144.0128,1384.5999,1088.3672)) //======ONDUTY Mafia
        {
            OndutyPlayer(playerid);    
        }
        if(PlayerToPoint(4, playerid,1351.9056,-1758.5581,13.5078)) 
        { //PINTU 7E
            MoveDynamicObject(Pintu7E, 1348.690063, -1759.452758, 13.653109, 5.00);
            SetTimerEx("ClosePintu7E", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(4, playerid,1351.9056,-1758.5581,13.5078)) 
        { //PINTU 7E
            MoveDynamicObject(Pintu7E2, 1356.550781, -1759.507812, 13.653109, 5.00);
            SetTimerEx("ClosePintu7E2", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(5, playerid,2800.2981, 2698.2441, 9.8203)) 
        { //PINTU 7E
            MoveDynamicObject(Masuk1, 2795.1733, 2698.1226, 11.4823, 5.00);
            SetTimerEx("CloseMasuk1", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(5, playerid,2800.2981, 2698.2441, 9.8203)) 
        { //PINTU 7E
            MoveDynamicObject(Masuk2, 2805.7891, 2698.1394, 11.4823, 5.00);
            SetTimerEx("CloseMasuk2", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(4, playerid,937.3243, -1730.0740, 13.9325)) 
        { //PINTU CD 1
            MoveDynamicObject(pintucd1, 937.6415, -1735.1646, 14.1958, 5.00);
            SetTimerEx("ClosePintuCD1", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(4, playerid,937.3243, -1730.0740, 13.9325)) 
        { //PINTU CD 2
            MoveDynamicObject(pintucd2, 937.6415, -1725.2066, 14.1958, 5.00);
            SetTimerEx("ClosePintuCD2", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(4, playerid,937.3243, -1730.0740, 13.9325)) 
        { //PINTU CD 3
            MoveDynamicObject(pintucd3, 937.6415, -1735.1646, 14.1958, 5.00);
            SetTimerEx("ClosePintuCD3", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(4, playerid,937.3243, -1730.0740, 13.9325)) 
        { //PINTU CD 4
            MoveDynamicObject(pintucd4, 937.6415, -1725.2066, 14.1958, 5.00);
            SetTimerEx("ClosePintuCD4", 5000, false, "i", playerid);//set your time
        }
        //=============================CD====================================//
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 955.5948, -1728.5149, 13.9325))
        {
            HargaKenderaan(playerid);
        }
        //==================GATE============================================//
        if(PlayerInfo[playerid][pAdmin] > 0)
        if(PlayerToPoint(7, playerid,1245.5944, -763.2645, 93.1298)) 
        { //GATE ADMIN
            MoveDynamicObject(gateadmin, 1251.4240, -763.0829, 88.6025, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateAdmin", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 8 || PlayerInfo[playerid][pAdmin] >= 2)
        if(PlayerToPoint(5, playerid,997.5047,1769.6245,10.9219)) 
        { //GATE Kapak
            MoveDynamicObject(gateKapak, 997.1098, 1781.1805, 12.7084, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateKapak", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 9 || PlayerInfo[playerid][pAdmin] >= 2)
        if(PlayerToPoint(5, playerid,2754.2759,1313.5090,12.3012)) 
        { //GATE Kapak
            MoveDynamicObject(gatemafia, 2756.9063, 1295.7507, 13.9563, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateMafia", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 6 || PlayerInfo[playerid][pAdmin] >= 2)
        if(PlayerToPoint(5, playerid,1527.9495, 659.6562, 11.0951)) 
        { //GATE YAKUZA 1
            MoveDynamicObject(gateyakuza1, 1533.7026, 663.2500, 6.8696, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateYakuza1", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 6 || PlayerInfo[playerid][pAdmin] >= 2)
        if(PlayerToPoint(5, playerid,1447.7701, 661.5413, 11.0951)) 
        { //GATE YAKUZA 2
            MoveDynamicObject(gateyakuza2, 1453.7075, 663.2500, 6.8496, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateYakuza2", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 7 || PlayerInfo[playerid][pAdmin] >= 2)
        if(PlayerToPoint(5, playerid,2507.2598,1604.8766,10.7421)) 
        { //GATE SCAR77
            MoveDynamicObject(Gatewhite, 2513.068847,1603.458251,6.859340, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateWhite", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 5 || PlayerInfo[playerid][pAdmin] > 2)
        if(PlayerToPoint(5, playerid,1525.7598, 2773.2063, 10.3369)) 
        { //GATE Kongsi
            MoveDynamicObject(gateKongsi, 1524.3313, 2778.9077, 6.8572, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("TutupGateKongsi", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(8, playerid,1695.7047, 412.5034, 31.0608)) 
        { //TOL KE LV
            MoveDynamicObject(tollv, 1686.5962, 418.2097, 30.8581, 5.00);
            SendClientMessage(playerid, -1, "{fbff00}[RUSUH TOL]{FFFFFF}Duit Anda Telah Ditolak Sebanyak RM100!");
            GameTextForPlayer(playerid, "~g~SELAMAT DATANG KE LOS VEGAS", -3000, 1);
            TolakDuitPlayer(playerid, 100);
            SetTimerEx("Tutuptollv", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(8, playerid,1704.9402, 411.7529, 31.0608))
        { //TOL KE LS
            MoveDynamicObject(tolls, 1714.6193, 406.5184, 30.8381, 5.00);
            SendClientMessage(playerid, -1, "{fbff00}[RUSUH TOL]{FFFFFF}Duit Anda Telah Ditolak Sebanyak RM100!");
            GameTextForPlayer(playerid, "~g~SELAMAT DATANG KE LOS SANTOS", -3000, 1);
            TolakDuitPlayer(playerid, 100);
            SetTimerEx("Tutuptolls", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pAdmin] > 2)
        if(PlayerToPoint(8, playerid,1543.5878, -1627.4794, 13.0159)) 
        { //PALANG BALAI
            MoveDynamicObject(PalangBalai, 1544.7754, -1637.6444, 13.1816, 5.00);
            SetTimerEx("TutupPalangBalai", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(5, playerid,2779.8250, 2665.1836, 13.8304))
        { //GATE Kapak
            MoveDynamicObject(GatePenjaraBesar, 2769.7219, 2665.1921, 13.8304, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGatePenjaraBesar", 5000, false, "i", playerid);//set your time
        }
        if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pAdmin] >= 2 || PlayerInfo[playerid][pLeader] == 1)
        if(PlayerToPoint(5, playerid,2792.1033, 2708.6794, 11.2684))
        { //GATE Kapak
            MoveDynamicObject(GateMasukPenjara, 2792.2180, 2706.9551, 11.2684, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateMasukPenjara", 5000, false, "i", playerid);//set your time
        }
        if(PlayerToPoint(5, playerid,2792.3174, 2721.1292, 11.2084))
        { //GATE Kapak
            MoveDynamicObject(GateGym, 2792.2458, 2722.9375, 11.2084, 5.00);
            IsPlayerInAnyVehicle(playerid);
            SendClientMessage(playerid, -1, "{FF0000}[MYBOT]{FFFFFF}Pagar Akan Ditutup Dalam 5 Saat!");
            SetTimerEx("CloseGateGym", 5000, false, "i", playerid);//set your time
        }
        //=====================================TUNE KENDERAAN=================================//
        if(IsPlayerInRangeOfPoint(playerid, 2, 1602.0372,-1808.5365,13.8207) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1601.9264,-1816.0817,13.8207) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1604.6527,-1823.9913,13.4649) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1604.2098,-1832.0674,13.8207) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1604.5778,-1839.1873,13.5038) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1655.4136,-1838.0573,13.9751) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1647.0038,-1838.6398,13.9751) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1639.1848,-1845.4011,13.5409) ||
        IsPlayerInRangeOfPoint(playerid, 2, 1630.2441,-1843.1969,13.5393))
        {
        	if(PlayerInfo[playerid][pRole] == 4)
    		{
        		if(PlayerInfo[playerid][pDuty] == 1)
        		{
       				TuneKenderaan(playerid);
    			}
        		else
        		{
                	SendClientMessage(playerid, COLOR_RED, ""COL_RED"[MYBOT]"COL_WHITE" Anda Haruslah Onduty Terlebih Dahulu Untuk Menggunakan Command Ini");
        		}
    		}
    		else return SendClientMessage(playerid,-1,""COL_RED"[MYBOT]"COL_WHITE" Maaf, Anda Tidak Dapat Menggunakan Command Ini");
		}
        //=======================SYSTEM MINYAK=============================================//
        if(IsPlayerInRangeOfPoint(playerid,10,1940.122314, -1772.685424, 13.382812))//ISI MINYAK
        {
            new string[500];
            new vehid = GetPlayerVehicleID(playerid);
            if(PlayerInfo[playerid][pMinyak] >= 95) return SendClientMessage(playerid, COLOR_RED, "Minyak Anda Masih Penuh!");
            if(IsPlayerInVehicle(playerid, vehid)) return SendClientMessage(playerid, COLOR_RED, "Sila Keluar Dari Kenderaan!");
            TogglePlayerControllable(playerid, false);
            //PlayerInfo[playerid][pMinyak] = 100;
            ApplyAnimation(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
            SetTimerEx("IsiFuelTimer", 10000, false, "i", playerid);
            GameTextForPlayer(playerid,"~w~MINYAK SEDANG DIISI...",10000, 3);
            format(string, sizeof(string), "* %s Sedang Mengisi Minyak", GetRPName(playerid));
            ProxDetector(30.0, playerid, string, ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR);
        }
        //=============================SYSTEM CASINO=========================================================//
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2898.9026,-1133.8525,16.7372))//mesin 1
        {
            if(GetPlayerMoney(playerid) >= 1000)
            {
                TolakDuitPlayer(playerid, 1000);
                SetTimerEx("Casino", 6000, 0, "i", playerid);
                SCM(playerid, -1, "SILA TUNGGU 6 SAAT");
                CreateDo(playerid, "Sedang Mencuci sebanyak 1000");
            }
            else return SCM(playerid, -1, "ANDA TIDAK MENCUKUPI DUIT");
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2903.2805,-1133.8518,16.7372))//mesin 2
        {
            if(GetPlayerMoney(playerid) >= 5000)
            {
                TolakDuitPlayer(playerid, 5000);
                SetTimerEx("Casino1", 6000, 0, "i", playerid);
                SCM(playerid, -1, "SILA TUNGGU 6 SAAT");
                CreateDo(playerid, "Sedang Mencuci sebanyak 5000");
            }
            else return SCM(playerid, -1, "ANDA TIDAK MENCUKUPI DUIT");
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2903.2554,-1131.1172,16.7372))//mesin 3
        {
            if(GetPlayerMoney(playerid) >= 10000)
            {
                TolakDuitPlayer(playerid, 10000);
                SetTimerEx("Casino2", 6000, 0, "i", playerid);
                SCM(playerid, -1, "SILA TUNGGU 6 SAAT");
                CreateDo(playerid, "Sedang Mencuci sebanyak 10000");
            }
            else return SCM(playerid, -1, "ANDA TIDAK MENCUKUPI DUIT");
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2899.0063,-1131.1135,16.7372))//mesin 4
        {
            if(GetPlayerMoney(playerid) >= 15000)
            {
                TolakDuitPlayer(playerid, 15000);
                SetTimerEx("Casino3", 6000, 0, "i", playerid);
                SCM(playerid, -1, "SILA TUNGGU 6 SAAT");
                CreateDo(playerid, "Sedang Mencuci sebanyak 15000");
            }
            else return SCM(playerid, -1, "ANDA TIDAK MENCUKUPI DUIT");
        }
        //===========================MASUK RUMAH=========================//
        new pname[MAX_PLAYER_NAME];
        GetPlayerName(playerid, pname, sizeof(pname));
        for(new i = 0; i < MAX_HOUSES; i++)
        {
            if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
            {
                if(strcmp(!pname, HouseInfo[i][hLocked], true)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Rumah Ini Dikunci.");
                if(HouseInfo[i][hOwned] == 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Anda tidak boleh masuk di rumah ini.");
                SetPlayerPos(playerid, HouseInfo[i][hEnterX], HouseInfo[i][hEnterY], HouseInfo[i][hEnterZ]);
                SetPlayerInterior(playerid, HouseInfo[i][hInterior]);
                SendClientMessage(playerid, -1, "{00ffe1}[RUMAH]: {FFFFFF}Anda telah masuk di rumah.");
                InHouse[playerid][i] = 1;
                SetPlayerVirtualWorld(playerid , 1);
                //SetPlayerVirtualWorld(playerid);
            }
        }
	}
    if(PRESSED(KEY_WALK))
    {
        if(PlayerToPoint(3, playerid, 1360.2893,-1770.3497,13.6761)) 
        {
            DialogMakanan(playerid);
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 955.5118, -1731.5348, 13.9325))
        {
            BeliKenderaan(playerid);
        }
    }
    if(PRESSED(KEY_NO))
    {
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][0], PlayerInfo[playerid][pLapar]);
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][1], PlayerInfo[playerid][pHaus]);
        
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[0]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[1]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[2]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[3]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[4]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[5]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[6]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[7]);
        //TextDrawShowForPlayer(playerid, BAGLAPARHAUS[8]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[9]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[10]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[11]);
        if(PlayerInfo[playerid][pBun] > 0) { TextDrawShowForPlayer(playerid, BAGLAPARHAUS[12]); }
        if(PlayerInfo[playerid][pBiskut] > 0) { TextDrawShowForPlayer(playerid, BAGLAPARHAUS[13]); }
        if(PlayerInfo[playerid][pMeggiCup] > 0) { TextDrawShowForPlayer(playerid, BAGLAPARHAUS[14]); }
        if(PlayerInfo[playerid][pMineral] > 0) { TextDrawShowForPlayer(playerid, BAGLAPARHAUS[15]); }
        if(PlayerInfo[playerid][p100Plus] > 0) { TextDrawShowForPlayer(playerid, BAGLAPARHAUS[16]); }
        if(PlayerInfo[playerid][pCoffee] > 0) { TextDrawShowForPlayer(playerid, BAGLAPARHAUS[17]); }
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[18]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[19]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[20]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[21]);
        TextDrawShowForPlayer(playerid, BAGLAPARHAUS[22]);
        
        TextDrawShowForPlayer(playerid, BAGLAPARHAUSSKIN[playerid]);//INVENTORY
        TextDrawSetPreviewModel(BAGLAPARHAUSSKIN[playerid], GetPlayerSkin(playerid));
        SelectTextDraw(playerid, 0xFF0000FF);
    }
    if(GetPVarInt(playerid, "Injured") != 0)
	if(!gPlayerUsingLoopingAnim[playerid])

	if(PRESSED(KEY_SPRINT,newkeys,oldkeys))
	{
	    StopLoopingAnim(playerid);
        TextDrawHideForPlayer(playerid,txtAnimHelper);
    }
    if (newkeys == KEY_SUBMISSION)
    {
        SelectTextDraw(playerid, 0xFF4040AA);
    }
    return 1;
}

public OnPlayerUpdate(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        AutoJail(playerid);
        AntiHackWeapon(playerid);
        AntiSpawnKilling(playerid);
        SpeedTrap(playerid);
        if(PlayerLogin[playerid] == 1) 
        {
            new Float:HP;
            GetPlayerHealth(playerid, HP);
            if(HP < 20) 
            {
                Injured[playerid] = 1;
                ApplyAnimation(playerid, "SWAT", "gnstwall_injurd", 4.0, 0, 1, 1, 1, 0, 1);//sakit perut
            }
        }
        if(PlayerInfo[playerid][pCuff] == 1)
        {
            TogglePlayerControllable(playerid,false);
        }
        if(PlayerInfo[playerid][pMinyak] >= 100)
        {
            PlayerInfo[playerid][pMinyak] = 100;
        }
        if(PlayerInfo[playerid][pMinyak] <= 0)
        {
            PlayerInfo[playerid][pMinyak] = 0;
        }
    }
    return 1;
}

public SV_VOID:OnPlayerActivationKeyPress(SV_UINT:playerid, SV_UINT:keyid)
{
    if(keyid == 0x42 && lstream[playerid]) SvAttachSpeakerToStream(lstream[playerid], playerid);
    if(keyid == 0x5A && gstream) SvAttachSpeakerToStream(gstream, playerid);
}

public SV_VOID:OnPlayerActivationKeyRelease(SV_UINT:playerid, SV_UINT:keyid)
{
    if(keyid == 0x42 && lstream[playerid]) SvDetachSpeakerFromStream(lstream[playerid], playerid);
    if(keyid == 0x5A && gstream) SvDetachSpeakerFromStream(gstream, playerid);
}

public OnDialogResponse(playerid, dialogid, response, listitem, inputtext[])
{
    //========================================== REGISTER DIALOG
    switch( dialogid )
    {
        case DIALOG_REGISTER:
        {
            if (!response) return Kick(playerid);
            if(response)
            {
                new name[MAX_PLAYER_NAME], file[256], string[128];
                new Float:X,Float:Y,Float:Z;
                GetPlayerName(playerid, name, sizeof(name));
                format(file, sizeof(file), "users/%s.ini", name);
                if(!response) return SendClientMessage(playerid, -1, "{FFFFFF}Sila Masukkan Password Anda!");
                if (!strlen(inputtext)) return ShowPlayerDialog(playerid, 1, DIALOG_STYLE_PASSWORD, "PENDAFTARAN", "{ffffff}SELAMAT DATANG!\n\n{ffffff}STATUS ACCOUNT: {ffffff}BELUM DIDAFTARKAN\n\n{ffffff}SILA MASUKKAN KATA LALUAN UNTUK MENDAFTAR", "Submit", "Exit");
                dini_Create(file);
                dini_IntSet(file, "Password", udb_hash(inputtext));
                dini_Set(file, "BackupPass", inputtext);
                dini_IntSet(file, "Admin",PlayerInfo[playerid][pAdmin] = 0);
                dini_IntSet(file, "Score", PlayerInfo[playerid][pScore] = 0);
                dini_IntSet(file, "Minyak", PlayerInfo[playerid][pMinyak] = 100);
                dini_IntSet(file, "Leader",PlayerInfo[playerid][pLeader] = 0);
                dini_IntSet(file, "Death", PlayerInfo[playerid][pDeath] = 0);
                dini_IntSet(file, "Lesenmotor", PlayerInfo[playerid][pLesenmotor] = 0);
                dini_IntSet(file, "Lesenkereta", PlayerInfo[playerid][pLesenkereta] = 0);
                dini_IntSet(file, "Lesengdl", PlayerInfo[playerid][pLesengdl] = 0);
                dini_IntSet(file, "LesenUdara", PlayerInfo[playerid][pLesenUdara] = 0);
                dini_IntSet(file, "Role",PlayerInfo[playerid][pRole] = 0);
                dini_IntSet(file, "Level",PlayerInfo[playerid][pLevel] = 0);
                dini_IntSet(file, "Vip",PlayerInfo[playerid][pVip] = 0);
                dini_IntSet(file, "Jail",PlayerInfo[playerid][pJail] = 0);
                dini_IntSet(file, "Roadblockpdrm",PlayerInfo[playerid][pRoadblockpdrm] = 0);
                dini_IntSet(file, "Skin",PlayerInfo[playerid][pSkin] = 239);//SKIN PERMULAAN DAFTAR
                dini_IntSet(file, "Cash",GivePlayerMoney(playerid, 10000));//DUIT PERMULAAN DAFTAR
                dini_IntSet(file, "DuitBank",PlayerInfo[playerid][pDuitBank] = 5000);
                dini_IntSet(file, "SultanSpoiler",PlayerInfo[playerid][pSultanSpoiler] = 0);
                dini_IntSet(file, "SultanTayar", PlayerInfo[playerid][pSultanTayar] = 0); //SULTAN
                dini_IntSet(file, "SultanPaintjob", PlayerInfo[playerid][pSultanPaintjob] = 0);
                dini_IntSet(file, "SultanRearbumper", PlayerInfo[playerid][pSultanRearbumper] = 0);
                dini_IntSet(file, "SultanRoof", PlayerInfo[playerid][pSultanRoof] = 0);
                dini_IntSet(file, "SultanSideskirt", PlayerInfo[playerid][pSultanSideskirt] = 0);
                dini_IntSet(file, "SultanNitro", PlayerInfo[playerid][pSultanNitro] = 0);
                dini_IntSet(file, "ElegyTayar", PlayerInfo[playerid][pElegyTayar] = 0); //ELEGY
                dini_IntSet(file, "ElegyPaintjob", PlayerInfo[playerid][pElegyPaintjob] = 0);
                dini_IntSet(file, "ElegyRearbumper", PlayerInfo[playerid][pElegyRearbumper] = 0);
                dini_IntSet(file, "ElegyFrontbumper", PlayerInfo[playerid][pElegyFrontbumper] = 0);
                dini_IntSet(file, "ElegyRoof", PlayerInfo[playerid][pElegyRoof] = 0);
                dini_IntSet(file, "ElegySideskirt", PlayerInfo[playerid][pElegySideskirt] = 0);
                dini_IntSet(file, "ElegyNitro", PlayerInfo[playerid][pElegyNitro] = 0);
                dini_IntSet(file, "Sultan", PlayerInfo[playerid][pSultan] = 0);
                dini_IntSet(file, "Infernus", PlayerInfo[playerid][pInfernus] = 0);
                dini_IntSet(file, "Cheetah", PlayerInfo[playerid][pCheetah] = 0);
                dini_IntSet(file, "Bullet", PlayerInfo[playerid][pBullet] = 0);
                dini_IntSet(file, "Tampa", PlayerInfo[playerid][pTampa] = 0);
                dini_IntSet(file, "Saber", PlayerInfo[playerid][pSaber] = 0);
                dini_IntSet(file, "Zr350", PlayerInfo[playerid][pZr350] = 0);
                dini_IntSet(file, "GTSUPER", PlayerInfo[playerid][pGTSUPER] = 0);
                dini_IntSet(file, "Elegy", PlayerInfo[playerid][pElegy] = 0);
                dini_IntSet(file, "Flash", PlayerInfo[playerid][pFlash] = 0);
                dini_IntSet(file, "NRG500", PlayerInfo[playerid][pNRG500] = 0);
                dini_IntSet(file, "BF400", PlayerInfo[playerid][pBF400] = 0);
                dini_IntSet(file, "Sultan", PlayerInfo[playerid][pSultan] = 0);
                dini_IntSet(file, "Sanchez", PlayerInfo[playerid][pSanchez] = 0);
                dini_IntSet(file, "Wayfarer", PlayerInfo[playerid][pWayfarer] = 0);
                dini_IntSet(file, "Pizza", PlayerInfo[playerid][pPizza] = 0);
                dini_IntSet(file, "Medkit", PlayerInfo[playerid][pMedkit] = 0);
                dini_IntSet(file, "Deserteagle", PlayerInfo[playerid][pDeserteagle] = 0);
                dini_IntSet(file, "M4", PlayerInfo[playerid][pM4] = 0);
                dini_IntSet(file, "Uzi", PlayerInfo[playerid][pUzi] = 0);
                dini_IntSet(file, "AccBank", PlayerInfo[playerid][pAccBank] = 0);
                dini_FloatSet(file, "X", X);
                dini_FloatSet(file, "Y", Y);
                dini_FloatSet(file, "Z", Z);
                dini_FloatSet(file, "LastX", PlayerInfo[playerid][pLastX] = 0);
                dini_FloatSet(file, "LastY", PlayerInfo[playerid][pLastY] = 0);
                dini_FloatSet(file, "LastZ", PlayerInfo[playerid][pLastZ] = 0);
                dini_IntSet(file, "Vehicleid", PlayerInfo[playerid][pVehicleid] = 0);
                dini_IntSet(file, "Cuff", PlayerInfo[playerid][pCuff] = 0);
                dini_IntSet(file, "Repairkit", PlayerInfo[playerid][pRepairkit] = 0);
                dini_IntSet(file, "SultanColor", PlayerInfo[playerid][pSultanColor] = 0);
                dini_IntSet(file, "ElegyColor", PlayerInfo[playerid][pElegyColor] = 0);
                dini_IntSet(file, "Warn", PlayerInfo[playerid][pWarn] = 0);
                dini_IntSet(file, "Jester", PlayerInfo[playerid][pJester] = 0);
                dini_IntSet(file, "SultanFuel", PlayerInfo[playerid][SultanFuel] = 100);
                dini_IntSet(file, "ElegyFuel", PlayerInfo[playerid][ElegyFuel] = 100);
                dini_IntSet(file, "SabreFuel", PlayerInfo[playerid][SabreFuel] = 100);
                dini_IntSet(file, "Lapar", PlayerInfo[playerid][pLapar] = 100);
                dini_IntSet(file, "Haus", PlayerInfo[playerid][pHaus] = 100);
                dini_IntSet(file, "Bun", PlayerInfo[playerid][pBun] = 1);
                dini_IntSet(file, "Biskut", PlayerInfo[playerid][pBiskut] = 1);
                dini_IntSet(file, "MeggiCup", PlayerInfo[playerid][pMeggiCup] = 1);
                dini_IntSet(file, "Mineral", PlayerInfo[playerid][pMineral] = 1);
                dini_IntSet(file, "100Plus", PlayerInfo[playerid][p100Plus] = 1);
                dini_IntSet(file, "Coffee", PlayerInfo[playerid][pCoffee] = 1);
                format(string, 128, "{ffffff} %s ANDA TELAH BERJAYA MENDAFTAR. KATA LALUAN ANDA IALAH {ffffff}%s !", name, inputtext); 
                SendClientMessage(playerid, -1, string);
                SpawnPlayer(playerid);
                TogglePlayerControllable(playerid, true);
                format(string, sizeof(string), "{ffffff}[RAKYAT]: {ffffff}%s telah Mendarat Ke Negara.", GetRPName(playerid)); 
                SendClientMessageToAll(-1, string);
                PlayerLogin[playerid] = 1;
                SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
            }
        }
        //========================================== LOGIN DIALOG
        case DIALOG_LOGIN:
        {
            if ( !response ) return Kick(playerid);
            if( response )
            {
                new name[MAX_PLAYER_NAME], file[256];
                new string[256];
                //new Float:pLastX,Float:pLastY,Float:pLastZ;
                GetPlayerName(playerid, name, sizeof(name));
                format(file, sizeof(file), "users/%s.ini", name);
                if(!response) return SendClientMessage(playerid, -1, "{FFFFFF}Sila Masukkan Password Anda!");
                if (!strlen(inputtext)) return ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD, "LOGIN", "{FFFF00}SELAMAT DATANG\n\n{FFFFFF}STATUS ACCOUNT: {FFFFFF}SUDAH DIDAFTARKAN\n\n{FFFFFF}SILA MASUKKAN KATA LALUAN ANDA", "Submit", "Exit");

                new tmp;
                tmp = dini_Int(file, "Password");
                if(udb_hash(inputtext) == tmp)
                {
                    PlayerInfo[playerid][pPassword] = dini_Int(file, "Password");
                    PlayerInfo[playerid][pBackupPass] = dini_Int(file, "BackupPass");
                    PlayerInfo[playerid][pAdmin] = dini_Int(file, "Admin");
                    PlayerInfo[playerid][pLeader] = dini_Int(file, "Leader");
                    PlayerInfo[playerid][pRole] = dini_Int(file, "Role");
                    PlayerInfo[playerid][pScore] = dini_Int(file, "Score");
                    PlayerInfo[playerid][pMinyak] = dini_Int(file, "Minyak");
                    PlayerInfo[playerid][pLevel] = dini_Int(file, "Level");
                    PlayerInfo[playerid][pDeath] = dini_Int(file, "Death");
                    PlayerInfo[playerid][pLesenmotor] = dini_Int(file, "Lesenmotor");
                    PlayerInfo[playerid][pLesenkereta] = dini_Int(file, "Lesenkereta");
                    PlayerInfo[playerid][pLesengdl] = dini_Int(file, "Lesengdl");
                    PlayerInfo[playerid][pLesenUdara] = dini_Int(file, "LesenUdara");
                    PlayerInfo[playerid][pSkin] = dini_Int(file, "Skin");
                    PlayerInfo[playerid][pCash] = dini_Int(file, "Cash");
                    PlayerInfo[playerid][pDuitBank] = dini_Int(file, "DuitBank");
                    PlayerInfo[playerid][pVip] = dini_Int(file, "Vip");
                    PlayerInfo[playerid][pJail] = dini_Int(file, "Jail");
                    PlayerInfo[playerid][pDadah] = dini_Int(file, "Dadah");
                    PlayerInfo[playerid][pGanja] = dini_Int(file, "Ganja");
                    PlayerInfo[playerid][pKetum] = dini_Int(file, "Ketum");
                    PlayerInfo[playerid][pRoadblockpdrm] = dini_Int(file, "Roadblockpdrm");
                    PlayerInfo[playerid][pSultanTayar] = dini_Int(file, "SultanTayar"); //SULTAN
                    PlayerInfo[playerid][pSultanPaintjob] = dini_Int(file, "SultanPaintjob");
                    PlayerInfo[playerid][pSultanSpoiler] = dini_Int(file, "SultanSpoiler");
                    PlayerInfo[playerid][pSultanSideskirt] = dini_Int(file, "SultanSideskirt");
                    PlayerInfo[playerid][pSultanRoof] = dini_Int(file, "SultanRoof");
                    PlayerInfo[playerid][pSultanRearbumper] = dini_Int(file, "SultanRearbumper");
                    PlayerInfo[playerid][pSultanNitro] = dini_Int(file, "SultanNitro");
                    PlayerInfo[playerid][pElegyTayar] = dini_Int(file, "ElegyTayar"); //ELEGY
                    PlayerInfo[playerid][pElegyPaintjob] = dini_Int(file, "ElegyPaintjob");
                    PlayerInfo[playerid][pElegySpoiler] = dini_Int(file, "ElegySpoiler");
                    PlayerInfo[playerid][pElegySideskirt] = dini_Int(file, "ElegySideskirt");
                    PlayerInfo[playerid][pElegyRoof] = dini_Int(file, "ElegyRoof");
                    PlayerInfo[playerid][pElegyRearbumper] = dini_Int(file, "ElegyRearbumper");
                    PlayerInfo[playerid][pElegyFrontbumper] = dini_Int(file, "ElegyFrontbumper");
                    PlayerInfo[playerid][pElegyNitro] = dini_Int(file, "ElegyNitro");
                    PlayerInfo[playerid][pSultan] = dini_Int(file, "Sultan");
                    PlayerInfo[playerid][pCheetah] = dini_Int(file, "Cheetah");
                    PlayerInfo[playerid][pBullet] = dini_Int(file, "Bullet");
                    PlayerInfo[playerid][pTampa] = dini_Int(file, "Tampa");
                    PlayerInfo[playerid][pSaber] = dini_Int(file, "Saber");
                    PlayerInfo[playerid][pZr350] = dini_Int(file, "Zr350");
                    PlayerInfo[playerid][pFlash] = dini_Int(file, "Flash");
                    PlayerInfo[playerid][pElegy] = dini_Int(file, "Elegy");
                    PlayerInfo[playerid][pGTSUPER] = dini_Int(file, "GTSUPER");
                    PlayerInfo[playerid][pInfernus] = dini_Int(file, "Infernus");
                    PlayerInfo[playerid][pBF400] = dini_Int(file, "BF400");
                    PlayerInfo[playerid][pNRG500] = dini_Int(file, "NRG500");
                    PlayerInfo[playerid][pSanchez] = dini_Int(file, "Sanchez");
                    PlayerInfo[playerid][pWayfarer] = dini_Int(file, "Wayfarer");
                    PlayerInfo[playerid][pPizza] = dini_Int(file, "Pizza");
                    PlayerInfo[playerid][pMedkit] = dini_Int(file, "Medkit");
                    PlayerInfo[playerid][pDeserteagle] = dini_Int(file, "Deserteagle");
                    PlayerInfo[playerid][pM4] = dini_Int(file, "M4");
                    PlayerInfo[playerid][pUzi] = dini_Int(file, "Uzi");
                    PlayerInfo[playerid][pAccBank] = dini_Int(file, "AccBank");
                    PlayerInfo[playerid][pVehicleid] = dini_Int(file, "Vehicleid");
                    PlayerInfo[playerid][pRepairkit] = dini_Int(file, "Repairkit");
                    PlayerInfo[playerid][pSultanColor] = dini_Int(file, "SultanColor");
                    PlayerInfo[playerid][pElegyColor] = dini_Int(file, "ElegyColor");
                    PlayerInfo[playerid][pWarn] = dini_Int(file, "Warn");
                    PlayerInfo[playerid][pLastX] = dini_Float(file, "LastX");
                    PlayerInfo[playerid][pLastY] = dini_Float(file, "LastY");
                    PlayerInfo[playerid][pLastZ] = dini_Float(file, "LastZ");
                    PlayerInfo[playerid][pJester] = dini_Int(file, "Jester");
                    PlayerInfo[playerid][SultanFuel] = dini_Int(file, "SultanFuel");
                    PlayerInfo[playerid][ElegyFuel] = dini_Int(file, "ElegyFuel");
                    PlayerInfo[playerid][SabreFuel] = dini_Int(file, "SabreFuel");
                    PlayerInfo[playerid][pLapar] = dini_Int(file, "Lapar");
                    PlayerInfo[playerid][pHaus] = dini_Int(file, "Haus");
                    PlayerInfo[playerid][pBun] = dini_Int(file, "Bun");
                    PlayerInfo[playerid][pBiskut] = dini_Int(file, "Biskut");
                    PlayerInfo[playerid][pMeggiCup] = dini_Int(file, "MeggiCup");
                    PlayerInfo[playerid][pMineral] = dini_Int(file, "Mineral");
                    PlayerInfo[playerid][p100Plus] = dini_Int(file, "100Plus");
                    PlayerInfo[playerid][pCoffee] = dini_Int(file, "Coffee");
                    TogglePlayerControllable(playerid, true);
                    PlayerLogin[playerid] = 1;
                    SetPlayerScore(playerid, PlayerInfo[playerid][pScore]);
                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
                    GivePlayerMoney(playerid,PlayerInfo[playerid][pCash]);
                    SetSpawnInfo(playerid, 0, PlayerInfo[playerid][pSkin], PlayerInfo[playerid][pLastX], PlayerInfo[playerid][pLastY], PlayerInfo[playerid][pLastZ], 0.0, 0, 0, 0, 0, 0, 0);
	                SpawnPlayer(playerid);

                    if(strfind(IsPlayerName(playerid), "Zahier", true) != -1) 
                    { 
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{fff200}[PERDANA MENTERI]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{fff200}[PERDANA MENTERI]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pJail] == 1) 
                    { 
                        new SpawnRandom = random(sizeof(SpawnJail));
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{878567}[BANDUAN]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{878567}[BANDUAN]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        SetPlayerPos(playerid,
                        SpawnJail[SpawnRandom][0],
                        SpawnJail[SpawnRandom][1],
                        SpawnJail[SpawnRandom][2]);
                        SetPlayerInterior(playerid,0);
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pJail] == 2) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{878567}[BANDUAN PENJARA BESAR]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{878567}[BANDUAN PENJARA BESAR]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pAdmin] == 6) 
                    { 
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{fff200}[OWNER]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{fff200}[OWNER]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pAdmin] == 5) 
                    { 
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{ff0000}[DEVELOPER]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{ff0000}[DEVELOPER]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pAdmin] == 4) 
                    { 
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{08d6ff}[A.DEVELOPER]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{08d6ff}[A.DEVELOPER]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pAdmin] == 3) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{08ff4e}[MODERATOR]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{08ff4e}[MODERATOR]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pAdmin] == 2) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{0e31e3}[ADMIN]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{0e31e3}[ADMIN]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pAdmin] == 1) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{0ceb29}[STAFF]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{0ceb29}[STAFF]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pVip] == 1 ) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{FC5603}[VIP]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{FC5603}[VIP]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pRole] == 1 ) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{001EFF}[Police]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{001EFF}[Police]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pRole] == 2 ) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{00C3FF}[Suruhanjaya]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{00C3FF}[Suruhanjaya]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pRole] == 3 ) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{FF00BD}[Medic]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{FF00BD}[Medic]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pRole] == 4 ) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{03CAFC}[Tailong]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{03CAFC}[Tailong]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    if(PlayerInfo[playerid][pRole] == 5 ) 
                    {
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{FFF369}[Mafia]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{FFF369}[Mafia]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                    else 
                    { 
                        if(IsPlayerAndroid(playerid))
                        {
                            format(string, sizeof(string), "{ffffff}[RAKYAT]: {ffffff}%s telah Mendarat Ke Negara. [Android]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        else
                        {
                            format(string, sizeof(string), "{ffffff}[RAKYAT]: {ffffff}%s telah Mendarat Ke Negara. [PC]", GetRPName(playerid)); 
                            SendClientMessageToAll(-1,string);
                        }
                        return 1; 
                    }
                }
                else
                {
                    ShowPlayerDialog(playerid, 2, DIALOG_STYLE_INPUT, "{FFFFFF}LOGIN ACCOUNT", "{FF0000}KATA LALUAN SALAH!\n{FFFFFF}SILA MASUKKAN KATA LALUAN ANDA!", "Login", "Exit");
                }
            }
            else
	        {
		        Kick(playerid);
	        }
        }
	}
	//=====//=====//=====//=====//=====//===== SpawnKereta
    if(dialogid == SpawnCars)
    {
		if(response)
		{
			switch(listitem)
			{
				case 0:
				{
					if(PlayerInfo[playerid][pSultan] == 1)
					{
					    CreateVehicleEx(playerid, 560, -1, -1);
						if(PlayerInfo[playerid][pSultanTayar] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1096); }
						if(PlayerInfo[playerid][pSultanTayar] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1074); }
						if(PlayerInfo[playerid][pSultanTayar] == 3) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1085); }
						if(PlayerInfo[playerid][pSultanTayar] == 4) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1073); }
						if(PlayerInfo[playerid][pSultanTayar] == 6) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1080); }
						if(PlayerInfo[playerid][pSultanTayar] == 5) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1077); }
						if(PlayerInfo[playerid][pSultanPaintjob] == 1) { ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 0); }
						if(PlayerInfo[playerid][pSultanPaintjob] == 2) { ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 1); }
						if(PlayerInfo[playerid][pSultanPaintjob] == 3) { ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 2); }
						if(PlayerInfo[playerid][pSultanNitro] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1009); }
						if(PlayerInfo[playerid][pSultanNitro] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1010); }
						if(PlayerInfo[playerid][pSultanSpoiler] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1138); }
						if(PlayerInfo[playerid][pSultanSpoiler] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1139); }
						if(PlayerInfo[playerid][pSultanRearbumper] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1140); }
						if(PlayerInfo[playerid][pSultanRearbumper] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1141); }
						if(PlayerInfo[playerid][pSultanExhaust] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1028); }
						if(PlayerInfo[playerid][pSultanExhaust] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1029); }
						if(PlayerInfo[playerid][pSultanRoof] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1139); }
						if(PlayerInfo[playerid][pSultanRoof] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1139); }
						if(PlayerInfo[playerid][pSultanSideskirt] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1030); AddVehicleComponent(GetPlayerVehicleID(playerid), 1027);	}
						if(PlayerInfo[playerid][pSultanSideskirt] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1031); AddVehicleComponent(GetPlayerVehicleID(playerid), 1026);	}
					    if(PlayerInfo[playerid][pSultanColor] == 1) { ChangeVehicleColor(GetPlayerVehicleID(playerid), 191, 191); }
                        if(PlayerInfo[playerid][pSultanColor] == 2) { ChangeVehicleColor(GetPlayerVehicleID(playerid), 197, 197); }
                    }
					else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Sultan!");	
				}
				case 1:
				{
				    if(PlayerInfo[playerid][pElegy] == 1)
					{
				    	CreateVehicleEx(playerid, 562, -1, -1);
        				if(PlayerInfo[playerid][pElegyTayar] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1096); }
						if(PlayerInfo[playerid][pElegyTayar] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1074); }
						if(PlayerInfo[playerid][pElegyTayar] == 3) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1085); }
						if(PlayerInfo[playerid][pElegyTayar] == 4) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1073); }
						if(PlayerInfo[playerid][pElegyTayar] == 6) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1080); }
						if(PlayerInfo[playerid][pElegyTayar] == 5) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1077); }
						if(PlayerInfo[playerid][pElegyPaintjob] == 1) { ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 0); }
						if(PlayerInfo[playerid][pElegyPaintjob] == 2) { ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 1); }
						if(PlayerInfo[playerid][pElegyPaintjob] == 3) { ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 2); }
						if(PlayerInfo[playerid][pElegyNitro] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1009); }
						if(PlayerInfo[playerid][pElegyNitro] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1010); }
						if(PlayerInfo[playerid][pElegySpoiler] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1146); }
						if(PlayerInfo[playerid][pElegySpoiler] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1147); }
						if(PlayerInfo[playerid][pElegyRearbumper] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1140); }
						if(PlayerInfo[playerid][pElegyRearbumper] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1141); }
						if(PlayerInfo[playerid][pElegyFrontbumper] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1171); }
						if(PlayerInfo[playerid][pElegyFrontbumper] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1172); }
						if(PlayerInfo[playerid][pElegyExhaust] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1034); }
						if(PlayerInfo[playerid][pElegyExhaust] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1037); }
						if(PlayerInfo[playerid][pElegyRoof] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1035); }
						if(PlayerInfo[playerid][pElegyRoof] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1038); }
						if(PlayerInfo[playerid][pElegySideskirt] == 1) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1036); AddVehicleComponent(GetPlayerVehicleID(playerid), 1040);	}
						if(PlayerInfo[playerid][pElegySideskirt] == 2) { AddVehicleComponent(GetPlayerVehicleID(playerid), 1039); AddVehicleComponent(GetPlayerVehicleID(playerid), 1041);	}
                        if(PlayerInfo[playerid][pElegyColor] == 1) { ChangeVehicleColor(GetPlayerVehicleID(playerid), 191, 191); }
                        if(PlayerInfo[playerid][pElegyColor] == 2) { ChangeVehicleColor(GetPlayerVehicleID(playerid), 197, 197); }
					}
                   	else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Elegy!");
				}
				case 2:
				{
				    if(PlayerInfo[playerid][pGTSUPER] == 1)
					{
						CreateVehicleEx(playerid, 506, -1, -1);
					}
                   	else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Super GT!");
				}
				case 3:
				{
				    if(PlayerInfo[playerid][pInfernus] == 1)
					{
				    	CreateVehicleEx(playerid, 411, -1, -1);
				    }
                   	else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Infernus!");
				}
				case 4:
				{
				    if(PlayerInfo[playerid][pFlash] == 1)
					{
						CreateVehicleEx(playerid, 565, -1, -1);
					}
                    else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Flash!");
				}
                case 5:
                {
                    if(PlayerInfo[playerid][pTampa] == 1)
                    {
                        CreateVehicleEx(playerid, 549, -1, -1);
                    }
                    else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Tampa!");
                }
                case 6:
                {
                    if(PlayerInfo[playerid][pZr350] == 1)
                    {
                        CreateVehicleEx(playerid, 477, -1, -1);
                    }
                    else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Zr350!");
                }
                case 7:
                {
                    if(PlayerInfo[playerid][pCheetah] == 1)
                    {
                        CreateVehicleEx(playerid, 415, -1, -1);
                    }
                    else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Cheetah!");
                }
                case 8:
                {
                    if(PlayerInfo[playerid][pBullet] == 1)
                    {
                        CreateVehicleEx(playerid, 541, -1, -1);
                    }
                    else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Bullet!");
                }
                case 9:
                {
                    if(PlayerInfo[playerid][pSaber] == 1)
                    {
                        CreateVehicleEx(playerid, 475, -1, -1);
                    }
                    else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Saber!");
                }
                case 10:
                {
                    if(PlayerInfo[playerid][pJester] == 1)
                    {
                        CreateVehicleEx(playerid, 559, -1, -1);
                    }
                    else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Jester!");
                }
			}
		}
	}
    if(dialogid == SpawnFreeCars)
    {
		if(response)
		{
			switch(listitem)
			{
    			case 0:
    			{ 
    				CreateVehicleEx(playerid, 507, -1, -1);
				}
    		   	case 1:
    		   	{
    		   	    CreateVehicleEx(playerid, 462, -1, -1);
    		   	}
			}
		}
	}
    if(dialogid == SpawnVehicleGodsideRoles)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    if(PlayerInfo[playerid][pRole] == 1)
                    {
                        CreateVehicleEx(playerid, 596, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK Pdrm");
                }
                case 1:
                {
                    if(PlayerInfo[playerid][pRole] == 1)
                    {
                        CreateVehicleEx(playerid, 523, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK Pdrm");    
                }
                case 2:
                {
                    if(PlayerInfo[playerid][pRole] == 2)
                    {
                        CreateVehicleEx(playerid, 599, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK HDRD");
                }
                case 3:
                {
                    if(PlayerInfo[playerid][pRole] == 2)
                    {
                        CreateVehicleEx(playerid, 586, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK HDRD");
                }
                case 4:
                {
                    if(PlayerInfo[playerid][pRole] == 3)
                    {
                        CreateVehicleEx(playerid, 416, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK Kkm");
                }
            }            
        }
    }   
	if(dialogid == Helpcommand)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
  	            	new str[600];
   					strcat(str, ""COL_OREN"/bayar"COL_WHITE" - Memberi Duit Kepada Pemain\n");
   					strcat(str, ""COL_OREN"/mask"COL_WHITE" - Memakai mask\n");
   					strcat(str, ""COL_OREN"/helm"COL_WHITE" - Memakai helmet\n");
   					strcat(str, ""COL_OREN"/afk"COL_WHITE" - Menjauhi Daripada Server\n");
   					strcat(str, ""COL_OREN"/fixspawn"COL_WHITE" - Spawn ke tempat rakyat"COL_RED"(Duit Akan Ditolak Sebanyak RM100)\n");
   					strcat(str, ""COL_OREN"/ca"COL_WHITE" - Chat All\n");
   					strcat(str, ""COL_OREN"/shareloc"COL_WHITE" - Share Location Anda Ke Pemain\n");
   					strcat(str, ""COL_OREN"/tutupgps"COL_WHITE" - Tutup GPS Anda\n");
                    strcat(str, ""COL_OREN"/phone"COL_WHITE" - Untuk Membuka Phone\n");
   					ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "General Command", str, "Tutup", "");
    			}
                case 1:
                {
                    if(PlayerInfo[playerid][pRole] == 1)
                    {
	                    new str[600];
	                    strcat(str, ""COL_OREN"/invite"COL_WHITE" - Invite Player\n");
	                    strcat(str, ""COL_OREN"/radio(/r)"COL_WHITE" - Radio Role\n");
	                    strcat(str, ""COL_OREN"Pdrm COMMAND"COL_WHITE" - \n");
	                    strcat(str, ""COL_OREN"/rb "COL_WHITE" - Membuat Roadblock \n");
	                    strcat(str, ""COL_OREN"/buangrb "COL_WHITE" - Membuang Roadblock  \n");
	                    strcat(str, ""COL_OREN"/jail"COL_WHITE" - jail pemain\n");
	                    strcat(str, ""COL_OREN"/unjail"COL_WHITE" - unjail pemain\n");
	                    strcat(str, ""COL_OREN"/cuff"COL_WHITE" - cuff pemain\n");
	                    strcat(str, ""COL_OREN"/uncuff"COL_WHITE" - uncuff pemain\n");
	                    ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "Pdrm Command", str, "Tutup", "");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Bukan Pdrm!");
                }
                case 2:
                {
                    if(PlayerInfo[playerid][pRole] == 2)
                    {
	                    new str[800];
	                    strcat(str, ""COL_OREN"/invite"COL_WHITE" - Invite Player\n");
	                    strcat(str, ""COL_OREN"/radio(/r)"COL_WHITE" - Radio Role\n");
	                    strcat(str, ""COL_OREN"HDRD COMMAND"COL_WHITE" - \n");
	                    strcat(str, ""COL_OREN"/rb "COL_WHITE" - Membuat Roadblock \n");
	                    strcat(str, ""COL_OREN"/buangrb "COL_WHITE" - Membuang Roadblock  \n");
	                    strcat(str, ""COL_OREN"/lesenkereta"COL_WHITE" - memberi pemain lesen kereta\n");
	                    strcat(str, ""COL_OREN"/lesenmotor"COL_WHITE" - memberi pemain lesen motor\n");
	                    strcat(str, ""COL_OREN"/lesengdl"COL_WHITE" - memberi pemain lesen lori\n");
	                    strcat(str, ""COL_OREN"/lesenfull"COL_WHITE" - memberi pemain kesemua lesen\n");
	                    strcat(str, ""COL_OREN"/tariklesenkereta"COL_WHITE" - tarik lesen kereta pemain\n");
	                    strcat(str, ""COL_OREN"/tariklesenmotor"COL_WHITE" - tarik lesen motor pemain\n");
	                    strcat(str, ""COL_OREN"/tariklesengdl"COL_WHITE" - tarik lesen lori pemain\n");
	                    strcat(str, ""COL_OREN"/tariklesensemua"COL_WHITE" - tarik kesemua lesen pemain\n");
	                    ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "HDRD Command", str, "Tutup", "");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Bukan HDRD!");
                }
                case 3:
                {
                    if(PlayerInfo[playerid][pRole] == 3)
                    {
                    	new str[600];
	                    strcat(str, ""COL_OREN"/invite"COL_WHITE" - Invite Player\n");
	                    strcat(str, ""COL_OREN"/radio(/r)"COL_WHITE" - Radio Role\n");
	                    strcat(str, ""COL_OREN"Kkm COMMAND"COL_WHITE" \n");
	                    strcat(str, ""COL_OREN"/heal"COL_WHITE" - Heal Player\n");
	                    strcat(str, ""COL_OREN"/revive"COL_WHITE" - Revive Player\n");
	                    strcat(str, ""COL_OREN"/jualmedkit"COL_WHITE" - SOON!!\n");
	                    ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "Kkm Command", str, "Tutup", "");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Bukan Kkm!");
                }
                case 4:
                {
                    if(PlayerInfo[playerid][pRole] == 4)
                    {
	                    new str[800];
	                    strcat(str, ""COL_OREN"/invite"COL_WHITE" - Invite Player\n");
	                    strcat(str, ""COL_OREN"/radio(/r)"COL_WHITE" - Radio Role\n");
	                    strcat(str, ""COL_OREN"/Repair"COL_WHITE" - Repair Kenderaan\n");
	                    strcat(str, ""COL_OREN"/Buka"COL_WHITE" - Buka Gate\n");
	                    strcat(str, ""COL_OREN"/Tutup"COL_WHITE" - Tutup Gate\n");
	                    strcat(str, ""COL_OREN""COL_WHITE" \n");
	                    strcat(str, ""COL_OREN""COL_WHITE" \n");
	                    strcat(str, ""COL_OREN"Untuk Modi Permanent"COL_WHITE" \n");
	                    strcat(str, ""COL_OREN""COL_WHITE" \n");
	                    strcat(str, ""COL_OREN"/Nama Kereta"COL_WHITE" - Komponen Kereta ~ style berape [playerid]\n");
	                    strcat(str, ""COL_OREN"/elegy [component] [playerid]"COL_WHITE" - Contoh\n");
	                    strcat(str, ""COL_OREN"/sultan [component] [playerid]"COL_WHITE" - Contoh\n");
	                    strcat(str, ""COL_OREN"Modi Permanent"COL_WHITE" - Sultan/Elegy\n");
	                    ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "FNF Command", str, "Tutup", "");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Bukan FNF!");
    			}
                case 5:
                {
                    if(PlayerInfo[playerid][pAdmin]  >= 1)
                    {
                        new str[800];
                        strcat(str, ""COL_OREN"/ajail"COL_WHITE" - Admin Jail\n");
                        strcat(str, ""COL_OREN"/kick"COL_WHITE" - Kick Player\n");
                        strcat(str, ""COL_OREN"/givesultan"COL_WHITE" - Jual Kenderaan Kepada Rakyat\n");
                        strcat(str, ""COL_OREN"/giveelegy"COL_WHITE" - Jual Kenderaan Kepada Rakyat\n");
                        strcat(str, ""COL_OREN"/ar"COL_WHITE" - Radio Admin\n");
                        strcat(str, ""COL_OREN"/lesenkereta"COL_WHITE" - Lesen Motor\n");
                        strcat(str, ""COL_OREN"/lesenmotor"COL_WHITE" - Lesen Kereta\n");
                        strcat(str, ""COL_OREN"/lesengdl"COL_WHITE" - Lesen Gdl\n");
                        strcat(str, ""COL_OREN"/makeleader"COL_WHITE" - makeleader\n");
                        strcat(str, ""COL_OREN"/givemoney"COL_WHITE" - Set money\n");
                        strcat(str, ""COL_OREN"/sethp"COL_WHITE" - set hp\n");
                        strcat(str, ""COL_OREN"/setarmor"COL_WHITE" - set armor\n");
                        strcat(str, ""COL_OREN"/makevip"COL_WHITE" - makevip\n");
                        strcat(str, ""COL_OREN"/cmdadmin"COL_WHITE" - cmd admin\n");
                        ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "ADMIN command", str, "Tutup", "");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Bukan ADMIN!");
                }
    		}
    	}
    }
    if(dialogid == BuyVehicle)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: { Kereta(playerid); }
                case 1: { Motor(playerid); }
            }
        }
    }
	if(dialogid == BuyCars)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    if(PlayerInfo[playerid][pFlash] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 50000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pFlash] = 1;
                        TolakDuitPlayer(playerid, 50000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Flash!!Duit Anda Ditolak Sebanyak RM50k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Flash", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 1:
                {
                    if(PlayerInfo[playerid][pElegy] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 100000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pElegy] = 1;
                        TolakDuitPlayer(playerid, 100000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Elegy!!Duit Anda Ditolak Sebanyak RM100k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Elegy", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 2:
                {
                    if(PlayerInfo[playerid][pSultan] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 300000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pSultan] = 1;
                        TolakDuitPlayer(playerid, 300000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Elegy!!Duit Anda Ditolak Sebanyak RM300k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Sultan", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 3:
                {
                    if(PlayerInfo[playerid][pGTSUPER] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 500000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        {
                            PlayerInfo[playerid][pGTSUPER] = 1;
                            TolakDuitPlayer(playerid, 500000);
                            SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Elegy!!Duit Anda Ditolak Sebanyak RM500k");
                            format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Super GT", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                        }
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 4:
                {
                    if(PlayerInfo[playerid][pInfernus] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 800000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pInfernus] = 1;
                        TolakDuitPlayer(playerid, 800000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Elegy!!Duit Anda Ditolak Sebanyak RM800k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Infernus", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 5:
                {
                    if(PlayerInfo[playerid][pTampa] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 120000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pTampa] = 1;
                        TolakDuitPlayer(playerid, 120000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Tampa!!Duit Anda Ditolak Sebanyak RM120000");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Tampa", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 6:
                {
                    if(PlayerInfo[playerid][pZr350] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 110000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        (PlayerInfo[playerid][pZr350] = 1);
                        TolakDuitPlayer(playerid, 110000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Zr350!!Duit Anda Ditolak Sebanyak RM110000");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Zr350", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 7:
                {
                    if(PlayerInfo[playerid][pCheetah] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 150000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pCheetah] = 1;
                        TolakDuitPlayer(playerid, 150000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Cheetah!!Duit Anda Ditolak Sebanyak RM150000");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Cheetah", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 8:
                {
                    if(PlayerInfo[playerid][pBullet] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 100000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pBullet] = 1;
                        TolakDuitPlayer(playerid, 100000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Bullet!!Duit Anda Ditolak Sebanyak RM100000");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Bullet", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 9:
                {
                    if(PlayerInfo[playerid][pSaber] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 120000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pSaber] = 1;
                        TolakDuitPlayer(playerid, 120000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Saber!!Duit Anda Ditolak Sebanyak RM120000");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Saber", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 10:
                {
                    if(PlayerInfo[playerid][pJester] == 0)
                    {
                        new string[128];
                        if(GetPlayerMoney(playerid) < 100000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pJester] = 1;
                        TolakDuitPlayer(playerid, 100000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Jester!!Duit Anda Ditolak Sebanyak RM100000");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Jester", GetRPName(playerid)); 
                        SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
            }
        }
    }
    if(dialogid == BuyMotorcycle)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    if(PlayerInfo[playerid][pSanchez] == 0)
                    {
                        new string[248];
                        if(GetPlayerMoney(playerid) < 10000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pSanchez] = 1;
                        TolakDuitPlayer(playerid, 10000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Sanchez!!Duit Anda Ditolak Sebanyak RM10k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Sanchez", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 1:
                {
                    if(PlayerInfo[playerid][pBF400] == 0)
                    {
                        new string[248];
                        if(GetPlayerMoney(playerid) < 30000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pBF400] = 1;
                        TolakDuitPlayer(playerid, 30000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli BF-400!!Duit Anda Ditolak Sebanyak RM30k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama BF-400", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 2:
                {
                    if(PlayerInfo[playerid][pNRG500] == 0)
                    {
                        new string[248];
                        if(GetPlayerMoney(playerid) < 50000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pNRG500] = 1;
                        TolakDuitPlayer(playerid, 50000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli NRG-500!!Duit Anda Ditolak Sebanyak RM50k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama NRG-500", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Kenderaan Tersebut!");
                }
                case 3:
                {
                    if(PlayerInfo[playerid][pFreeway] == 0)
                    {
                        new string[250];
                        if(GetPlayerMoney(playerid)< 10000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pFreeway] = 1;
                        TolakDuitPlayer(playerid, 70000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Freeway!!Duit Anda Ditolak Sebanyak RM10k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Freeway", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                }
                case 4:
                {
                    if(PlayerInfo[playerid][pFcr] == 0)
                    {
                        new string[250];
                        if(GetPlayerMoney(playerid)< 10000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        PlayerInfo[playerid][pFcr] = 1;
                        TolakDuitPlayer(playerid, 70000);
                        SendClientMessage(playerid, -1,"{14a5ff}[INFO CARDEALER]: {FFFFFF}Anda Telah Membeli Fcr!!Duit Anda Ditolak Sebanyak RM10k");
                        format(string, sizeof(string), "{14a5ff}[INFO CARDEALER]: {FFFFFF}%s Telah Membeli Kenderaan Bernama Fcr", GetRPName(playerid)); SendClientMessageToAll(-1, string);
                    }
                }
            }
        }
    }
    if(dialogid == ListPrice)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    new str[348];
                    strcat(str, ""COL_OREN"FLASH"COL_WHITE" - RM50K\n");
                    strcat(str, ""COL_OREN"ELEGY"COL_WHITE" - RM100K\n");
                    strcat(str, ""COL_OREN"SULTAN"COL_WHITE" - RM300K\n");
                    strcat(str, ""COL_OREN"SUPER GT"COL_WHITE" - RM500K\n");
                    strcat(str, ""COL_OREN"INFERNUS"COL_WHITE" - RM800K\n");
                    strcat(str, ""COL_OREN"TAMPA"COL_WHITE" - RM120000\n");
                    strcat(str, ""COL_OREN"ZR-350"COL_WHITE" - RM110000\n");
                    strcat(str, ""COL_OREN"BULLET"COL_WHITE" - RM150000\n");
                    strcat(str, ""COL_OREN"CHEETAH"COL_WHITE" - RM100000\n");
                    strcat(str, ""COL_OREN"SABER"COL_WHITE" - RM120000\n");
                    ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "Harga Kenderaan", str, "Tutup", "");
                }
                case 1:
                {
                    new str[200];
                    strcat(str, ""COL_OREN"Sanchez"COL_WHITE" - RM10K\n");
                    strcat(str, ""COL_OREN"BF-400"COL_WHITE" - RM30K\n");
                    strcat(str, ""COL_OREN"NRG-500"COL_WHITE" - RM50K\n");
                    strcat(str, ""COL_OREN"FREEWAY"COL_WHITE" - RM70K\n");
                    ShowPlayerDialog(playerid,DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "Harga Kenderaan", str, "Tutup", "");
                }
            }
        }
    }
    if(dialogid == LesenKeretaMotorDll)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    if(PlayerInfo[playerid][pLesenmotor] == 0)
                    {
                        //new Float:x, Float:y, Float:z;
                        if(GetPlayerMoney(playerid) < 1500)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        LesenMotor[playerid] = 1;
                        TolakDuitPlayer(playerid, 1500);
						SendClientMessage(playerid, -1,"SILA BAWA KENDERAAN DENGAN BERHATI-HATI");
                        //GetPlayerPos(playerid, x, y, z);
                        SetPlayerCheckpoint(playerid, 1285.5018,1285.8827,10.8203, 5.0);
                        SendClientMessage(playerid, -1, "SILA PERGI KE TMPAT LESEN DAN SPAWN KERETA ANDA DI SANA");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Lesen B!");
                }
                case 1:
                {
                    if(PlayerInfo[playerid][pLesenkereta] == 0)
                    {
                        //new Float:x, Float:y, Float:z;
                        if(GetPlayerMoney(playerid) < 2500)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        LesenKereta[playerid] = 1;
						SendClientMessage(playerid, -1,"SILA BAWA KENDERAAN DENGAN BERHATI-HATI");
						//GetPlayerPos(playerid, x, y, z);
                        TolakDuitPlayer(playerid, 2500);
                        SetPlayerCheckpoint(playerid, 1300.4434,1373.5651,10.8639, 5.0);
                        //CreateVehicleEx(playerid, 462, -1, -1);
                        SendClientMessage(playerid, -1, "SILA PERGI KE TMPAT LESEN DAN SPAWN KERETA ANDA DI SANA");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Lesen DA!");
                }
                case 2:
                {
                    if(PlayerInfo[playerid][pLesengdl] == 0)
                    {
                        if(GetPlayerMoney(playerid) < 5000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        LesenGDL[playerid] = 1;
                        GivePlayerMoney(playerid, -5000);
						SendClientMessage(playerid, -1,"SILA BAWA KENDERAAN DENGAN BERHATI-HATI");
                        SetPlayerCheckpoint(playerid, 1296.6158,1374.7207,10.8639, 5.0);
                        SendClientMessage(playerid, -1, "SILA PERGI KE TMPAT LESEN DAN SPAWN KERETA ANDA DI SANA");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Lesen GDL!");
                }
                case 3:
                {
                    if(PlayerInfo[playerid][pLesenUdara] == 0)
                    {
                        if(GetPlayerMoney(playerid) < 20000)return SendClientMessage(playerid,-1,"Duit Anda Tidak Mencukupi");
                        SendClientMessage(playerid, -1,"SABAR NGENTOD KAPAL TERBANG TAK LETAK LAGI!!");
                    }
                    else return SendClientMessage(playerid,-1,"Anda Sudah Mempunyai Lesen Udara!");
                }
            }
        }
    }
    if(dialogid == ModiItems)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0: { Paintjob(playerid); }
                case 1: { Tayar(playerid); }
                case 2: { Spoiler(playerid); }
                case 3: { Rearbumper(playerid); }
				case 4: { Frontbumper(playerid); }
                case 5: { Sideskirt(playerid); }
                case 6: { Roof(playerid); }
                case 7: { Exhaust(playerid); }
                case 8: { Nitro(playerid); }
                case 9: { Color(playerid); }
            }
        }
    }
    if(dialogid == ModiPaintJobs)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
					ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 0);
				}
				case 1:
                {
					ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 1);
				}
				case 2:
                {
					ChangeVehiclePaintjob(GetPlayerVehicleID(playerid), 2);
				}
			}
        }
    }
    if(dialogid == ModiWheels)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                	AddVehicleComponent(GetPlayerVehicleID(playerid), 1096);
				}
                case 1:
                {
				    AddVehicleComponent(GetPlayerVehicleID(playerid), 1074);
				}
				case 2:
                {
				    AddVehicleComponent(GetPlayerVehicleID(playerid), 1085);
				}
				case 3:
                {
				    AddVehicleComponent(GetPlayerVehicleID(playerid), 1073);
				}
				case 4:
                {
				    AddVehicleComponent(GetPlayerVehicleID(playerid), 1077);
				}
                case 5:
                {
				    AddVehicleComponent(GetPlayerVehicleID(playerid), 1080);
				}
			}
        }
    }
    if(dialogid == ModiSpoilers)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                	AddVehicleComponent(GetPlayerVehicleID(playerid), 1138);    //SULTAN
                	AddVehicleComponent(GetPlayerVehicleID(playerid), 1146);	//ELEGY
				}
				case 1:
				{
				    AddVehicleComponent(GetPlayerVehicleID(playerid), 1139);    //SULTAN
				    AddVehicleComponent(GetPlayerVehicleID(playerid), 1147);	//ELEGY
				}
			}
        }
    }//REARBUMPER
    if(dialogid == ModiRearbumbers)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1140);    //SULTAN
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1140);	//ELEGY
				}
				case 1:
				{
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1141);	//SULTAN
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1141);	//ELEGY
				}
			}
        }
    }
    if(dialogid == ModiFrontbumbers)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1171);	//ELEGY
				}
				case 1:
				{
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1172);	//ELEGY
				}
			}
        }
    }
    if(dialogid == ModiSideSkirts)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1030);	//SULTAN
					AddVehicleComponent(GetPlayerVehicleID(playerid), 1027);    //SULTAN
					AddVehicleComponent(GetPlayerVehicleID(playerid), 1036);    //ELEGY
					AddVehicleComponent(GetPlayerVehicleID(playerid), 1040);    //ELEGY
				}
				case 1:
				{
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1031);    //SULTAN
       			 	AddVehicleComponent(GetPlayerVehicleID(playerid), 1026);    //SULTAN
       			 	AddVehicleComponent(GetPlayerVehicleID(playerid), 1039);    //ELEGY
       			 	AddVehicleComponent(GetPlayerVehicleID(playerid), 1041);    //ELEGY
				}
			}
        }
    }
    if(dialogid == ModiRoofs)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1028);	//SULTAN
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1035);    //ELEGY
				}
				case 1:
				{
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1028);	//SULTAN
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1038);    //ELEGY
				}
			}
        }
    }
    if(dialogid == ModiExhausts)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1028);	//SULTAN
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1034);    //ELEGY
				}
				case 1:
				{
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1029);	//SULTAN
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1037);    //ELEGY
				}
			}
        }
    }
    if(dialogid == ModiNitros)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1009);
				}
				case 1:
				{
                    AddVehicleComponent(GetPlayerVehicleID(playerid), 1010);
				}
			}
        }
    }
    if(dialogid == ModiColours)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 191, 191);
                }
                case 1:
                {
                    ChangeVehicleColor(GetPlayerVehicleID(playerid), 197, 197);
                }
            }
        }
    }//SpawnVehicleGodsideRoles
    if(dialogid == SpawnVehicleBadsideRoles)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    if(PlayerInfo[playerid][pRole] == 6)
                    {
                        CreateVehicleEx(playerid, 413, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK ROLEBADSIDE SAHAJA");
                }
                case 1:
                {
                    if(PlayerInfo[playerid][pRole] == 8)
                    {
                        CreateVehicleEx(playerid, 413, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK ROLEBADSIDE SAHAJA");
                }
                case 2:
                {
                    if(PlayerInfo[playerid][pRole] == 7)
                    {
                        CreateVehicleEx(playerid, 413, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK ROLEBADSIDE SAHAJA");
                }
                case 3:
                {
                    if(PlayerInfo[playerid][pRole] == 5)
                    {
                        CreateVehicleEx(playerid, 413, -1, -1);
                    }
                    else return SendClientMessage(playerid, -1,"KENDERAAN INI HANYA UNTUK ROLEBADSIDE SAHAJA");
                }
            }
        }
    }
    if(dialogid == DIALOG_VATT)
	{
	    if(response)
	    {
			switch(listitem)
			{
    			case 0:
				{
					if (AttEnabled[playerid] == 1)
					{
					    AttEnabled[playerid] = 0;
						RemovePlayerAttachedObject(playerid, 3);
						RemovePlayerAttachedObject(playerid, 4);
					}
					else if (AttEnabled[playerid] == 0)
					{
			    		AttEnabled[playerid] = 1;
						SetPlayerAttachedObject(playerid, 3, 18693, 6, 1.417000, -0.012000, 0.991999, 0.000000, -126.299972, 0.000000, 1.000000, 1.000000, 1.000000);
						SetPlayerAttachedObject(playerid, 4, 18693, 5, 1.645999, 0.000000, -0.490999, 0.000000, -72.499969, 0.000000, 1.000000, 1.000000, 1.000000);
					}
				}
    			case 1:
				{
					if (AttEnabled[playerid] == 1)
					{
					    AttEnabled[playerid] = 0;
						RemovePlayerAttachedObject(playerid, 5);
					}
					else if (AttEnabled[playerid] == 0)
					{
			    		AttEnabled[playerid] = 1;
                    	SetPlayerAttachedObject(playerid, 5, 1550, 1, 0.081000, -0.272000, 0.000000, 0.000000, 84.900032, 156.200012, 1.000000, 1.000000, 1.000000);
					}
				}
    			case 2:
				{
					if (AttEnabled[playerid] == 1)
					{
					    AttEnabled[playerid] = 0;
						RemovePlayerAttachedObject(playerid, 6);
					}
					else if (AttEnabled[playerid] == 0)
					{
			    		AttEnabled[playerid] = 1;
						SetPlayerAttachedObject(playerid, 6, 19559, 1, 0.076999, -0.043999, 0.000000, 0.000000, 89.599983, 0.000000, 1.000000, 1.000000, 1.000000);
					}
				}
    			case 3:
				{
					if (AttEnabled[playerid] == 1)
					{
					    AttEnabled[playerid] = 0;
						RemovePlayerAttachedObject(playerid, 7);
					}
					else if (AttEnabled[playerid] == 0)
					{
			    		AttEnabled[playerid] = 1;
						SetPlayerAttachedObject(playerid, 7, 19137, 2, 0.081000, -0.004000, 0.000000, 0.000000, 0.000000, 0.000000, 1.000000, 1.000000, 1.000000);
					}
				}
    			case 4:
				{
					if (AttEnabled[playerid] == 1)
					{
					    AttEnabled[playerid] = 0;
						RemovePlayerAttachedObject(playerid, 8);
					}
					else if (AttEnabled[playerid] == 0)
					{
			    		AttEnabled[playerid] = 1;
						SetPlayerAttachedObject(playerid, 8, 19317, 1, 0.336999, -0.109000, 0.260000, 0.000000, 55.299991, 0.000000, 1.000000, 1.000000, 1.000000);
					}
				}
                case 5:
				{
					if (AttEnabled[playerid] == 1)
					{
					    AttEnabled[playerid] = 0;
						RemovePlayerAttachedObject(playerid, 0);
					}
					else if (AttEnabled[playerid] == 0)
					{
			    		AttEnabled[playerid] = 1;
						SetPlayerAttachedObject(playerid, 0, 355, 1, -0.1389, -0.1189, 0.0639, 0.0000, 38.0000, 0.0000, 1.0000, 1.0000, 1.0000, 0xFFFFFFFF, 0xFFFFFFFF);
					}
				}
			}
		}
	}
	if(dialogid == DIALOG_VFSTYLE)
	{
	    if(response)
	    {
			switch(listitem)
			{
    			case 0:
				{
					SetPlayerFightingStyle(playerid,FIGHT_STYLE_BOXING);
					SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Anda Telah Set Fighting Style Anda Ke Boxing Style");
				}
    			case 1:
				{
					SetPlayerFightingStyle(playerid,FIGHT_STYLE_KUNGFU);
					SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Anda Telah Set Fighting Style Anda Ke KungFu Style");
				}
    			case 2:
				{
					SetPlayerFightingStyle(playerid,FIGHT_STYLE_KNEEHEAD);
					SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Anda Telah Set Fighting Style Anda Ke Kneehead Style");
				}
    			case 3:
				{
					SetPlayerFightingStyle(playerid,FIGHT_STYLE_GRABKICK);
					SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Anda Telah Set Fighting Style Anda Ke Grab Kick Style");
				}
    			case 4:
				{
					SetPlayerFightingStyle(playerid,FIGHT_STYLE_ELBOW);
					SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Anda Telah Set Fighting Style Anda Ke Elbow Style");
				}
			}
		}
	}
    if(dialogid == DIALOG_EDITID)
    {
        if(response)
        {
            new string[144], file[50];
            hid = strval(inputtext);
            format(file, sizeof(file), "Houses/%d.ini", hid);
            if(!fexist(file)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}This house doesn't exist in data-base.");
            format(string, sizeof(string), "{FF0000}[EDIT-MODE]: {FFFFFF}Currently editing house: {FF0000}%d.", strval(inputtext));
            SendClientMessage(playerid, -1, string);
            ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
        }
        else
        {
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}You don't edit house now.");
        }
    }
    if(dialogid == DIALOG_EDIT)
    {
        if(response)
        {
            if(listitem == 0)
            {
                ShowPlayerDialog(playerid, DIALOG_EDITPRICE, DIALOG_STYLE_INPUT, "Edit Price", "{FFFFFF}Please, input below new house's Harga:", "Continue", "Back");
            }
            if(listitem == 1)
            {
                ShowPlayerDialog(playerid, DIALOG_EDITINTERIOR, DIALOG_STYLE_INPUT, "Edit Interior", "{FFFFFF}Please, input below house's interior:", "Continue", "Back");
            }
            if(listitem == 2)
            {
                new file[50], string[144];
                HouseInfo[hid][hOwned] = 0;
                format(file, sizeof(file), "Houses/%d.ini", hid);
                if(fexist(file))
                {
                    dini_IntSet(file, "Owned", 0);
                }
                format(string, sizeof(string), "{FF0000}[EDIT-MODE]: {FFFFFF}House setted ownable.");
                SendClientMessage(playerid, -1, string);
                ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
            }
            if(listitem == 3)
            {
                HouseInfo[hid][hLocked] = 1;
                SendClientMessage(playerid, -1, "{FF0000}[EDIT-MODE]: {FFFFFF}House locked.");
                ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
            }
            if(listitem == 4)
            {
                HouseInfo[hid][hLocked] = 0;
                SendClientMessage(playerid, -1, "{FF0000}[EDIT-MODE]: {FFFFFF}House unlocked.");
                ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
            }
            if(listitem == 5)
            {
                SetPlayerPos(playerid, HouseInfo[hid][hX], HouseInfo[hid][hY], HouseInfo[hid][hZ]);
                SendClientMessage(playerid, -1, "{FF0000}[EDIT-MODE]: {FFFFFF}Teleported to house.");
                ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
            }
            if(listitem == 6)
            {
                SetPlayerPos(playerid, HouseInfo[hid][hX], HouseInfo[hid][hY], HouseInfo[hid][hZ]);
                SetPlayerInterior(playerid, HouseInfo[hid][hInterior]);
                SendClientMessage(playerid, -1, "{FF0000}[EDIT-MODE]: {FFFFFF}Entered in house.");
            }
            if(listitem == 7)
            {
                SetPlayerPos(playerid, HouseInfo[hid][hX], HouseInfo[hid][hY], HouseInfo[hid][hZ]);
                SetPlayerInterior(playerid, 0);
                SendClientMessage(playerid, -1, "{FF0000}[EDIT-MODE]: {FFFFFF}House exited to pick-up position.");
                ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
            }
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_EDITID, DIALOG_STYLE_INPUT, "House ID", "{FFFFFF}Please, input below house ID wich you want to edit:", "Continue", "Exit");
        }
    }
    if(dialogid == DIALOG_EDITPRICE)
    {
        if(response)
        {
            new file[50], string[144];
            HouseInfo[hid][hPrice] = strval(inputtext);
            format(file, sizeof(file), "Houses/%d.ini", hid);
            if(fexist(file))
            {
                dini_IntSet(file, "Price", HouseInfo[hid][hPrice]);
            }
            format(string, sizeof(string), "{FF0000}[EDIT-MODE]: {FFFFFF}New price of house: {FF0000}%d {FFFFFF}it's {FF0000}%d.", hid, HouseInfo[hid][hPrice]);
            SendClientMessage(playerid, -1, string);
            ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
        }
    }
    if(dialogid == DIALOG_EDITINTERIOR)
    {
        if(response)
        {
            new file[50], string[144];
            HouseInfo[hid][hInterior] = strval(inputtext);
            format(file, sizeof(file), "Houses/%d.ini", hid);
            if(fexist(file))
            {
                dini_IntSet(file, "Interior", HouseInfo[hid][hInterior]);
            }
            format(string, sizeof(string), "{FF0000}[EDIT-MODE]: {FFFFFF}New interior of house: {FF0000}%d {FFFFFF}it's {FF0000}%d.", hid, HouseInfo[hid][hInterior]);
            SendClientMessage(playerid, -1, string);
            ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
        }
        else
        {
            ShowPlayerDialog(playerid, DIALOG_EDIT, DIALOG_STYLE_LIST, "Edit House:", "Edit Price\nEdit Interior\nSet Owned\nLock House\nUnlock House\nTeleport House\nEnter House\nExit House", "Select", "Back");
        }
    }
    switch(dialogid)//
    {
        case 0:
        {
            if(response)
            {
                switch(listitem)
                {
                    case 0: { PlayerInfo[playerid][pBun] += 1; GivePlayerMoney(playerid,-100); GameTextForPlayer(playerid, "~g~+1 ~w~Keropok", 5000, 1); DialogMakanan(playerid); }
                    case 1: { PlayerInfo[playerid][pBiskut] += 1; GivePlayerMoney(playerid,-300); GameTextForPlayer(playerid, "~g~+1 ~w~Roti Coklat", 5000, 1); DialogMakanan(playerid); }
                    case 2: { PlayerInfo[playerid][pMeggiCup] += 1; GivePlayerMoney(playerid,-700); GameTextForPlayer(playerid, "~g~+1 ~w~Nasi Papaya", 5000, 1); DialogMakanan(playerid); }
                    case 3: { PlayerInfo[playerid][pMineral] += 1; GivePlayerMoney(playerid,-50); GameTextForPlayer(playerid, "~g~+1 ~w~Mineral", 5000, 1); DialogMakanan(playerid); }
                    case 4: { PlayerInfo[playerid][p100Plus] += 1; GivePlayerMoney(playerid,-250); GameTextForPlayer(playerid, "~g~+1 ~w~Oren", 5000, 1); DialogMakanan(playerid); }
                    case 5: { PlayerInfo[playerid][pCoffee] += 1; GivePlayerMoney(playerid,-500); GameTextForPlayer(playerid, "~g~+1 ~w~Milo", 5000, 1); DialogMakanan(playerid); }
                }
            }
        }
    }
    if(dialogid == BANK)
    {
        if(response)
        {
            if(PlayerInfo[playerid][pAccBank] == 1)
            {
                if(listitem == 0)
                {
                    new string[600];
                    format(string,sizeof(string),"Nama : %s\nBalance Yang Tinggal : RM%d\n\n{FF0000}Sila Masukkan Jumlah Yang Mahu Disimpan.",GetRPName(playerid),PlayerInfo[playerid][pDuitBank]);
                    ShowPlayerDialog(playerid, SIMPANAN, DIALOG_STYLE_INPUT,"{00FFFF}Penyimpanan Duit Di Bank",string,"SIMPAN","TUTUP");
                }
                if(listitem == 1)
                {
                    new string[600];
                    format(string,sizeof(string),"Nama : %s\nBalance Yang Tinggal : RM%d\n\n{FF0000}Sila Masukkan Jumlah Yang Mahu Dikeluarkan.",GetRPName(playerid),PlayerInfo[playerid][pDuitBank]);
                    ShowPlayerDialog(playerid, KELUARAN, DIALOG_STYLE_INPUT,"{00FFFF}Pengeluaran Duit Di Bank",string,"KELUARKAN","TUTUP");
                }
            }
        }
        return 1;
    }
    if(dialogid == SIMPANAN)
    {
        if(response)
        {
            if(PlayerInfo[playerid][pAccBank] == 1)
            {
                if(!IsNumeric(inputtext) || strlen(inputtext) < 1) return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] {FFFFFF}Anda Perlulah Simpan Lebih Dari RM0.");
                if(strval(inputtext) > GetPlayerMoney(playerid)) return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] {FFFFFF}Duit Anda Tidak Cukup.");

                new amount = strval(inputtext),
                string[600];

                PlayerInfo[playerid][pDuitBank] += amount;
                GivePlayerMoney(playerid, - amount);
                
                format(string, sizeof string, "**BANK LOG** \n`\nNAMA : %s\nJumlah Simpanan : RM%d`",GetRPName(playerid),amount);
                DCC_SendChannelMessage(Robbank_Info, string);

                format(string, sizeof(string), "{f0fc03}[INFO BANK] {FFFFFF}Anda Telah Menyimpan Duit Sebanyak RM%d Kedalam Bank Anda.", amount);
                return SendClientMessage(playerid, COLOR_RED, string);
            }
        }
        return 1;
    }
    if(dialogid == KELUARAN)
    {
        if(response)
        {
            if(PlayerInfo[playerid][pAccBank] == 1)
            {
                new balance = PlayerInfo[playerid][pDuitBank];
                if(!IsNumeric(inputtext) || strlen(inputtext) < 1) return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] {FFFFFF}Anda Perlulah Keluarkan Lebih Dari RM0.");
                if(strval(inputtext) > balance) return SendClientMessage(playerid, COLOR_RED, "{FF0000}[ERROR] {FFFFFF}Duit Anda Tidak Mempunyai Jumlah Sebanyak Itu.");

                new amount = strval(inputtext),
                string[600];

                PlayerInfo[playerid][pDuitBank] -= amount;
                GivePlayerMoney(playerid, amount);

                format(string, sizeof string, "**BANK LOG** \nNAMA : %s\nJumlah Keluaran : RM%d`",GetRPName(playerid),amount);
                DCC_SendChannelMessage(Robbank_Info, string);

                format(string, sizeof(string), "{f0fc03}[INFO BANK] {FFFFFF}Anda Telah Mengambil Duit Sebanyak RM%d Di Dalam Bank Anda.", amount);
                return SendClientMessage(playerid, COLOR_RED, string);
            }
        }
        return 1;
    }
    if(dialogid == RB)
	{
		if(response)
		{
			if(PlayerInfo[playerid][pRole] == 1|| PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 1)
			if(listitem == 0)
			{
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                CreateRoadblock(1459,plocx,plocy,plocz-0.4,ploca);
			}
            if(PlayerInfo[playerid][pRole] == 1|| PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 1)
			if(listitem == 1)
			{
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                CreateRoadblock(978,plocx,plocy,plocz-0.3,ploca);
			}
			if(PlayerInfo[playerid][pRole] == 1|| PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pAdmin] >= 1)
			if(listitem == 2)
			{
                PlayerPlaySound(playerid, 1052, 0.0, 0.0, 0.0);
                new Float:plocx,Float:plocy,Float:plocz,Float:ploca;
                GetPlayerPos(playerid, plocx, plocy, plocz);
                GetPlayerFacingAngle(playerid,ploca);
                CreatePaku(2899,plocx,plocy,plocz-0.9,ploca);
			}
		}
	}
    if(dialogid == WAZESYSTEM)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    SetPlayerCheckpoint(playerid, 1542.5664,-1676.4053,13.5548, 7.0);//Balai Pdrm
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 1:
                {
                    SetPlayerCheckpoint(playerid, 1660.2261,-1704.6515,20.4772, 7.0);//Balai Jpj
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 2:
                {
                    SetPlayerCheckpoint(playerid, 2028.8477,-1411.5864,16.9989, 7.0);//Hospital Kkm
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 3:
                {
                    SetPlayerCheckpoint(playerid, 1288.6660, -1651.8835, 13.5469, 7.0);//Bank
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 4:
                {
                    SetPlayerCheckpoint(playerid, 1262.903808,-1242.732910,28.749244, 7.0);//Car Dealer
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 5:
                {
                    SetPlayerCheckpoint(playerid, 2793.4604,2650.4954,10.6719, 7.0);//Penjara Besar
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 6:
                {
                    SetPlayerCheckpoint(playerid, 1296.3813,-1870.4203,13.5469, 7.0);//job sweeper
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 7:
                {
                    SetPlayerCheckpoint(playerid, 1784.2490,-1908.4894,13.3924, 7.0);//job bus
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 8:
                {
                    SetPlayerCheckpoint(playerid, 1805.6050,-1695.2198,13.5435, 7.0);//JOB TRASHER
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 9:
                {
                    SetPlayerCheckpoint(playerid, 2098.0195,-1809.0858,13.5541, 7.0);//JOB PIZZA
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 10:
                {
                    SetPlayerCheckpoint(playerid, 2900.9954,-1120.6375,11.2118, 7.0);//MAMAK
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
                case 11:
                {
                    SetPlayerCheckpoint(playerid, 2819.0476,-1087.2804,30.7344, 7.0);//CITYHALL
                    SendClientMessage(playerid,-1,""COL_LBLUE"[WAZE]"COL_WHITE" Sila Pergi Ke Tanda Merah Yang Ada Di Map");
                }
            }
        }
    }
    if(dialogid == TWITTER)
    {
        if(response)
        {
            new string[500];
            new text[44], name[64];
            new Nama[MAX_PLAYER_NAME];

            if(!strlen(inputtext)) return ShowPlayerDialog(playerid, TWITTER, DIALOG_STYLE_INPUT, ""COL_WHITE"TWITTER", ""COL_WHITE"SILA TYPE MESSAGE", "HANTAR", "Tutup");

            format(text, sizeof text, "%s", inputtext);
            TextDrawSetString(ke6, text);
                    
            GetPlayerName(playerid, Nama, sizeof(Nama));
            format(name, sizeof name, "%s", Nama);
            TextDrawSetString(ke5, name);
                    
            TextDrawShowForAllo();

            SetTimer("ViolaKO", 2000, false);

            format(string, sizeof string, " :speaking_head: *[TWITTER]* \n %s: %s", GetRPName(playerid), inputtext);
            DCC_SendChannelMessage(Chat_Ingame, string);
        }
    }
    if(dialogid == SHARELOC)
    {
        if(response)
        {
            new string[128],targetid;
	        new Float:x, Float:y, Float:z;
	        if(!strlen(inputtext)) return ShowPlayerDialog(playerid, TWITTER, DIALOG_STYLE_INPUT, ""COL_WHITE"SHARELOC", ""COL_WHITE"SILA TULIS ID PLAYER", "HANTAR", "Tutup");
            if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Pemain itu tidak online ");
            GetPlayerPos(playerid, x, y, z);
            SetPlayerCheckpoint(targetid, x, y, z, 5.0);
            format(string, 128, "{6aed28}[INFO SHARELOC]{FFFFFF} Anda Telah Shareloc Location Anda Kepada %s", GetRPName(targetid));
 	        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
 	        format(string, 128, "{6aed28}[INFO SHARELOC]{FFFFFF} %s Telah Shareloc Location Kepada Anda", GetRPName(playerid));
 	        SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
        }
    }
    if(dialogid == ANNOUNCEMENT)
    {
        if(response)
        {
            new string[128];
            if(!strlen(inputtext)) return ShowPlayerDialog(playerid, ANNOUNCEMENT, DIALOG_STYLE_INPUT, ""COL_WHITE"ANNOUNCEMENT", ""COL_WHITE"SILA TYPE ANNOUNCEMENT", "HANTAR", "Tutup");

            format(string,sizeof(string),"%s",inputtext);
            TextDrawSetString(ann_2, string);

            TextDrawShowForAll(ann_1);
            TextDrawShowForAll(ann_2);
            TextDrawShowForAll(ann_3);

            SetTimerEx("Announcement", 10000,false,"i",playerid);

            PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
        }
    }
    if(dialogid == PHONE)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    ShowPlayerDialog(playerid, WAZESYSTEM, DIALOG_STYLE_LIST, ""COL_WHITE"Waze", ""COL_WHITE"Pdrm\nJpj\nKkm\nBank\nCar Dealer\nPenjara Besar\nJob Sweeper\nJob Bus\nJob Lori Sampah\nJob Pizza\nKedai Mamak\nCityHall", "Pilih", "Tutup");
                }
                case 1:
                {
                    ShowPlayerDialog(playerid, TWITTER, DIALOG_STYLE_INPUT, ""COL_WHITE"TWITTER", ""COL_WHITE"SILA TYPE MESSAGE", "HANTAR", "Tutup");
                }
                case 2:
                {
                    ShowPlayerDialog(playerid, SHARELOC, DIALOG_STYLE_INPUT, ""COL_WHITE"SHARELOC", ""COL_WHITE"SILA TULIS ID PLAYER", "HANTAR", "Tutup");
                }
            }
        }
    }
    if(dialogid == CMDADMIN)
    {
        if(response)
        {
            switch(listitem)
            {
                case 0:
                {
                    for(new v = 0; v < MAX_VEHICLES; v++) 
                    {
                        RepairVehicle(v);
                    }
                    new string[128];
                    format(string,sizeof(string),"{FF0000}[MYBOT]{FFFFFF}Admin %s Telah Membaiki Semua Kenderaan!", GetRPName(playerid));
                    return SendClientMessageToAll(-1, string);
                }
                case 1:
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
                        SendClientMessage(i, -1,"Anda Semua Telah Ditarik Oleh Admin");
                    }
                }
                case 2:
                {
                    ShowPlayerDialog(playerid, ANNOUNCEMENT, DIALOG_STYLE_INPUT, ""COL_WHITE"ANNOUNCEMENT", ""COL_WHITE"SILA TYPE ANNOUNCEMENT", "HANTAR", "Tutup");
                }
                case 3:
                {
                    new string[128];
                    for(new i = 0; i < MAX_PLAYERS; i++)
                    {
                        if(IsPlayerConnected(i))
                        {
                            SetPlayerHealth(i, 100);
                        }
                    }
                    format(string,sizeof(string),"{FF0000}[MYBOT]{FFFFFF}Admin %s Telah Heal Semua Pemain", GetRPName(playerid));
                    return SendClientMessageToAll(-1, string);
                }
                case 4:
                {
                    for(new i = 0; i < MAX_VEHICLES; i++)
                    {
                        DestroyVehicle(i);
                        DestroyVehicle(pemain[i][Vehicles]);
                        pemain[i][Vehicles] = INVALID_VEHICLE_ID;
                        SendClientMessage(i, -1,"SEMUA KERETA DI NEGARA INI SUDAH DI CLEAR KAN");
                    }
                }
            }
        }
    }
    return 1;
}

//==========function

Function:SpawnKenderaan(playerid)
{
    ShowPlayerDialog(playerid, SpawnVehicle,DIALOG_STYLE_LIST,"{33ff00}Spawn Kenderaan","Motor\nKereta\nKenderaan Percuma\nKenderaan Kerajaan\nVan Badside","Okay","Exit");
}

Function:SpawnMotor(playerid)
{
    ShowPlayerDialog(playerid, SpawnMotorsikal, DIALOG_STYLE_LIST, "{33ff00}Motor","Sanchez\nNRG500\nBF400\nFREEWAY\nFCR-900","Okay","Exit");
}

Function:SpawnKereta(playerid)
{
    ShowPlayerDialog(playerid, SpawnCars,DIALOG_STYLE_LIST,"{33ff00}Kereta","Sultan\nElegy\nSuper GT\nInfernus\nFlash\nTampa\nZr-350\nCheetah\nBullet\nSaber\nJester","Okay","Exit");
}

Function:KenderaanPercuma(playerid)
{
    ShowPlayerDialog(playerid, SpawnFreeCars,DIALOG_STYLE_LIST,"{33ff00}Kenderaan Percuma","Elegant\nFaggio","Okay","Exit");
}

Function:KenderaanKerajaan(playerid)
{
    ShowPlayerDialog(playerid, SpawnVehicleGodsideRoles, DIALOG_STYLE_LIST,"{33ff00}Kenderaan Kerajaan","Kereta Pdrm\nMotor Pdrm\nKereta HDRD\nMotor HDRD\nKereta Kkm","Okay","Exit");
}

Function:Help(playerid)
{
    ShowPlayerDialog(playerid, Helpcommand,DIALOG_STYLE_LIST,"{33ff00}All Command","General Command\nPdrm Command\nHDRD Command\n Kkm command\n FNF command\n ADMIN command","Okay","Exit");
}

Function:BeliKenderaan(playerid)
{
    ShowPlayerDialog(playerid, BuyVehicle, DIALOG_STYLE_LIST,"{33ff00}Beli Kenderaan","Kereta\nMotor","Okay","Exit");
}

Function:Kereta(playerid)
{
    ShowPlayerDialog(playerid, BuyCars, DIALOG_STYLE_LIST,"{33ff00}Beli Kereta","Flash\nElegy\nSultan\nSuper GT\nInfernus\nTampa\nZr-350\nCheetah\nBullet\nSaber\nJester","Okay","Exit");
}

Function:Motor(playerid)
{
    ShowPlayerDialog(playerid,BuyMotorcycle,DIALOG_STYLE_LIST,"{33ff00}Beli Motor","Sanchez\nBF400\nNRG500\nFREEWAY\nFCR-900","Okay","Exit");
}

Function:HargaKenderaan(playerid)
{
    ShowPlayerDialog(playerid,ListPrice,DIALOG_STYLE_LIST,"{33ff00}Harga Kenderaan","Kereta\nMotor","Okay","Exit");
}

Function:BeliLesen(playerid)
{
    ShowPlayerDialog(playerid,LesenKeretaMotorDll,DIALOG_STYLE_LIST,"{33ff00}Beli Lesen","Lesen B\nLesen DA\nLesen GDL\nLesen Udara","Okay","Exit");
}

Function:TuneKenderaan(playerid)
{
    ShowPlayerDialog(playerid,ModiItems,DIALOG_STYLE_LIST,"{33ff00}Tune Kenderaan","Paintjob\nTayar\nSpoiler\nRearbumper\nFrontbumper\nSidekirt\nRoof\nExhaust\nNitro\nColor","Okay","Exit");
}

Function:Paintjob(playerid)
{
    ShowPlayerDialog(playerid,ModiPaintJobs,DIALOG_STYLE_LIST,"{33ff00}Paintjob","Paintjob 1\nPaintjob 2\nPaintjob 3","Okay","Exit");
}

Function:Tayar(playerid)
{
    ShowPlayerDialog(playerid,ModiWheels,DIALOG_STYLE_LIST,"{33ff00}Tayar","Tayar 1\nTayar 2\nTayar 3\nTayar 4\nTayar 5\nTayar 6","Okay","Exit");
}

Function:Spoiler(playerid)
{
    ShowPlayerDialog(playerid,ModiSpoilers,DIALOG_STYLE_LIST,"{33ff00}Spoiler","Spoiler 1\nSpoiler 2","Okay","Exit");
}

Function:Rearbumper(playerid)
{
    ShowPlayerDialog(playerid,ModiRearbumbers,DIALOG_STYLE_LIST,"{33ff00}Rearbumper","Rearbumper 1\nRearbumper  2","Okay","Exit");
}

Function:Frontbumper(playerid)
{
    ShowPlayerDialog(playerid,ModiFrontbumbers,DIALOG_STYLE_LIST,"{33ff00}Frontbumper","Frontbumper 1\nFrontbumper  2","Okay","Exit");
}

Function:Sideskirt(playerid)
{
    ShowPlayerDialog(playerid,ModiSideSkirts,DIALOG_STYLE_LIST,"{33ff00}Sideskirt","Sidekirt 1\nSidekirt 2","Okay","Exit");
}

Function:Roof(playerid)
{
    ShowPlayerDialog(playerid,ModiRoofs,DIALOG_STYLE_LIST,"{33ff00}Roof","Roof 1\nRoof 2","Okay","Exit");
}

Function:Exhaust(playerid)
{
    ShowPlayerDialog(playerid,ModiExhausts,DIALOG_STYLE_LIST,"{33ff00}Exhaust","Exhaust 1\nExhaust 2","Okay","Exit");
}

Function:Nitro(playerid)
{
    ShowPlayerDialog(playerid,ModiNitros,DIALOG_STYLE_LIST,"{33ff00}Nitro","Nitro 1\nNitro 2","Okay","Exit");
}

Function:VanBadside(playerid)
{
    ShowPlayerDialog(playerid,SpawnVehicleBadsideRoles,DIALOG_STYLE_LIST,"{33ff00}Van Badside","Van Pony","Okay","Exit");
}

Function:Color(playerid)
{
    ShowPlayerDialog(playerid,ModiColours,DIALOG_STYLE_LIST,"{33ff00}Color","Color 1\nColor 2","Okay","Exit");
}

//Function:PERGERAKAN PLAYER
Function:Unfreeze(playerid)
{
   TogglePlayerControllable(playerid, true);
}

Function:StopAnim(playerid)
{
    TogglePlayerControllable(playerid, true);
    ClearAnimations(playerid);
    return 1;
}

//=================Function:GATE

Function:CloseGateWhite(playerid)
{
    MoveDynamicObject(Gatewhite, 2513.068847,1603.458251,12.559341, 5.00);
}

Function:ClosePintu7E(playerid)
{
    MoveDynamicObject(Pintu7E, 1350.450439,-1759.465087,13.653109, 5.00);
}

Function:ClosePintu7E2(playerid)
{
    MoveDynamicObject(Pintu7E2, 1354.800415,-1759.495239,13.653109, 5.00);
}

Function:CloseGateAdmin(playerid)
{
    MoveDynamicObject(gateadmin, 1251.4240, -763.0829, 94.0625, 5.00);
}

Function:CloseGatePenjaraBesar(playerid)
{
    MoveDynamicObject(GatePenjaraBesar, 2779.8250, 2665.1836, 13.8304, 5.00);
}

Function:CloseGateMasukPenjara(playerid)
{
    MoveDynamicObject(GateMasukPenjara, 2792.1033, 2708.6794, 11.2684, 5.00);
}

Function:CloseMasuk1(playerid)
{
    MoveDynamicObject(Masuk1, 2798.5227, 2698.1287, 11.4823, 5.00);
}

Function:CloseMasuk2(playerid)
{
    MoveDynamicObject(Masuk2, 2802.9612, 2698.1541, 11.4823, 5.00);
}

Function:CloseGateGym(playerid)
{
    MoveDynamicObject(GateGym, 2792.3174, 2721.1292, 11.2084, 5.00);
}

Function:CloseGateKapak(playerid)
{
    MoveDynamicObject(gateKapak, 997.3008, 1764.9008, 12.7084, 5.00);
}

Function:CloseGateMafia(playerid)
{
    MoveDynamicObject(gatemafia, 2755.7874, 1307.2389, 14.0972, 5.00);
}

Function:CloseGateYakuza1(playerid)
{
    MoveDynamicObject(gateyakuza1, 1533.7026, 663.2500, 12.4296, 5.00);
}

Function:CloseGateYakuza2(playerid)
{
    MoveDynamicObject(gateyakuza2, 1453.7075, 663.2500, 12.4296, 5.00);
}

Function:ClosePintuCD1(playerid)
{
    MoveDynamicObject(pintucd1, 937.6415, -1732.4446, 14.1958, 5.00);
}

Function:ClosePintuCD2(playerid)
{
    MoveDynamicObject(pintucd2, 937.6415, -1728.0266, 14.1958, 5.00);
}

Function:ClosePintuCD3(playerid)
{
    MoveDynamicObject(pintucd3, 937.6415, -1732.4446, 14.1958, 5.00);
}

Function:ClosePintuCD4(playerid)
{
    MoveDynamicObject(pintucd4, 937.6415, -1728.0266, 14.1958, 5.00);
}

Function:Tutuptolls(playerid)
{
    MoveDynamicObject(tolls,1708.3950, 408.9993, 30.8381, 5.00);
}

Function:Tutuptollv(playerid)
{
    MoveDynamicObject(tollv, 1692.5437, 415.9217, 30.8581, 5.00);
}

Function:TutupGateKongsi(playerid)
{
    MoveDynamicObject(gateKongsi, 1524.33130, 2778.90771, 12.61638, 5.00);
}

Function:TutupPalangBalai(playerid)
{
    MoveDynamicObject(PalangBalai, 1544.7754, -1630.9844, 13.1816, 5.00);
}

Function:OndutyPlayer(playerid)
{
	if(PlayerInfo[playerid][pDuty] == 1) 
    {
	    ResetPlayerWeapons(playerid);
        SetPlayerColor(playerid,COLOR_WHITE);
        PlayerInfo[playerid][pDuty] = 0;
        SetPlayerSkin(playerid,PlayerInfo[playerid][pSkin]);
        SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda Telah Offduty");
		return 1;
	}
	//ROLE Police
	if(PlayerInfo[playerid][pLeader] == 1 || PlayerInfo[playerid][pRole] == 1) 
    {
	    SkinLama[playerid] = GetPlayerSkin(playerid);
	    if(PlayerInfo[playerid][pLevel] == 1) { SetPlayerSkin(playerid,300); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300);}
	    if(PlayerInfo[playerid][pLevel] == 2) { SetPlayerSkin(playerid,300); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,25,100); }
	    if(PlayerInfo[playerid][pLevel] == 3) { SetPlayerSkin(playerid,300); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,25,100); GivePlayerWeapon(playerid,30,300); }
	    if(PlayerInfo[playerid][pLevel] == 4) { SetPlayerSkin(playerid,301); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,32,300); GivePlayerWeapon(playerid,30,300); }
	    if(PlayerInfo[playerid][pLevel] == 5) { SetPlayerSkin(playerid,283); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,32,300); GivePlayerWeapon(playerid,31,300); }
	    SetPlayerColor(playerid,COLOR_POLICE);
	    SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda Telah Onduty Pdrm");
	    PlayerInfo[playerid][pDuty] = 1;
	}
	//ROLE Suruhanjaya
	if(PlayerInfo[playerid][pLeader] == 2 || PlayerInfo[playerid][pRole] == 2) {
	    SkinLama[playerid] = GetPlayerSkin(playerid);
	    if(PlayerInfo[playerid][pLevel] == 1) { SetPlayerSkin(playerid,282); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300);}
	    if(PlayerInfo[playerid][pLevel] == 2) { SetPlayerSkin(playerid,282); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,25,100); }
	    if(PlayerInfo[playerid][pLevel] == 3) { SetPlayerSkin(playerid,282); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,25,100); GivePlayerWeapon(playerid,30,300); }
	    if(PlayerInfo[playerid][pLevel] == 4) { SetPlayerSkin(playerid,282); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,32,300); GivePlayerWeapon(playerid,30,300); }
	    if(PlayerInfo[playerid][pLevel] == 5) { SetPlayerSkin(playerid,288); GivePlayerWeapon(playerid,3,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,32,300); GivePlayerWeapon(playerid,31,300); }
	    SetPlayerColor(playerid,COLOR_SURUHANJAYA);
	    SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda Telah Onduty HDRD");
	    PlayerInfo[playerid][pDuty] = 1;
	}
    //ROLE Medic
	if(PlayerInfo[playerid][pLeader] == 3 || PlayerInfo[playerid][pRole] == 3) {
	    SkinLama[playerid] = GetPlayerSkin(playerid);
	    if(PlayerInfo[playerid][pLevel] == 1) { SetPlayerSkin(playerid,274); }
	    if(PlayerInfo[playerid][pLevel] == 2) { SetPlayerSkin(playerid,274); }
	    if(PlayerInfo[playerid][pLevel] == 3) { SetPlayerSkin(playerid,275); }
	    if(PlayerInfo[playerid][pLevel] == 4) { SetPlayerSkin(playerid,276); }
	    if(PlayerInfo[playerid][pLevel] == 5) { SetPlayerSkin(playerid,70); }
	    SetPlayerColor(playerid,COLOR_MEDIC);
	    SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda Telah Onduty Kkm");
	    PlayerInfo[playerid][pDuty] = 1;
    }
    //ROLE Tailong
	if(PlayerInfo[playerid][pLeader] == 4 || PlayerInfo[playerid][pRole] == 4) {
	    SkinLama[playerid] = GetPlayerSkin(playerid);
	    if(PlayerInfo[playerid][pLevel] == 1) { SetPlayerSkin(playerid,50); }
	    if(PlayerInfo[playerid][pLevel] == 2) { SetPlayerSkin(playerid,50); }
	    if(PlayerInfo[playerid][pLevel] == 3) { SetPlayerSkin(playerid,50); }
	    if(PlayerInfo[playerid][pLevel] == 4) { SetPlayerSkin(playerid,50); }
	    if(PlayerInfo[playerid][pLevel] == 5) { SetPlayerSkin(playerid,50); }
	    SetPlayerColor(playerid,COLOR_TAILONG);
	    SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda Telah Onduty FNF");
	    PlayerInfo[playerid][pDuty] = 1;
 	}
    //ROLE Mafia
	if(PlayerInfo[playerid][pLeader] == 5 || PlayerInfo[playerid][pRole] == 5) {
	    SkinLama[playerid] = GetPlayerSkin(playerid);
	    if(PlayerInfo[playerid][pLevel] == 1) { SetPlayerSkin(playerid,181); GivePlayerWeapon(playerid,4,0); GivePlayerWeapon(playerid,22,300);}
	    if(PlayerInfo[playerid][pLevel] == 2) { SetPlayerSkin(playerid,73); GivePlayerWeapon(playerid,4,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,25,100); }
	    if(PlayerInfo[playerid][pLevel] == 3) { SetPlayerSkin(playerid,254); GivePlayerWeapon(playerid,4,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,25,100); GivePlayerWeapon(playerid,30,300); }
	    if(PlayerInfo[playerid][pLevel] == 4) { SetPlayerSkin(playerid,247); GivePlayerWeapon(playerid,4,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,32,300); GivePlayerWeapon(playerid,30,300); }
	    if(PlayerInfo[playerid][pLevel] == 5) { SetPlayerSkin(playerid,248); GivePlayerWeapon(playerid,4,0); GivePlayerWeapon(playerid,22,300); GivePlayerWeapon(playerid,32,300); GivePlayerWeapon(playerid,31,300); }
	    SetPlayerColor(playerid,COLOR_MAFIA);
	    SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda Telah Onduty Kongsi");
	    PlayerInfo[playerid][pDuty] = 1;
	}
	return 1;
}

//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====//=====
public OnPlayerCommandPerformed(playerid,cmdtext[],success)
{
    if(!success) return SendClientMessage(playerid,Red,"{FFFFFF}Maaf,Command Anda Salah!Sila Lihat Command Dengan Cara Taip /menu");
    return 1;
}

CMD:createhouse(playerid, params[])
{
    new Price, Level, string[144], Float:X, Float:Y, Float:Z, labelstring[144], file[50];
    GetPlayerPos(playerid, X, Y, Z);
    if(PlayerInfo[playerid][pAdmin] < 4 && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda bukan Owner/Developer");
    if(sscanf(params, "ii", Price, Level)) return SendClientMessage(playerid, -1, "{FF0000}USAGE: {FFFFFF}/CreateHouse [Price] [Level]");
    if(Price > 1000000 || Price < 1) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Invalid Price. [1 - 10,000,000]");
    if(Level > 5 || Level < 1) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Invalid Level. [1 - 5]");
    if(Level == 1)
    {
        HouseInfo[houseid][hEnterX] = 2237.590087;
        HouseInfo[houseid][hEnterY] = -1078.869995;
        HouseInfo[houseid][hEnterZ] = 1049.023437;
        HouseInfo[houseid][hInterior] = 2;
        SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}House Interior setted. {FF0000}#1.");
    }
    else if(Level == 2)
    {
        HouseInfo[houseid][hEnterX] = 2282.909912;
        HouseInfo[houseid][hEnterY] = -1137.971191;
        HouseInfo[houseid][hEnterZ] = 1050.898437;
        HouseInfo[houseid][hInterior] = 1;
        SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}House Interior setted. {FF0000}#2.");
    }
    else if(Level == 3)
    {
        HouseInfo[houseid][hEnterX] = 2282.909912;
        HouseInfo[houseid][hEnterY] = -1137.971191;
        HouseInfo[houseid][hEnterZ] = 1050.898437;
        HouseInfo[houseid][hInterior] = 11;
        SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}House Interior setted. {FF0000}#3.");
    }
    else if(Level == 4)
    {
        HouseInfo[houseid][hEnterX] = 2365.300048;
        HouseInfo[houseid][hEnterY] = -1132.920043;
        HouseInfo[houseid][hEnterZ] = 1050.875000;
        HouseInfo[houseid][hInterior] = 8;
        SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}House Interior setted. {FF0000}#4.");
    }
    else if(Level == 5)
    {
        HouseInfo[houseid][hEnterX] = 1299.079956;
        HouseInfo[houseid][hEnterY] = -795.226989;
        HouseInfo[houseid][hEnterZ] = 1084.007812;
        HouseInfo[houseid][hInterior] = 5;
        SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}House Interior setted. {FF0000}#5.");
    }
    format(string, sizeof(string), "{FF0000}[HOUSE]: {FFFFFF}ID Rumah: {FF0000}%d {FFFFFF}created.", houseid); SendClientMessage(playerid, -1, string);
    format(labelstring, sizeof(labelstring), "{15FF00}ID Rumah: {FFFFFF}%d\n{15FF00}Status: {FFFFFF}Untuk Dijual\n{15FF00}Harga: {FFFFFF}%d", houseid, Price);
    HouseInfo[houseid][hOwned] = 0;
    HouseInfo[houseid][hX] = X;
    HouseInfo[houseid][hY] = Y;
    HouseInfo[houseid][hZ] = Z;
    HouseInfo[houseid][hPrice] = Price;
    HouseInfo[houseid][hPick] = CreateDynamicPickup(1273, 1, X, Y, Z, 0);
    HouseInfo[houseid][hLabel] = Create3DTextLabel(labelstring, 0xFFFFFFFF, X, Y, Z, 30.0, 0, 0);
    HouseInfo[houseid][hMapicon] = CreateDynamicMapIcon(HouseInfo[houseid][hX], HouseInfo[houseid][hY], HouseInfo[houseid][hZ], 31, -1, -1, -1, -1, 500.0);
    format(file, sizeof(file), "Houses/%d.ini", houseid);
    if(!fexist(file))
    {
        dini_Create(file);
        dini_IntSet(file, "Price", Price);
        dini_IntSet(file, "Interior", HouseInfo[houseid][hInterior]);
        dini_IntSet(file, "Mapicon", HouseInfo[houseid][hMapicon]);
        dini_IntSet(file, "Owned", 0);
        dini_IntSet(file, "Level", Level);
        dini_IntSet(file, "Locked", HouseInfo[houseid][hLocked]);
        dini_FloatSet(file, "Position X", X);
        dini_FloatSet(file, "Position Y", Y);
        dini_FloatSet(file, "Position Z", Z);
        dini_FloatSet(file, "Enter X", HouseInfo[houseid][hEnterX]);
        dini_FloatSet(file, "Enter Y", HouseInfo[houseid][hEnterY]);
        dini_FloatSet(file, "Enter Z", HouseInfo[houseid][hEnterZ]);
    }
    houseid++;
    return 1;
}

CMD:belirumah(playerid, params[])
{
    new name[MAX_PLAYER_NAME], labelstring[144], string[144], file[50];
    GetPlayerName(playerid, name, sizeof(name));
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
        {
            if(HouseInfo[i][hOwned] == 1) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}This house have an Owner.");
            if(GetPlayerMoney(playerid) < HouseInfo[i][hPrice]) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}ANDA TIDAK MENCUKUPI DUIT.");
            DestroyPickup(HouseInfo[i][hPick]);
            //SetPlayerVirtualWorld(playerid);
            format(labelstring, sizeof(labelstring), "{15FF00}ID Rumah: {FFFFFF}%d\n{15FF00}Nama Rumah: {FFFFFF}%s\n{15FF00}Harga: {FFFFFF}%d", i, name, HouseInfo[i][hPrice]);
            HouseInfo[i][hPick] = CreateDynamicPickup(1272, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
            Update3DTextLabelText(HouseInfo[i][hLabel], 0xFFFFFFFF, labelstring);
            format(string, sizeof(string), "{FF0000}[HOUSE]: {FFFFFF}You bought ID Rumah: {FF0000}%d {FFFFFF}for {FF0000}$ %d.", i, HouseInfo[i][hPrice]);
            SendClientMessage(playerid, -1, string);
            HouseInfo[i][hOwned] = 1;
            HouseInfo[i][hOwner] = name;
            GivePlayerMoney(playerid, -HouseInfo[i][hPrice]);
            DestroyDynamicMapIcon(HouseInfo[i][hMapicon]);
            HouseInfo[i][hMapicon] = CreateDynamicMapIcon(HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 32, -1, -1, -1, -1, 100.0);
            format(file, sizeof(file), "Houses/%d.ini", i);
            if(fexist(file))
            {
                dini_IntSet(file, "Owned", 1);
                dini_Set(file, "Owner", name);
            }
        }
    }
    return 1;
}

CMD:jualrumah(playerid, params[])
{
    new pname[MAX_PLAYER_NAME], labelstring[144], string[144], file[50];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pAdmin] < 4 && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda bukan Owner/Developer");
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
        {
            if(HouseInfo[i][hOwned] == 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}You cannot sell this house.");
            if(strcmp(pname, HouseInfo[i][hOwner], true)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}You aren't Owner of this house.");
            format(labelstring, sizeof(labelstring), "{15FF00}ID Rumah: {FFFFFF}%d\n{15FF00}Status: {FFFFFF}Untuk Dijual\n{15FF00}Harga: {FFFFFF}%d", i, HouseInfo[i][hPrice]);
            DestroyPickup(HouseInfo[i][hPick]);
            HouseInfo[i][hPick] = CreateDynamicPickup(1273, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 0);
            Update3DTextLabelText(HouseInfo[i][hLabel], 0xFFFFFFFF, labelstring);
            format(string, sizeof(string), "{FF0000}[HOUSE]: {FFFFFF}You've sold your house: {FF0000}%d.", i);
            SendClientMessage(playerid, -1, string);
            HouseInfo[i][hOwned] = 0;
            HouseInfo[i][hOwner] = 0;
            GivePlayerMoney(playerid, HouseInfo[i][hPrice]);
            DestroyDynamicMapIcon(HouseInfo[i][hMapicon]);
            HouseInfo[i][hMapicon] = CreateDynamicMapIcon(HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 31, -1, -1, -1, -1, 100.0);
            format(file, sizeof(file), "Houses/%d.ini", i);
            if(fexist(file))
            {
                dini_IntSet(file, "Owned", 0);
                dini_Set(file, "Owner", " ");
            }
        }
    }
    return 1;
}

CMD:keluarrumah(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(InHouse[playerid][i] == 1)
        {
            SetPlayerPos(playerid, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
            SetPlayerInterior(playerid, 0);
            SendClientMessage(playerid, -1, "{00ffe1}[RUMAH]: {FFFFFF}Anda telah keluar dari rumah.");
            InHouse[playerid][i] = 0;
        }
    }
    return 1;
}

CMD:kuncirumah(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    if(PlayerInfo[playerid][pAdmin] < 4 && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda bukan Owner/Developer");
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
        {
            if(HouseInfo[i][hOwned] == 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Anda tidak boleh kunci rumah ini.");
            if(HouseInfo[i][hLocked] == 1) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Rumah ini telah dikunci.");
            if(strcmp(pname, HouseInfo[i][hOwner], true)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Anda bukan owner rumah ini.");
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Anda telah kunci rumah anda.");
            GameTextForPlayer(playerid, "~g~Rumah ~r~Dikunci", 5000, 3);
            HouseInfo[i][hLocked] = 1;
            new file[50];
            format(file, sizeof(file), "Houses/%d.ini", i);
            if(fexist(file))
            {

                dini_Set(file, "Locked", "1");
            }
        }
    }
    return 1;
}

CMD:bukakunci(playerid, params[])
{
    new pname[MAX_PLAYER_NAME];
    GetPlayerName(playerid, pname, sizeof(pname));
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 1.0, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]))
        {
            if(HouseInfo[i][hOwned] == 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Anda tidak boleh masuk ke rumah ini.");
            if(HouseInfo[i][hLocked] == 0) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Rumah ini tidak dikunci.");
            if(strcmp(pname, HouseInfo[i][hOwner], true)) return SendClientMessage(playerid, -1, "{FF0000}ERROR: {FFFFFF}Anda bukan owner rumah ini.");
            SendClientMessage(playerid, -1, "{FF0000}[HOUSE]: {FFFFFF}Anda telah membuka kunci rumah anda.");
            GameTextForPlayer(playerid, "~g~House ~g~Dibuka", 5000, 3);
            HouseInfo[i][hLocked] = 0;
            new file[50];
            format(file, sizeof(file), "Houses/%d.ini", i);
            if(fexist(file))
            {
                dini_Set(file, "Locked", "0");
            }
        }
    }
    return 1;
}

CMD:edithouse(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] < 4 && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_WHITE, "[MYBOT]: Anda bukan Owner/Developer");
    ShowPlayerDialog(playerid, DIALOG_EDITID, DIALOG_STYLE_INPUT, "House ID", "{FFFFFF}Please, input below house ID wich you want to edit:", "Continue", "Exit");
    return 1;
}

CMD:househelp(playerid, params[])
{
    new Dialog[512];
    strcat(Dialog, "{FFFFFF}CMD RUMAH.\n\n", sizeof(Dialog));
    strcat(Dialog, "{FFFFFF}/HouseCMDS {FFFFFF}- See this list with all commands.\n", sizeof(Dialog));
    strcat(Dialog, "{FFFFFF}/BuyHouse {FFFFFF}- Buy a house.\n", sizeof(Dialog));
    strcat(Dialog, "{FFFFFF}/SellHouse {FFFFFF}- Sell your house.\n", sizeof(Dialog));
    strcat(Dialog, "{FFFFFF}/EnterHouse {FFFFFF}- Enter in a house.\n", sizeof(Dialog));
    strcat(Dialog, "{FFFFFF}/ExitHouse {FFFFFF}- Exit from a house.\n", sizeof(Dialog));
    strcat(Dialog, "{FFFFFF}/LockHouse {FFFFFF}- Locks your house.\n", sizeof(Dialog));
    strcat(Dialog, "{FFFFFF}/UnlockHouse {FFFFFF}- Unlocks your house.\n\n", sizeof(Dialog));
    ShowPlayerDialog(playerid, DIALOG_CMDS, DIALOG_STYLE_MSGBOX, "House Commands", Dialog, "Exit", "");
    return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
    new string[500];
    if(clickedid == BAGLAPARHAUS[12]) 
    {
        if(PlayerInfo[playerid][pBun] < 1) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Tiada Keropok !");
        if(PlayerInfo[playerid][pLapar] > 99) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Sudah Kenyang !");
        PlayerInfo[playerid][pBun] -= 1; PlayerInfo[playerid][pLapar] += 5;
        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1); SetTimerEx("ClearAnimChat", 5000, false, "i", playerid); GameTextForPlayer(playerid, "~g~+Hunger 5%", 5000, 3);
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "* %s mengambil keropok dan makan.", sendername); ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        SetPlayerChatBubble(playerid, "*mengambil keropok dan makan.", 0xC2A2DAAA, 10.0, 5000);
        format(string, sizeof(string), "{ffd500}[INFO]: {ffffff}Baki Keropok dalam bag: {ffd500}%d .", PlayerInfo[playerid][pBun]); SendClientMessage(playerid, COLOR_WHITE, string);
        if(PlayerInfo[playerid][pBun] == 0) {TextDrawHideForPlayer(playerid, BAGLAPARHAUS[12]);}
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][0], PlayerInfo[playerid][pLapar]);
    }
    if(clickedid == BAGLAPARHAUS[13]) 
    {
        if(PlayerInfo[playerid][pBiskut] < 1) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Tiada Roti Coklat !");
        if(PlayerInfo[playerid][pLapar] > 99) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Sudah Kenyang !");
        PlayerInfo[playerid][pBiskut] -= 1; PlayerInfo[playerid][pLapar] += 3;
        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1); SetTimerEx("ClearAnimChat", 5000, false, "i", playerid); GameTextForPlayer(playerid, "~g~+Hunger 3%", 5000, 3);
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "* %s mengambil roti coklat dan makan.", sendername); ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        SetPlayerChatBubble(playerid, "*mengambil roti coklat dan makan.", 0xC2A2DAAA, 10.0, 5000);
        format(string, sizeof(string), "{ffd500}[INFO]: {ffffff}Baki Roti Coklat dalam bag: {ffd500}%d .", PlayerInfo[playerid][pBiskut]); SendClientMessage(playerid, COLOR_WHITE, string);
        if(PlayerInfo[playerid][pBiskut] == 0) {TextDrawHideForPlayer(playerid, BAGLAPARHAUS[13]);}
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][0], PlayerInfo[playerid][pLapar]);
    }
    if(clickedid == BAGLAPARHAUS[14]) {
        if(PlayerInfo[playerid][pMeggiCup] < 1) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Tiada Nasi papaya !");
        if(PlayerInfo[playerid][pLapar] > 99) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Sudah Kenyang !");
        PlayerInfo[playerid][pMeggiCup] -= 1; PlayerInfo[playerid][pLapar] += 15;
        ApplyAnimation(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1); SetTimerEx("ClearAnimChat", 5000, false, "i", playerid); GameTextForPlayer(playerid, "~g~+Hunger 15%", 5000, 3);
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "* %s mengambil nasi papaya dan makan.", sendername); ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        SetPlayerChatBubble(playerid, "*mengambil nasi papaya dan makan.", 0xC2A2DAAA, 10.0, 5000);
        format(string, sizeof(string), "{ffd500}[INFO]: {ffffff}Baki Nasi Papaya dalam bag: {ffd500}%d .", PlayerInfo[playerid][pMeggiCup]); SendClientMessage(playerid, COLOR_WHITE, string);
        if(PlayerInfo[playerid][pMeggiCup] == 0) {TextDrawHideForPlayer(playerid, BAGLAPARHAUS[14]);}
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][0], PlayerInfo[playerid][pLapar]);
    }
    if(clickedid == BAGLAPARHAUS[15]) {
        if(PlayerInfo[playerid][pMineral] < 1) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Tiada Mineral Water !");
        if(PlayerInfo[playerid][pHaus] > 99) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Sudah Tidak Haus !");
        PlayerInfo[playerid][pMineral] -= 1; PlayerInfo[playerid][pHaus] += 5;
        ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1); SetTimerEx("ClearAnimChat", 5000, false, "i", playerid); GameTextForPlayer(playerid, "~g~+Thirsty 5%", 5000, 3);
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "* %s mengambil mineral dan minum.", sendername); ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        SetPlayerChatBubble(playerid, "*mengambil mineral dan minum.", 0xC2A2DAAA, 10.0, 5000);
        format(string, sizeof(string), "{ffd500}[INFO]: {ffffff}Baki Mineral dalam bag: {ffd500}%d .", PlayerInfo[playerid][pMineral]); SendClientMessage(playerid, COLOR_WHITE, string);
        if(PlayerInfo[playerid][pMineral] == 0) {TextDrawHideForPlayer(playerid, BAGLAPARHAUS[15]);}
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][1], PlayerInfo[playerid][pHaus]);
    }
    if(clickedid == BAGLAPARHAUS[16]) {
        if(PlayerInfo[playerid][p100Plus] < 1) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Tiada Air Oren !");
        if(PlayerInfo[playerid][pHaus] > 99) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Sudah Tidak Haus !");
        PlayerInfo[playerid][p100Plus] -= 1; PlayerInfo[playerid][pHaus] += 10;
        ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1); SetTimerEx("ClearAnimChat", 5000, false, "i", playerid); GameTextForPlayer(playerid, "~g~+Thirsty 10%", 5000, 3);
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "* %s mengambil air oren dan minum.", sendername); ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        SetPlayerChatBubble(playerid, "*mengambil air oren dan minum.", 0xC2A2DAAA, 10.0, 5000);
        format(string, sizeof(string), "{ffd500}[INFO]: {ffffff}Baki Air Oren dalam bag: {ffd500}%d .", PlayerInfo[playerid][p100Plus]); SendClientMessage(playerid, COLOR_WHITE, string);
        if(PlayerInfo[playerid][p100Plus] == 0) {TextDrawHideForPlayer(playerid, BAGLAPARHAUS[16]);}
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][1], PlayerInfo[playerid][pHaus]);
    }
    if(clickedid == BAGLAPARHAUS[17]) {
        if(PlayerInfo[playerid][pCoffee] < 1) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Tiada Air Milo !");
        if(PlayerInfo[playerid][pHaus] > 99) return SendClientMessage(playerid, COLOR_WHITE, "{ffc800}Info: {ffffff}Anda Sudah Tidak Haus !");
        PlayerInfo[playerid][pCoffee] -= 1; PlayerInfo[playerid][pHaus] += 15;
        ApplyAnimation(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1); 
        SetTimerEx("ClearAnimChat", 5000, false, "i", playerid); 
        GameTextForPlayer(playerid, "~g~+Thirsty 15%", 5000, 3);
        GetPlayerName(playerid, sendername, sizeof(sendername));
        format(string, sizeof(string), "* %s mengambil air milo dan minum.", sendername); 
        ProxDetector(10.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
        SetPlayerChatBubble(playerid, "*mengambil air milo dan minum.", 0xC2A2DAAA, 10.0, 5000);
        format(string, sizeof(string), "{ffd500}[INFO]: {ffffff}Baki Air Milo dalam bag: {ffd500}%d .", PlayerInfo[playerid][pCoffee]); SendClientMessage(playerid, COLOR_WHITE, string);
        if(PlayerInfo[playerid][pCoffee] == 0) {TextDrawHideForPlayer(playerid, BAGLAPARHAUS[17]);}
        SetPlayerProgressBarValue(playerid, LAPARHAUSBAR[playerid][1], PlayerInfo[playerid][pHaus]);
    }
    if(clickedid == BAGLAPARHAUS[10])///CLOSE
    {
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[0]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[1]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[2]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[3]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[4]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[5]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[6]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[7]);
        //TextDrawShowForPlayer(playerid, BAGLAPARHAUS[8]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[9]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[10]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[11]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[12]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[13]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[14]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[15]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[16]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[17]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[18]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[19]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[20]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[21]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUS[22]);
        TextDrawHideForPlayer(playerid, BAGLAPARHAUSSKIN[playerid]);
        CancelSelectTextDraw(playerid);
    }
    if(clickedid == HYRP10)///CLOSE
    {
        ShowPlayerDialog(playerid, 2, DIALOG_STYLE_PASSWORD, "LOGIN", "{FFFFFF}SELAMAT DATANG!\n\n{FFFFFF}STATUS AKAUN: {FFFFFF}SUDAH DIDAFTARKAN\n\n{FFFFFF}SILA MASUKKAN KATA LALUAN UNTUK LOGIN", "Login", "Keluar");
		TextDrawHideForPlayer(playerid, HYRP1);
		TextDrawHideForPlayer(playerid, HYRP2);
		TextDrawHideForPlayer(playerid, HYRP3);
		TextDrawHideForPlayer(playerid, HYRP4);
		TextDrawHideForPlayer(playerid, HYRP5);
		TextDrawHideForPlayer(playerid, HYRP6);
		TextDrawHideForPlayer(playerid, HYRP7);
		TextDrawHideForPlayer(playerid, HYBRID8);
		TextDrawHideForPlayer(playerid, HYRP9);
		TextDrawHideForPlayer(playerid, HYRP10);
		TextDrawHideForPlayer(playerid, HYRP11);
		TextDrawHideForPlayer(playerid, HYRP12);
        TextDrawHideForPlayer(playerid, HYRP13);
		TextDrawHideForPlayer(playerid, HYRP14);
		TextDrawHideForPlayer(playerid, HYRP15);
		CancelSelectTextDraw(playerid);	
    }
    return 0;
}

//=================FUNCTION=========================================//

Function:Announcement(playerid)
{
    for(new i = 0; i < MAX_PLAYERS; i++) 
    {
        TextDrawHideForAll(ann_1);
        TextDrawHideForAll(ann_2);  
        TextDrawHideForAll(ann_3);  
    }
    return 1;
}

Function:Meter(playerid)
{
    //-------------------------TEXTDRAW-------------------------------------//
    TextDrawShowForPlayer(playerid,PublicTD[0]);
    TextDrawShowForPlayer(playerid,PublicTD[1]);
    TextDrawShowForPlayer(playerid,PublicTD[2]);
    TextDrawShowForPlayer(playerid,PublicTD[3]);
    TextDrawShowForPlayer(playerid,PublicTD[4]);
    TextDrawShowForPlayer(playerid,PublicTD[5]);
    TextDrawShowForPlayer(playerid,PublicTD[6]);
    TextDrawShowForPlayer(playerid,PublicTD[7]);
   	//--------------------------SPEEDMETER-----------------------------------//
	cWspeedo[playerid][0] = CreatePlayerTextDraw(playerid, 525.111389, 394.088836, "box");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][0], 0.000000, -0.044444);
	PlayerTextDrawTextSize(playerid, cWspeedo[playerid][0], 623.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][0], 1);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][0], -1);
	PlayerTextDrawUseBox(playerid, cWspeedo[playerid][0], 1);
	PlayerTextDrawBoxColor(playerid, cWspeedo[playerid][0], 0x000000AA);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][0], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][0], 0);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][0], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][0], 1);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][0], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][0], 0);
 
	cWspeedo[playerid][1] = CreatePlayerTextDraw(playerid, 627.777770, 365.715454, "box");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][1], 0.000000, 6.133327);
	PlayerTextDrawTextSize(playerid, cWspeedo[playerid][1], 621.000000, 0.000000);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][1], 1);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][1], -1);
	PlayerTextDrawUseBox(playerid, cWspeedo[playerid][1], 1);
	PlayerTextDrawBoxColor(playerid, cWspeedo[playerid][1], 0x000000AA);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][1], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][1], 0);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][1], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][1], 1);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][1], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][1], 0);
 
	cWspeedo[playerid][2] = CreatePlayerTextDraw(playerid, 565.889099, 341.168945, "");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][2], 0.000000, 0.000000);
	PlayerTextDrawTextSize(playerid, cWspeedo[playerid][2], 60.000000, 73.000000);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][2], 1);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][2], -1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][2], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][2], 0);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][2], 0);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][2], 5);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][2], 0);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][2], 0);
	PlayerTextDrawSetPreviewModel(playerid, cWspeedo[playerid][2], 411);
	PlayerTextDrawSetPreviewRot(playerid, cWspeedo[playerid][2], 0.000000, 0.000000, -30.000000, 1.000000);
	PlayerTextDrawSetPreviewVehCol(playerid, cWspeedo[playerid][2], 1, 1);
 
	cWspeedo[playerid][3] = CreatePlayerTextDraw(playerid, 524.222167, 395.582153, "220");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][3], 0.342222, 1.316266);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][3], 1);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][3], -1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][3], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][3], 1);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][3], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][3], 3);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][3], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][3], 0);
 
	cWspeedo[playerid][4] = CreatePlayerTextDraw(playerid, 523.777770, 382.142395, "infernus");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][4], 0.172888, 0.903111);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][4], 1);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][4], -1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][4], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][4], 1);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][4], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][4], 2);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][4], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][4], 0);
 
	cWspeedo[playerid][5] = CreatePlayerTextDraw(playerid, 526.000244, 408.026733, "~g~KM/H");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][5], 0.175555, 0.669155);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][5], 1);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][5], -1378294017);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][5], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][5], 0);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][5], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][5], 1);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][5], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][5], 0);
 
	cWspeedo[playerid][6] = CreatePlayerTextDraw(playerid, 572.933105, 396.080047, "100");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][6], 0.301333, 1.171911);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][6], 2);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][6], -1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][6], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][6], 1);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][6], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][6], 3);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][6], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][6], 0);
 
	cWspeedo[playerid][7] = CreatePlayerTextDraw(playerid, 572.509460, 407.528869, "~r~Minyak");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][7], 0.151111, 0.689067);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][7], 2);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][7], -1378294017);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][7], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][7], 0);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][7], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][7], 1);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][7], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][7], 0);
 
	cWspeedo[playerid][8] = CreatePlayerTextDraw(playerid, 621.111633, 396.080108, "999.0");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][8], 0.231555, 1.052444);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][8], 3);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][8], -1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][8], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][8], 1);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][8], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][8], 3);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][8], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][8], 0);
 
	cWspeedo[playerid][9] = CreatePlayerTextDraw(playerid, 618.444335, 406.533325, "~g~HEALTH");
	PlayerTextDrawLetterSize(playerid, cWspeedo[playerid][9], 0.145778, 0.699022);
	PlayerTextDrawAlignment(playerid, cWspeedo[playerid][9], 3);
	PlayerTextDrawColor(playerid, cWspeedo[playerid][9], -1378294017);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][9], 0);
	PlayerTextDrawSetOutline(playerid, cWspeedo[playerid][9], 0);
	PlayerTextDrawBackgroundColor(playerid, cWspeedo[playerid][9], 255);
	PlayerTextDrawFont(playerid, cWspeedo[playerid][9], 1);
	PlayerTextDrawSetProportional(playerid, cWspeedo[playerid][9], 1);
	PlayerTextDrawSetShadow(playerid, cWspeedo[playerid][9], 0);

    return 1;
}

Function:LoadMap()
{
    #include mapphybrid.inc
    
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(!IsPlayerConnected(i)) continue;
        OnPlayerConnect(i);
    }
    return 1;
}

Function:Textdraw()
{
    LAPARHAUS[0] = TextDrawCreate(554.000000, 102.000000, "_");
    TextDrawFont(LAPARHAUS[0], 1);
    TextDrawLetterSize(LAPARHAUS[0], 0.600000, 1.199981);
    TextDrawTextSize(LAPARHAUS[0], 298.500000, 105.500000);
    TextDrawSetOutline(LAPARHAUS[0], 1);
    TextDrawSetShadow(LAPARHAUS[0], 0);
    TextDrawAlignment(LAPARHAUS[0], 2);
    TextDrawColor(LAPARHAUS[0], -1);
    TextDrawBackgroundColor(LAPARHAUS[0], 255);
    TextDrawBoxColor(LAPARHAUS[0], 201);
    TextDrawUseBox(LAPARHAUS[0], 1);
    TextDrawSetProportional(LAPARHAUS[0], 1);
    TextDrawSetSelectable(LAPARHAUS[0], 0);

    LAPARHAUS[1] = TextDrawCreate(554.000000, 103.000000, "_");
    TextDrawFont(LAPARHAUS[1], 1);
    TextDrawLetterSize(LAPARHAUS[1], 0.600000, 0.999979);
    TextDrawTextSize(LAPARHAUS[1], 298.500000, 103.000000);
    TextDrawSetOutline(LAPARHAUS[1], 1);
    TextDrawSetShadow(LAPARHAUS[1], 0);
    TextDrawAlignment(LAPARHAUS[1], 2);
    TextDrawColor(LAPARHAUS[1], -1);
    TextDrawBackgroundColor(LAPARHAUS[1], 255);
    TextDrawBoxColor(LAPARHAUS[1], -1061109676);
    TextDrawUseBox(LAPARHAUS[1], 1);
    TextDrawSetProportional(LAPARHAUS[1], 1);
    TextDrawSetSelectable(LAPARHAUS[1], 0);

    LAPARHAUS[2] = TextDrawCreate(502.000000, 102.000000, "HUD:radar_burgershot");
    TextDrawFont(LAPARHAUS[2], 4);
    TextDrawLetterSize(LAPARHAUS[2], 0.600000, 2.000000);
    TextDrawTextSize(LAPARHAUS[2], 10.500000, 11.000000);
    TextDrawSetOutline(LAPARHAUS[2], 1);
    TextDrawSetShadow(LAPARHAUS[2], 0);
    TextDrawAlignment(LAPARHAUS[2], 1);
    TextDrawColor(LAPARHAUS[2], -1);
    TextDrawBackgroundColor(LAPARHAUS[2], 255);
    TextDrawBoxColor(LAPARHAUS[2], 50);
    TextDrawUseBox(LAPARHAUS[2], 1);
    TextDrawSetProportional(LAPARHAUS[2], 1);
    TextDrawSetSelectable(LAPARHAUS[2], 0);

    LAPARHAUS[3] = TextDrawCreate(594.000000, 101.000000, "HUD:radar_diner");
    TextDrawFont(LAPARHAUS[3], 4);
    TextDrawLetterSize(LAPARHAUS[3], 0.600000, 2.000000);
    TextDrawTextSize(LAPARHAUS[3], 10.500000, 11.000000);
    TextDrawSetOutline(LAPARHAUS[3], 1);
    TextDrawSetShadow(LAPARHAUS[3], 0);
    TextDrawAlignment(LAPARHAUS[3], 1);
    TextDrawColor(LAPARHAUS[3], -1);
    TextDrawBackgroundColor(LAPARHAUS[3], 255);
    TextDrawBoxColor(LAPARHAUS[3], 50);
    TextDrawUseBox(LAPARHAUS[3], 1);
    TextDrawSetProportional(LAPARHAUS[3], 1);
    TextDrawSetSelectable(LAPARHAUS[3], 0);

    LAPARHAUS[4] = TextDrawCreate(595.000000, 114.000000, "LAPARHAUS SYSTEM BY JAI");
    TextDrawFont(LAPARHAUS[4], 2);
    TextDrawLetterSize(LAPARHAUS[4], 0.145833, 0.449999);
    TextDrawTextSize(LAPARHAUS[4], 400.000000, 17.000000);
    TextDrawSetOutline(LAPARHAUS[4], 0);
    TextDrawSetShadow(LAPARHAUS[4], 0);
    TextDrawAlignment(LAPARHAUS[4], 3);
    TextDrawColor(LAPARHAUS[4], -1);
    TextDrawBackgroundColor(LAPARHAUS[4], 255);
    TextDrawBoxColor(LAPARHAUS[4], 50);
    TextDrawUseBox(LAPARHAUS[4], 0);
    TextDrawSetProportional(LAPARHAUS[4], 1);
    TextDrawSetSelectable(LAPARHAUS[4], 0);
    //==========//==========//==========//==========//==========//==========//==========
    
    BAGLAPARHAUS[0] = TextDrawCreate(351.000000, 189.000000, "_");
    TextDrawFont(BAGLAPARHAUS[0], 1);
    TextDrawLetterSize(BAGLAPARHAUS[0], 0.600000, 17.600000);
    TextDrawTextSize(BAGLAPARHAUS[0], 298.500000, 273.500000);
    TextDrawSetOutline(BAGLAPARHAUS[0], 1);
    TextDrawSetShadow(BAGLAPARHAUS[0], 0);
    TextDrawAlignment(BAGLAPARHAUS[0], 2);
    TextDrawColor(BAGLAPARHAUS[0], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[0], 255);
    TextDrawBoxColor(BAGLAPARHAUS[0], -1061109625);
    TextDrawUseBox(BAGLAPARHAUS[0], 1);
    TextDrawSetProportional(BAGLAPARHAUS[0], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[0], 0);

    BAGLAPARHAUS[1] = TextDrawCreate(351.000000, 191.000000, "_");
    TextDrawFont(BAGLAPARHAUS[1], 1);
    TextDrawLetterSize(BAGLAPARHAUS[1], 0.600000, 17.150007);
    TextDrawTextSize(BAGLAPARHAUS[1], 298.500000, 271.000000);
    TextDrawSetOutline(BAGLAPARHAUS[1], 1);
    TextDrawSetShadow(BAGLAPARHAUS[1], 0);
    TextDrawAlignment(BAGLAPARHAUS[1], 2);
    TextDrawColor(BAGLAPARHAUS[1], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[1], 255);
    TextDrawBoxColor(BAGLAPARHAUS[1], 223);
    TextDrawUseBox(BAGLAPARHAUS[1], 1);
    TextDrawSetProportional(BAGLAPARHAUS[1], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[1], 0);

    BAGLAPARHAUS[2] = TextDrawCreate(399.000000, 207.000000, "_");
    TextDrawFont(BAGLAPARHAUS[2], 1);
    TextDrawLetterSize(BAGLAPARHAUS[2], 0.600000, 13.100011);
    TextDrawTextSize(BAGLAPARHAUS[2], 298.500000, 169.000000);
    TextDrawSetOutline(BAGLAPARHAUS[2], 1);
    TextDrawSetShadow(BAGLAPARHAUS[2], 0);
    TextDrawAlignment(BAGLAPARHAUS[2], 2);
    TextDrawColor(BAGLAPARHAUS[2], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[2], 255);
    TextDrawBoxColor(BAGLAPARHAUS[2], 1296911751);
    TextDrawUseBox(BAGLAPARHAUS[2], 1);
    TextDrawSetProportional(BAGLAPARHAUS[2], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[2], 0);

    BAGLAPARHAUS[3] = TextDrawCreate(264.000000, 315.000000, "INVENTORY");
    TextDrawFont(BAGLAPARHAUS[3], 2);
    TextDrawLetterSize(BAGLAPARHAUS[3], 0.354166, 1.100000);
    TextDrawTextSize(BAGLAPARHAUS[3], 400.000000, 17.000000);
    TextDrawSetOutline(BAGLAPARHAUS[3], 1);
    TextDrawSetShadow(BAGLAPARHAUS[3], 0);
    TextDrawAlignment(BAGLAPARHAUS[3], 2);
    TextDrawColor(BAGLAPARHAUS[3], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[3], 255);
    TextDrawBoxColor(BAGLAPARHAUS[3], 50);
    TextDrawUseBox(BAGLAPARHAUS[3], 0);
    TextDrawSetProportional(BAGLAPARHAUS[3], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[3], 0);

    BAGLAPARHAUS[4] = TextDrawCreate(354.000000, 210.000000, "_");
    TextDrawFont(BAGLAPARHAUS[4], 1);
    TextDrawLetterSize(BAGLAPARHAUS[4], 0.600000, 12.700011);
    TextDrawTextSize(BAGLAPARHAUS[4], 298.500000, -1.500000);
    TextDrawSetOutline(BAGLAPARHAUS[4], 1);
    TextDrawSetShadow(BAGLAPARHAUS[4], 0);
    TextDrawAlignment(BAGLAPARHAUS[4], 2);
    TextDrawColor(BAGLAPARHAUS[4], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[4], 255);
    TextDrawBoxColor(BAGLAPARHAUS[4], 143);
    TextDrawUseBox(BAGLAPARHAUS[4], 1);
    TextDrawSetProportional(BAGLAPARHAUS[4], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[4], 0);

    BAGLAPARHAUS[5] = TextDrawCreate(399.000000, 327.000000, "_");
    TextDrawFont(BAGLAPARHAUS[5], 1);
    TextDrawLetterSize(BAGLAPARHAUS[5], 0.600000, -0.200017);
    TextDrawTextSize(BAGLAPARHAUS[5], 298.500000, -175.000000);
    TextDrawSetOutline(BAGLAPARHAUS[5], 1);
    TextDrawSetShadow(BAGLAPARHAUS[5], 0);
    TextDrawAlignment(BAGLAPARHAUS[5], 2);
    TextDrawColor(BAGLAPARHAUS[5], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[5], 255);
    TextDrawBoxColor(BAGLAPARHAUS[5], 182);
    TextDrawUseBox(BAGLAPARHAUS[5], 1);
    TextDrawSetProportional(BAGLAPARHAUS[5], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[5], 0);

    BAGLAPARHAUS[6] = TextDrawCreate(399.000000, 243.000000, "_");
    TextDrawFont(BAGLAPARHAUS[6], 1);
    TextDrawLetterSize(BAGLAPARHAUS[6], 0.600000, -0.250018);
    TextDrawTextSize(BAGLAPARHAUS[6], 298.500000, -175.000000);
    TextDrawSetOutline(BAGLAPARHAUS[6], 1);
    TextDrawSetShadow(BAGLAPARHAUS[6], 0);
    TextDrawAlignment(BAGLAPARHAUS[6], 2);
    TextDrawColor(BAGLAPARHAUS[6], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[6], 255);
    TextDrawBoxColor(BAGLAPARHAUS[6], 170);
    TextDrawUseBox(BAGLAPARHAUS[6], 1);
    TextDrawSetProportional(BAGLAPARHAUS[6], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[6], 0);

    BAGLAPARHAUS[7] = TextDrawCreate(351.000000, 198.000000, "_");
    TextDrawFont(BAGLAPARHAUS[7], 1);
    TextDrawLetterSize(BAGLAPARHAUS[7], 0.600000, -0.100020);
    TextDrawTextSize(BAGLAPARHAUS[7], 298.500000, 255.500000);
    TextDrawSetOutline(BAGLAPARHAUS[7], 1);
    TextDrawSetShadow(BAGLAPARHAUS[7], 0);
    TextDrawAlignment(BAGLAPARHAUS[7], 2);
    TextDrawColor(BAGLAPARHAUS[7], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[7], 255);
    TextDrawBoxColor(BAGLAPARHAUS[7], 1296911687);
    TextDrawUseBox(BAGLAPARHAUS[7], 1);
    TextDrawSetProportional(BAGLAPARHAUS[7], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[7], 0);

    BAGLAPARHAUS[8] = TextDrawCreate(218.000000, 192.000000, "HYRP");
    TextDrawFont(BAGLAPARHAUS[8], 2);
    TextDrawLetterSize(BAGLAPARHAUS[8], 0.245831, 0.800000);
    TextDrawTextSize(BAGLAPARHAUS[8], 400.000000, 17.000000);
    TextDrawSetOutline(BAGLAPARHAUS[8], 1);
    TextDrawSetShadow(BAGLAPARHAUS[8], 0);
    TextDrawAlignment(BAGLAPARHAUS[8], 1);
    TextDrawColor(BAGLAPARHAUS[8], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[8], 255);
    TextDrawBoxColor(BAGLAPARHAUS[8], 50);
    TextDrawUseBox(BAGLAPARHAUS[8], 0);
    TextDrawSetProportional(BAGLAPARHAUS[8], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[8], 0);

    BAGLAPARHAUS[9] = TextDrawCreate(213.000000, 194.000000, "Preview_Model");
    TextDrawFont(BAGLAPARHAUS[9], 5);
    TextDrawLetterSize(BAGLAPARHAUS[9], 0.600000, 2.000000);
    TextDrawTextSize(BAGLAPARHAUS[9], 104.500000, 115.500000);
    TextDrawSetOutline(BAGLAPARHAUS[9], 0);
    TextDrawSetShadow(BAGLAPARHAUS[9], 0);
    TextDrawAlignment(BAGLAPARHAUS[9], 1);
    TextDrawColor(BAGLAPARHAUS[9], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[9], 0);
    TextDrawBoxColor(BAGLAPARHAUS[9], 255);
    TextDrawUseBox(BAGLAPARHAUS[9], 0);
    TextDrawSetProportional(BAGLAPARHAUS[9], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[9], 0);
    TextDrawSetPreviewModel(BAGLAPARHAUS[9], 0);
    TextDrawSetPreviewRot(BAGLAPARHAUS[9], -10.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(BAGLAPARHAUS[9], 1, 1);

    BAGLAPARHAUS[10] = TextDrawCreate(240.000000, 331.000000, "CLOSE");
    TextDrawFont(BAGLAPARHAUS[10], 2);
    TextDrawLetterSize(BAGLAPARHAUS[10], 0.233333, 1.100000);
    TextDrawTextSize(BAGLAPARHAUS[10], 16.500000, 39.000000);
    TextDrawSetOutline(BAGLAPARHAUS[10], 1);
    TextDrawSetShadow(BAGLAPARHAUS[10], 0);
    TextDrawAlignment(BAGLAPARHAUS[10], 2);
    TextDrawColor(BAGLAPARHAUS[10], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[10], 255);
    TextDrawBoxColor(BAGLAPARHAUS[10], 1296911816);
    TextDrawUseBox(BAGLAPARHAUS[10], 1);
    TextDrawSetProportional(BAGLAPARHAUS[10], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[10], 1);

    BAGLAPARHAUS[11] = TextDrawCreate(287.000000, 331.000000, "-");
    TextDrawFont(BAGLAPARHAUS[11], 2);
    TextDrawLetterSize(BAGLAPARHAUS[11], 0.233333, 1.100000);
    TextDrawTextSize(BAGLAPARHAUS[11], 16.500000, 39.000000);
    TextDrawSetOutline(BAGLAPARHAUS[11], 1);
    TextDrawSetShadow(BAGLAPARHAUS[11], 0);
    TextDrawAlignment(BAGLAPARHAUS[11], 2);
    TextDrawColor(BAGLAPARHAUS[11], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[11], 255);
    TextDrawBoxColor(BAGLAPARHAUS[11], 1296911816);
    TextDrawUseBox(BAGLAPARHAUS[11], 1);
    TextDrawSetProportional(BAGLAPARHAUS[11], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[11], 1);

    BAGLAPARHAUS[12] = TextDrawCreate(318.000000, 208.000000, "Preview_Model");
    TextDrawFont(BAGLAPARHAUS[12], 5);
    TextDrawLetterSize(BAGLAPARHAUS[12], 0.600000, 2.000000);
    TextDrawTextSize(BAGLAPARHAUS[12], 32.000000, 29.000000);
    TextDrawSetOutline(BAGLAPARHAUS[12], 0);
    TextDrawSetShadow(BAGLAPARHAUS[12], 0);
    TextDrawAlignment(BAGLAPARHAUS[12], 1);
    TextDrawColor(BAGLAPARHAUS[12], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[12], 0);
    TextDrawBoxColor(BAGLAPARHAUS[12], 255);
    TextDrawUseBox(BAGLAPARHAUS[12], 0);
    TextDrawSetProportional(BAGLAPARHAUS[12], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[12], 1);
    TextDrawSetPreviewModel(BAGLAPARHAUS[12], 19883);
    TextDrawSetPreviewRot(BAGLAPARHAUS[12], -34.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(BAGLAPARHAUS[12], 1, 1);

    BAGLAPARHAUS[13] = TextDrawCreate(359.000000, 208.000000, "Preview_Model");
    TextDrawFont(BAGLAPARHAUS[13], 5);
    TextDrawLetterSize(BAGLAPARHAUS[13], 0.600000, 2.000000);
    TextDrawTextSize(BAGLAPARHAUS[13], 32.000000, 29.500000);
    TextDrawSetOutline(BAGLAPARHAUS[13], 0);
    TextDrawSetShadow(BAGLAPARHAUS[13], 0);
    TextDrawAlignment(BAGLAPARHAUS[13], 1);
    TextDrawColor(BAGLAPARHAUS[13], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[13], 0);
    TextDrawBoxColor(BAGLAPARHAUS[13], 255);
    TextDrawUseBox(BAGLAPARHAUS[13], 0);
    TextDrawSetProportional(BAGLAPARHAUS[13], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[13], 1);
    TextDrawSetPreviewModel(BAGLAPARHAUS[13], 2821);
    TextDrawSetPreviewRot(BAGLAPARHAUS[13], -10.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(BAGLAPARHAUS[13], 1, 1);

    BAGLAPARHAUS[14] = TextDrawCreate(400.000000, 209.000000, "Preview_Model");
    TextDrawFont(BAGLAPARHAUS[14], 5);
    TextDrawLetterSize(BAGLAPARHAUS[14], 0.600000, 2.000000);
    TextDrawTextSize(BAGLAPARHAUS[14], 34.000000, 28.500000);
    TextDrawSetOutline(BAGLAPARHAUS[14], 0);
    TextDrawSetShadow(BAGLAPARHAUS[14], 0);
    TextDrawAlignment(BAGLAPARHAUS[14], 1);
    TextDrawColor(BAGLAPARHAUS[14], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[14], 0);
    TextDrawBoxColor(BAGLAPARHAUS[14], 217);
    TextDrawUseBox(BAGLAPARHAUS[14], 0);
    TextDrawSetProportional(BAGLAPARHAUS[14], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[14], 1);
    TextDrawSetPreviewModel(BAGLAPARHAUS[14], 2647);
    TextDrawSetPreviewRot(BAGLAPARHAUS[14], -10.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(BAGLAPARHAUS[14], 1, 1);

    BAGLAPARHAUS[15] = TextDrawCreate(443.000000, 209.000000, "Preview_Model");
    TextDrawFont(BAGLAPARHAUS[15], 5);
    TextDrawLetterSize(BAGLAPARHAUS[15], 0.600000, 2.000000);
    TextDrawTextSize(BAGLAPARHAUS[15], 36.000000, 29.000000);
    TextDrawSetOutline(BAGLAPARHAUS[15], 0);
    TextDrawSetShadow(BAGLAPARHAUS[15], 0);
    TextDrawAlignment(BAGLAPARHAUS[15], 1);
    TextDrawColor(BAGLAPARHAUS[15], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[15], 0);
    TextDrawBoxColor(BAGLAPARHAUS[15], 235);
    TextDrawUseBox(BAGLAPARHAUS[15], 0);
    TextDrawSetProportional(BAGLAPARHAUS[15], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[15], 1);
    TextDrawSetPreviewModel(BAGLAPARHAUS[15], 19570);
    TextDrawSetPreviewRot(BAGLAPARHAUS[15], -10.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(BAGLAPARHAUS[15], 1, 1);

    BAGLAPARHAUS[16] = TextDrawCreate(318.000000, 247.000000, "Preview_Model");
    TextDrawFont(BAGLAPARHAUS[16], 5);
    TextDrawLetterSize(BAGLAPARHAUS[16], 0.600000, 2.000000);
    TextDrawTextSize(BAGLAPARHAUS[16], 32.000000, 33.500000);
    TextDrawSetOutline(BAGLAPARHAUS[16], 0);
    TextDrawSetShadow(BAGLAPARHAUS[16], 0);
    TextDrawAlignment(BAGLAPARHAUS[16], 1);
    TextDrawColor(BAGLAPARHAUS[16], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[16], 0);
    TextDrawBoxColor(BAGLAPARHAUS[16], 255);
    TextDrawUseBox(BAGLAPARHAUS[16], 0);
    TextDrawSetProportional(BAGLAPARHAUS[16], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[16], 1);
    TextDrawSetPreviewModel(BAGLAPARHAUS[16], 19821);
    TextDrawSetPreviewRot(BAGLAPARHAUS[16], -10.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(BAGLAPARHAUS[16], 1, 1);

    BAGLAPARHAUS[17] = TextDrawCreate(358.000000, 248.000000, "Preview_Model");
    TextDrawFont(BAGLAPARHAUS[17], 5);
    TextDrawLetterSize(BAGLAPARHAUS[17], 0.600000, 2.000000);
    TextDrawTextSize(BAGLAPARHAUS[17], 33.000000, 33.000000);
    TextDrawSetOutline(BAGLAPARHAUS[17], 0);
    TextDrawSetShadow(BAGLAPARHAUS[17], 0);
    TextDrawAlignment(BAGLAPARHAUS[17], 1);
    TextDrawColor(BAGLAPARHAUS[17], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[17], 0);
    TextDrawBoxColor(BAGLAPARHAUS[17], 255);
    TextDrawUseBox(BAGLAPARHAUS[17], 0);
    TextDrawSetProportional(BAGLAPARHAUS[17], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[17], 1);
    TextDrawSetPreviewModel(BAGLAPARHAUS[17], 19835);
    TextDrawSetPreviewRot(BAGLAPARHAUS[17], -10.000000, 0.000000, -20.000000, 1.000000);
    TextDrawSetPreviewVehCol(BAGLAPARHAUS[17], 1, 1);

    BAGLAPARHAUS[18] = TextDrawCreate(395.000000, 210.000000, "_");
    TextDrawFont(BAGLAPARHAUS[18], 1);
    TextDrawLetterSize(BAGLAPARHAUS[18], 0.600000, 12.600010);
    TextDrawTextSize(BAGLAPARHAUS[18], 298.500000, -1.500000);
    TextDrawSetOutline(BAGLAPARHAUS[18], 1);
    TextDrawSetShadow(BAGLAPARHAUS[18], 0);
    TextDrawAlignment(BAGLAPARHAUS[18], 2);
    TextDrawColor(BAGLAPARHAUS[18], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[18], 255);
    TextDrawBoxColor(BAGLAPARHAUS[18], 143);
    TextDrawUseBox(BAGLAPARHAUS[18], 1);
    TextDrawSetProportional(BAGLAPARHAUS[18], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[18], 0);

    BAGLAPARHAUS[19] = TextDrawCreate(438.000000, 210.000000, "_");
    TextDrawFont(BAGLAPARHAUS[19], 1);
    TextDrawLetterSize(BAGLAPARHAUS[19], 0.600000, 12.750011);
    TextDrawTextSize(BAGLAPARHAUS[19], 298.500000, -1.500000);
    TextDrawSetOutline(BAGLAPARHAUS[19], 1);
    TextDrawSetShadow(BAGLAPARHAUS[19], 0);
    TextDrawAlignment(BAGLAPARHAUS[19], 2);
    TextDrawColor(BAGLAPARHAUS[19], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[19], 255);
    TextDrawBoxColor(BAGLAPARHAUS[19], 143);
    TextDrawUseBox(BAGLAPARHAUS[19], 1);
    TextDrawSetProportional(BAGLAPARHAUS[19], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[19], 0);

    BAGLAPARHAUS[20] = TextDrawCreate(399.000000, 287.000000, "_");
    TextDrawFont(BAGLAPARHAUS[20], 1);
    TextDrawLetterSize(BAGLAPARHAUS[20], 0.600000, -0.200018);
    TextDrawTextSize(BAGLAPARHAUS[20], 298.500000, -175.000000);
    TextDrawSetOutline(BAGLAPARHAUS[20], 1);
    TextDrawSetShadow(BAGLAPARHAUS[20], 0);
    TextDrawAlignment(BAGLAPARHAUS[20], 2);
    TextDrawColor(BAGLAPARHAUS[20], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[20], 255);
    TextDrawBoxColor(BAGLAPARHAUS[20], 170);
    TextDrawUseBox(BAGLAPARHAUS[20], 1);
    TextDrawSetProportional(BAGLAPARHAUS[20], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[20], 0);

    BAGLAPARHAUS[21] = TextDrawCreate(399.000000, 332.000000, "_");
    TextDrawFont(BAGLAPARHAUS[21], 1);
    TextDrawLetterSize(BAGLAPARHAUS[21], 0.600000, -0.100020);
    TextDrawTextSize(BAGLAPARHAUS[21], 298.500000, 168.000000);
    TextDrawSetOutline(BAGLAPARHAUS[21], 1);
    TextDrawSetShadow(BAGLAPARHAUS[21], 0);
    TextDrawAlignment(BAGLAPARHAUS[21], 2);
    TextDrawColor(BAGLAPARHAUS[21], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[21], 255);
    TextDrawBoxColor(BAGLAPARHAUS[21], 1296911687);
    TextDrawUseBox(BAGLAPARHAUS[21], 1);
    TextDrawSetProportional(BAGLAPARHAUS[21], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[21], 0);

    BAGLAPARHAUS[22] = TextDrawCreate(399.000000, 340.000000, "_");
    TextDrawFont(BAGLAPARHAUS[22], 1);
    TextDrawLetterSize(BAGLAPARHAUS[22], 0.600000, -0.100020);
    TextDrawTextSize(BAGLAPARHAUS[22], 298.500000, 168.000000);
    TextDrawSetOutline(BAGLAPARHAUS[22], 1);
    TextDrawSetShadow(BAGLAPARHAUS[22], 0);
    TextDrawAlignment(BAGLAPARHAUS[22], 2);
    TextDrawColor(BAGLAPARHAUS[22], -1);
    TextDrawBackgroundColor(BAGLAPARHAUS[22], 255);
    TextDrawBoxColor(BAGLAPARHAUS[22], 1296911687);
    TextDrawUseBox(BAGLAPARHAUS[22], 1);
    TextDrawSetProportional(BAGLAPARHAUS[22], 1);
    TextDrawSetSelectable(BAGLAPARHAUS[22], 0);
    
    for(new i = 0; i < MAX_PLAYERS; i++)//playertd
    {
        BAGLAPARHAUSSKIN[i] = TextDrawCreate(213.000000, 194.000000, "Preview_Model");
        TextDrawFont(BAGLAPARHAUSSKIN[i], 5);
        TextDrawLetterSize(BAGLAPARHAUSSKIN[i], 0.600000, 2.000000);
        TextDrawTextSize(BAGLAPARHAUSSKIN[i], 104.500000, 115.500000);
        TextDrawSetOutline(BAGLAPARHAUSSKIN[i], 0);
        TextDrawSetShadow(BAGLAPARHAUSSKIN[i], 0);
        TextDrawAlignment(BAGLAPARHAUSSKIN[i], 1);
        TextDrawColor(BAGLAPARHAUSSKIN[i], -1);
        TextDrawBackgroundColor(BAGLAPARHAUSSKIN[i], 0);
        TextDrawBoxColor(BAGLAPARHAUSSKIN[i], 255);
        TextDrawUseBox(BAGLAPARHAUSSKIN[i], 0);
        TextDrawSetProportional(BAGLAPARHAUSSKIN[i], 1);
        TextDrawSetSelectable(BAGLAPARHAUSSKIN[i], 0);
        TextDrawSetPreviewModel(BAGLAPARHAUSSKIN[i], 0);
        TextDrawSetPreviewRot(BAGLAPARHAUSSKIN[i], -10.000000, 0.000000, -20.000000, 1.000000);
        TextDrawSetPreviewVehCol(BAGLAPARHAUSSKIN[i], 1, 1);
    }

    TextDate = TextDrawCreate(25.777742, 421.119964,"--");
    TextDrawBackgroundColor(TextDate, 255);
    TextDrawFont(TextDate, 3);
    TextDrawLetterSize(TextDate, 0.36000, 1.400000);
    TextDrawSetOutline(TextDate, 1);
    TextDrawSetProportional(TextDate, 1);
    TextDrawSetShadow(TextDate, 1);
    TextDrawColor(TextDate,0xFFFFFFFF);

    TextTime = TextDrawCreate(547.5, 25.33,"--");
    TextDrawLetterSize(TextTime,0.270833, 1.150000);
    TextDrawFont(TextTime , 3);
    TextDrawTextSize(TextTime, 796.500000, 847.000000);
    TextDrawSetOutline(TextTime , 1);
    TextDrawAlignment(TextTime, 3);
    TextDrawSetProportional(TextTime , 1);
    TextDrawBackgroundColor(TextTime, 255);
    TextDrawSetShadow(TextTime, 1);
    TextDrawColor(TextTime,0xFFFFFFFF);

    //TWITTER
    ke1 = TextDrawCreate(242.000000, 293.000000, "_");
    TextDrawFont(ke1, 1);
    TextDrawLetterSize(ke1, 0.600000, 10.750003);
    TextDrawTextSize(ke1, 298.500000, 190.000000);
    TextDrawSetOutline(ke1, 1);
    TextDrawSetShadow(ke1, 0);
    TextDrawAlignment(ke1, 2);
    TextDrawColor(ke1, -1);
    TextDrawBackgroundColor(ke1, 255);
    TextDrawBoxColor(ke1, 16777095);
    TextDrawUseBox(ke1, 1);
    TextDrawSetProportional(ke1, 1);
    TextDrawSetSelectable(ke1, 0);

    ke2 = TextDrawCreate(243.000000, 300.000000, "_");
    TextDrawFont(ke2, 1);
    TextDrawLetterSize(ke2, 0.600000, 9.299999);
    TextDrawTextSize(ke2, 298.500000, 181.000000);
    TextDrawSetOutline(ke2, 1);
    TextDrawSetShadow(ke2, 0);
    TextDrawAlignment(ke2, 2);
    TextDrawColor(ke2, -1);
    TextDrawBackgroundColor(ke2, 255);
    TextDrawBoxColor(ke2, 1097458120);
    TextDrawUseBox(ke2, 1);
    TextDrawSetProportional(ke2, 1);
    TextDrawSetSelectable(ke2, 0);

    ke3 = TextDrawCreate(242.000000, 304.000000, "_");
    TextDrawFont(ke3, 1);
    TextDrawLetterSize(ke3, 0.600000, 1.400006);
    TextDrawTextSize(ke3, 298.500000, 166.500000);
    TextDrawSetOutline(ke3, 1);
    TextDrawSetShadow(ke3, 0);
    TextDrawAlignment(ke3, 2);
    TextDrawColor(ke3, -1);
    TextDrawBackgroundColor(ke3, 255);
    TextDrawBoxColor(ke3, 16777095);
    TextDrawUseBox(ke3, 1);
    TextDrawSetProportional(ke3, 1);
    TextDrawSetSelectable(ke3, 0);

    ke4 = TextDrawCreate(243.000000, 300.000000, "twitter");
    TextDrawFont(ke4, 1);
    TextDrawLetterSize(ke4, 0.600000, 1.899999);
    TextDrawTextSize(ke4, 400.000000, 72.500000);
    TextDrawSetOutline(ke4, 1);
    TextDrawSetShadow(ke4, 0);
    TextDrawAlignment(ke4, 2);
    TextDrawColor(ke4, -1);
    TextDrawBackgroundColor(ke4, 255);
    TextDrawBoxColor(ke4, 50);
    TextDrawUseBox(ke4, 0);
    TextDrawSetProportional(ke4, 1);
    TextDrawSetSelectable(ke4, 0);

    ke5 = TextDrawCreate(242.000000, 321.000000, "NAMA");
    TextDrawFont(ke5, 1);
    TextDrawLetterSize(ke5, 0.600000, 1.150000);
    TextDrawTextSize(ke5, 400.000000, 168.000000);
    TextDrawSetOutline(ke5, 1);
    TextDrawSetShadow(ke5, 0);
    TextDrawAlignment(ke5, 2);
    TextDrawColor(ke5, -1);
    TextDrawBackgroundColor(ke5, 255);
    TextDrawBoxColor(ke5, 50);
    TextDrawUseBox(ke5, 0);
    TextDrawSetProportional(ke5, 1);
    TextDrawSetSelectable(ke5, 0);

    ke6 = TextDrawCreate(240.000000, 334.000000, "TEXT");
    TextDrawFont(ke6, 1);
    TextDrawLetterSize(ke6, 0.600000, 1.400000);
    TextDrawTextSize(ke6, 400.000000, 152.000000);
    TextDrawSetOutline(ke6, 0);
    TextDrawSetShadow(ke6, 0);
    TextDrawAlignment(ke6, 2);
    TextDrawColor(ke6, -1);
    TextDrawBackgroundColor(ke6, 255);
    TextDrawBoxColor(ke6, 50);
    TextDrawUseBox(ke6, 0);
    TextDrawSetProportional(ke6, 1);
    TextDrawSetSelectable(ke6, 0);

    ann_1 = TextDrawCreate(315.000000, 154.000000, "!!ANNOUNCEMENT!!");
    TextDrawFont(ann_1, 1);
    TextDrawLetterSize(ann_1, 0.737496, 2.799998);
    TextDrawTextSize(ann_1, 438.500000, 190.500000);
    TextDrawSetOutline(ann_1, 0);
    TextDrawSetShadow(ann_1, 2);
    TextDrawAlignment(ann_1, 2);
    TextDrawColor(ann_1, -16776961);
    TextDrawBackgroundColor(ann_1, 255);
    TextDrawBoxColor(ann_1, 16711730);
    TextDrawUseBox(ann_1, 0);
    TextDrawSetProportional(ann_1, 1);
    TextDrawSetSelectable(ann_1, 0);

    ann_2 = TextDrawCreate(312.000000, 199.000000, "text");
    TextDrawFont(ann_2, 1);
    TextDrawLetterSize(ann_2, 0.779165, 3.399996);
    TextDrawTextSize(ann_2, 400.000000, 597.000000);
    TextDrawSetOutline(ann_2, 1);
    TextDrawSetShadow(ann_2, 0);
    TextDrawAlignment(ann_2, 2);
    TextDrawColor(ann_2, -1);
    TextDrawBackgroundColor(ann_2, 255);
    TextDrawBoxColor(ann_2, 50);
    TextDrawUseBox(ann_2, 0);
    TextDrawSetProportional(ann_2, 1);
    TextDrawSetSelectable(ann_2, 0);

    ann_3 = TextDrawCreate(314.000000, 134.000000, "_");
    TextDrawFont(ann_3, 1);
    TextDrawLetterSize(ann_3, 0.600000, 16.300003);
    TextDrawTextSize(ann_3, 298.500000, 655.000000);
    TextDrawSetOutline(ann_3, 1);
    TextDrawSetShadow(ann_3, 0);
    TextDrawAlignment(ann_3, 2);
    TextDrawColor(ann_3, -1);
    TextDrawBackgroundColor(ann_3, 255);
    TextDrawBoxColor(ann_3, 169);
    TextDrawUseBox(ann_3, 1);
    TextDrawSetProportional(ann_3, 1);
    TextDrawSetSelectable(ann_3, 0);

    //=====================TEXTDRAW LOGIN======================//
    HYRP1 = TextDrawCreate(307.000000, 145.000000, "_");
    TextDrawFont(HYRP1, 1);
    TextDrawLetterSize(HYRP1, 0.600000, 15.700012);
    TextDrawTextSize(HYRP1, 298.500000, 316.500000);
    TextDrawSetOutline(HYRP1, 1);
    TextDrawSetShadow(HYRP1, 0);
    TextDrawAlignment(HYRP1, 2);
    TextDrawColor(HYRP1, -1);
    TextDrawBackgroundColor(HYRP1, 255);
    TextDrawBoxColor(HYRP1, -16776961);
    TextDrawUseBox(HYRP1, 1);
    TextDrawSetProportional(HYRP1, 1);
    TextDrawSetSelectable(HYRP1, 0);

    HYRP2 = TextDrawCreate(306.000000, 155.000000, "_");
    TextDrawFont(HYRP2, 1);
    TextDrawLetterSize(HYRP2, 0.600000, 13.300005);
    TextDrawTextSize(HYRP2, 298.500000, 298.000000);
    TextDrawSetOutline(HYRP2, 1);
    TextDrawSetShadow(HYRP2, 0);
    TextDrawAlignment(HYRP2, 2);
    TextDrawColor(HYRP2, -1);
    TextDrawBackgroundColor(HYRP2, 255);
    TextDrawBoxColor(HYRP2, 255);
    TextDrawUseBox(HYRP2, 1);
    TextDrawSetProportional(HYRP2, 1);
    TextDrawSetSelectable(HYRP2, 0);

    HYRP3 = TextDrawCreate(340.000000, 127.000000, "RUSUH");
    TextDrawFont(HYRP3, 1);
    TextDrawLetterSize(HYRP3, 0.437500, 1.600000);
    TextDrawTextSize(HYRP3, 400.000000, 17.000000);
    TextDrawSetOutline(HYRP3, 1);
    TextDrawSetShadow(HYRP3, 0);
    TextDrawAlignment(HYRP3, 2);
    TextDrawColor(HYRP3, 65535);
    TextDrawBackgroundColor(HYRP3, 255);
    TextDrawBoxColor(HYRP3, 50);
    TextDrawUseBox(HYRP3, 0);
    TextDrawSetProportional(HYRP3, 1);
    TextDrawSetSelectable(HYRP3, 0);

    HYRP4 = TextDrawCreate(376.000000, 127.000000, "RP");
    TextDrawFont(HYRP4, 1);
    TextDrawLetterSize(HYRP4, 0.420832, 1.649999);
    TextDrawTextSize(HYRP4, 400.000000, 17.000000);
    TextDrawSetOutline(HYRP4, 1);
    TextDrawSetShadow(HYRP4, 0);
    TextDrawAlignment(HYRP4, 2);
    TextDrawColor(HYRP4, -16776961);
    TextDrawBackgroundColor(HYRP4, 255);
    TextDrawBoxColor(HYRP4, 50);
    TextDrawUseBox(HYRP4, 0);
    TextDrawSetProportional(HYRP4, 1);
    TextDrawSetSelectable(HYRP4, 0);

    HYRP5 = TextDrawCreate(306.000000, 161.000000, "_");
    TextDrawFont(HYRP5, 2);
    TextDrawLetterSize(HYRP5, 0.600000, 1.500002);
    TextDrawTextSize(HYRP5, 298.500000, 93.000000);
    TextDrawSetOutline(HYRP5, 1);
    TextDrawSetShadow(HYRP5, 0);
    TextDrawAlignment(HYRP5, 2);
    TextDrawColor(HYRP5, -1);
    TextDrawBackgroundColor(HYRP5, 255);
    TextDrawBoxColor(HYRP5, 35719);
    TextDrawUseBox(HYRP5, 1);
    TextDrawSetProportional(HYRP5, 1);
    TextDrawSetSelectable(HYRP5, 0);

    HYRP6 = TextDrawCreate(306.000000, 158.000000, "LOGIN");
    TextDrawFont(HYRP6, 1);
    TextDrawLetterSize(HYRP6, 0.600000, 2.000000);
    TextDrawTextSize(HYRP6, 400.000000, 17.000000);
    TextDrawSetOutline(HYRP6, 1);
    TextDrawSetShadow(HYRP6, 0);
    TextDrawAlignment(HYRP6, 2);
    TextDrawColor(HYRP6, -1);
    TextDrawBackgroundColor(HYRP6, 255);
    TextDrawBoxColor(HYRP6, 50);
    TextDrawUseBox(HYRP6, 0);
    TextDrawSetProportional(HYRP6, 1);
    TextDrawSetSelectable(HYRP6, 0);

    HYRP7 = TextDrawCreate(307.000000, 192.000000, "_");
    TextDrawFont(HYRP7, 2);
    TextDrawLetterSize(HYRP7, 0.600000, 1.800001);
    TextDrawTextSize(HYRP7, 258.500000, 215.000000);
    TextDrawSetOutline(HYRP7, 1);
    TextDrawSetShadow(HYRP7, 0);
    TextDrawAlignment(HYRP7, 2);
    TextDrawColor(HYRP7, -1);
    TextDrawBackgroundColor(HYRP7, 255);
    TextDrawBoxColor(HYRP7, -16777081);
    TextDrawUseBox(HYRP7, 1);
    TextDrawSetProportional(HYRP7, 1);
    TextDrawSetSelectable(HYRP7, 0);

    HYBRID8 = TextDrawCreate(304.000000, 195.000000, "NAMA");
    TextDrawFont(HYBRID8, 1);
    TextDrawLetterSize(HYBRID8, 0.600000, 1.450000);
    TextDrawTextSize(HYBRID8, 400.000000, 192.500000);
    TextDrawSetOutline(HYBRID8, 1);
    TextDrawSetShadow(HYBRID8, 0);
    TextDrawAlignment(HYBRID8, 2);
    TextDrawColor(HYBRID8, -1);
    TextDrawBackgroundColor(HYBRID8, 255);
    TextDrawBoxColor(HYBRID8, 50);
    TextDrawUseBox(HYBRID8, 0);
    TextDrawSetProportional(HYBRID8, 1);
    TextDrawSetSelectable(HYBRID8, 0);

    HYRP9 = TextDrawCreate(307.000000, 234.000000, "_");
    TextDrawFont(HYRP9, 2);
    TextDrawLetterSize(HYRP9, 0.600000, 1.800001);
    TextDrawTextSize(HYRP9, 258.500000, 215.000000);
    TextDrawSetOutline(HYRP9, 1);
    TextDrawSetShadow(HYRP9, 0);
    TextDrawAlignment(HYRP9, 2);
    TextDrawColor(HYRP9, -1);
    TextDrawBackgroundColor(HYRP9, 255);
    TextDrawBoxColor(HYRP9, -16777081);
    TextDrawUseBox(HYRP9, 1);
    TextDrawSetProportional(HYRP9, 1);
    TextDrawSetSelectable(HYRP9, 0);

    HYRP10 = TextDrawCreate(304.000000, 237.000000, "PASSWORD");
    TextDrawFont(HYRP10, 1);
    TextDrawLetterSize(HYRP10, 0.600000, 1.450000);
    TextDrawTextSize(HYRP10, 400.000000, 192.500000);
    TextDrawSetOutline(HYRP10, 1);
    TextDrawSetShadow(HYRP10, 0);
    TextDrawAlignment(HYRP10, 2);
    TextDrawColor(HYRP10, -1);
    TextDrawBackgroundColor(HYRP10, 255);
    TextDrawBoxColor(HYRP10, 50);
    TextDrawUseBox(HYRP10, 0);
    TextDrawSetProportional(HYRP10, 1);
    TextDrawSetSelectable(HYRP10, 1);

    HYRP11 = TextDrawCreate(349.000000, 291.000000, "FOUNDER");
    TextDrawFont(HYRP11, 1);
    TextDrawLetterSize(HYRP11, 0.474999, 1.349997);
    TextDrawTextSize(HYRP11, 425.000000, 91.000000);
    TextDrawSetOutline(HYRP11, 1);
    TextDrawSetShadow(HYRP11, 0);
    TextDrawAlignment(HYRP11, 2);
    TextDrawColor(HYRP11, -65281);
    TextDrawBackgroundColor(HYRP11, 255);
    TextDrawBoxColor(HYRP11, -16776961);
    TextDrawUseBox(HYRP11, 1);
    TextDrawSetProportional(HYRP11, 1);
    TextDrawSetSelectable(HYRP11, 0);

    HYRP12 = TextDrawCreate(429.000000, 288.000000, "TranZK");
    TextDrawFont(HYRP12, 1);
    TextDrawLetterSize(HYRP12, 0.550001, 1.649999);
    TextDrawTextSize(HYRP12, 400.000000, 71.500000);
    TextDrawSetOutline(HYRP12, 1);
    TextDrawSetShadow(HYRP12, 0);
    TextDrawAlignment(HYRP12, 2);
    TextDrawColor(HYRP12, 9109759);
    TextDrawBackgroundColor(HYRP12, 255);
    TextDrawBoxColor(HYRP12, -16776961);
    TextDrawUseBox(HYRP12, 1);
    TextDrawSetProportional(HYRP12, 1);
    TextDrawSetSelectable(HYRP12, 0);

    HYRP13 = TextDrawCreate(261.000000, 95.000000, "WELCOME");
    TextDrawFont(HYRP13, 1);
    TextDrawLetterSize(HYRP13, 0.504166, 1.649999);
    TextDrawTextSize(HYRP13, 400.000000, -104.000000);
    TextDrawSetOutline(HYRP13, 1);
    TextDrawSetShadow(HYRP13, 0);
    TextDrawAlignment(HYRP13, 2);
    TextDrawColor(HYRP13, -65281);
    TextDrawBackgroundColor(HYRP13, 255);
    TextDrawBoxColor(HYRP13, 50);
    TextDrawUseBox(HYRP13, 0);
    TextDrawSetProportional(HYRP13, 1);
    TextDrawSetSelectable(HYRP13, 0);

    HYRP14 = TextDrawCreate(308.000000, 111.000000, "TO");
    TextDrawFont(HYRP14, 1);
    TextDrawLetterSize(HYRP14, 0.512498, 1.649999);
    TextDrawTextSize(HYRP14, 400.000000, 17.000000);
    TextDrawSetOutline(HYRP14, 1);
    TextDrawSetShadow(HYRP14, 0);
    TextDrawAlignment(HYRP14, 2);
    TextDrawColor(HYRP14, 1296911871);
    TextDrawBackgroundColor(HYRP14, 255);
    TextDrawBoxColor(HYRP14, 50);
    TextDrawUseBox(HYRP14, 0);
    TextDrawSetProportional(HYRP14, 1);
    TextDrawSetSelectable(HYRP14, 0);

    HYRP15 = TextDrawCreate(388.000000, 285.000000, ":");
    TextDrawFont(HYRP15, 1);
    TextDrawLetterSize(HYRP15, 0.600000, 2.199999);
    TextDrawTextSize(HYRP15, 241.500000, 4.500000);
    TextDrawSetOutline(HYRP15, 1);
    TextDrawSetShadow(HYRP15, 0);
    TextDrawAlignment(HYRP15, 1);
    TextDrawColor(HYRP15, -1);
    TextDrawBackgroundColor(HYRP15, 255);
    TextDrawBoxColor(HYRP15, 50);
    TextDrawUseBox(HYRP15, 0);
    TextDrawSetProportional(HYRP15, 1);
    TextDrawSetSelectable(HYRP15, 0);
    return 1;
}



Function:ClearAnimChat(playerid)
{ 
    ApplyAnimation(playerid, "CARRY", "crry_prtial",4.0,0,0,0,0,0,1); 
    return 1; 
}

Function:DialogMakanan(playerid)
{
    new coordsstring[256];
    new finalstring [ 1024 ] ;

    format(coordsstring, sizeof(coordsstring), "{ffffff}Keropok = {22ff00}RM100 || {ffffff}My Bag: {22ff00}%d\n",PlayerInfo[playerid][pBun]); strcat ( finalstring, coordsstring ) ;
    format(coordsstring, sizeof(coordsstring), "{ffffff}Roti Coklat = {22ff00}RM300 || {ffffff}My Bag: {22ff00}%d\n",PlayerInfo[playerid][pBiskut]); strcat ( finalstring, coordsstring ) ;
    format(coordsstring, sizeof(coordsstring), "{ffffff}Nasi Papaya = {22ff00}RM700 || {ffffff}My Bag: {22ff00}%d\n",PlayerInfo[playerid][pMeggiCup]); strcat ( finalstring, coordsstring ) ;
    format(coordsstring, sizeof(coordsstring), "{ffffff}Mineral = {22ff00}RM50 || {ffffff}My Bag: {22ff00}%d\n",PlayerInfo[playerid][pMineral]); strcat ( finalstring, coordsstring ) ;
    format(coordsstring, sizeof(coordsstring), "{ffffff}Air Oren = {22ff00}RM250 || {ffffff}My Bag: {22ff00}%d\n\n",PlayerInfo[playerid][p100Plus]); strcat ( finalstring, coordsstring ) ;
    format(coordsstring, sizeof(coordsstring), "{ffffff}Air Milo = {22ff00}RM500 || {ffffff}My Bag: {22ff00}%d\n",PlayerInfo[playerid][pCoffee]); strcat ( finalstring, coordsstring ) ;

    ShowPlayerDialog(playerid, 0, DIALOG_STYLE_LIST, "{22ff00}Shop", finalstring, "Ok", "Exit");
}

Function:ViolaKO(playerid)
{
    TextDrawHideForAll(ke1);
    TextDrawHideForAll(ke2);
    TextDrawHideForAll(ke3);
    TextDrawHideForAll(ke4);
    TextDrawHideForAll(ke5);
    TextDrawHideForAll(ke6);
    return 1;
}

Function:TextDrawShowForAllo()
{
    TextDrawShowForAll(ke1);
    TextDrawShowForAll(ke2);
    TextDrawShowForAll(ke3);
    TextDrawShowForAll(ke4);
    TextDrawShowForAll(ke5);
    TextDrawShowForAll(ke6);
    return 1;
}

Function:PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
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

Function:CreateVehicleEx(playerid, modelid, color_1, color_2)
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

Function:UnFreezeJob(playerid)
{
	TogglePlayerControllable(playerid,true);
}

Function:KickLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("kick.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

Function:BanLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("ban.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

Function:PayLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("pay.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

Function:SlapLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("slap.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

Function:SendMSG()
{
	new randMSG = random(sizeof(RandomMSG));
    SendClientMessageToAll(COLOR_RED, RandomMSG[randMSG]);
	return 1;
}

Function:ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5)
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

Function:SendRandomMesg()
{
    new randMSG = random(sizeof(RandomMSG));
    SendClientMessageToAll(-1, RandomMSG[randMSG]);
	return 1;
}

Function:AutoJail(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
		if(PlayerToPoint(2, playerid, 1544.3119,-2182.2561,13.6328) ||
        PlayerToPoint(2, playerid, 938.0092,-1730.0391,13.5546) ||
        PlayerToPoint(2, playerid, 1352.8988,-1761.0807,13.7312))
	    {
	   	 	new string[248];
            new SpawnRandom = random(sizeof(SpawnJail));
			format(string,sizeof(string),"[MYBOT]: {FFFFFF}%s telah di jail secara automatik. {ff0000}(Sebab: POWER GAMING)",GetRPName(playerid));
	     	SendClientMessageToAll(Yellow,string);
            SetPlayerPos(playerid,
            SpawnJail[SpawnRandom][0],
            SpawnJail[SpawnRandom][1],
            SpawnJail[SpawnRandom][2]);
            PlayerInfo[playerid][pJail] = 1;
            SetTimerEx("Unjail",1800000,false,"i",playerid);
            GameTextForPlayer(playerid, "~g~-DALAM 30MIN BARU ANDA DI LEPASKAN", -3000, 1);
	     	format(string, sizeof string, " :bar_chart: *[Info Jail]* \n ** %s Telah Di Jail \nSEBAB:Power Gaming!... ~ ** ", GetRPName(playerid));
			DCC_SendChannelMessage(Info_Pdrm, string);
	    }
    }
    return 1;
}

Function:Unjail(playerid)
{   
    new string[248];
    GameTextForPlayer(playerid, "~g~-SEMOGA JADI INSAN BERGUNA", -3000, 1);
    PlayerInfo[playerid][pJail] = 0;
    format(string,sizeof(string),"[MYBOT]: {FFFFFF}%s TELAH DI UNJAIL SECARA AUTOMATIC",GetRPName(playerid));
    SendClientMessageToAll(COLOR_RED,string);
    SetPlayerPos(playerid, 245.5502,212.0632,1042.1980);
    return 1;
}

Function:SpeedTrap(playerid)
{
    if(IsPlayerInAnyVehicle(playerid))
    {
        if(PlayerToPoint(8, playerid, 1707.805175, -662.118225, 42.669570) ||
        PlayerToPoint(8, playerid, 1609.405395, 63.321758, 36.387725) ||
        PlayerToPoint(8, playerid, 1350.000610, -1387.381225, 12.520277) ||
        PlayerToPoint(8, playerid, 2041.765625, 843.254638, 5.715529) ||
        PlayerToPoint(8, playerid, 2717.647705, 2052.267333, 5.206883))
        {
            new str[256];
            new veh = GetPlayerVehicleID(playerid);
            if(IsAPlane(veh) || IsAHelicopter(veh))
            if(PlayerInfo[playerid][pAdmin] >= 3 || PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pRole] == 2 || PlayerInfo[playerid][pRole] == 3)
            {
                return 1;
            }
            else
            {   
                if(GetVehicleSpeed(veh) >= 250)
                {
                    //new string[248];
                    format(str,sizeof(str), ""COL_RED"[MYBOT]:"COL_WHITE" %s Telah Di Tolak Duit Kerana Melebihi Speed Negara Rusuh Kelajuan : 250KMH, Dan Di Tolak Duit Sebanyak RM1000",GetRPName(playerid));
                    SendClientMessageToAll(Yellow,str);
                    RandomMoneySpeedTrap(playerid);
                }
            }
        }
    }
    return 1;
}

Function:KickPublic(playerid) 
{ 
    Kick(playerid);  
}

Function:Delay_Kick(playerid)
{
    Kick(playerid);
    return 1;
}

Function:ResetRobbank()
{
    Robbank = 0;
}

Function:RobbankMoney(playerid)
{
    GivePlayerMoney(playerid,30000);
}

Function:LetakBomb(playerid)
{
    new Float:x,Float:y,Float:z;
    GetPlayerPos(playerid,x,y,z);
    ClearAnimations(playerid,1);
    foreach(new i : Player)
    {
        if(IsPlayerInRangeOfPoint(i,5,x,y,z))
        {
            GameTextForPlayer(i,"Bomb Sudah Diletakkan, Sila Jauh Dari Tempat Bomb!",3000,3);
            SendClientMessage(i,Yellow,"INFO: {FFFFFF}Bomb Sudah Diletakkan, Sila Jauh Dari Bom Ini!");
        }
    }
    SetTimerEx("Letup",7000,false,"i",playerid);
    //MoveDynamicObject(PintuRobbank,1496.0811, -2168.2449, 15.1600,4.0);
    return 1;
}

Function:Letup(playerid)
{
    CreateExplosion(1244.2650,-1648.4912,11.8013, 6, 3);
    MoveDynamicObject(PintuRobbank,1496.0811, -2168.2449, 15.1600, 5.0);
    SendClientMessageToAll(COLOR_GREEN,"[BANK]: {FFFFFF}Pintu Besi Bank Telah Diceroboh! Sila Bersedia Pihak Pdrm!");
    return 1;
}

Function:BolehRob(playerid)
{ 
    MoveDynamicObject(PintuRobbank,1502.3087, -2168.0730, 15.1600,7.0);
    SendClientMessageToAll(COLOR_GREEN,"[BANK RUSUH]: {FFFFFF}Bank Telah Berjaya Dikemaskini");
    return 1;
}

Function:ScoreSystem()
{
    for(new i = 0; i < MAX_PLAYERS; i++) 
    {    
        if(PlayerInfo[i][pRole] >= 1)
        {
            new string[248];
            PlayerInfo[i][pScore] += 1;
            SetPlayerScore(i,PlayerInfo[i][pScore]);
            format(string,sizeof(string),"~w~PAYDAY");
            GameTextForAll(string,5000,3);
            GameTextForPlayer(i, "~g~+Rm5000", -100, 1);
            SendClientMessage(i, -1,"{9ACD32}[PAYDAY] {FFFFFF}Payday!!Anda Telah Mendapat Duit Sebanyak Rm5000 Gaji Anda Dan Level Anda Naik Sebanyak 1");
            GiveMoneyPayday(i, 5000);
        }
        else
        {
            new string[248];
            PlayerInfo[i][pScore] += 1;
            SetPlayerScore(i,PlayerInfo[i][pScore]);
            format(string,sizeof(string),"~w~PAYDAY");
            GameTextForAll(string,5000,3);
            GameTextForPlayer(i, "~g~+Rm100", -100, 1);
            SendClientMessage(i, -1,"{9ACD32}[PAYDAY] {FFFFFF}Payday!!Anda Telah Mendapat Duit Sebanyak Rm100 Dan Level Anda Naik Sebanyak 1");
            PlayerInfo[i][pCash] = 100;
            GivePlayerMoney(i, 100);
        }
    }
}

Function:DamagedEngine(playerid)
{
    new vehicleid = GetPlayerVehicleID(playerid);
    new Float:health;

    GetVehicleHealth(vehicleid, health);

	if(IsPlayerInAnyVehicle(playerid))
	{
	    if(vehEngine[vehicleid] == 1)
	    {
	        if(health < 100)
			{
			    vehEngine[vehicleid] = 0;
				TogglePlayerControllable(playerid, 0);
			    SendClientMessage(playerid, COLOR_YELLOW, "Engine Kenderaan Anda Telah Rosak");
			}
		}
	}
	return 1;
}

Function:Casino(playerid)
{   
    new casino = RandomEx(0,4);
    if(casino == 0)
    {
        GiveMoneyPayday(playerid, 1000);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM1000");
        CreateRp(playerid, "Telah Mendapat Rm1000");
    }
    if(casino == 1)
    {
        GiveMoneyPayday(playerid, 100);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM100");
        CreateRp(playerid, "Telah Mendapat Rm100");
    }
    if(casino == 2)
    {
        GiveMoneyPayday(playerid, 200);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM200");
        CreateRp(playerid, "Telah Mendapat Rm200");
    }
    if(casino == 3)
    {
        GiveMoneyPayday(playerid, 400);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM400");
        CreateRp(playerid, "Telah Mendapat Rm400");
    }
    if(casino == 4)
    {
        GiveMoneyPayday(playerid, 500);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM500");
        CreateRp(playerid, "Telah Mendapat Rm500");
    }
    return 1;
}

Function:Casino1(playerid)
{   
    new casino = RandomEx(0,4);
    if(casino == 0)
    {
        GiveMoneyPayday(playerid, 3000);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM3000");
        CreateRp(playerid, "Telah Mendapat Rm3000");
    }
    if(casino == 1)
    {
        GiveMoneyPayday(playerid, 1000);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM1000");
        CreateRp(playerid, "Telah Mendapat Rm1000");
    }
    if(casino == 2)
    {
        GiveMoneyPayday(playerid, 4590);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM4590");
        CreateRp(playerid, "Telah Mendapat Rm4590");
    }
    if(casino == 3)
    {
        GiveMoneyPayday(playerid, 3947);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM3947");
        CreateRp(playerid, "Telah Mendapat Rm3947");
    }
    if(casino == 4)
    {
        GiveMoneyPayday(playerid, 1838);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM1838");
        CreateRp(playerid, "Telah Mendapat Rm1838");
    }
    return 1;
}

Function:Casino2(playerid)
{   
    new casino = RandomEx(0,4);
    if(casino == 0)
    {
        GiveMoneyPayday(playerid, 100);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM100");
        CreateRp(playerid, "Telah Mendapat Rm100");
    }
    if(casino == 1)
    {
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"NASIB ANDA MALANG HARINI, ANDA TIDAK MENDAPAT APA II HASIL HAHA...");
    }
    if(casino == 2)
    {
        GiveMoneyPayday(playerid, 9999);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM9999");
        CreateRp(playerid, "Telah Mendapat Rm9999");
    }
    if(casino == 3)
    {
        GiveMoneyPayday(playerid, 7829);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM7829");
        CreateRp(playerid, "Telah Mendapat Rm7829");
    }
    if(casino == 4)
    {
        GiveMoneyPayday(playerid, 8793);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM8793");
        CreateRp(playerid, "Telah Mendapat Rm8793");
    }
    return 1;
}

Function:Casino3(playerid)
{   
    new casino = RandomEx(0,4);
    if(casino == 0)
    {
        GiveMoneyPayday(playerid, 100);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM100");
        CreateRp(playerid, "Telah Mendapat Rm100");
    }
    if(casino == 1)
    {
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"NASIB ANDA MALANG HARINI, ANDA TIDAK MENDAPAT APA II HASIL HAHA...");
    }
    if(casino == 2)
    {
        GiveMoneyPayday(playerid, 9999);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM9999");
        CreateRp(playerid, "Telah Mendapat Rm9999");
    }
    if(casino == 3)
    {
        GiveMoneyPayday(playerid, 7829);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM7829");
        CreateRp(playerid, "Telah Mendapat Rm7829");
    }
    if(casino == 4)
    {
        GiveMoneyPayday(playerid, 1);
        SCM(playerid, -1, ""COL_YELLOW"[CASINO]: " COL_WHITE"ANDA TELAH MENDAPAT JACKPOT SEBANYAK RM1");
        CreateRp(playerid, "Telah Mendapat Rm1");
    }
    return 1;
}

Function:ResetPlayerVariable(playerid)
{
    PlayerLogin[playerid] = 0;
    Onduty[playerid] = 0;
    SkinLama[playerid] = 0;
    Injured[playerid] = 0;
    PizzaJob[playerid] = 0;
    BasJob[playerid] = 0;
    LoriSampah[playerid] = 0;
    Sweeper[playerid] = 0;
    pemain[playerid][Vehicles] = 0;
    PlayerInfo[playerid][pCuff] = 0;
    PlayerInfo[playerid][pWarn] = 0;
    PlayerInfo[playerid][pCarry] = 0;
    TengahPaintball[playerid] = 0;
    CooldownHidup[playerid] = 0;
    MatiPaintball[playerid] = 0;
    ScorePaintball[playerid] = 0;
    return 1;
}

Function:AntiHackWeapon(playerid)
{
    if(PlayerInfo[playerid][pAdmin] >= 3)
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
        GetPlayerWeapon(playerid) == 21 ||
        GetPlayerWeapon(playerid) == 26 ||
        GetPlayerWeapon(playerid) == 28 ||
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
        GetPlayerWeapon(playerid) == 47)
        {
            new string[248];
            format(string,sizeof(string),"{FCE21F}[BOT]: {FFFFFF}%s telah di kick secara automatik. {ff0000}(Sebab: HACK WEAPON)",GetRPName(playerid));
            SendClientMessageToAll(-1, string);
            format(string, sizeof string, " :bar_chart: *[SERVER LOG]* \n **%s Telah Dikick Dari Server\nSEBAB:HACK WEAPON! ( %d ) ... ~** ", GetRPName(playerid), GetPlayerWeapon(playerid));
            DCC_SendChannelMessage(Info_Server, string);
            SetTimerEx("Delay_Kick",100,false,"i",playerid);
        }
    }
    return 1;
}

Function:AntiSpawnKilling(playerid)
{
    new Float:health;
    if(CooldownHidup[playerid] == 0)
    {
       return 1;
    }
    else
    {
       GetPlayerHealth(playerid, health);
       {
            if(health < 100)
            {
               SetPlayerHealth(playerid, health+120);
            }
        }
    }
    return 1;
}

Function:UpdateLapar()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayerInfo[i][pLapar] -= 1;
    }
    return 1;
}

Function:OnLapar()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pLapar] < 5)
        {
            if(PlayerLogin[i] == 1)
            {
                SetPlayerHealth(i, - 1);
                SendClientMessage(i, -1, ""COL_RED"[SERVER]"COL_WHITE" Anda Sudah Mulai Merasa Lapar Sila Pergi Ke Kedai Untuk Membeli Makanan!");
            }
        }
    }
    return 1;
}

Function:IsiFuelTimer(playerid)
{
	new string[500];
    PlayerInfo[playerid][pMinyak] = 100;
    TolakDuitPlayer(playerid, 500);
    SendClientMessage(playerid, -1, ""COL_RED"[PETROL]"COL_WHITE" Minyak Telah Siap Diisi Dengan Penuh");
    format(string, sizeof(string), "* %s Telah Siap Mengisi Minyak", GetRPName(playerid));
    ProxDetector(30.0, playerid, string, ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR);
    SetTimerEx("UnFreezeJob", 1000, false, "i", playerid);
	return 1;
}

Function:UpdateHaus()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        PlayerInfo[i][pHaus] -= 1;
    }
    return 1;
}

Function:OnHaus()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pHaus] < 5)
        {
            if(PlayerLogin[i] == 1)
            {
                SetPlayerHealth(i, - 1);
                SendClientMessage(i, -1, ""COL_RED"[MYBOT]"COL_WHITE" Anda Sudah Mulai Merasa Haus Sila Pergi Ke Kedai Untuk Membeli Minuman!");
            }
            
        }
    }
    return 1;
}

Function:EnjinTimer(playerid)
{
    new vid = GetPlayerVehicleID(playerid);
    new string[1000];
    GetVehicleParamsEx(vid,engine,lights,alarm,doors,bonnet,boot,objective);
    if(vid != INVALID_VEHICLE_ID)
    if(!IsPlayerInAnyVehicle(playerid)) return SendClientMessage(playerid,-1,""COL_OREN"[ENJIN]"COL_WHITE" Anda Mestilah Menaiki Kenderaan Untuk Guna Command Ini");
    if(GetPlayerState(playerid) == PLAYER_STATE_PASSENGER) return SendClientMessage(playerid,-1,""COL_OREN"[ENJIN]"COL_WHITE" Hanya Pemandu Sahaja Boleh Guna Cmd Ini");
    if(PlayerInfo[playerid][pMinyak] >= 1)
    {
        vehEngine[vid] = 1;
        SendClientMessage(playerid, -1, ""COL_OREN"[ENJIN]"COL_WHITE" Anda Telah Menghidupkan Enjin Kenderaan.Taip /en Untuk Menutup Enjin");
        format(string, sizeof(string), "* %s Telah Berjaya Menghidupkan Enjin Kenderaan", GetRPName(playerid));
        ProxDetector(30.0, playerid, string, ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR);
        SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
        StopAudioStreamForPlayer(playerid);
    }
    if(PlayerInfo[playerid][pMinyak] <= 0)
    {
        vehEngine[vid] = 0;
        SendClientMessage(playerid, -1, ""COL_OREN"[ENJIN]"COL_WHITE" Anda Telah Gagal Menghidupkan Enjin Kenderaan.Taip /en Untuk Membuka Enjin");
        format(string, sizeof(string), "* %s Telah Gagal Menghidupkan Enjin", GetRPName(playerid));
        ProxDetector(30.0, playerid, string, ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR,ACTION_COLOR);
        SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
    }
    return 1;
}

Function:UpdateFuel()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        new vehicleid = GetPlayerVehicleID(i);
        GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
        if(IsPlayerInAnyVehicle(i) && GetPlayerState(i) == PLAYER_STATE_DRIVER && engine == VEHICLE_PARAMS_ON && vehEngine[vehicleid] == 1)
        {
            PlayerInfo[i][pMinyak] -= 1;
        }
    }
    return 1;
}

Function:ProxDetectorS(Float:radi, playerid, targetid)
{
    if(IsPlayerConnected(playerid)&&IsPlayerConnected(targetid))
	{
		new Float:posx, Float:posy, Float:posz;
		new Float:oldposx, Float:oldposy, Float:oldposz;
		new Float:tempposx, Float:tempposy, Float:tempposz;
		GetPlayerPos(playerid, oldposx, oldposy, oldposz);
		GetPlayerPos(targetid, posx, posy, posz);
		tempposx = (oldposx -posx);
		tempposy = (oldposy -posy);
		tempposz = (oldposz -posz);
		if(((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
		{
			return 1;
		}
	}
	return 0;
}

Function:OnFuel()
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pMinyak] == 0)
		{
			if(IsPlayerInAnyVehicle(i))
			{
				new vehicleid = GetPlayerVehicleID(i);
				GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
                if(vehicleid != INVALID_VEHICLE_ID)
				SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
                RemovePlayerFromVehicle(i);
                vehEngine[vehicleid] = 0;
				SendClientMessage(i, -1, ""COL_OREN"[BOT]"COL_WHITE" Minyak Anda Telah Pun Habis!");
				if(IsAbicycle(i))
				{
                    GetVehicleParamsEx(vehicleid,engine,lights,alarm,doors,bonnet,boot,objective);
                    if(vehicleid != INVALID_VEHICLE_ID)
                    SetVehicleParamsEx(vehicleid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
				}
			}
		}
	}
    return 1;
}

Function:RandomPaintballSpawn(playerid)
{
    new paintball = RandomEx(0,3);

    if(paintball == 0)
    {
        SetPlayerPos(playerid, -959.2236,1859.6760,9.0000); //TUKAR KORDINAT
        SetPlayerInterior(playerid, 0);
        MatiPaintball[playerid] = 0;
        CooldownHidup[playerid] = 1;
        SetTimerEx("Delay_Paintball", 5000, false, "d", playerid);
    }
    if(paintball == 1)
    {
        SetPlayerPos(playerid, 1951.1860,-2337.0510,13.6281); //TUKAR KORDINAT
        SetPlayerInterior(playerid, 0);
        MatiPaintball[playerid] = 0;
        CooldownHidup[playerid] = 1;
        SetTimerEx("Delay_Paintball", 5000, false, "d", playerid);
    }
    if(paintball == 2)
    {
        SetPlayerPos(playerid, 1966.3151,-2350.8816,16.7422); //TUKAR KORDINAT
        SetPlayerInterior(playerid, 0);
        MatiPaintball[playerid] = 0;
        CooldownHidup[playerid] = 1;
        SetTimerEx("Delay_Paintball", 5000, false, "d", playerid);
    }
    if(paintball == 3)
    {
        SetPlayerPos(playerid, 1965.6499,-2351.5552,13.5469); //TUKAR KORDINAT
        SetPlayerInterior(playerid, 0);
        MatiPaintball[playerid] = 0;
        CooldownHidup[playerid] = 1;
        SetTimerEx("Delay_Paintball", 5000, false, "d", playerid);
    }
    return 1;
}

Function:Delay_Paintball(playerid)
{
    SendClientMessage(playerid, COLOR_WHITE, "{F9EB11}[PAINTBALL]{FFFFFF} Anti Spawn Killing Anda Telah Habis");
    CooldownHidup[playerid] = 0;
    GivePlayerWeapon(playerid, 24, 100000);
    GivePlayerWeapon(playerid, 27, 100000);
    GivePlayerWeapon(playerid, 30, 100000);
    GivePlayerWeapon(playerid, 32, 100000);
    return 1;
}

Function:RemoveBuilding(playerid)
{
    //Mapping kahwin
    RemoveBuildingForPlayer(playerid, 3474, 978.289, 2094.989, 16.742, 0.250);
    RemoveBuildingForPlayer(playerid, 7493, 966.359, 2140.968, 13.397, 0.250);
    RemoveBuildingForPlayer(playerid, 7673, 966.359, 2140.968, 13.397, 0.250);
    RemoveBuildingForPlayer(playerid, 1497, 965.789, 2162.148, 9.812, 0.250);
    RemoveBuildingForPlayer(playerid, 1497, 965.804, 2159.138, 9.812, 0.250);
    RemoveBuildingForPlayer(playerid, 7926, 969.625, 2082.138, 14.178, 0.250);
    RemoveBuildingForPlayer(playerid, 7672, 969.625, 2082.138, 14.178, 0.250);
    RemoveBuildingForPlayer(playerid, 7627, 969.625, 2082.138, 14.178, 0.250);
    RemoveBuildingForPlayer(playerid, 7672, 969.625, 2082.138, 14.178, 0.250);
    //Police department
    RemoveBuildingForPlayer(playerid, 4211, 1380.265, -1655.539, 10.804, 0.250);
    RemoveBuildingForPlayer(playerid, 4198, 1380.265, -1655.539, 10.804, 0.250);
    RemoveBuildingForPlayer(playerid, 6106, 1226.953, -1656.156, 24.773, 0.250);
    RemoveBuildingForPlayer(playerid, 6196, 1225.335, -1642.750, 25.101, 0.250);
    RemoveBuildingForPlayer(playerid, 1525, 1271.484, -1662.320, 20.250, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 1204.640, -1707.171, 15.929, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 1235.718, -1707.171, 15.937, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 1267.039, -1707.304, 15.937, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1190.984, -1686.312, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1190.984, -1691.390, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 1191.789, -1691.906, 12.015, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1190.984, -1681.523, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 1191.406, -1674.421, 12.015, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1190.984, -1674.148, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1196.726, -1691.390, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1202.414, -1691.390, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1202.414, -1686.312, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 1204.390, -1692.320, 12.015, 0.250);
    RemoveBuildingForPlayer(playerid, 1350, 1291.835, -1702.460, 12.250, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 1292.179, -1691.757, 15.890, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1202.414, -1681.523, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 1312, 1299.453, -1683.507, 16.585, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1258.578, -1675.500, 14.601, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1267.671, -1675.500, 14.601, 0.250);
    RemoveBuildingForPlayer(playerid, 620, 1203.640, -1674.484, 12.015, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1202.414, -1674.148, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1197.273, -1674.148, 13.093, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1181.312, -1665.468, 14.796, 0.250);
    RemoveBuildingForPlayer(playerid, 1281, 1197.234, -1667.054, 13.351, 0.250);
    RemoveBuildingForPlayer(playerid, 1281, 1189.601, -1667.312, 13.351, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1208.281, -1665.468, 14.500, 0.250);
    RemoveBuildingForPlayer(playerid, 1281, 1195.179, -1661.500, 13.351, 0.250);
    RemoveBuildingForPlayer(playerid, 1281, 1187.742, -1661.421, 13.351, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 1188.343, -1655.820, 13.179, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 1200.312, -1655.820, 13.179, 0.250);
    RemoveBuildingForPlayer(playerid, 6102, 1226.953, -1656.156, 24.773, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1258.578, -1659.875, 14.601, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1267.671, -1659.875, 14.601, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 1292.179, -1660.171, 15.890, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1237.500, -1643.429, 14.851, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1233.468, -1643.429, 14.851, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1245.562, -1643.429, 14.851, 0.250);
    RemoveBuildingForPlayer(playerid, 647, 1241.531, -1643.429, 14.851, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1258.578, -1643.367, 14.601, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1267.671, -1643.367, 14.601, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1219.117, -1640.460, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1231.312, -1640.460, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1243.507, -1640.460, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1255.710, -1640.460, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1282.828, -1639.960, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1211.601, -1632.867, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1219.117, -1632.867, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1231.312, -1632.867, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1243.507, -1632.867, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1255.710, -1632.867, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1282.828, -1619.851, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 626, 1282.828, -1629.109, 28.421, 0.250);
    RemoveBuildingForPlayer(playerid, 1297, 1292.179, -1629.101, 15.906, 0.250);
    RemoveBuildingForPlayer(playerid, 1312, 1299.449, -1683.510, 16.585, 0.250);
    //Sprp
    RemoveBuildingForPlayer(playerid, 9072, 2113.128, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 8694, 2113.128, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9070, 2111.320, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9074, 2111.320, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 8502, 2134.148, 1483.119, 21.483, 0.250);
    RemoveBuildingForPlayer(playerid, 8501, 2160.270, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9075, 2160.270, 1465.109, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9071, 2158.418, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 9073, 2158.418, 1501.119, 22.148, 0.250);
    RemoveBuildingForPlayer(playerid, 8852, 2162.138, 1483.250, 10.781, 0.250);
    RemoveBuildingForPlayer(playerid, 8855, 2181.580, 1483.229, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2182.050, 1503.229, 12.522, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2181.989, 1500.438, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2180.080, 1521.438, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1341, 2175.090, 1523.410, 10.734, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2169.678, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2168.540, 1514.078, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2161.918, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2157.510, 1514.078, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2153.850, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2148.918, 1522.078, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 8854, 2161.760, 1522.520, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2119.500, 1522.078, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2121.729, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2117.050, 1514.078, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2110.888, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 8853, 2107.188, 1522.520, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2101.570, 1514.078, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2099.810, 1518.130, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2088.479, 1522.078, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2087.610, 1503.229, 12.522, 0.250);
    RemoveBuildingForPlayer(playerid, 8851, 2086.810, 1483.229, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2087.610, 1463.250, 12.522, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2088.888, 1439.588, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2088.888, 1426.479, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2099.810, 1447.979, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2100.989, 1452.160, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 8856, 2107.188, 1443.989, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2110.888, 1447.979, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2117.330, 1452.160, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2121.729, 1447.979, 12.460, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2121.840, 1443.229, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1341, 2125.128, 1442.078, 10.703, 0.250);
    RemoveBuildingForPlayer(playerid, 1340, 2144.638, 1441.930, 10.850, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2147.658, 1443.229, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 8843, 2163.530, 1444.619, 9.859, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2157.070, 1452.160, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2169.580, 1452.160, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2181.918, 1443.229, 9.750, 0.250);
    RemoveBuildingForPlayer(playerid, 1280, 2181.989, 1458.708, 10.225, 0.250);
    RemoveBuildingForPlayer(playerid, 1231, 2182.050, 1463.250, 12.522, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2147.158, 1424.739, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2171.870, 1424.640, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 1344, 2178.218, 1418.838, 10.625, 0.250);
    RemoveBuildingForPlayer(playerid, 1344, 2181.560, 1418.838, 10.625, 0.250);
    RemoveBuildingForPlayer(playerid, 8839, 2162.479, 1403.438, 14.656, 0.250);
    RemoveBuildingForPlayer(playerid, 8931, 2162.479, 1403.438, 14.656, 0.250);
    RemoveBuildingForPlayer(playerid, 8840, 2162.790, 1401.410, 14.375, 0.250);
    RemoveBuildingForPlayer(playerid, 8842, 2217.750, 1477.660, 31.679, 0.250);
    RemoveBuildingForPlayer(playerid, 8930, 2217.750, 1477.660, 31.679, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2236.360, 1402.130, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 8866, 2237.479, 1471.359, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2116.360, 1384.328, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 718, 2098.378, 1384.318, 9.765, 0.250);
    RemoveBuildingForPlayer(playerid, 3516, 2074.600, 1423.369, 12.991, 0.250);
    RemoveBuildingForPlayer(playerid, 8446, 2152.378, 1453.229, 9.741, 0.250);
    RemoveBuildingForPlayer(playerid, 8605, 2152.378, 1453.229, 9.741, 0.250);
    RemoveBuildingForPlayer(playerid, 8664, 2162.388, 1453.229, 9.741, 0.250);
    RemoveBuildingForPlayer(playerid, 8755, 2162.388, 1453.229, 9.741, 0.250);
    RemoveBuildingForPlayer(playerid, 8865, 2215.090, 1522.520, 10.062, 0.250);
    RemoveBuildingForPlayer(playerid, 8390, 2307.370, 1453.180, 29.125, 0.250);
    RemoveBuildingForPlayer(playerid, 8695, 2307.370, 1453.180, 29.125, 0.250);
    RemoveBuildingForPlayer(playerid, 1294, 2251.638, 1463.318, 14.303, 0.250);
    //Motorsport
    RemoveBuildingForPlayer(playerid, 1522, 1038.949, -1341.150, 12.718, 0.250);
	RemoveBuildingForPlayer(playerid, 6158, 986.820, -1520.069, 17.929, 0.250);
	RemoveBuildingForPlayer(playerid, 6163, 986.820, -1520.069, 17.929, 0.250);
	RemoveBuildingForPlayer(playerid, 6100, 1251.790, -1541.280, 36.914, 0.250);
	RemoveBuildingForPlayer(playerid, 6107, 1251.790, -1541.280, 36.914, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1257.130, -1560.520, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1264.000, -1560.520, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1266.550, -1557.619, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1266.550, -1550.880, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1266.550, -1544.000, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1266.550, -1537.300, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1266.550, -1530.589, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1232.040, -1560.520, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1263.920, -1527.829, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1257.050, -1527.829, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1238.829, -1527.829, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1231.949, -1527.829, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1229.150, -1530.619, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1229.150, -1537.349, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1229.150, -1544.229, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1229.150, -1550.939, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1229.150, -1557.650, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 638, 1238.910, -1560.520, 13.265, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1273.609, -1542.380, 15.234, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1280.030, -1531.140, 12.070, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1279.729, -1552.949, 12.218, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1219.849, -1547.900, 12.617, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1219.849, -1534.469, 12.617, 0.250);
	RemoveBuildingForPlayer(playerid, 792, 1219.849, -1561.339, 12.617, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1210.310, -1559.000, 12.406, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1210.650, -1546.810, 12.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1218.280, -1554.089, 15.234, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1218.280, -1540.949, 15.234, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1218.280, -1528.400, 15.234, 0.250);
	RemoveBuildingForPlayer(playerid, 620, 1210.719, -1525.439, 12.406, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1289.890, -1520.150, 15.195, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1263.300, -1520.150, 15.195, 0.250);
	RemoveBuildingForPlayer(playerid, 1231, 1236.719, -1520.150, 15.195, 0.250);
    return 1;
}

//======================================================================================================================//

stock LoadHouses()
{
    new file[50], labelstring[144], stringlabel[144];
    for(new i = 0; i < MAX_HOUSES; i++)
    {
        format(file, sizeof(file), "Houses/%d.ini", i);
        if(fexist(file))
        {
            HouseInfo[i][hOwned] = dini_Int(file, "Owned");
            HouseInfo[i][hLocked] = dini_Int(file, "Locked");
            HouseInfo[i][hPrice] = dini_Int(file, "Price");
            HouseInfo[i][hInterior] = dini_Int(file, "Interior");
            HouseInfo[i][hX] = dini_Float(file, "Position X");
            HouseInfo[i][hY] = dini_Float(file, "Position Y");
            HouseInfo[i][hZ] = dini_Float(file, "Position Z");
            HouseInfo[i][hEnterX] = dini_Float(file, "Enter X");
            HouseInfo[i][hEnterY] = dini_Float(file, "Enter Y");
            HouseInfo[i][hEnterZ] = dini_Float(file, "Enter Z");
            HouseInfo[i][hMapicon] = dini_Int(file, "Mapicon");
            strmid(HouseInfo[i][hOwner], dini_Get(file, "Owner"), false, strlen(dini_Get(file, "Owner")), MAX_PLAYER_NAME);
            format(labelstring, sizeof(labelstring), "{15FF00}ID Rumah: {FFFFFF}%d\n{15FF00}Status: {FFFFFF}Untuk Dijual\n{15FF00}Harga: {FFFFFF}%d", i, HouseInfo[i][hPrice]);
            format(stringlabel, sizeof(stringlabel), "{15FF00}ID Rumah: {FFFFFF}%d\n{15FF00}Nama Rumah: {FFFFFF}%s\n{15FF00}Harga: {FFFFFF}%d", i, HouseInfo[i][hOwner], HouseInfo[i][hPrice]);
            if(HouseInfo[i][hOwned] == 0)
            {
                HouseInfo[i][hPick] = CreateDynamicPickup(1273, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
                HouseInfo[i][hLabel] = Create3DTextLabel(labelstring, 0xFFFFFFFF, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 30.0, 0, 0);
            }
            else if(HouseInfo[i][hOwned] == 1)
            {
                HouseInfo[i][hPick] = CreateDynamicPickup(1272, 1, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ]);
                HouseInfo[i][hLabel] = Create3DTextLabel(stringlabel, 0xFFFFFFFF, HouseInfo[i][hX], HouseInfo[i][hY], HouseInfo[i][hZ], 30.0, 0, 0);
            }
            houseid++;
        }
    }
    print(" ");
    print(" ");
    printf("  LOADED HOUSE: %d/%d", houseid, MAX_HOUSES);
    print(" ");
    print(" ");
    return 1;
}

stock SaveStatsPlayer(playerid)
{
    new file[800];
    new fname[MAX_PLAYER_NAME + 1];
    new Float:X, Float:Y, Float:Z;
    new cash = GetPlayerMoney(playerid);
    new score = GetPlayerScore(playerid);
    new skin = GetPlayerSkin(playerid);
    new role = PlayerInfo[playerid][pRole];
    new lesenkereta = PlayerInfo[playerid][pLesenkereta];
    new cuff = PlayerInfo[playerid][pCuff];
    new vehicleid = GetVehicleModel(playerid);
    PlayerInfo[playerid][pInterior] = GetPlayerInterior(playerid);
    GetPlayerPos(playerid, X, Y, Z);
    GetVehiclePos(playerid, X,Y,Z);
    GetPlayerName(playerid, fname, sizeof fname);
    format(file, sizeof(file), "users/%s.ini", fname);
    if(dini_Exists(file))
    {
        dini_Create(file);
        dini_IntSet(file, "Jail", PlayerInfo[playerid][pJail]);
        dini_IntSet(file, "Admin", PlayerInfo[playerid][pAdmin]);
        dini_IntSet(file, "Score", score);
        dini_IntSet(file, "Minyak", PlayerInfo[playerid][pMinyak]);
        dini_IntSet(file, "Leader", PlayerInfo[playerid][pLeader]);
        dini_IntSet(file, "Lesenkereta", lesenkereta);
        dini_IntSet(file, "Lesenmotor", PlayerInfo[playerid][pLesenmotor]);
        dini_IntSet(file, "Lesengdl", PlayerInfo[playerid][pLesengdl]);
        dini_IntSet(file, "LesenUdara", PlayerInfo[playerid][pLesenUdara]);
        dini_IntSet(file, "Role", role);
        dini_IntSet(file, "Death", PlayerInfo[playerid][pDeath]);
        dini_IntSet(file, "Level", PlayerInfo[playerid][pLevel]);
        dini_IntSet(file, "Skin", skin);
        dini_IntSet(file, "Vip", PlayerInfo[playerid][pVip]);
        dini_IntSet(file, "Ganja", PlayerInfo[playerid][pGanja]);
        dini_IntSet(file, "Dadah", PlayerInfo[playerid][pDadah]);
        dini_IntSet(file, "pKetum", PlayerInfo[playerid][pKetum]);
        dini_IntSet(file, "Cash", cash);
        dini_IntSet(file, "DuitBank", PlayerInfo[playerid][pDuitBank]);
        dini_IntSet(file, "Roadblockpdrm", PlayerInfo[playerid][pRoadblockpdrm]);
        dini_IntSet(file, "SultanPaintjob", PlayerInfo[playerid][pSultanPaintjob]); //SULTAN
        dini_IntSet(file, "SultanTayar", PlayerInfo[playerid][pSultanTayar]);
        dini_IntSet(file, "SultanSpoiler", PlayerInfo[playerid][pSultanSpoiler]);
        dini_IntSet(file, "SultanSideskirt", PlayerInfo[playerid][pSultanSideskirt]);
        dini_IntSet(file, "SultanExhaust", PlayerInfo[playerid][pSultanExhaust]);
        dini_IntSet(file, "SultanRoof", PlayerInfo[playerid][pSultanRoof]);
        dini_IntSet(file, "SultanRearbumper", PlayerInfo[playerid][pSultanRearbumper]);
        dini_IntSet(file, "SultanNitro", PlayerInfo[playerid][pSultanNitro]);
        dini_IntSet(file, "ElegyPaintjob", PlayerInfo[playerid][pElegyPaintjob]); //ELEGY
        dini_IntSet(file, "ElegyTayar", PlayerInfo[playerid][pElegyTayar]);
        dini_IntSet(file, "ElegySpoiler", PlayerInfo[playerid][pElegySpoiler]);
        dini_IntSet(file, "ElegySideskirt", PlayerInfo[playerid][pElegySideskirt]);
        dini_IntSet(file, "ElegyExhaust", PlayerInfo[playerid][pElegyExhaust]);
        dini_IntSet(file, "ElegyRoof", PlayerInfo[playerid][pElegyRoof]);
        dini_IntSet(file, "ElegyRearbumper", PlayerInfo[playerid][pElegyRearbumper]);
        dini_IntSet(file, "ElegyFrontbumper", PlayerInfo[playerid][pElegyFrontbumper]);
        dini_IntSet(file, "ElegyNitro", PlayerInfo[playerid][pElegyNitro]);
        dini_IntSet(file, "Cheetah", PlayerInfo[playerid][pCheetah]);
        dini_IntSet(file, "Bullet", PlayerInfo[playerid][pBullet]);
        dini_IntSet(file, "Tampa", PlayerInfo[playerid][pTampa]);
        dini_IntSet(file, "Saber", PlayerInfo[playerid][pSaber]);
        dini_IntSet(file, "Zr350", PlayerInfo[playerid][pZr350]);
        dini_IntSet(file, "Sultan", PlayerInfo[playerid][pSultan]);
        dini_IntSet(file, "Elegy", PlayerInfo[playerid][pElegy]);
        dini_IntSet(file, "GTSUPER", PlayerInfo[playerid][pGTSUPER]);
        dini_IntSet(file, "Infernus", PlayerInfo[playerid][pInfernus]);
        dini_IntSet(file, "Flash", PlayerInfo[playerid][pFlash]);
        dini_IntSet(file, "NRG500", PlayerInfo[playerid][pNRG500]);
        dini_IntSet(file, "BF400", PlayerInfo[playerid][pBF400]);
        dini_IntSet(file, "Sanchez", PlayerInfo[playerid][pSanchez]);
        dini_IntSet(file, "Wayfarer", PlayerInfo[playerid][pWayfarer]);
        dini_IntSet(file, "Medkit", PlayerInfo[playerid][pMedkit]);
        dini_IntSet(file, "Deserteagle", PlayerInfo[playerid][pDeserteagle]);
        dini_IntSet(file, "M4", PlayerInfo[playerid][pM4]);
        dini_IntSet(file, "Uzi", PlayerInfo[playerid][pUzi]);
        dini_FloatSet(file, "X", X);                  //LAST SPAWN
        dini_FloatSet(file, "Y", Y);
        dini_FloatSet(file, "Z", Z);
        dini_FloatSet(file, "LastX", X);                  //LAST SPAWN
        dini_FloatSet(file, "LastY", Y);
        dini_FloatSet(file, "LastZ", Z);
        dini_IntSet(file, "AccBank", PlayerInfo[playerid][pAccBank]);
        dini_IntSet(file, "Vehicleid", vehicleid);
        dini_IntSet(file, "Repairkit", PlayerInfo[playerid][pRepairkit]);
        dini_IntSet(file, "Cuff", cuff);
        dini_IntSet(file, "SultanColor", PlayerInfo[playerid][pSultanColor]);
        dini_IntSet(file, "ElegyColor", PlayerInfo[playerid][pElegyColor]);
        dini_IntSet(file, "Warn", PlayerInfo[playerid][pWarn]);
        dini_IntSet(file, "SultanFuel", PlayerInfo[playerid][SultanFuel]);
        dini_IntSet(file, "ElegyFuel", PlayerInfo[playerid][ElegyFuel]);
        dini_IntSet(file, "SabreFuel", PlayerInfo[playerid][SabreFuel]);
        dini_IntSet(file, "Lapar", PlayerInfo[playerid][pLapar] );
        dini_IntSet(file, "Haus", PlayerInfo[playerid][pHaus] );
        dini_IntSet(file, "Bun", PlayerInfo[playerid][pBun] );
        dini_IntSet(file, "Biskut", PlayerInfo[playerid][pBiskut] );
        dini_IntSet(file, "MeggiCup", PlayerInfo[playerid][pMeggiCup] );
        dini_IntSet(file, "Mineral", PlayerInfo[playerid][pMineral] );
        dini_IntSet(file, "100Plus", PlayerInfo[playerid][p100Plus] );
        dini_IntSet(file, "Coffee", PlayerInfo[playerid][pCoffee] );
    }
    return 1;
}

stock SendPoliceMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pRole] == 1)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock SendSuruhanjayaMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pRole] == 2)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock SendMedicMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pRole] == 3)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock SendTailongMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pRole] == 4)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock SendMafiaMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pRole] == 5)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock SendAdminMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pAdmin] >= 1)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock CreateRoadblock(Object,Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
    {
        if(Roadblocks[i][sCreated] == 0)
        {
            Roadblocks[i][sCreated] = 1;
            Roadblocks[i][sX] = x;
            Roadblocks[i][sY] = y; 
            Roadblocks[i][sZ] = z;
            Roadblocks[i][sObject] = CreateDynamicObject(Object, x, y, z, 0, 0, Angle);
            return 1;
        }
    }
    return 0;
}

stock DeleteClosestRoadblock(playerid)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
            if(Roadblocks[i][sCreated] == 1)
            {
                Roadblocks[i][sCreated] = 0;
                Roadblocks[i][sX] = 0.0;
                Roadblocks[i][sY] = 0.0;
                Roadblocks[i][sZ] = 0.0;
                DestroyDynamicObject(Roadblocks[i][sObject]);
                return 1;
            }
        }
    }
    return 0;
}

stock DeleteAllRoadblocks(playerid)
{
    for(new i = 0; i < sizeof(Roadblocks); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 300, Roadblocks[i][sX], Roadblocks[i][sY], Roadblocks[i][sZ]))
        {
            if(Roadblocks[i][sCreated] == 1)
            {
                Roadblocks[i][sCreated] = 0;
                Roadblocks[i][sX] = 0.0;
                Roadblocks[i][sY] = 0.0;
                Roadblocks[i][sZ] = 0.0;
                DestroyDynamicObject(Roadblocks[i][sObject]);
            }
        }
    }
    return 0;
}

stock CreatePaku(Object,Float:x,Float:y,Float:z,Float:Angle)
{
    for(new i = 0; i < sizeof(Spikes); i++)
    {
        if(Spikes[i][cCreated] == 0)
        {
            Spikes[i][cCreated] = 1;
            Spikes[i][cX] = x;
            Spikes[i][cY] = y;
            Spikes[i][cZ] = z;
            Spikes[i][cObject] = CreateDynamicObject(Object, x, y, z, 0, 0, Angle);
            return 1;
        }
    }
    return 0;
}

stock DeletePakuBerdekatan(playerid)
{
    for(new i = 0; i < sizeof(Spikes); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 5.0, Spikes[i][cX], Spikes[i][cY], Spikes[i][cZ]))
        {
            if(Spikes[i][cCreated] == 1)
            {
                Spikes[i][cCreated] = 0;
                Spikes[i][cX] = 0.0;
                Spikes[i][cY] = 0.0;
                Spikes[i][cZ] = 0.0;
                DestroyDynamicObject(Spikes[i][cObject]);
                return 1;
            }
        }
    }
    return 0;
}

stock DeleteSemuaPaku(playerid)
{
    for(new i = 0; i < sizeof(Spikes); i++)
    {
        if(IsPlayerInRangeOfPoint(playerid, 300, Spikes[i][cX], Spikes[i][cY], Spikes[i][cZ]))
        {
            if(Spikes[i][cCreated] == 1)
            {
                Spikes[i][cCreated] = 0;
                Spikes[i][cX] = 0.0;
                Spikes[i][cY] = 0.0;
                Spikes[i][cZ] = 0.0;
                DestroyDynamicObject(Spikes[i][cObject]);
            }
        }
    }
    return 0;
}

stock SendVipMessage(col, string[])
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        if(PlayerInfo[i][pVip] == 1)
        SendClientMessage(i, col, string);
    }
    return 1;
}

stock GetFullName(playerid)
{
    new name[24];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

stock GetRPName(playerid)
{
    new
        name[MAX_PLAYER_NAME];
    GetPlayerName(playerid, name, sizeof(name));
    for(new i = 0, l = strlen(name); i < l; i ++)
    {
        if(name[i] == '_')
        {
            name[i] = ' ';
        }
    }
    return name;
}

stock GetPlayerNameEx(playerid)
{
    new sz_playerName[MAX_PLAYER_NAME], i_pos;
    GetPlayerName(playerid, sz_playerName, MAX_PLAYER_NAME);
    while ((i_pos = strfind(sz_playerName, "_", false, i_pos)) != -1) sz_playerName[i_pos] = ' ';
    return sz_playerName;
}

stock ret_pName(playerid)
{
    new name[24];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

stock str_replace(string[], find, replace)
{
    for(new i=0; string[i]; i++) { if(string[i] == find) { string[i] = replace; } }
}

stock ABroadCast(color,string[],level)
{
    foreach(Player, i)
    {
        if (PlayerInfo[i][pAdmin] >= level)
        {
            SendClientMessage(i, color, string);
            printf("%s", string);
        }
    }
    return 1;
}

stock IsNumeric(const string[])
{
    for (new i = 0, j = strlen(string); i < j; i++)
    {
        if (string[i] > '9' || string[i] < '0') return 0;
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
stock IsABike(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 461,463,468,521,522,523,581,586,481,409,510: return 1;
    }
    return 0;
}

stock IsAVehicle(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case
            400,
            401,
            402,
            404,
            405,
            409,
            410,
            411,
            412,
            415,
            419,
            420,
            421,
            422,
            424,
            426,
            429,
            436,
            434,
            438,
            439,
            445,
            451,
            458,
            466,
            467,
            474,
            475,
            477,
            479,
            480,
            489,
            491,
            492,
            494,
            496,
            500,
            502,
            503,
            504,
            505,
            506,
            516,
            518,
            517,
            526,
            527,
            529,
            533,
            535,
            536,
            540,
            541,
            542,
            543,
            545,
            546,
            547,
            548,
            649,
            550,
            551,
            554,
            555,
            558,
            559,
            560,
            561,
            562,
            563,
            565,
            566,
            567,
            575,
            576,
            579,
            580,
            585,
            587,
            589,
            600,
            602,
            603: 
            return 1;
    }
    return 0;
}

stock IsAGdl(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case
            403,
            406,
            408,
            414,
            416,
            418,
            423,
            428,
            431,
            433,
            437,
            440,
            443,
            445,
            455,
            456,
            459,
            478,
            482,
            486,
            485,
            498,
            499,
            508,
            514,
            515,
            524,
            525,
            530,
            531,
            532,
            552,
            573,
            578,
            582,
            583,
            588,
            609: return 1;
    }
    return 0;
}

stock IsAHelicopter(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case
            417,
            425,
            447,
            497,
            548,
            563: return 1;
    }
    return 0;
}

stock IsAPlane(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case
            593,
            592,
            577,
            553,
            519,
            512,
            513,
            511,
            476,
            460,
            520: return 1;
    }
    return 0;
}

stock ModifyVehicleSpeed(vehicleid,mph)
{
    new Float:Vx,Float:Vy,Float:Vz,Float:Speed,Float:multiple;
    GetVehicleVelocity(vehicleid,Vx,Vy,Vz);
    Speed = floatsqroot(Vx*Vx + Vy*Vy + Vz*Vz);
    if(Speed > 0)
    {
        multiple = ((mph + Speed * 100) / (Speed * 100));
        return SetVehicleVelocity(vehicleid,Vx*multiple,Vy*multiple,Vz*multiple);
    }
    return 0;
}

stock IsAtImpound(playerid)
{
    if(IsPlayerConnected(playerid))
    {
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1487.1653,-1725.0394,13.5469))//DATARAN
        {
            SCM(Playerid, -1, "Sila Tekan Format yg disediakan");
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1325.6984,1279.7039,10.8203))//Lesen
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1257.1165,-2025.9359,59.5023))//SPAWN RAKYAT
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2827.9924,1290.8412,10.7693))//mafia
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1282.4229,-1669.1729,13.5529))//BANK
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1601.0554,-1609.1011,13.4746))//POLIS
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1176.4408,-1308.0441,13.9626))//KKM
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1659.9290,-1704.5850,20.4772))//JPJ
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1535.0077,716.1779,10.8203))//YAKUZA
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1479.7106,2841.7881,10.8203))//Kongsi
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2498.4270,1538.1479,10.8203))//SCAR77
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1232.8434,-1259.5446,13.5228))//STARBUCKS
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1242.8713,-806.8870,84.1406))//ADMIN
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1817.5563,891.9930,9.8750))//SPG
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 2104.7385,-1774.7881,13.3920))//PIZZA
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1778.8472,-1692.9858,13.4532))//lorisampah
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 909.6874, -1728.8009, 13.2229)//car dealer
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1612.8627,-1838.6803,13.5217)//FNF
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1557.7644,-1255.0266,17.5062))//hargakenderaan
        {
            return 1;
        }
        if(IsPlayerInRangeOfPoint(playerid, 2.0, 1553.2930,-1255.0669,17.5062))//belikenderaan 
        {
            return 1;
        }
    }
    return 1;
}

stock KickWithMessage(playerid, color, message[])
{
    SendClientMessage(playerid, color, message);
    SetTimerEx("KickPublic", 1000, 0, "d", playerid);
}

stock IsPlayerName(playerid)
{
    new name[MAX_PLAYERS];
    GetPlayerName(playerid, name, sizeof(name));
    return name;
}

stock CreateRp(playerid,text[])
{
    new string[300];
    format(string,sizeof(string),"* %s %s",GetRPName(playerid),text);
    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}

stock CreateDo(playerid,text[])
{
    new string[300];
    format(string,sizeof(string),"* %s (( %s ))",text,GetRPName(playerid));
    ProxDetector(30.0, playerid, string, COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE,COLOR_PURPLE);
    return 1;
}

stock SaveData()
{
    for(new i = 0; i < MAX_PLAYERS; i++)
    {
        SaveStatsPlayer(i);
    }
    return 1;
}

stock GivePlayerMoneyEx(playerid, amount)
{
    if(GetPlayerMoney(playerid) < amount) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" Duit Anda Tidak Mencukupi");
    PlayerInfo[playerid][pCash] += amount;
    GivePlayerMoney(playerid, amount);
    return amount;
}

stock GiveMoneyPayday(playerid, amount)
{
    PlayerInfo[playerid][pCash] += amount;
    GivePlayerMoney(playerid, amount);
    return amount;
}

stock TolakDuitPlayer(playerid, amount)
{
    PlayerInfo[playerid][pCash] -= amount;
    GivePlayerMoney(playerid, -amount);
    return amount;
}

public OnPlayerWeaponShot(playerid, weaponid, hittype, hitid, Float:fX, Float:fY, Float:fZ)
{
    if(PlayerInfo[playerid][pRole] == 1 || PlayerInfo[playerid][pAdmin] >= 5)
    {
        if(weaponid == 23)
        {
            if(hittype == BULLET_HIT_TYPE_PLAYER)
            {
                new string[248];
                ApplyAnimation(hitid, "CRACK","crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
                TogglePlayerControllable(hitid, false);
                SetTimerEx("Unfreeze", 20000, false, "i", hitid);
                format(string, sizeof(string), ""COL_Pdrm"[INFO TAZER]: " COL_WHITE"ANDA TELAH DI TAZER OLEH PEGAWAI %s", GetRPName(playerid));
                SCM(hitid, COLOR_LIGHTBLUE, string);
            }
        }
    }
    return 1;
}

CMD:setminyak(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 3)
    {
        new targetid, level;
        new string[300];
        if(sscanf(params, "ui", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /setfuel [playerid] [peratus]");
        PlayerInfo[targetid][pMinyak] = level;
        format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Set Fuel %s Kepada %d Peratus", GetRPName(targetid), level);
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
        format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Set Fuel Anda Kepada %d Peratus", GetRPName(playerid), level);
        SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
    }
    else return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Hanya Admin Sahaja Yang Boleh Guna Command Ini");
    return 1;
}

native IsValidVehicle(vehicleid);

CMD:tow(playerid, params[])
{
    new vehicle = GetPlayerVehicleID(playerid);
    new model = GetVehicleModel(vehicle);
    new targetVehicle, Float:targetVehicleDistance, closestVehicle, Float:closestVehicleDistance = 7.0, found = 0;
    new Float:tX, Float:tY, Float:tZ;
    if(PlayerInfo[playerid][pRole] == 4 || PlayerInfo[playerid][pAdmin] >= 1)
    {
        if((GetPlayerState(playerid) == PLAYER_STATE_DRIVER) && (model == 525 || model == 531)) 
        {
            while(targetVehicle < MAX_VEHICLES) 
            {
                GetVehiclePos(targetVehicle, tX, tY, tZ);
                targetVehicleDistance = GetVehicleDistanceFromPoint(vehicle, tX, tY, tZ);
                if(IsValidVehicle(targetVehicle) && (floatcmp(targetVehicleDistance, 7.0) <= 0) && (targetVehicle != vehicle) && (floatcmp(targetVehicleDistance, closestVehicleDistance) <= 0)) 
                {
                    found = 1;
                    closestVehicle = targetVehicle;
                    closestVehicleDistance = targetVehicleDistance;
                }
                targetVehicle++;
            }
            if(found) 
            {
                if(IsTrailerAttachedToVehicle(vehicle))
                {
                    DetachTrailerFromVehicle(vehicle);
                }
                AttachTrailerToVehicle(closestVehicle, vehicle);
            }
        }
    }
    return 1;
}

CMD:phone(playerid, params[])
{
    ShowPlayerDialog(playerid, PHONE, DIALOG_STYLE_LIST, "MY PHONE", "WAZE \nTWITTER \nSHARELOC", "Pilih", "Tutup");
    return 1;
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
    new vid = GetPlayerVehicleID(playerid);
    if(engine == VEHICLE_PARAMS_ON)
    {
        SetVehicleParamsEx(vid,VEHICLE_PARAMS_ON,lights,alarm,doors,bonnet,boot,objective);
    }
    else if(engine == VEHICLE_PARAMS_OFF)
    {
        SetVehicleParamsEx(vid,VEHICLE_PARAMS_OFF,lights,alarm,doors,bonnet,boot,objective);
    }
	return 1;
}

Function:RandomMoneySpeedTrap(playerid)
{   
    new speedtrap = RandomEx(0,4);
    new vehicle = GetPlayerVehicleID(playerid);
    new string[300];
    if(speedtrap == 0)
    {
        TolakDuitPlayer(playerid, 1000);
        CreateRp(playerid, "Telah Di Tolak Duit Sebanyak 1000 Sbb speedtrap");
        format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"DUIT ANDA TELAH DI TOLAK SEBANYAK RM1000, KELAJUAN %d/250KMH", GetVehicleSpeed(vehicle));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    }
    if(speedtrap == 1)
    {
        TolakDuitPlayer(playerid, 3045);
        CreateRp(playerid, "Telah Di Tolak Duit Sebanyak 1000 Sbb speedtrap");
        format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"DUIT ANDA TELAH DI TOLAK SEBANYAK RM1000, KELAJUAN %d/250KMH", GetVehicleSpeed(vehicle));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    }
    if(speedtrap == 2)
    {
        TolakDuitPlayer(playerid, 141);
        CreateRp(playerid, "Telah Di Tolak Duit Sebanyak 1000 Sbb speedtrap");
        format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"DUIT ANDA TELAH DI TOLAK SEBANYAK RM1000, KELAJUAN %d/250KMH", GetVehicleSpeed(vehicle));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    }
    if(speedtrap == 3)
    {
        TolakDuitPlayer(playerid, 2301);
        CreateRp(playerid, "Telah Di Tolak Duit Sebanyak 1000 Sbb speedtrap");
        format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"DUIT ANDA TELAH DI TOLAK SEBANYAK RM1000, KELAJUAN %d/250KMH", GetVehicleSpeed(vehicle));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    }
    if(speedtrap == 4)
    {
        TolakDuitPlayer(playerid, 1190);
        CreateRp(playerid, "Telah Di Tolak Duit Sebanyak 1000 Sbb speedtrap");
        format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"DUIT ANDA TELAH DI TOLAK SEBANYAK RM1000, KELAJUAN %d/250KMH", GetVehicleSpeed(vehicle));
        SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
    }
    return 1;
}

CMD:cd(playerid, params[])
{
    new sec,
	Float:x, Float:y, Float:z;
	if(sscanf(params, "d", sec)) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE"/cd [3 - 8 Saat]");
	if(InCountDown == 1) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Countdown Sedang Dimulakan");
	if(sec < 1 || sec > 8) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE"/cd [3 - 8 Saat]");
	GetPlayerPos(playerid, x, y, z);
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
	    if(IsPlayerConnected(i))
		{
		    if(IsPlayerInRangeOfPoint(i, 20, x, y, z))
            {
                if(sec == 8) { TimerCountDown[i] = SetTimerEx("CountDown8", 1000, false, "i", i); }
                if(sec == 7) { TimerCountDown[i] = SetTimerEx("CountDown7", 1000, false, "i", i); }
                if(sec == 6) { TimerCountDown[i] = SetTimerEx("CountDown6", 1000, false, "i", i); }
                if(sec == 5) { TimerCountDown[i] = SetTimerEx("CountDown5", 1000, false, "i", i); }
                if(sec == 4) { TimerCountDown[i] = SetTimerEx("CountDown4", 1000, false, "i", i); }
                if(sec == 3) { TimerCountDown[i] = SetTimerEx("CountDown3", 1000, false, "i", i); }
            }
        }
    }
	InCountDown = 1;
    CreateRp(playerid, "Telah Memulakan CountDown.");
    return 1;
}

//================== COUNTDOWN ====================================================

Function:CountDown8(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, "~g~:: 8 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown7", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown7(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, ":: 7 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown6", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown6(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, "~g~:: 6 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown5", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown5(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, ":: 5 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown4", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown4(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, "~g~:: 4 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown3", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown3(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, ":: 3 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown2", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown2(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, "~g~:: 2 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown1", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown1(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, ":: 1 ::", 1000, 3);
    PlayerPlaySound(playerid, 1056, 0, 0, 0);
	TimerCountDown[playerid] = SetTimerEx("CountDown0", 1000, false, "i", playerid);
	return 1;
}

Function:CountDown0(playerid)
{
    KillTimer(TimerCountDown[playerid]);
    GameTextForPlayer(playerid, "~r~:: GO! GO! GO! ::", 1000, 3);
    PlayerPlaySound(playerid, 1057, 0, 0, 0);
    InCountDown = 0;
	return 1;
}

Funtion:OnClientCheckResponse(playerid, type, arg, response)
{
    switch(type) 
    { 
        case 0x48: 
        {
            SetPVarInt(playerid, "NotAndroid", 1); 
        } 
    }
    return 1;
}


PlayAnim(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync)
{
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
}

PlayAnimEx(playerid, animlib[], animname[], Float:fDelta, loop, lockx, locky, freeze, time, forcesync)
{
	gPlayerUsingLoopingAnim[playerid] = 1;
	ApplyAnimation(playerid, animlib, animname, fDelta, loop, lockx, locky, freeze, time, forcesync);
}

StopLoopingAnim(playerid)
{
	gPlayerUsingLoopingAnim[playerid] = 0;
    ApplyAnimation(playerid, "CARRY", "crry_prtial", 4.0, 0, 0, 0, 0, 0, 1);
}

PreloadAnimLib(playerid, animlib[])
{
	ApplyAnimation(playerid,animlib,"null",0.0,0,0,0,0,0,1);
}

IsAblePedAnimation(playerid)
{
    if(GetPVarInt(playerid, "PlayerCuffed") != 0 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1)
	{
   		SendClientMessage(playerid, COLOR_GRAD2, "You can't do that at this time!");
   		return 0;
	}
    if(IsPlayerInAnyVehicle(playerid) == 1)
    {
		SendClientMessage(playerid, COLOR_GRAD2, "This animation requires you to be outside a vehicle.");
		return 0;
	}
	return 1;
}

IsAbleVehicleAnimation(playerid)
{
    if(GetPVarInt(playerid, "PlayerCuffed") != 0 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1)
	{
   		SendClientMessage(playerid, COLOR_GRAD2, "You can't do that at this time!");
   		return 0;
	}
	if(IsPlayerInAnyVehicle(playerid) == 0)
    {
		SendClientMessage(playerid, COLOR_GRAD2, "This animation requires you to be inside a vehicle.");
		return 0;
	}
	return 1;
}

IsCLowrider(carid)
{
	new Cars[] = { 536, 575, 567};
	for(new i = 0; i < sizeof(Cars); i++)
	{
		if(GetVehicleModel(carid) == Cars[i]) return 1;
	}
	return 0;
}

CMD:animlist(playerid, params[])
{
	SendClientMessage(playerid, COLOR_GREEN, "Available Animations:");
	SendClientMessage(playerid, COLOR_GRAD1, "/handsup /drunk /bomb /rob /laugh /lookout /robman /crossarms /sit /siteat /hide /vomit /eat");
	SendClientMessage(playerid, COLOR_GRAD2, "/wave /slapass /deal /taichi /crack /smoke /chat /dance /fucku /taichi /drinkwater /pedmove");
	SendClientMessage(playerid, COLOR_GRAD3, "/checktime /sleep /blob /opendoor /wavedown /shakehand /reloads /cpr /dive /showoff /box /tag");
	SendClientMessage(playerid, COLOR_GRAD4, "/goggles /cry /dj /cheer /throw /robbed /hurt /nobreath /bar /getjiggy /fallover /rap /piss");
	SendClientMessage(playerid, COLOR_GRAD5, "/salute /crabs /washhands /signal /stop /gesture /jerkoff /idles /lowrider /carchat");
	SendClientMessage(playerid, COLOR_GRAD6, "/blowjob /spank /sunbathe /kiss /snatch /sneak /copa /sexy /holdup /misc /bodypush");
	SendClientMessage(playerid, COLOR_GRAD6, "/lowbodypush /headbutt /airkick /doorkick /leftslap /elbow /coprun");
	SendClientMessage(playerid, COLOR_GREEN, "Use /stopani to stop an animation.");
	return 1;
}

CMD:animhelp(playerid, params[])
{
	return cmd_animlist(playerid, params);
}

CMD:stopani(playerid, params[])
{
	if(GetPVarInt(playerid, "PlayerCuffed") != 0 || GetPVarInt(playerid, "Injured") == 1 || GetPVarInt(playerid, "IsFrozen") == 1)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "You can't do that at this time!");
		return 1;
	}
	if(IsPlayerInAnyVehicle(playerid) == 1)
	{
		SendClientMessage(playerid, COLOR_GRAD2, "This command requires you to be outside a vehicle.");
		return 1;
	}
	ClearAnimations(playerid);
	SetPlayerSkin(playerid, GetPlayerSkin(playerid));
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_NONE);
	return 1;
}

CMD:bodypush(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"GANGS","shake_cara",4.0,0,0,0,0,0);
	return 1;
}

CMD:lowbodypush(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"GANGS","shake_carSH",4.0,0,0,0,0,0);
	return 1;
}

CMD:headbutt(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"WAYFARER","WF_Fwd",4.0,0,0,0,0,0);
	return 1;
}

CMD:airkick(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"FIGHT_C","FightC_M",4.0,0,1,1,0,0);
	return 1;
}

CMD:doorkick(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"POLICE","Door_Kick",4.0,0,0,0,0,0);
	return 1;
}

CMD:leftslap(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"PED","BIKE_elbowL",4.0,0,0,0,0,0);
	return 1;
}

CMD:elbow(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"FIGHT_D","FightD_3",4.0,0,1,1,0,0);
	return 1;
}

CMD:coprun(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    ApplyAnimation(playerid,"SWORD","sword_block",50.0,0,1,1,1,1);
	return 1;
}

CMD:handsup(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	ApplyAnimation(playerid, "ROB_BANK","SHP_HandsUp_Scr",4.1, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:piss(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
   	SetPlayerSpecialAction(playerid, 68);
	return 1;
}

CMD:sneak(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "PED", "Player_Sneak", 4.1, 1, 1, 1, 1, 1, 1);
	return 1;
}

CMD:drunk(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
   	PlayAnimEx(playerid, "PED", "WALK_DRUNK", 4.0, 1, 1, 1, 1, 1, 1);
    return 1;
}

CMD:bomb(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
   	PlayAnim(playerid, "BOMBER", "BOM_Plant", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:rob(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "ped", "ARRESTgun", 4.0, 0, 1, 1, 1, 1, 1);
	return 1;
}

CMD:laugh(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	PlayAnimEx(playerid, "RAPPING", "Laugh_01", 4.0, 1, 0, 0, 0, 0, 1);
	return 1;
}

CMD:lookout(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
   	PlayAnim(playerid, "SHOP", "ROB_Shifty", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:robman(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "ROB_Loop_Threat", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hide(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ped", "cower", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:vomit(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Vomit_P", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:eat(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "FOOD", "EAT_Burger", 3.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:slapass(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "SWEET", "sweet_ass_slap", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crack(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckdeth2", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:fucku(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "PED", "fucku", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:taichi(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PARK", "Tai_Chi_Loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:drinkwater(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "BAR", "dnk_stndF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:checktime(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "COP_AMBIENT", "Coplook_watch", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:sleep(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckdeth4", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:blob(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "CRACK", "crckidle1", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:opendoor(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "AIRPORT", "thrw_barl_thrw", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:wavedown(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "BD_FIRE", "BD_Panic_01", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cpr(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "MEDIC", "CPR", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:dive(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "DODGE", "Crush_Jump", 4.0, 0, 1, 1, 1, 0, 1);
    return 1;
}

CMD:showoff(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "Freeweights", "gym_free_celebrate", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:goggles(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "goggles", "goggles_put_on", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:cry(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "GRAVEYARD", "mrnF_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:throw(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnim(playerid, "GRENADE", "WEAPON_throw", 4.0, 0, 0, 0, 0, 0, 1);
    return 1;
}

CMD:robbed(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SHOP", "SHP_Rob_GiveCash", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:hurt(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "SWAT", "gnstwall_injurd", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:box(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "GYMNASIUM", "GYMshadowbox", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:washhands(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "BD_FIRE", "wash_up", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:crabs(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "MISC", "Scratchballs_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:salute(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "ON_LOOKERS", "Pointup_loop", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:jerkoff(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PAULNMAC", "wank_out", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:stop(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
    PlayAnimEx(playerid, "PED", "endchat_01", 4.0, 1, 0, 0, 0, 0, 1);
    return 1;
}

CMD:rap(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "RAPPING", "RAP_A_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "RAPPING", "RAP_B_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "RAPPING", "RAP_C_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /rap [1-3]");
	}
	return 1;
}

CMD:chat(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "PED", "IDLE_CHAT", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkA", 4.0, 1, 0, 0, 0, 0, 1);
        case 3:	PlayAnimEx(playerid, "GANGS", "prtial_gngtlkB", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkE", 4.0, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkF", 4.0, 1, 0, 0, 0, 0, 1);
        case 6: PlayAnimEx(playerid, "GANGS", "prtial_gngtlkG", 4.0, 1, 0, 0, 0, 0, 1);
        case 7:	PlayAnimEx(playerid, "GANGS", "prtial_gngtlkH", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /chat [1-7]");
	}
	return 1;
}

CMD:gesture(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnim(playerid, "GHANDS", "gsign1", 4.0, 0, 0, 0, 0, 0, 1);
        case 2: PlayAnim(playerid, "GHANDS", "gsign1LH", 4.0, 0, 0, 0, 0, 0, 1);
        case 3: PlayAnim(playerid, "GHANDS", "gsign2", 4.0, 0, 0, 0, 0, 0, 1);
        case 4: PlayAnim(playerid, "GHANDS", "gsign2LH", 4.0, 0, 0, 0, 0, 0, 1);
        case 5: PlayAnim(playerid, "GHANDS", "gsign3", 4.0, 0, 0, 0, 0, 0, 1);
        case 6: PlayAnim(playerid, "GHANDS", "gsign3LH", 4.0, 0, 0, 0, 0, 0, 1);
        case 7: PlayAnim(playerid, "GHANDS", "gsign4", 4.0, 0, 0, 0, 0, 0, 1);
        case 8: PlayAnim(playerid, "GHANDS", "gsign4LH", 4.0, 0, 0, 0, 0, 0, 1);
        case 9: PlayAnim(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
        case 10: PlayAnim(playerid, "GHANDS", "gsign5", 4.0, 0, 0, 0, 0, 0, 1);
        case 11: PlayAnim(playerid, "GHANDS", "gsign5LH", 4.0, 0, 0, 0, 0, 0, 1);
        case 12: PlayAnim(playerid, "GANGS", "Invite_No", 4.0, 0, 0, 0, 0, 0, 1);
        case 13: PlayAnim(playerid, "GANGS", "Invite_Yes", 4.0, 0, 0, 0, 0, 0, 1);
        case 14: PlayAnim(playerid, "GANGS", "prtial_gngtlkD", 4.0, 0, 0, 0, 0, 0, 1);
        case 15: PlayAnim(playerid, "GANGS", "smkcig_prtl", 4.0, 0, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /gesture [1-15]");
	}
	return 1;
}

CMD:lay(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /lay [1-3]");
	}
	return 1;
}

CMD:wave(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "ON_LOOKERS", "wave_loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "KISSING", "gfwave2", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "PED", "endchat_03", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /wave [1-3]");
	}
	return 1;
}

CMD:signal(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "POLICE", "CopTraf_Come", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "POLICE", "CopTraf_Stop", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /signal [1-2]");
	}
	return 1;
}

CMD:nobreath(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "SWEET", "Sweet_injuredloop", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "PED", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "FAT", "IDLE_tired", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /nobreath [1-3]");
	}
	return 1;
}

CMD:fallover(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "KNIFE", "KILL_Knife_Ped_Die", 4.0, 0, 1, 1, 1, 0, 1);
        case 2: PlayAnimEx(playerid, "PED", "KO_shot_face", 4.0, 0, 1, 1, 1, 0, 1);
        case 3: PlayAnimEx(playerid, "PED", "KO_shot_stom", 4.0, 0, 1, 1, 1, 0, 1);
        case 4: PlayAnimEx(playerid, "PED", "BIKE_fallR", 4.1, 0, 1, 1, 1, 0, 1);
        case 5: PlayAnimEx(playerid, "PED", "BIKE_fall_off", 4.1, 0, 1, 1, 1, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /fallover [1-5]");
	}
	return 1;
}

CMD:pedmove(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "PED", "JOG_femaleA", 4.0, 1, 1, 1, 1, 1, 1);
        case 2: PlayAnimEx(playerid, "PED", "JOG_maleA", 4.0, 1, 1, 1, 1, 1, 1);
        case 3: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 4: PlayAnimEx(playerid, "PED", "run_fat", 4.0, 1, 1, 1, 1, 1, 1);
        case 5: PlayAnimEx(playerid, "PED", "run_fatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 6: PlayAnimEx(playerid, "PED", "run_old", 4.0, 1, 1, 1, 1, 1, 1);
        case 7: PlayAnimEx(playerid, "PED", "Run_Wuzi", 4.0, 1, 1, 1, 1, 1, 1);
        case 8: PlayAnimEx(playerid, "PED", "swat_run", 4.0, 1, 1, 1, 1, 1, 1);
        case 9: PlayAnimEx(playerid, "PED", "WALK_fat", 4.0, 1, 1, 1, 1, 1, 1);
        case 10: PlayAnimEx(playerid, "PED", "WALK_fatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 11: PlayAnimEx(playerid, "PED", "WALK_gang1", 4.0, 1, 1, 1, 1, 1, 1);
        case 12: PlayAnimEx(playerid, "PED", "WALK_gang2", 4.0, 1, 1, 1, 1, 1, 1);
        case 13: PlayAnimEx(playerid, "PED", "WALK_old", 4.0, 1, 1, 1, 1, 1, 1);
        case 14: PlayAnimEx(playerid, "PED", "WALK_shuffle", 4.0, 1, 1, 1, 1, 1, 1);
        case 15: PlayAnimEx(playerid, "PED", "woman_run", 4.0, 1, 1, 1, 1, 1, 1);
        case 16: PlayAnimEx(playerid, "PED", "WOMAN_runbusy", 4.0, 1, 1, 1, 1, 1, 1);
        case 17: PlayAnimEx(playerid, "PED", "WOMAN_runfatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 18: PlayAnimEx(playerid, "PED", "woman_runpanic", 4.0, 1, 1, 1, 1, 1, 1);
        case 19: PlayAnimEx(playerid, "PED", "WOMAN_runsexy", 4.0, 1, 1, 1, 1, 1, 1);
        case 20: PlayAnimEx(playerid, "PED", "WOMAN_walkbusy", 4.0, 1, 1, 1, 1, 1, 1);
        case 21: PlayAnimEx(playerid, "PED", "WOMAN_walkfatold", 4.0, 1, 1, 1, 1, 1, 1);
        case 22: PlayAnimEx(playerid, "PED", "WOMAN_walknorm", 4.0, 1, 1, 1, 1, 1, 1);
        case 23: PlayAnimEx(playerid, "PED", "WOMAN_walkold", 4.0, 1, 1, 1, 1, 1, 1);
        case 24: PlayAnimEx(playerid, "PED", "WOMAN_walkpro", 4.0, 1, 1, 1, 1, 1, 1);
        case 25: PlayAnimEx(playerid, "PED", "WOMAN_walksexy", 4.0, 1, 1, 1, 1, 1, 1);
        case 26: PlayAnimEx(playerid, "PED", "WOMAN_walkshop", 4.0, 1, 1, 1, 1, 1, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /pedmove [1-26]");
	}
	return 1;
}

CMD:getjiggy(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "DANCING", "DAN_Down_A", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "DANCING", "DAN_Left_A", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "DANCING", "DAN_Loop_A", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "DANCING", "DAN_Right_A", 4.0, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "DANCING", "DAN_Up_A", 4.0, 1, 0, 0, 0, 0, 1);
        case 6: PlayAnimEx(playerid, "DANCING", "dnce_M_a", 4.0, 1, 0, 0, 0, 0, 1);
        case 7: PlayAnimEx(playerid, "DANCING", "dnce_M_b", 4.0, 1, 0, 0, 0, 0, 1);
        case 8: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
        case 9: PlayAnimEx(playerid, "DANCING", "dnce_M_c", 4.0, 1, 0, 0, 0, 0, 1);
        case 10: PlayAnimEx(playerid, "DANCING", "dnce_M_d", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /getjiggy [1-10]");
	}
	return 1;
}

CMD:stripclub(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "STRIP", "PLY_CASH", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "STRIP", "PUN_CASH", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /stripclub [1-2]");
	}
	return 1;
}


CMD:smoke(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnim(playerid, "SMOKING", "M_smk_in", 4.0, 0, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "SMOKING", "M_smklean_loop", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /smoke [1-2]");
	}
	return 1;
}

CMD:dj(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "SCRATCHING", "scdldlp", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "SCRATCHING", "scdlulp", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "SCRATCHING", "scdrdlp", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "SCRATCHING", "scdrulp", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /dj [1-4]");
	}
	return 1;
}

CMD:reloads(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnim(playerid, "BUDDY", "buddy_reload", 4.0, 0, 0, 0, 0, 0, 1);
        case 2: PlayAnim(playerid, "PYTHON", "python_reload", 4.0, 0, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /reloads [1-2]");
	}
	return 1;
}

CMD:tag(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "GRAFFITI", "graffiti_Chkout", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "GRAFFITI", "spraycan_fire", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /tag [1-2]");
	}
	return 1;
}

CMD:deal(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "DEALER", "DEALER_DEAL", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "DEALER", "shop_pay", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /deal [1-2]");
	}
	return 1;
}

CMD:crossarms(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.0, 0, 1, 1, 1, -1, 1);
        case 2: PlayAnimEx(playerid, "DEALER", "DEALER_IDLE", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "GRAVEYARD", "mrnM_loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "GRAVEYARD", "prst_loopa", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /crossarms [1-4]");
	}
	return 1;
}

CMD:cheer(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "ON_LOOKERS", "shout_01", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "ON_LOOKERS", "shout_02", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "ON_LOOKERS", "shout_in", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "RIOT", "RIOT_ANGRY_B", 4.0, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "RIOT", "RIOT_CHANT", 4.0, 1, 0, 0, 0, 0, 1);
        case 6: PlayAnimEx(playerid, "RIOT", "RIOT_shout", 4.0, 1, 0, 0, 0, 0, 1);
        case 7: PlayAnimEx(playerid, "STRIP", "PUN_HOLLER", 4.0, 1, 0, 0, 0, 0, 1);
        case 8: PlayAnimEx(playerid, "OTB", "wtchrace_win", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /cheer [1-8]");
	}
	return 1;
}

CMD:sit(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "BEACH", "bather", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "BEACH", "Lay_Bac_Loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "BEACH", "ParkSit_W_loop", 4.0, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "BEACH", "SitnWait_loop_W", 4.0, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "BEACH", "ParkSit_M_loop", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sit [1-5]");
	}
	return 1;
}

CMD:siteat(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat3", 4.0, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "FOOD", "FF_Sit_Eat2", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /siteat [1-2]");
	}
	return 1;
}

CMD:bar(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnim(playerid, "BAR", "Barcustom_get", 4.0, 0, 1, 0, 0, 0, 1);
        case 2: PlayAnim(playerid, "BAR", "Barserve_bottle", 4.0, 0, 0, 0, 0, 0, 1);
        case 3: PlayAnim(playerid, "BAR", "Barserve_give", 4.0, 0, 0, 0, 0, 0, 1);
        case 4: PlayAnim(playerid, "BAR", "dnk_stndM_loop", 4.0, 0, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "BAR", "BARman_idle", 4.0, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /bar [1-5]");
	}
	return 1;
}

CMD:dance(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: SetPlayerSpecialAction(playerid, 5);
        case 2: SetPlayerSpecialAction(playerid, 6);
        case 3: SetPlayerSpecialAction(playerid, 7);
        case 4: SetPlayerSpecialAction(playerid, 8);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /dance [1-4]");
	}
	return 1;
}

CMD:spank(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "SNM", "SPANKINGW", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "SNM", "SPANKINGP", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnimEx(playerid, "SNM", "SPANKEDW", 4.1, 1, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "SNM", "SPANKEDP", 4.1, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /spank [1-4]");
	}
	return 1;
}

CMD:sexy(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "STRIP", "strip_E", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnimEx(playerid, "STRIP", "strip_G", 4.1, 1, 0, 0, 0, 0, 1);
        case 3: PlayAnim(playerid, "STRIP", "STR_A2B", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: PlayAnimEx(playerid, "STRIP", "STR_Loop_A", 4.1, 1, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "STRIP", "STR_Loop_B", 4.1, 1, 0, 0, 0, 0, 1);
        case 6: PlayAnimEx(playerid, "STRIP", "STR_Loop_C", 4.1, 1, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sexy [1-6]");
	}
	return 1;
}

CMD:holdup(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "POOL", "POOL_ChalkCue", 4.1, 0, 1, 1, 1, 1, 1);
        case 2: PlayAnimEx(playerid, "POOL", "POOL_Idle_Stance", 4.1, 0, 1, 1, 1, 1, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /holdup [1-2]");
	}
	return 1;
}

CMD:copa(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnim(playerid, "POLICE", "CopTraf_Away", 4.1, 0, 0, 0, 0, 0, 1);
        case 2: PlayAnim(playerid, "POLICE", "CopTraf_Come", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: PlayAnim(playerid, "POLICE", "CopTraf_Left", 4.1, 0, 0, 0, 0, 0, 1);
        case 4: PlayAnim(playerid, "POLICE", "CopTraf_Stop", 4.1, 0, 0, 0, 0, 0, 1);
        case 5: PlayAnimEx(playerid, "POLICE", "Cop_move_FWD", 4.1, 1, 1, 1, 1, 1, 1);
        case 6: PlayAnimEx(playerid, "POLICE", "crm_drgbst_01", 4.1, 0, 0, 0, 1, 5000, 1);
        case 7: PlayAnim(playerid, "POLICE", "Door_Kick", 4.1, 0, 1, 1, 1, 1, 1);
        case 8: PlayAnim(playerid, "POLICE", "plc_drgbst_01", 4.1, 0, 0, 0, 0, 5000, 1);
        case 9: PlayAnim(playerid, "POLICE", "plc_drgbst_02", 4.1, 0, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /copa [1-9]");
	}
	return 1;
}

CMD:misc(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
        case 1: PlayAnimEx(playerid, "CAR", "Fixn_Car_Loop", 4.1, 1, 0, 0, 0, 0, 1);
        case 2: PlayAnim(playerid, "CAR", "flag_drop", 4.1, 0, 0, 0, 0, 0, 1);
        case 3: PlayAnim(playerid, "PED", "bomber", 4.1, 0, 0, 0, 0, 0, 1);
        default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /misc [1-3]");
	}
	return 1;
}

CMD:snatch(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnim(playerid, "PED", "BIKE_elbowL", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: PlayAnim(playerid, "PED", "BIKE_elbowR", 4.1, 0, 0, 0, 0, 0, 1);
		default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /snatch [1-2]");
	}
	return 1;
}

CMD:blowjob(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_COUCH_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1);
		case 2: PlayAnimEx(playerid, "BLOWJOBZ", "BJ_STAND_LOOP_P", 4.1, 1, 0, 0, 0, 0, 1); 
		default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /blowjob [1-2]");
	}
	return 1;
}

CMD:kiss(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnim(playerid, "KISSING", "Playa_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 2: PlayAnim(playerid, "KISSING", "Playa_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 3: PlayAnim(playerid, "KISSING", "Playa_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
		case 4: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_01", 4.1, 0, 0, 0, 0, 0, 1);
		case 5: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_02", 4.1, 0, 0, 0, 0, 0, 1);
		case 6: PlayAnim(playerid, "KISSING", "Grlfrd_Kiss_03", 4.1, 0, 0, 0, 0, 0, 1);
		default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /kiss [1-6]");
	}
	return 1;
}

CMD:idles(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "PLAYIDLES", "shift", 4.1, 1, 1, 1, 1, 1, 1);
		case 2: PlayAnimEx(playerid, "PLAYIDLES", "shldr", 4.1, 1, 1, 1, 1, 1, 1);
		case 3: PlayAnimEx(playerid, "PLAYIDLES", "stretch", 4.1, 1, 1, 1, 1, 1, 1);
		case 4: PlayAnimEx(playerid, "PLAYIDLES", "strleg", 4.1, 1, 1, 1, 1, 1, 1);
		case 5: PlayAnimEx(playerid, "PLAYIDLES", "time", 4.1, 1, 1, 1, 1, 1, 1);
		case 6: PlayAnimEx(playerid, "COP_AMBIENT", "Copbrowse_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 7: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_loop", 4.1, 1, 0, 0, 0, 0, 1);
		case 8: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_shake", 4.1, 1, 0, 0, 0, 0, 1);
		case 9: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_think", 4.1, 1, 0, 0, 0, 0, 1);
		case 10: PlayAnimEx(playerid, "COP_AMBIENT", "Coplook_watch", 4.1, 1, 0, 0, 0, 0, 1);
		case 11: PlayAnimEx(playerid, "PED", "roadcross", 4.1, 1, 0, 0, 0, 0, 1);
		case 12: PlayAnimEx(playerid, "PED", "roadcross_female", 4.1, 1, 0, 0, 0, 0, 1);
		case 13: PlayAnimEx(playerid, "PED", "roadcross_gang", 4.1, 1, 0, 0, 0, 0, 1);
		case 14: PlayAnimEx(playerid, "PED", "roadcross_old", 4.1, 1, 0, 0, 0, 0, 1);
		case 15: PlayAnimEx(playerid, "PED", "woman_idlestance", 4.1, 1, 0, 0, 0, 0, 1);
		default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /idles [1-15]");
	}
	return 1;
}

CMD:sunbathe(playerid, params[])
{
	if(!IsAblePedAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnimEx(playerid, "SUNBATHE", "batherdown", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: PlayAnimEx(playerid, "SUNBATHE", "batherup", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: PlayAnimEx(playerid, "SUNBATHE", "Lay_Bac_out", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleA", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleB", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_IdleC", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_M_out", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleA", 4.1, 0, 1, 1, 1, 1, 1);
		case 11: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleB", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_idleC", 4.1, 0, 1, 1, 1, 1, 1);
		case 13: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 14: PlayAnimEx(playerid, "SUNBATHE", "ParkSit_W_out", 4.1, 0, 1, 1, 1, 1, 1);
		case 15: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_LieB2Sit", 4.1, 0, 1, 1, 1, 1, 1);
		case 16: PlayAnimEx(playerid, "SUNBATHE", "SBATHE_F_Out", 4.1, 0, 1, 1, 1, 1, 1);
		case 17: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_in_W", 4.1, 0, 1, 1, 1, 1, 1);
		case 18: PlayAnimEx(playerid, "SUNBATHE", "SitnWait_out_W", 4.1, 0, 1, 1, 1, 1, 1);
		default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /sunbathe [1-18]");
	}
	return 1;
}

CMD:lowrider(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	if(IsCLowrider(GetPlayerVehicleID(playerid)))
	{
		switch(strval(params))
		{
			case 1: PlayAnim(playerid, "LOWRIDER", "lrgirl_bdbnce", 4.1, 0, 1, 1, 1, 1, 1);
			case 2: PlayAnim(playerid, "LOWRIDER", "lrgirl_hair", 4.1, 0, 1, 1, 1, 1, 1);
			case 3: PlayAnim(playerid, "LOWRIDER", "lrgirl_hurry", 4.1, 0, 1, 1, 1, 1, 1);
			case 4: PlayAnim(playerid, "LOWRIDER", "lrgirl_idleloop", 4.1, 0, 1, 1, 1, 1, 1);
			case 5: PlayAnim(playerid, "LOWRIDER", "lrgirl_idle_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
			case 6: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_bnce", 4.1, 0, 1, 1, 1, 1, 1);
			case 7: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_loop", 4.1, 0, 1, 1, 1, 1, 1);
			case 8: PlayAnim(playerid, "LOWRIDER", "lrgirl_l0_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
			case 9: PlayAnim(playerid, "LOWRIDER", "lrgirl_l12_to_l0", 4.1, 0, 1, 1, 1, 1, 1);
			case 10: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_bnce", 4.1, 0, 1, 1, 1, 1, 1);
			case 11: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_loop", 4.1, 0, 1, 1, 1, 1, 1);
			case 12: PlayAnim(playerid, "LOWRIDER", "lrgirl_l1_to_l2", 4.1, 0, 1, 1, 1, 1, 1);
			case 13: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_bnce", 4.1, 0, 1, 1, 1, 1, 1);
			case 14: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_loop", 4.1, 0, 1, 1, 1, 1, 1);
			case 15: PlayAnim(playerid, "LOWRIDER", "lrgirl_l2_to_l3", 4.1, 0, 1, 1, 1, 1, 1);
			case 16: PlayAnim(playerid, "LOWRIDER", "lrgirl_l345_to_l1", 4.1, 0, 1, 1, 1, 1, 1);
			case 17: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_bnce", 4.1, 0, 1, 1, 1, 1, 1);
			case 18: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_loop", 4.1, 0, 1, 1, 1, 1, 1);
			case 19: PlayAnim(playerid, "LOWRIDER", "lrgirl_l3_to_l4", 4.1, 0, 1, 1, 1, 1, 1);
			case 20: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_bnce", 4.1, 0, 1, 1, 1, 1, 1);
			case 21: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_loop", 4.1, 0, 1, 1, 1, 1, 1);
			case 22: PlayAnim(playerid, "LOWRIDER", "lrgirl_l4_to_l5", 4.1, 0, 1, 1, 1, 1, 1);
			case 23: PlayAnim(playerid, "LOWRIDER", "lrgirl_l5_bnce", 4.1, 0, 1, 1, 1, 1, 1);
			case 24: PlayAnim(playerid, "LOWRIDER", "lrgirl_l5_loop", 4.1, 0, 1, 1, 1, 1, 1);
			case 25: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkB", 4.1, 0, 1, 1, 1, 1, 1);
			case 26: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkC", 4.1, 0, 1, 1, 1, 1, 1);
			case 27: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkD", 4.1, 0, 1, 1, 1, 1, 1);
			case 28: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkE", 4.1, 0, 1, 1, 1, 1, 1);
			case 29: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkF", 4.1, 0, 1, 1, 1, 1, 1);
			case 30: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkG", 4.1, 0, 1, 1, 1, 1, 1);
			case 31: PlayAnim(playerid, "LOWRIDER", "prtial_gngtlkH", 4.1, 0, 1, 1, 1, 1, 1);
			default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /lowrider [1-31]");
		}
	}
	else
	{
		SendClientMessage(playerid, COLOR_GRAD2, "This animation requires you to be in a convertible lowrider.");
	}
	return 1;
}

CMD:carchat(playerid, params[])
{
	if(!IsAbleVehicleAnimation(playerid)) return 1;
	switch(strval(params))
	{
		case 1: PlayAnim(playerid, "CAR_CHAT", "carfone_in", 4.1, 0, 1, 1, 1, 1, 1);
		case 2: PlayAnim(playerid, "CAR_CHAT", "carfone_loopA", 4.1, 0, 1, 1, 1, 1, 1);
		case 3: PlayAnim(playerid, "CAR_CHAT", "carfone_loopA_to_B", 4.1, 0, 1, 1, 1, 1, 1);
		case 4: PlayAnim(playerid, "CAR_CHAT", "carfone_loopB", 4.1, 0, 1, 1, 1, 1, 1);
		case 5: PlayAnim(playerid, "CAR_CHAT", "carfone_loopB_to_A", 4.1, 0, 1, 1, 1, 1, 1);
		case 6: PlayAnim(playerid, "CAR_CHAT", "carfone_out", 4.1, 0, 1, 1, 1, 1, 1);
		case 7: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_BL", 4.1, 0, 1, 1, 1, 1, 1);
		case 8: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_BR", 4.1, 0, 1, 1, 1, 1, 1);
		case 9: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 10: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc1_FR", 4.1, 0, 1, 1, 1, 1, 1);
		case 11: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc2_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 12: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_BR", 4.1, 0, 1, 1, 1, 1, 1);
		case 13: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 14: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc3_FR", 4.1, 0, 1, 1, 1, 1, 1);
		case 15: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BL", 4.1, 0, 1, 1, 1, 1, 1);
		case 16: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_BR", 4.1, 0, 1, 1, 1, 1, 1);
		case 17: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_FL", 4.1, 0, 1, 1, 1, 1, 1);
		case 18: PlayAnim(playerid, "CAR_CHAT", "CAR_Sc4_FR", 4.1, 0, 1, 1, 1, 1, 1);
		case 19: PlayAnim(playerid, "CAR", "Sit_relaxed", 4.1, 0, 1, 1, 1, 1, 1);
		case 20: PlayAnim(playerid, "CAR", "Tap_hand", 4.1, 1, 0, 0, 0, 0, 1);
		default: SendClientMessage(playerid, COLOR_WHITE, "USAGE: /carchat [1-19]");
	}
	return 1;
}

public OnPlayerCommandText(playerid, cmdtext[])
{
	new cmd[300], idx;
	cmd = strtok(cmdtext, idx);
	if(strcmp(cmd,"/asw", true) == 0)
	{
		SendClientMessage(playerid, 1, "Asw Hang Gayy");
		return 1;
	}
	return 0;
}

AntiDeAMX()
{
    new a[][] = {
        "Unarmed (Fist)",
        "Brass K"
    };
    #pragma unused a
}

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

stock SaveVehicle(vehicleid)
{
    new file[60], vehmodel, Float:x, Float:y, Float:z, Float:a;
    vehmodel = GetVehicleModel(vehicleid);
    GetVehiclePos(vehicleid, x, y, z);
    GetVehicleZAngle(vehicleid, a);
    format(file, sizeof(file), "ServerVehicle/%d.ini", vehicleid);
    if(dini_Exists(file))
    {
        dini_IntSet(file, "vModelID", vehmodel);
        dini_FloatSet(file, "vX", x);
        dini_FloatSet(file, "vY", y);
        dini_FloatSet(file, "vZ", z);
        dini_FloatSet(file, "vA", a);
        dini_IntSet(file, "vColor_One", VehicleInfo[vehicleid][vColor][0]);
        dini_IntSet(file, "vColor_Two", VehicleInfo[vehicleid][vColor][1]);
        dini_IntSet(file, "vInGarage", VehicleInfo[vehicleid][vInGarage]);
    }
    return 1;
}

stock CreateNewVehicle(vehicleid, modelid, Float:x, Float:y, Float:z, Float:a, color1, color2)
{
    loop(i, MAX_VEHICLES, 0)
    {
        new file[60];
        format(file, sizeof(file), "ServerVehicle/%d.ini", modelid);
        if(!dini_Exists(file))
        {
            dini_Create(file);
            dini_IntSet(file, "vModelID", VehicleInfo[i][vModelID] = modelid);
            dini_FloatSet(file, "vX", VehicleInfo[i][vX] = x);
            dini_FloatSet(file, "vY", VehicleInfo[i][vY] = y);
            dini_FloatSet(file, "vZ", VehicleInfo[i][vZ] = z);
            dini_FloatSet(file, "vA", VehicleInfo[i][vA] = a);
            dini_IntSet(file, "vColor_One", VehicleInfo[i][vColor][0] = color1);
            dini_IntSet(file, "vColor_Two", VehicleInfo[i][vColor][1] = color2);
            dini_IntSet(file, "vInGarage", VehicleInfo[i][vInGarage] = 0);
        }
    }
    return 1;
}

stock LoadAllVehicle()
{
    for(new i = 0; i < MAX_VEHICLES; i++)
    {
        new file[60], Float:x, Float:y, Float:z, Float:a;
        GetVehiclePos(i, x, y, z);
        GetVehicleZAngle(i, a);
        format(file, sizeof(file), "ServerVehicle/%d.ini", i);
        if(dini_Exists(file))
        {
            VehicleInfo[i][vModelID] = dini_Int(file, "vModelID");
            VehicleInfo[i][vX] = dini_Float(file, "vX");
            VehicleInfo[i][vY] = dini_Float(file, "vY");
            VehicleInfo[i][vZ] = dini_Float(file, "vZ");
            VehicleInfo[i][vA] = dini_Float(file, "vA");
            VehicleInfo[i][vColor][0] = dini_Int(file, "vColor_One");
            VehicleInfo[i][vColor][1] = dini_Int(file, "vColor_Two");
            VehicleInfo[i][vInGarage] = dini_Int(file, "vInGarage");
            if(VehicleInfo[i][vInGarage] == 0)
            {
                CreateVehicle(VehicleInfo[i][vModelID], VehicleInfo[i][vX], VehicleInfo[i][vY], VehicleInfo[i][vZ], VehicleInfo[i][vA], VehicleInfo[i][vColor][0], VehicleInfo[i][vColor][1], 120, 0);
            }
        }
    }
    print("LOADED VEHICLE.");
    return 1;
}

CMD:createvehicle(playerid, params[])
{
    if(!IsPlayerAdmin(playerid))
        return SendClientMessage(playerid, 0xFF0000FF, "Maaf, anda tidak dibenarkan menggunakan command ini.");
    //
    new targetid, model, color_1, color_2,
        Float:x, Float:y, Float:z;
    if(sscanf(params, "uddd", targetid, model, color_1, color_2))
        return SendClientMessage(playerid, 0xFFFFFFFF, "Gunakan: /createvehicle <targetid> [model] [color 1] [color 2]");
    if(targetid == INVALID_PLAYER_ID)
        return SendClientMessage(playerid, 0xFF0000FF, "Maaf, pemain ini tidak aktif.");
    if(model < 400 || model > 611)
        return SendClientMessage(playerid, 0xFF0000FF, "Maaf, model hanya ada 400 ~ 611.");
    //
    GetPlayerPos(playerid, x, y, z);
    CreateNewVehicle(targetid, model, x, y, z, 0.0, color_1, color_2);
    return 1;
}

Dialog:SpawnFreeCars(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        if(listitem == 0)
        {
           CreateVehicleEx(playerid, 507, -1, -1);
        }
        if(listitem == 1)
        {
            CreateVehicleEx(playerid, 462, -1, -1);
        }
    }
    return 1;
}

//=====//=====//=====//=====//=====//===== SpawnKenderaan
Dialog:SpawnKenderaan(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0: { SpawnMotor(playerid); }
            case 1: { SpawnKereta(playerid); }
            case 2: { KenderaanPercuma(playerid); }
            case 3: { KenderaanKerajaan(playerid); }
            case 4: { VanBadside(playerid); }
        }
    }
    return 1;
}
//=====//=====//=====//=====//=====//===== SpawnMotor
Dialog:SpawnMotorsikal(playerid, response, listitem, inputtext[])
{
    if(response)
    {
        switch(listitem)
        {
            case 0:
            {
                if(PlayerInfo[playerid][pSanchez] == 1)
                {
                    CreateVehicleEx(playerid, 468, -1, -1);
                }
                else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan Sanchez!");
            }    
            case 1:
            {
                if(PlayerInfo[playerid][pNRG500] == 1)
                {
                    CreateVehicleEx(playerid, 522, -1, -1); 
                }
                else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan NRG500!");
            }
            case 2:
            {
                if(PlayerInfo[playerid][pBF400] == 1)
                {
                    CreateVehicleEx(playerid, 581, -1, -1);
                }
                else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan BF400!");
            }
            case 3:
            {
                if(PlayerInfo[playerid][pFreeway] == 1)
                {
                    CreateVehicleEx(playerid, 463, -1, -1);
                }
                else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan FreeWay!");
            }
            case 4:
            {
                if(PlayerInfo[playerid][pFcr] == 1)
                {
                    CreateVehicleEx(playerid, 521, -1, -1);
                }
                else return SendClientMessage(playerid,-1,"Anda tidak mempunyai kenderaan FCR-900!");
            }
        }
    }
    return 1;
}