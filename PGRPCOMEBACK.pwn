// ================= PENANG ROLEPLAY GAMEMODE ===========================================

// =======================   INCLUDE   ==================================================
#include <a_samp>
#include <sscanf2>
#include <YSI\y_ini>
#include <zcmd>
#include <dini>
#include <streamer>
#include <core>
#include <foreach>
#include <float>
#include <zones>
#include <discord-connector>
#include <audio>

// =======================   PRAGMA   ==================================================

// =======================   DEFINE   ==================================================
#define PATH "Users/%s.ini"
#define PATH2 "UserWhitelist/%s.txt"
#define NOPERMS ""COL_RED"[ERROR]"COL_WHITE"Anda Tidak Dibenarkan Menggunakan Commands Ini!"

#define PRESSED(%0) \
	(((newkeys & (%0)) == (%0)) && ((oldkeys & (%0)) != (%0)))

#define ADMIN_SPEC_TYPE_NONE 0
#define ADMIN_SPEC_TYPE_PLAYER 1
#define ADMIN_SPEC_TYPE_VEHICLE 2
//VOTE SYSTEM
#define SLOTS 500
#define CREATEVOTE 250

// =======================   DIALOG   ==================================================
//REGISTER SYSTEM
#define  REGISTER                1
#define  LOGIN                   2
//MENU
#define  MENU                    3
#define  AMENU                   4
#define  VMENU                   5
#define  JANTINA                 6
#define  SPAWN                   7
//LESEN
#define  LESEN                   8
//SPAWN KENDERAAN
#define  MOTOR                   9
#define  KERETA                  10
#define  LORI                    11
#define  KERAJAAN                12
#define  FREE                    13
#define  JOBVEHICLE              14
//ROLE ON DUTY
#define DUTY_PPR 				 15
#define DUTY_PJP 				 16
#define DUTY_MPR 				 17
#define DUTY_Kapak 				 18
#define DUTY_BLACKSHARK 		 19
#define DUTY_KING302 			 20
#define DUTY_TODAK97 			 21
//KEDAI SKIN
#define  PEREMPUAN           	 22
#define  LELAKI  				 23
#define  WEAPON                  24
//KEDAI
#define  KEDAI                   25
#define  MART 					 26
//INVENTORY
#define  INVENTORY 				 27
#define  INV 					 28
#define  WEAPONINV 				 29
#define  MAKANANINV 			 30
#define  MINUMANINV 			 31
//PHONE DIALOG
#define DIALOG_ROLE 		 	 32
#define DIALOG_TELEPORT 		 33
#define DIALOG_WEAPON 			 34
#define DIALOG_MAP 				 35
//DIALOG IKAN
#define KEDAI_IKAN 				 36
#define JUAL_IKAN 				 37
//MORE DIALOG
#define DUTY_VEHICLEDEALER 		 45
#define CHANGE_MODE 			 46
#define ADMIN_CHANGEMODE 		 47
#define DUTY_TENJIKUGENG 		 48

// =======================   DIALOG COLORS   ==========================================
//COMMON
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
#define COL_DBLUE			"{0013A1}"
#define COL_LGREEN  		"{3FFF4C}"
#define COL_OREN  			"{FFA000}"
#define COL_DC  			"{9739E3}"
#define COL_CYAN 			"{00ff00}"
#define COL_ORANGE 			"{ff0000}"
#define COL_LIME           "{B7FF00}"
#define COL_COLOR_GREY 		"{AFAFAF}"
#define COL_EASY           "{FFF1AF}"
#define COL_NICEGREEN      "{6EF83C}"
#define COL_NICERED        "{F81414}"

#define COL_MAGENTA        "{F300FF}"
#define COL_VIOLET         "{B700FF}"
#define COL_MARONE         "{A90202}"
#define COL_CMD            "{B8FF02}"
#define COL_PARAM          "{3FCD02}"
#define COL_SERVER         "{AFE7FF}"
#define COL_VALUE          "{A3E4FF}"
#define COL_RULE           "{F9E8B7}"
#define COL_RULE2          "{FBDF89}"
#define COL_RWHITE         "{FFFFFF}"
#define COL_LRED2          "{C77D87}"
#define EMBED_WHITE 	   "{6422DD}"
#define DARK_PURPLE        "{800040}"
#define BIZ_HEX            "{F5DEB3}"
#define GARAGE_HEX         "{FFA500}"
//COL ROLE
#define COL_DEV     		"{FF0000}"
#define COL_ADEV     		"{FF4F4F}"
#define COL_ADMIN     		"{00FFFF}"
#define COL_STAFF     		"{3FFF4C}"
#define COL_PPR         	"{0083FF}"
#define COL_PJP      		"{001EFF}"
#define COL_MPR				"{FA08CB}"
#define Col_Kapak 			"{00FFFF}"
#define COL_BLACKSHARK		"{000001}"
#define COL_KING302			"{FFA100}"
#define COL_TODAK	 		"{00FF16}"
#define COL_VEHICLE			"{3FD1EB}"
#define COL_TENJIKUGENG 	"{646464}"
#define COL_VIP            	"{630469}"
//COLOR ROLE
#define COLOR_DEV      	    0xFF0000FF
#define COLOR_ADEV      	0xFF4F4FFF
#define COLOR_ADMIN      	0x00FFFFFF
#define COLOR_STAFF      	0x3FFF4CFF
#define COLOR_PPR	 		0x0083FFFF
#define COLOR_PJP	 		0x001EFFFF
#define COLOR_MPR 			0xFA08CBFF
#define COLOR_KAPAK 		0x00FFFFFF
#define COLOR_BLACKSHARK 	0x000001FF
#define COLOR_KING302 		0xFFA100FF
#define COLOR_TODAK 		0x00FF1FF
#define COLOR_VEHICLE		0x0C8AA0FF
#define COLOR_TenjikuGeng 	0x646464FF
//OTHERS
#define COLOR_AFK	 		0xFF0000FF
#define COLOR_BITEM 		0xE1B0B0FF
#define COLOR_GRAD1 		0xB4B5B7FF
#define COLOR_GRAD2 		0xBFC0C2FF
#define COLOR_GRAD3 		0xCBCCCEFF
#define COLOR_GRAD4 		0xD8D8D8FF
#define COLOR_GRAD5 		0xE3E3E3FF
#define COLOR_GRAD6 		0xF0F0F0FF
#define COLOR_COLOR_GREY 	0xAFAFAFAA
#define COLOR_GREEN 		0x33AA33AA
#define COLOR_RED 			0xFF0000FF
#define COLOR_BLACK         0x000001FF
#define COLOR_BLUE 			0x007BD0FF
#define ACTION_COLOR 	    0xC2A2DAAA
#define COLOR_LIGHTORANGE 	0xFFA100FF
#define COLOR_FLASH 		0xFF000080
#define COLOR_LIGHTRED 		0xB00000
#define COLOR_LIGHTBLUE 	0x00FFFF
#define COLOR_LIGHTGREEN 	0x3FFF4C
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
#define COLOR_VIP 			0xECFF0000
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
#define TEAM_CYAN_COLOR 	0xFF8282AA
#define COLOR_DBLUE 		0x2641FEAA
#define COLOR_DOC 			0xFF8282AA
#define COLOR_DCHAT 		0xF0CC00FF
#define COLOR_NEWS 			0xFFA500AA
#define COLOR_OOC 			0xE0FFFFAA
#define COLOR_ORANGE 		0xFF9900AA
#define TEAM_BLUE_COLOR 	0x8D8DFF00
#define TEAM_GROVE_COLOR 	0x00AA00FF
#define ENT_COLOR           0xFF6347FF
#define TEAM_AZTECAS_COLOR 	0x01FCFFC8
#define COLOR_TEAL 			0x00AAAAAA
#define COLOR_OFFWHITE 		0xF5DEB3AA
#define COLOR_DARKAQUA 		0x83BFBFAA
#define NEWBIE_COLOR 		0x7DAEFFFF
#define TPARAMEDIC  		0xFF828200
#define SCOLOR_RED          0xD9000000
#define SCOLOR_PINK         0xFE81FE00
#define SCOLOR_ORANGE       0xFF6A2200
#define SCOLOR_YELLOW       0xF0F00000
#define SCOLOR_CYAN         0x00E6E600
#define SCOLOR_GREEN       	0x00CA0000
#define SCOLOR_BLUE       	0x0058B000
#define SCOLOR_BLACK        0x00000000
#define SCOLOR_WHITE        0xFFFFFF00
#define SCOLOR_MARKER       0xD90000FF
#define TBLUE 			 	0x2641FE00
#define GARAGE_COLOR        0xFFA500FF

#define ADMINCHAT            0x00FF00FF
#define ILLEGAL 		     0xE1B0B0FF
#define GREY1 			  	 0xB4B5B7FF
#define GREY2 			 	 0xBFC0C2FF
#define GREY3 			  	 0xCBCCCEFF
#define GREY4 				 0xD8D8D8FF
#define GREY5 			 	 0xE3E3E3FF
#define GREY6 			 	 0xF0F0F0FF
#define GREY				 0xAFAFAFFF
#define GREEN 			 	 0x33AA33FF
#define RED 				 0xAA3333FF
#define BLACK         	 	 0x000001FF
#define BLUE 				 0x007BD0FF
#define LIGHTORANGE 		 0xFFA100FF
#define FLASH 			 	 0xFF000080
#define LIGHTRED 			 0xFF6347FF
#define LIGHTBLUE 		 	 0x33CCFFFF
#define LIGHTGREEN		 	 0x9ACD32FF
#define YELLOW 			 	 0xFFFF00FF
#define LIGHTYELLOW		 	 0xFFFF91FF
#define YELLOW2 			 0xF5DEB3FF
#define FADE1 		 	 	 0xE6E6E6E6
#define FADE2 		 	 	 0xC8C8C8C8
#define FADE3 			 	 0xAAAAAAFF
#define FADE4 			 	 0x8C8C8C8C
#define FADE5 			 	 0x6E6E6E6E
#define PURPLE 			 	 0xC2A2DAAA
#define DBLUE 			 	 0x2641FEFF
#define DOC 				 0xFF8282FF
#define DCHAT 			 	 0xF0CC00FF
#define NEWS 				 0xFFA500FF
#define OOC 				 0xE0FFFFFF
#define TEAM_BLUE_COLOR 	 0x8D8DFF00
#define TEAM_GROVE_COLOR 	 0x00AA00FF
#define TEAM_AZTECAS_COLOR 	 0x01FCFFC8
#define NEWBIE_COLOR 		 0x7DAEFFFF
#define HOUSETEXT 		 	 0xBDB388FF
#define ORANGE   			 0xFF8300FF
#define SAMP_COLOR			 0xAAC4E5FF
#define BIZ            	 	 0xE85D00FF

//================= MAX VARIABLE ===============================================
#define DIALOG_WHITELIST 14139
#define DIALOG_REMOVE   14140

//=================   VIP    ===================================================
#define N 69
#define DIALOG_CMD_1 1
#define DIALOG_CMD_2 2
#define MAX_VIP 3
#define MAX_ITEM 5

//	VEHICLE DEFINE
#define VehLandstalker 			400
#define VehBravura 				401
#define VehBuffalo				402
#define VehLinerunner			403
#define VehPerennial 			404
#define VehSentinel				405
#define VehDumper 				406
#define VehFireTruck 			407
#define VehTrashmaster 			408
#define VehStretch 				409
#define VehManana 				410
#define VehInfernus 			411
#define VehVoodoo 				412
#define VehPony 				413
#define VehMule 				414
#define VehCheetah 				415
#define VehAmbulance 			416
#define VehLeviathan 			417
#define VehMoonbeam 			418
#define VehEsperanto 			419
#define VehTaxi 				420
#define VehWashington 			421
#define VehBobcat 				422
#define VehMrWhoopee			423
#define VehBFInjection 			424
#define VehHunter				425
#define VehPremier 				426
#define VehEnforcer				427
#define VehSecuricar			428
#define VehBanshee				429
#define VehPredator				430
#define VehBus					431
#define VehRhino				432
#define VehBarracks				433
#define VehHotKnife				434
#define VehTrailer1				435
#define VehPrevion				436
#define VehCoach				437
#define VehCabbie				438
#define VehStallion				439
#define VehRumpo				440
#define VehRCBandit				441
#define VehRomero				442
#define VehPacker				443
#define VehMonster				444
#define VehAdmiral 				445
#define VehSqualo				446
#define VehSeasparrow			447
#define VehPizzaboy				448
#define VehTram 				449
#define VehTrailer2				450
#define VehTurismo				451
#define VehSpeeder				452
#define VehReefer				453
#define VehTropic				454
#define VehFlatbed				455
#define VehYankee				456
#define VehCaddy				457
#define VehSolair				458
#define VehBerkley				459
#define VehSkimmer 				460
#define VehPCJ600				461
#define VehFaggio				462
#define VehFreeway 				463
#define VehRCBaron				464
#define VehRCRaider				465
#define VehGlendale 			466
#define VehOceanic				467
#define VehSanchez				468
#define VehSparrow 				469
#define VehPatriot 				470
#define VehQuadbike				471
#define VehCoastguard 			472
#define VehDinghy				473
#define VehHermes				474
#define VehSabre				475
#define VehRustler				476
#define VehZR350				477
#define VehWalton				478
#define VehRegina				479
#define VehComet 				480
#define VehBMX					481
#define VehBurrito 				482
#define VehCamper 				483
#define VehMarquis 				484
#define VehBaggage 				485
#define VehDozer 				486
#define VehMaverick 			487
#define VehNewsChopper 			488
#define VehRancher 				489
#define VehFBIRancher 			490
#define VehVirgo 				491
#define VehGreenwood			492
#define VehJetmax 				493
#define VehHotringRacer 		494
#define VehSandking 			495
#define VehBlistaCompact 		496
#define VehPoliceMaverick 		497
#define VehBoxville 			498
#define VehBenson 				499
#define VehMesa 				500
#define VehRCGoblin				501
#define VehHotringRacer3 		502
#define VehHotringRacer2		503
#define VehBloodringBanger		504
#define VehRancherLure			505
#define VehSuperGT				506
#define VehElegant				507
#define VehJourney				508
#define VehBike 				509
#define VehMountainBike			510
#define VehBeagle				511
#define VehCropduster			512
#define VehStuntplane			513
#define VehTanker				514
#define VehRoadtrain			515
#define VehNebula				516
#define VehMajestic 			517
#define VehBuccaneer 			518
#define VehShamal				519
#define VehHydra 				520
#define VehFCR900				521
#define VehNRG500				522
#define VehHPV1000				523
#define VehCementTruck			524
#define VehTowTruck				525
#define VehFortune				526
#define VehCadrona				527 
#define VehFBITruck				528
#define VehWillard 				529
#define VehForklift				530
#define VehTractor				531
#define VehCombineHarvester		532
#define VehFeltzer				533
#define VehRemington			534
#define VehSlamvan				535
#define VehBlade 				536
#define VehFreight				537
#define VehStreak				538
#define VehVortex 				539
#define VehVincent				540
#define VehBullet				541
#define VehClover				542
#define VehSadler				543
#define VehFireTruckLadder		544
#define VehHustler				545
#define VehIntruder				546
#define VehPrimo				547
#define VehCargobob				548
#define VehTampa 				549
#define VehSunrise				550
#define VehMerit 				551
#define VehUtilityVan 			552
#define VehNevada 				553
#define VehYosemite 			554
#define VehWindsor				555
#define VehMonster2 			556
#define VehMonster3				557
#define VehUranus 				558
#define VehJester 				559
#define VehSultan 				560
#define VehStratum				561
#define VehElegy				562
#define VehRaindance 			563
#define VehRCTiger 				564
#define VehFlash				565
#define VehTahoma				566
#define VehSavanna 				567
#define VehBandito				568
#define VehFreightTrainFlatbed	569
#define VehStreakTrainTrailer	570
#define VehKart 				571
#define VehMower 				572
#define VehDune 				573
#define VehSweeper 				574
#define VehBroadway 			575
#define VehTornado 				576
#define VehAT400 				577
#define VehDFT30 				578
#define VehHuntley 				579
#define VehStafford 			580
#define VehBF400 				581
#define VehNewsvan 				582
#define VehTug 					583
#define VehTrailerTankerComando	584
#define VehEmperor 				585
#define VehWayfarer 			586
#define VehEuros 				587
#define VehHotdog 				588
#define VehClub 				589
#define VehBoxFreight 			590
#define VehTrailer3 			591
#define VehAndromada 			592
#define VehDodo 				593
#define VehRCCam				594
#define VehLaunch				595
#define VehCopCarLS 			596
#define VehCopCarSF 			597
#define VehCopCopLV 			598
#define VehRanger 	 			599
#define VehPicador		 		600
#define VehSwatTank 			601
#define VehAlpha 				602
#define VehPhoenix 				603
#define VehGlendaleDamaged		604
#define VehSadlerDamaged 		605
#define VehBagBoxA 				606
#define VehBagBoxB 				607
#define VehStairs		 		608
#define VehBoxvilleBlack		609
#define VehFarmTrailer 			610
#define VehUtilityTrailer 		611
//DEFINE JOBS DUNKIN BELL ONLY
#define DunkinBell1 965.0623, -1388.2992, 13.4645
#define DunkinBell2 958.2437, -1474.6013, 13.5478
#define DunkinBell3 909.6518, -1484.3540, 13.5526
#define DunkinBell4 824.5651, -1473.6938, 12.9574
#define DunkinBell5 785.9207, -1464.5437, 13.5430
#define DunkinBell6 689.0508, -1595.5580, 14.1195
#define DunkinBell7 650.5483, -1621.0004, 15.0000
#define DunkinBell8 648.6233, -1655.6559, 14.8904
#define DunkinBell9 792.2418, -1666.7974, 13.4960
#define DunkinBell10 844.6729, -1597.7797, 13.5469
#define DunkinBell11 909.6848, -1508.2130, 13.5448
#define DunkinBell12 964.3726, -1362.9003, 13.3438
//DEFINE JOBS TAXI ONLY
#define CHECKPOINT_TAXI1 1225.0529, -1826.7791, 12.9642 
#define CHECKPOINT_TAXI2 1075.3184, -1849.4337, 12.9323
#define CHECKPOINT_TAXI3 975.9478, -1782.1699, 13.6240
#define CHECKPOINT_TAXI4 919.0344, -1749.9053, 12.9092
#define CHECKPOINT_TAXI5 932.4641, -1575.0449, 12.9271
#define CHECKPOINT_TAXI6 1049.3838, -1574.5908, 12.9333
#define CHECKPOINT_TAXI7 1278.6895, -1573.3555, 12.9369
#define CHECKPOINT_TAXI8 1296.0103, -1699.4515, 12.9281
#define CHECKPOINT_TAXI9 1241.5885, -1817.2246, 12.9269
//DEFINE JOBS BUS ONLY
#define CHECKPOINT_BUS1 1743.0261, -1863.8929, 13.5745
#define CHECKPOINT_BUS2 1808.6235, -1852.8185, 13.1753
#define CHECKPOINT_BUS3 1825.0488, -1928.0282, 13.1441
#define CHECKPOINT_BUS4 1946.6829, -1930.1090, 13.1457
#define CHECKPOINT_BUS5 2077.5908, -1928.8916, 13.0833
#define CHECKPOINT_BUS6 2190.3835, -1892.4464, 13.3726
#define CHECKPOINT_BUS7 2215.7751, -1866.4520, 13.1460
#define CHECKPOINT_BUS8 2214.6838, -1756.6240, 13.1343
#define CHECKPOINT_BUS9 2178.4861, -1751.1989, 13.1382
#define CHECKPOINT_BUS10 1839.7551, -1752.8250, 13.1462
#define CHECKPOINT_BUS11 1823.5975, -1847.4917, 13.1772
#define CHECKPOINT_BUS12 1722.5829, -1879.5676, 13.3271
//DEFINE JOBS PEMBERSIH JALAN ONLY
#define CHECKPOINT_SWEEPER1 1371.3744, -1882.0924, 13.5386
#define CHECKPOINT_SWEEPER2 1277.1256, -1851.2622, 13.3904
#define CHECKPOINT_SWEEPER3 1178.5864, -1852.8040, 13.3984
#define CHECKPOINT_SWEEPER4 1174.3390, -1727.7600, 13.5547
#define CHECKPOINT_SWEEPER5 1149.3081, -1585.9673, 13.3758
#define CHECKPOINT_SWEEPER6 1048.6205, -1571.4932, 13.3897
#define CHECKPOINT_SWEEPER7 1062.3269, -1418.7800, 13.3671
#define CHECKPOINT_SWEEPER8 1330.2784, -1397.8185, 13.3574
#define CHECKPOINT_SWEEPER9 1314.7189, -1559.4698, 13.3906
#define CHECKPOINT_SWEEPER10 1313.9392, -1718.8320, 13.3828
#define CHECKPOINT_SWEEPER11 1315.6101, -1839.5520, 13.3828
#define CHECKPOINT_SWEEPER12 1334.6603, -1853.0048, 13.3906
#define CHECKPOINT_SWEEPER13 1382.9808, -1897.5674, 13.4979
//DEFINE JOBS PEMBANGGUNAN ONLY
#define CHECKPOINT_PEMBANGGUNAN1 1279.0221, -1234.8156, 14.3325
#define CHECKPOINT_PEMBANGGUNAN2 1265.1566, -1267.5376, 13.4322
#define CHECKPOINT_PEMBANGGUNAN3 1249.1390, -1234.1366, 17.1995
#define CHECKPOINT_PEMBANGGUNAN4 1228.7424, -1243.9203, 19.3420
#define CHECKPOINT_PEMBANGGUNAN5 1228.1727, -1268.2595, 13.6071
#define CHECKPOINT_PEMBANGGUNAN6 1237.9884, -1259.9320, 17.1903
#define CHECKPOINT_PEMBANGGUNAN7 1282.2952, -1269.2198, 13.5414
#define CHECKPOINT_PEMBANGGUNAN8 1239.2034, -1252.3595, 13.7319
#define CHECKPOINT_PEMBANGGUNAN9 1243.7275, -1257.3239, 13.1389

//DEFINE RACING CHECKPOINT ONLY
#define CHECKPOINT_RACING1 -2522.2556, -608.4470, 132.5625
#define CHECKPOINT_RACING2 -2430.9004, -612.3241, 132.1248
#define CHECKPOINT_RACING3 -2465.4941, -499.1453, 105.4832
#define CHECKPOINT_RACING4 -2622.7830, -498.7916, 70.3897
#define CHECKPOINT_RACING5 -2425.5625, -416.3429, 85.3436
#define CHECKPOINT_RACING6 -2320.7310, -442.2689, 79.1713
#define CHECKPOINT_RACING7 -2634.9460, -385.0630, 35.7881
#define CHECKPOINT_RACING8 -2670.5095, -508.3741, 18.6965
#define CHECKPOINT_RACING9 -2821.9155, -425.3945, 6.6070
#define CHECKPOINT_RACING10 -2808.8103, -216.7479, 6.5996
#define CHECKPOINT_RACING11 -2443.8662, -209.6686, 34.1981
#define CHECKPOINT_RACING12 -2419.2678, -73.0928, 34.8432
#define CHECKPOINT_RACING13 -2263.3982, -70.0689, 34.7393
#define CHECKPOINT_RACING14 -2206.5708, -452.9418, 50.0025
#define CHECKPOINT_RACING15 -2225.4829, -744.7214, 64.1540
#define CHECKPOINT_RACING16 -2358.8469, -755.9598, 97.3378
#define CHECKPOINT_RACING17 -2392.8811, -636.1664, 130.1671
#define CHECKPOINT_RACING18 -2396.5398, -569.6365, 131.6850

//================= FORWARD ONLY ===============================================
forward split(const strsrc[], strdest[][], delimiter);
forward ProxDetector(Float:radi, playerid, string[],col1,col2,col3,col4,col5);
forward ProxDetectorS(Float:radi, playerid, targetid);
forward GetUserPassword(playerid, name[], value[]);
forward SetPlayerSpeedCap(playerid, Float:value);
forward LoadUser_data(playerid,name[],value[]);
forward DisablePlayerSpeedCap(playerid);
forward SaveAccountInfo(playerid);
forward FixHour(hour);
forward OOCOff(color,const string[]);
forward SetPlayerSpawn(playerid);
forward savedata(playerid);
forward SendMSG();
forward hSpeedINFO(PlayerId);
//FORWARD TIMER ONLY
forward RacingPosTimer(playerid);
forward FreezeTimer(playerid);
forward AdminRacingFreezeTimer(playerid);
forward FishTimer(playerid);
forward AdminRacingTimer(playerid);
forward FiveSecondTimer(playerid);
forward FourSecondTimer(playerid);
forward TreeSecondTimer(playerid);
forward TwoSecondTimer(playerid);
forward OneSecondTimer(playerid);
//LOG
forward PayLog(string[]);
forward BanLog(string[]);
forward KickLog(string[]);

//================= VARIABLE ===================================================
new gPlayerLogged[MAX_PLAYERS char];
new gOOC[MAX_PLAYERS];

new realchat = 1;

new gSpectateID[MAX_PLAYERS];
new gSpectateType[MAX_PLAYERS];

new HelmetEnabled[MAX_PLAYERS];
new MaskEnabled[MAX_PLAYERS];

new adminduty[MAX_PLAYERS];

//DISCORD CONNECTOR 
static DCC_Channel:AdminPanel;
new DCC_Channel:WhitelistChannel;
new DCC_Channel:BlacklistChannel;
new DCC_Channel:JoinLeaveChannel;
new DCC_Channel:DeathChannel;
new DCC_Channel:RoleChannel;
new DCC_Channel:DiscordChat;

new Spawned[MAX_PLAYERS];

new afk[MAX_PLAYERS];

new Text3D:playerLabels[MAX_PLAYERS];

//KENDERAAN SPEED
new Text:Textdraw0;
new Text:Textdraw1;
new Text:Textdraw2;
new PlayerText:Textdraw3[MAX_PLAYERS];
new PlayerText:Textdraw4[MAX_PLAYERS];
new PlayerText:Textdraw5[MAX_PLAYERS];
//TEXTDRAW
new Text:PMRPLoginLogo[8];
new Text:PhoneTD[16];
new Text:PenangLOGO[2];

new hSpeedActiv[MAX_PLAYERS];
new hspeedinfotimer[MAX_PLAYERS];
//SPEED LIMIT
new Float:VehicleSpeed[MAX_PLAYERS] = {0.0, ...};
//SPEED CAMERA
new UpdateSeconds = 2;
new maxobject = 4;
new objectcreated;
new distance1[MAX_PLAYERS];
//VOTE SYSTEM
new bool:HasVoted[MAX_PLAYERS];

//PICKUP PINTU
new PPRM;
new PPRK;
new PJPM;
new PJPK;
new MPRM;
new MPRK;
new SKINM;
new SKINK;
new BANKM;
new BANKK;
new WEAPM;
new WEAPK;
new TESTM;
new TESTK;
new MARTM;
new MARTK;

//=================================VEHICLE SYSTEM===========================
new VehicleNames[][] =
{
	"Landstalker",
	"Bravura",
	"Buffalo",
	"Linerunner",
	"Perenniel",
	"Sentinel",
	"Dumper",
	"Firetruck",
	"Trashmaster",
	"Stretch",
	"Manana",
	"Infernus",
	"Voodoo",
	"Pony",
	"Mule",
	"Cheetah",
	"Ambulance",
	"Leviathan",
	"Moonbeam",
	"Esperanto",
	"Taxi",
	"Washington",
	"Bobcat",
	"Mr Whoopee",
	"BF Injection",
	"Hunter",
	"Premier",
	"Enforcer",
	"Securicar",
	"Banshee",
	"Predator",
	"Bus",
	"Rhino",
	"Barracks",
	"Hotknife",
	"Article Trailer",
	"Previon",
	"Coach",
	"Cabbie",
	"Stallion",
	"Rumpo",
	"RC Bandit",
	"Romero",
	"Packer",
	"Monster",
	"Admiral",
	"Squallo",
	"Seasparrow",
	"Pizzaboy",
	"Tram",
	"Article Trailer 2",
	"Turismo",
	"Speeder",
	"Reefer",
	"Tropic",
	"Flatbed",
	"Yankee",
	"Caddy",
	"Solair",
	"Topfun Van (Berkley's RC)",
	"Skimmer",
	"PCJ-600",
	"Faggio",
	"Freeway",
	"RC Baron",
	"RC Raider",
	"Glendale",
	"Oceanic",
	"Sanchez",
	"Sparrow",
	"Patriot",
	"Quad",
	"Coastguard",
	"Dinghy",
	"Hermes",
	"Sabre",
	"Rustler",
	"ZR-350",
	"Walton",
	"Regina",
	"Comet",
	"BMX",
	"Burrito",
	"Camper",
	"Marquis",
	"Baggage",
	"Dozer",
	"Maverick",
	"SAN News Maverick",
	"Rancher",
	"FBI Racher",
	"Virgo",
	"Greenwood",
	"Jetmax",
	"Hotring Racer",
	"Sandking",
	"Blista Compact",
	"Police Maverick",
	"Boxville",
	"Benson",
	"Mesa",
	"RC Goblin",
	"Hotring Racer",
	"Hotring Racer",
	"Bloodring Banger",
	"Rancher",
	"Super GT",
	"Elegant",
	"Journey",
	"Bike",
	"Mountain Bike",
	"Beagle",
	"Cropduster",
	"Stuntplane",
	"Tanker",
	"Roadtrain",
	"Nebula",
	"Majestic",
	"Buccaneer",
	"Shamal",
	"Hydra",
	"FCR-900",
	"NRG-500",
	"HPV1000",
	"Cement Truck",
	"Towtruck",
	"Fortune",
	"Cadrona",
	"FBI Truck",
	"Willard",
	"Forklift",
	"Tractor",
	"Combine Hervester",
	"Feltzer",
	"Remington",
	"Slamvan",
	"Blade",
	"Freight (Train)",
	"Brownstreak (Train)",
	"Vortex",
	"Vincent",
	"Bullet",
	"Clover",
	"Sadler",
	"Firetruck LA",
	"Hustler",
	"Intruder",
	"Primo",
	"Cargobob",
	"Tampa",
	"Sunrise",
	"Merit",
	"Utility Van",
	"Nevada",
	"Yosemite",
	"Windsor",
	"Monster \"A\"",
	"Monster \"B\"",
	"Uranus",
	"Jester",
	"Sultan",
	"Stratum",
	"Elegy",
	"Raindance",
	"RC Tiger",
	"Flash",
	"Tahoma",
	"Savanna",
	"Bandito",
	"Freight Flat Tailer (Train)",
	"Streak Trailer (Train)",
	"Kart",
	"Mower",
	"Dune",
	"Sweeper",
	"Broadway",
	"Tornado",
	"AT-400",
	"DFT-30",
	"Huntley",
	"Stafford",
	"BF-400",
	"Newsvan",
	"Tug",
	"Petrol Trailer",
	"Emperor",
	"Wayfarer",
	"Euros",
	"Hotdog",
	"Club",
	"Freight Box Trailer (Train)",
	"Article Trailer 3",
	"Andromada",
	"Dodo",
	"RC Cam",
	"Launch",
	"Police Car (LSPD)",
	"Police Car (SFPD)",
	"Police Car (LVPD)",
	"Police Ranger",
	"Picador",
	"S.W.A.T.",
	"Alpha",
	"Phoenix",
	"Glendale Shit",
	"Sadler Shit",
	"Baggage Trailer \"A\"",
	"Baggage Trailer \"B\"",
	"Tug Stairs Trailer",
	"Boxville",
	"Farm Trailer",
	"Utility Trailer"
};

//PLAYER INFO / PLAYER DATA
enum pInfo
{


    pPassword[180],
    pIdentityCard,
    pDuit,
    pDeposit,
    pSkin,
    pJantina,
    pAdmin,
    pLesenKereta,
	pLesenMotor,
	pLesenLori,
	pLesenKapalTerbang,
	pLesenBot,
    pMYKAD,
    pVip,
	pPpr,
	pPjp,
	pMpr,
	pKapak,
	pBlackShark,
	pKing302,
	pTodak97,
	pVEH,
	pTenjikuGeng,
	pVIP,
	pJail,
	pGari,
	pJobs,
	pMati,
	pInfernus,
	pSultan,
	pElegy,
	pBlista,
	pTampa,
	pHuntley,
	pSabre,
	pCheetah,
	pBullet,
	pBuffalo,
	pStretch,
	pBanshee,
	pBF400,
	pNRG500,
	pFCR900,
	pPCJ600,
	pFREEWAY,
	pWAYFARER,
	pSANCHEZ,
	pQUADBIKE,
	pBurrito,
	pFlatbed,
	pDFT30,
	pMule,
	pTanker,
	pBag,
	pMeggi,
	pRoti,
	pKeropok,
	pBurger,
	pPepsi,
	pLemontea,
	pCoke,
	pSlurphy,	
	pKnife,
	pBat,
	pSilenced,
	pDesert,
	pShotgun,
	pMp5,
	pAk47,
	pM4,
	pSniper,
	pKantana,
	pUzi,
	pJoran,
	pIkanBawal,
	pIkanSiakap,
	pIkanPatin,
	Float:pHealth,
	Float:pArmour,
}
new PlayerInfo[MAX_PLAYERS][pInfo];

enum vInfo
{
	vEngine,
	vLampu,
	vAlarm,
	vBonnet,
	vBoot,
	vObj,
}
new VehInfo [MAX_VEHICLES][vInfo];

enum e_votedata
{
	bool:voteExists,
	voteYes,
	voteNo
};
new VoteData[e_votedata];

new SkinNewbie[] = {
	78,
	79,
	134,
	135,
	137,
	212,
	230,
	239
};

new RandomMSG[][] =
{
    "{9739E3}[DISCORD]: {FFFFFF}Anda Boleh Membeli VIP Dengan Pembayaran Terus Ke {FF2400}Boss Danial",
    "{9739E3}[DISCORD]: {FFFFFF}Musim-Musim Covid Ni Jangan Banyak Keluar Rumah Ye. {FF2400}#STAYSAFE",
    "{9739E3}[DISCORD]: {FFFFFF}Happy Roleplay!",
    "{9739E3}[DISCORD]: {FFFFFF}Jika Anda Player Baru Dan Tidak Tahu Buat Apa, Tulis /help",
    "{9739E3}[DISCORD]: {FFFFFF}Untuk Melihat Command, Tulis /menu",
    "{9739E3}[DISCORD]: {FFFFFF}Main Rilek Je Boss Jangan Panas-Panas!",
    "{9739E3}[DISCORD]: {FFFFFF}Sebarang Pertanyaan Boleh PM Discord Pihak Developer!",
    "{9739E3}[DISCORD]: {FFFFFF}Terima Kasih Sudi Support Penang Roleplay!",
    "{9739E3}[DISCORD]: {FFFFFF}Jika Ada Sebarang Bug Sila Laporkannya Kepada Pihak Developer!"
};

new RandomFISH[][] =
{
	"Anda Berjaya Mendapat Ikan Bawal",
	"Anda Berjaya Mendapat Sampah Sarap",
	"Anda Berjaya Mendapat Ikan Patin",
	"Anda Berjaya Mendapat Selipar",
	"Anda Berjaya Mendapat Ikan Siakap",
	"Anda Berjaya Mendapat Plastik Sampah",
	"Anda Berjaya Mendapat Plastik Sampah",
	"Anda Berjaya Mendapat Plastik Sampah"
};

public PayLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("pay.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public KickLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("kick.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public BanLog(string[])
{
	new entry[256];
	format(entry, sizeof(entry), "%s\n",string);
	new File:hFile;
	hFile = fopen("ban.log", io_append);
	fwrite(hFile, entry);
	fclose(hFile);
}

public ProxDetectorS(Float:radi, playerid, targetid)
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
			if(IsPlayerConnected(i))
			{
				GetPlayerPos(i, posx, posy, posz);
				tempposx = (oldposx -posx);
				tempposy = (oldposy -posy);
				tempposz = (oldposz -posz);
				new playerworld, player2world;
				playerworld = GetPlayerVirtualWorld(playerid);
				player2world = GetPlayerVirtualWorld(i);
				if(playerworld == player2world)
				{
					if (((tempposx < radi/16) && (tempposx > -radi/16)) && ((tempposy < radi/16) && (tempposy > -radi/16)) && ((tempposz < radi/16) && (tempposz > -radi/16)))
					{
						SendClientMessage(i, col1, string);
					}
					else if (((tempposx < radi/8) && (tempposx > -radi/8)) && ((tempposy < radi/8) && (tempposy > -radi/8)) && ((tempposz < radi/8) && (tempposz > -radi/8)))
					{
						SendClientMessage(i, col2, string);
					}
					else if (((tempposx < radi/4) && (tempposx > -radi/4)) && ((tempposy < radi/4) && (tempposy > -radi/4)) && ((tempposz < radi/4) && (tempposz > -radi/4)))
					{
						SendClientMessage(i, col3, string);
					}
					else if (((tempposx < radi/2) && (tempposx > -radi/2)) && ((tempposy < radi/2) && (tempposy > -radi/2)) && ((tempposz < radi/2) && (tempposz > -radi/2)))
					{
						SendClientMessage(i, col4, string);
					}
					else if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi)))
					{
						SendClientMessage(i, col5, string);
					}
				}
				else
				{
					SendClientMessage(i, col1, string);
				}
			}
		}
	}
	return 1;
}

public OOCOff(color,const string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(IsPlayerConnected(i))
		{
		    if(!gOOC[i])
		    {
				SendClientMessage(i, color, string);
			}
		}
	}
}

public SaveAccountInfo(playerid)
{
	new Duit = GetPlayerMoney(playerid);
	new Skin = GetPlayerSkin(playerid);
	new Float:health;
	new Float:armour;
	GetPlayerHealth(playerid, health);
	GetPlayerArmour(playerid, armour);
	new INI:File = INI_Open(UserPath(playerid));
    INI_SetTag(File,"DATA AKAUN");
    INI_WriteInt(File,"Duit",Duit);
    INI_WriteInt(File,"Skin",Skin);
    INI_WriteInt(File,"Admin", PlayerInfo[playerid][pAdmin]);
    INI_WriteInt(File,"PPR", PlayerInfo[playerid][pPpr]);
    INI_WriteInt(File,"JPJ", PlayerInfo[playerid][pPjp]);
    INI_WriteInt(File,"MPR", PlayerInfo[playerid][pMpr]);
    INI_WriteInt(File,"Kapak", PlayerInfo[playerid][pKapak]);
    INI_WriteInt(File,"Black Shark", PlayerInfo[playerid][pBlackShark]);
    INI_WriteInt(File,"King302", PlayerInfo[playerid][pKing302]);
    INI_WriteInt(File,"Todak97", PlayerInfo[playerid][pTodak97]);
    INI_WriteInt(File,"Tenjiku Geng", PlayerInfo[playerid][pTenjikuGeng]);
    INI_WriteInt(File,"Jantina", PlayerInfo[playerid][pJantina]);
    INI_WriteInt(File,"MYKAD", PlayerInfo[playerid][pMYKAD]);
    INI_WriteInt(File,"BAG", PlayerInfo[playerid][pBag]);
    INI_WriteInt(File,"VEHICLE", PlayerInfo[playerid][pVEH]);
    INI_WriteInt(File,"Infernus", PlayerInfo[playerid][pInfernus]);
    INI_WriteInt(File,"Sultan", PlayerInfo[playerid][pSultan]);
    INI_WriteInt(File,"Elegy", PlayerInfo[playerid][pElegy]);
    INI_WriteInt(File,"Blista", PlayerInfo[playerid][pBlista]);
    INI_WriteInt(File,"Tampa", PlayerInfo[playerid][pTampa]);
    INI_WriteInt(File,"Huntley", PlayerInfo[playerid][pHuntley]);
    INI_WriteInt(File,"Sabre", PlayerInfo[playerid][pSabre]);
    INI_WriteInt(File,"Cheetah", PlayerInfo[playerid][pCheetah]);
    INI_WriteInt(File,"Bullet", PlayerInfo[playerid][pBullet]);
    INI_WriteInt(File,"Buffalo", PlayerInfo[playerid][pBuffalo]);
    INI_WriteInt(File,"Stretch", PlayerInfo[playerid][pStretch]);
    INI_WriteInt(File,"Banshee", PlayerInfo[playerid][pBanshee]);
    INI_WriteInt(File,"BF400", PlayerInfo[playerid][pBF400]);
    INI_WriteInt(File,"NRG500", PlayerInfo[playerid][pNRG500]);
    INI_WriteInt(File,"FCR900", PlayerInfo[playerid][pFCR900]);
    INI_WriteInt(File,"PCJ600", PlayerInfo[playerid][pPCJ600]);
    INI_WriteInt(File,"FREEWAY", PlayerInfo[playerid][pFREEWAY]);
    INI_WriteInt(File,"WAYFARER", PlayerInfo[playerid][pWAYFARER]);
    INI_WriteInt(File,"SANCHEZ", PlayerInfo[playerid][pSANCHEZ]);
    INI_WriteInt(File,"QUADBIKE", PlayerInfo[playerid][pQUADBIKE]);
    INI_WriteInt(File,"BURRITO", PlayerInfo[playerid][pBurrito]);
    INI_WriteInt(File,"FLATBED", PlayerInfo[playerid][pFlatbed]);
    INI_WriteInt(File,"DFT-30", PlayerInfo[playerid][pDFT30]);
    INI_WriteInt(File,"MULE", PlayerInfo[playerid][pMule]);
    INI_WriteInt(File,"TANKER", PlayerInfo[playerid][pTanker]);
    INI_WriteInt(File,"Jail", PlayerInfo[playerid][pJail]);
    INI_WriteInt(File,"Gari", PlayerInfo[playerid][pGari]);
    INI_WriteInt(File,"Mati", PlayerInfo[playerid][pMati]);
    INI_WriteInt(File,"Knife",PlayerInfo[playerid][pKnife]);
    INI_WriteInt(File,"Bat",PlayerInfo[playerid][pBat]);
    INI_WriteInt(File,"Silenced",PlayerInfo[playerid][pSilenced]);
    INI_WriteInt(File,"Desert",PlayerInfo[playerid][pDesert]);
    INI_WriteInt(File,"Shotgun",PlayerInfo[playerid][pShotgun]);
    INI_WriteInt(File,"Mp5",PlayerInfo[playerid][pAk47]);
    INI_WriteInt(File,"Ak47",PlayerInfo[playerid][pKnife]);
    INI_WriteInt(File,"M4",PlayerInfo[playerid][pM4]);
    INI_WriteInt(File,"Sniper",PlayerInfo[playerid][pSniper]);
    INI_WriteInt(File,"Kantana",PlayerInfo[playerid][pKantana]);
    INI_WriteInt(File,"Uzi",PlayerInfo[playerid][pUzi]);
    INI_WriteInt(File,"Joran",PlayerInfo[playerid][pJoran]);
    INI_WriteInt(File,"Ikan Bawal",PlayerInfo[playerid][pIkanBawal]);
    INI_WriteInt(File,"Ikan Siakap",PlayerInfo[playerid][pIkanSiakap]);
    INI_WriteInt(File,"Ikan Patin",PlayerInfo[playerid][pIkanPatin]);
    INI_WriteFloat(File,"Health", health);
    INI_WriteFloat(File,"Armour", armour);
    INI_WriteInt(File,"VIP", PlayerInfo[playerid][pVip]);
    INI_Close(File);
	return 1;
}

public LoadUser_data(playerid,name[],value[])
{
    INI_Int("Duit",PlayerInfo[playerid][pDuit]);
    INI_Int("Deposit",PlayerInfo[playerid][pDeposit]);
    INI_Int("Skin",PlayerInfo[playerid][pSkin]);
    INI_Int("Jantina",PlayerInfo[playerid][pJantina]);
    INI_Int("Admin",PlayerInfo[playerid][pAdmin]);
    INI_Int("PPR", PlayerInfo[playerid][pPpr]);
    INI_Int("JPJ", PlayerInfo[playerid][pPjp]);
    INI_Int("MPR", PlayerInfo[playerid][pMpr]);
    INI_Int("Kapak", PlayerInfo[playerid][pKapak]);
    INI_Int("Black Shark", PlayerInfo[playerid][pBlackShark]);
    INI_Int("King302", PlayerInfo[playerid][pKing302]);
    INI_Int("Todak97", PlayerInfo[playerid][pTodak97]);
    INI_Int("Tenjiku Geng", PlayerInfo[playerid][pTenjikuGeng]);
    INI_Int("MYKAD",PlayerInfo[playerid][pMYKAD]);
    INI_Int("BAG",PlayerInfo[playerid][pBag]);
    INI_Int("VEHICLE",PlayerInfo[playerid][pVEH]);
    INI_Int("Stretch",PlayerInfo[playerid][pStretch]);
    INI_Int("Buffalo",PlayerInfo[playerid][pBuffalo]);
    INI_Int("Banshee",PlayerInfo[playerid][pBanshee]);
    INI_Int("Sabre",PlayerInfo[playerid][pSabre]);
    INI_Int("BF400",PlayerInfo[playerid][pBF400]);
    INI_Int("NRG500",PlayerInfo[playerid][pNRG500]);
    INI_Int("FCR900",PlayerInfo[playerid][pFCR900]);
    INI_Int("PCJ600",PlayerInfo[playerid][pPCJ600]);
    INI_Int("FREEWAY",PlayerInfo[playerid][pFREEWAY]);
    INI_Int("WAYFARER",PlayerInfo[playerid][pWAYFARER]);
    INI_Int("SANCHEZ",PlayerInfo[playerid][pSANCHEZ]);
    INI_Int("QUADBIKE",PlayerInfo[playerid][pQUADBIKE]);
    INI_Int("BURRITO",PlayerInfo[playerid][pBurrito]);
    INI_Int("FLATBED",PlayerInfo[playerid][pFlatbed]);
    INI_Int("DFT30",PlayerInfo[playerid][pDFT30]);
    INI_Int("TANKER",PlayerInfo[playerid][pTanker]);
    INI_Int("MULE",PlayerInfo[playerid][pMule]);
    INI_Int("VIP",PlayerInfo[playerid][pVip]);
    INI_Int("Jail",PlayerInfo[playerid][pJail]);
    INI_Int("Gari",PlayerInfo[playerid][pGari]);
    INI_Int("Mati",PlayerInfo[playerid][pMati]);
    INI_Int("Knife",PlayerInfo[playerid][pKnife]);
    INI_Int("Bat",PlayerInfo[playerid][pBat]);
    INI_Int("Silenced",PlayerInfo[playerid][pSilenced]);
    INI_Int("Desert",PlayerInfo[playerid][pDesert]);
    INI_Int("Shotgun",PlayerInfo[playerid][pShotgun]);
    INI_Int("Mp5",PlayerInfo[playerid][pAk47]);
    INI_Int("Ak47",PlayerInfo[playerid][pKnife]);
    INI_Int("M4",PlayerInfo[playerid][pM4]);
    INI_Int("Sniper",PlayerInfo[playerid][pSniper]);
    INI_Int("Kantana",PlayerInfo[playerid][pKantana]);
    INI_Int("Uzi",PlayerInfo[playerid][pUzi]);
    INI_Int("Joran",PlayerInfo[playerid][pJoran]);
    INI_Int("Ikan Bawal",PlayerInfo[playerid][pIkanBawal]);
    INI_Int("Ikan Siakap",PlayerInfo[playerid][pIkanSiakap]);
    INI_Int("Ikan Patin",PlayerInfo[playerid][pIkanPatin]);
    INI_Float("Health",PlayerInfo[playerid][pHealth]);
    INI_Float("Armour",PlayerInfo[playerid][pArmour]);
    return 1;
}

public GetUserPassword(playerid, name[], value[])
{
    INI_String("Password", PlayerInfo[playerid][pPassword], 130);
    return 1;
}
//==================== STOCK ===================================================
stock ABroadCast(color,string[], rank)
{
	foreach(Player, i)
	{
		if (PlayerInfo[i][pAdmin] >= rank)
		{
			SendClientMessage(i, color, string);
			printf("%s", string);
		}
	}
	return 1;
}

stock IsABoat(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 430,446,452,453,454,472,473,484,493,595: return 1;
    }
    return 0;
}

stock IsAPlane(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 460,464,476,511,512,513,519,520,553,577,592,593: return 1;
    }
    return 0;
}

stock IsAHelicopter(vehicleid) 
{
    switch(GetVehicleModel(vehicleid))
    {
        case 417,425,447,465,469,487,488,497,501,548,563: return 1;
    }
    return 0;
}

stock IsATrain(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 449,537,538,569,570,590: return 1;
    }
    return 0;
}

stock IsABike(vehicleid)
{
    switch(GetVehicleModel(vehicleid))
    {
        case 461,462,463,468,521,522,523,581,586,481,409,510: return 1;
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
			507,
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
			603: return 1;
    }
    return 0;
}

stock IsALORI(vehicleid)
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

stock UserPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string), PATH, playername);
    return string;
}

stock WhitelistPath(playerid)
{
    new string[128],playername[MAX_PLAYER_NAME];
    GetPlayerName(playerid,playername,sizeof(playername));
    format(string,sizeof(string), PATH2, playername);
    return string;
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

stock udb_hash(buf[]) {
    new length=strlen(buf);
    new s1 = 1;
    new s2 = 0;
    new n;
    for (n=0; n<length; n++)
    {
       s1 = (s1 + buf[n]) % 65521;
       s2 = (s2 + s1)     % 65521;
    }
    return (s2 << 16) + s1;
}

stock str_replace(string[], find, replace)
{
    for(new i=0; string[i]; i++)
    {
        if(string[i] == find)
        {
            string[i] = replace;
        }
    }
}

stock GetName(playerid)
{
    new
        name[24];
    GetPlayerName(playerid, name, sizeof(name));
    str_replace(name, '_', ' ');
    return name;
}

//==============================================================================
main()
{
	print("\n------ PENANG ROLEPLAY ----------");
	print("    GAMEMODE PENANG ROLEPLAY"       );
	print("-------- GAMEMODE PENANG ---------");
	AdminPanel = DCC_FindChannelById("858663240544550972");// ADMIN AdminPanel
 	WhitelistChannel = DCC_FindChannelById("857807110117130280");//WHITELISTED 
 	BlacklistChannel = DCC_FindChannelById("857807110942752799");//BLACKLISTED
 	JoinLeaveChannel = DCC_FindChannelById("857807111692877824");//JOIN AND LEAVE CHANNEL
 	RoleChannel = DCC_FindChannelById("857807113215279135");//ROLE CHANNEL
 	DeathChannel = DCC_FindChannelById("857807112516403200");//PLAYER DEATH CHANNEL
 	DiscordChat = DCC_FindChannelById("858173020447178813");//DISCORD CHAT
}

public OnGameModeInit()
{
    SetGameModeText("| PMRP V1 |");
    SetNameTagDrawDistance(30.0);
    AllowInteriorWeapons(1);
	ShowPlayerMarkers(1);
	EnableStuntBonusForAll(0);
	DisableInteriorEnterExits();
	SetTimer("SendMSG", 300000, true);
	SetTimer("UpdateSpeed", UpdateSeconds*1000, 1);

	//================ MAPPING ONLY ===========================================
	new King[53];
	King[0] = CreateObject(19381, 1557.4233, 777.0485, 10.0818, 0.0000, 0.0000, 0.0000, 300.0); //wall029
	King[1] = CreateObject(19381, 1552.7021, 663.2693, 10.6718, 0.0000, 0.0000, -89.7999); //wall029
	King[2] = CreateObject(19381, 1557.3527, 785.8516, 10.0356, 0.0000, 0.0000, 0.0000); //wall029
	King[3] = CreateObject(19381, 1557.3815, 769.0682, 10.1203, 0.0000, 0.0000, 0.0000); //wall029
	King[4] = CreateObject(19381, 1557.4058, 761.0756, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[5] = CreateObject(19381, 1557.4029, 752.3195, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[6] = CreateObject(19381, 1557.4610, 742.7070, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[7] = CreateObject(19381, 1557.4310, 734.7670, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[8] = CreateObject(19381, 1557.3610, 726.3787, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[9] = CreateObject(19381, 1557.3836, 717.2095, 10.7691, 0.0000, 0.0000, 0.0000); //wall029
	King[10] = CreateObject(19381, 1557.3463, 707.6828, 10.7644, 0.0000, 0.0000, 0.0000); //wall029
	King[11] = CreateObject(19381, 1557.4091, 698.5304, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[12] = CreateObject(19381, 1557.4163, 688.9618, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[13] = CreateObject(19381, 1557.3671, 679.9458, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[14] = CreateObject(19381, 1557.3712, 671.3888, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[15] = CreateObject(19381, 1557.4605, 668.0821, 10.6718, 0.0000, 0.0000, 0.0000); //wall029
	King[16] = CreateObject(980, 1531.7357, 663.2075, 12.5212, 0.0000, 0.0000, 0.0000); //airportgate
	King[17] = CreateObject(19381, 1543.1555, 663.2694, 10.7018, 0.0000, 0.0000, -89.8999); //wall029
	King[18] = CreateObject(19381, 1542.2662, 663.2915, 10.6547, -0.2999, 0.0000, -87.6999); //wall029
	King[19] = CreateObject(19381, 1512.5350, 663.2545, 10.8418, 0.0000, 0.0000, -89.9999); //wall029
	King[20] = CreateObject(980, 1520.1964, 663.2446, 12.5077, 0.0000, 0.0000, 0.0000); //airportgate
	King[21] = CreateObject(19381, 1557.3381, 795.1702, 10.0032, 0.0000, 0.0000, 0.0000); //wall029
	King[22] = CreateObject(19381, 1504.4959, 663.1842, 10.6718, 0.0000, 0.0000, -89.9000); //wall029
	King[23] = CreateObject(19381, 1494.8847, 663.0737, 10.6796, 0.0000, 0.0000, -88.6999); //wall029
	King[24] = CreateObject(19381, 1485.3021, 663.1398, 10.6796, 0.0000, 0.0000, -90.2999); //wall029
	King[25] = CreateObject(19381, 1475.6582, 663.2199, 10.6718, 0.0000, 0.0000, -89.4000); //wall029
	King[26] = CreateObject(19381, 1466.1511, 663.0731, 10.6718, 0.0000, 0.0000, -89.5000); //wall029
	King[27] = CreateObject(19381, 1456.8549, 663.1947, 10.7188, 0.0000, 0.0000, 90.6000); //wall029
	King[28] = CreateObject(19381, 1447.2141, 663.0689, 10.8619, 0.0000, 0.0000, -88.6999); //wall029
	King[29] = CreateObject(19381, 1437.6003, 662.9459, 10.6718, 0.0000, 0.0000, 91.5999); //wall029
	King[30] = CreateObject(19381, 1428.2070, 662.9802, 10.6718, 0.0000, 0.0000, 90.7999); //wall029
	King[31] = CreateObject(19381, 1418.7855, 662.9782, 10.6718, 0.0000, 0.0000, -89.5999); //wall029
	King[32] = CreateObject(19381, 1409.2392, 663.0009, 10.6718, 0.0000, 0.0000, 90.1999); //wall029
	King[33] = CreateObject(19381, 1402.3175, 662.9573, 10.6718, 0.0000, 0.0000, -89.9999); //wall029
	King[34] = CreateObject(19384, 1397.4681, 731.9255, 14.3303, 0.0000, 0.0000, 0.0000); //wall032
	King[35] = CreateObject(19381, 1552.6473, 797.6993, 10.4164, 0.0000, 0.0000, -89.8000); //wall029
	King[36] = CreateObject(19381, 1543.1312, 797.8919, 10.0895, 0.0000, 0.0000, 90.1999); //wall029
	King[37] = CreateObject(19381, 1397.4484, 667.6405, 10.8280, 0.0000, 0.0000, 0.0000); //wall029
	King[38] = CreateObject(19381, 1397.2658, 677.2651, 10.8280, 0.0000, 0.0000, 0.0000); //wall029
	King[39] = CreateObject(19381, 1397.3190, 686.8222, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[40] = CreateObject(19381, 1397.4609, 696.4450, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[41] = CreateObject(19381, 1397.4500, 706.0814, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[42] = CreateObject(19381, 1397.4283, 715.7122, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[43] = CreateObject(19381, 1397.4385, 725.2783, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[44] = CreateObject(19381, 1397.4321, 725.8917, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[45] = CreateObject(971, 1397.4112, 731.6307, 10.8133, 0.0000, 0.0000, 90.4000); //subwaygate
	King[46] = CreateObject(19381, 1397.4097, 738.0594, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[47] = CreateObject(19381, 1397.2913, 747.8187, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[48] = CreateObject(19381, 1397.4755, 757.4255, 10.8203, 0.0000, 0.0000, 0.0000); //wall029
	King[49] = CreateObject(19381, 1397.3936, 767.5276, 11.3124, -89.0000, -0.3000, 0.0000); //wall029
	King[50] = CreateObject(19380, 1397.4222, 785.2169, 10.8203, 0.0000, 0.0000, 0.0000); //wall028
	King[51] = CreateObject(19380, 1397.4578, 775.2577, 11.4099, -89.8000, 1.8999, 2.2000); //wall028
	King[52] = CreateObject(19380, 1397.5020, 793.2680, 10.8280, 0.0000, 0.0000, 0.0000); //wall028

	new Todak[131];
	Todak[0] = CreateObject(19380, 2517.3659, 1813.3883, 11.8996, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[0], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[1] = CreateObject(3528, 2518.7155, 1816.0333, 20.7618, 0.0000, 0.0000, 180.0000); //vgsEdragon
	Todak[2] = CreateObject(19380, 2517.3659, 1808.1870, 11.8996, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[2], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[3] = CreateObject(19380, 2517.3659, 1833.0682, 11.8996, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[3], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[4] = CreateObject(19380, 2517.3659, 1838.3989, 11.8996, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[4], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[5] = CreateObject(980, 2517.2990, 1822.5970, 12.4834, 0.0000, 0.0000, 90.0000); //airportgate
	Todak[6] = CreateObject(3528, 2518.7155, 1823.7535, 20.7618, 0.0000, 0.0000, 180.0000); //vgsEdragon
	Todak[7] = CreateObject(3528, 2518.7155, 1831.5041, 20.7618, 0.0000, 0.0000, 180.0000); //vgsEdragon
	Todak[8] = CreateObject(19124, 2515.6308, 1828.9123, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[9] = CreateObject(19124, 2515.6308, 1828.9123, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[10] = CreateObject(19124, 2513.3310, 1831.5522, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[11] = CreateObject(19124, 2513.3310, 1831.5522, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[12] = CreateObject(19124, 2513.0908, 1836.4226, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[13] = CreateObject(19124, 2513.0908, 1836.4226, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[14] = CreateObject(19124, 2513.0908, 1843.0433, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[15] = CreateObject(19124, 2513.0908, 1843.0433, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[16] = CreateObject(19124, 2513.0908, 1803.2408, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[17] = CreateObject(19124, 2513.0908, 1803.2408, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[18] = CreateObject(19124, 2513.0908, 1807.9615, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[19] = CreateObject(19124, 2513.0908, 1807.9615, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[20] = CreateObject(19124, 2513.0908, 1814.8028, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[21] = CreateObject(19124, 2513.0908, 1814.8028, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[22] = CreateObject(19124, 2516.1530, 1817.6125, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[23] = CreateObject(19124, 2516.1530, 1817.6125, 10.1855, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[24] = CreateObject(19353, 2517.9372, 1826.7861, 18.2469, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[24], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Todak[25] = CreateObject(19353, 2517.9372, 1823.5865, 18.2469, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[25], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Todak[26] = CreateObject(19353, 2517.9372, 1820.4167, 18.2469, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[26], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Todak[27] = CreateObject(19353, 2517.9372, 1819.5660, 18.2469, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[27], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Todak[28] = CreateObject(19353, 2517.9372, 1825.3165, 18.2469, 0.0000, 0.0000, 0.0000); //wall001 
	SetObjectMaterialText(Todak[28], "BASE", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 85, 1, 0xFFFFFFFF, 0x00000000, 1);
	Todak[29] = CreateObject(19353, 2517.9372, 1820.4759, 18.2469, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterialText(Todak[29], "TODAK97", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 60, 1, 0xFFFFFFFF, 0x00000000, 1);
	Todak[30] = CreateObject(19380, 2557.5134, 1679.8327, 13.3696, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[30], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[31] = CreateObject(19380, 2557.5134, 1689.3232, 13.3696, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[31], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[32] = CreateObject(19380, 2557.5134, 1698.8138, 13.3696, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[32], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[33] = CreateObject(19380, 2557.5134, 1708.1136, 13.3696, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Todak[33], 0, 3820, "boxhses_sfsx", "ws_ irongate", 0x00000000);
	Todak[34] = CreateObject(19124, 2556.2053, 1687.5306, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[35] = CreateObject(19124, 2556.2053, 1687.5306, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[36] = CreateObject(19124, 2554.1933, 1686.4405, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[37] = CreateObject(19124, 2554.1933, 1686.4405, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[38] = CreateObject(19124, 2553.0334, 1680.8194, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[39] = CreateObject(19124, 2553.0334, 1680.8194, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[40] = CreateObject(19124, 2553.0334, 1673.2585, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[41] = CreateObject(19124, 2553.0334, 1673.2585, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[42] = CreateObject(19124, 2550.4919, 1710.8911, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[43] = CreateObject(19124, 2550.4919, 1710.8911, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[44] = CreateObject(19124, 2552.3320, 1706.2004, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[45] = CreateObject(19124, 2552.3320, 1706.2004, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[46] = CreateObject(19124, 2553.7607, 1700.9798, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[47] = CreateObject(19124, 2553.7607, 1700.9798, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[48] = CreateObject(19124, 2556.1918, 1698.7696, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[49] = CreateObject(19124, 2556.1918, 1698.7696, 10.2248, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[50] = CreateObject(6965, 2577.5646, 1831.9399, 12.5830, 0.0000, 0.0000, 0.0000); //venefountain02
	Todak[51] = CreateObject(6965, 2577.5646, 1820.5097, 12.5830, 0.0000, 0.0000, 0.0000); //venefountain02
	Todak[52] = CreateObject(6965, 2577.5646, 1809.6196, 12.5830, 0.0000, 0.0000, 0.0000); //venefountain02
	Todak[53] = CreateObject(19121, 2577.6005, 1831.9233, 16.3050, 0.0000, 0.0000, 0.0000); //BollardLight1
	Todak[54] = CreateObject(19121, 2577.6005, 1831.9233, 16.3050, 0.0000, 0.0000, 0.0000); //BollardLight1
	Todak[55] = CreateObject(19121, 2577.6005, 1820.5728, 16.3050, 0.0000, 0.0000, 0.0000); //BollardLight1
	Todak[56] = CreateObject(19121, 2577.6005, 1820.5728, 16.3050, 0.0000, 0.0000, 0.0000); //BollardLight1
	Todak[57] = CreateObject(19121, 2577.6005, 1809.6530, 16.3050, 0.0000, 0.0000, 0.0000); //BollardLight1
	Todak[58] = CreateObject(19121, 2577.6005, 1809.6530, 16.3050, 0.0000, 0.0000, 0.0000); //BollardLight1
	Todak[59] = CreateObject(18688, 2621.6250, 1821.0133, 11.0234, 0.0000, 0.0000, 0.0000); //fire
	Todak[60] = CreateObject(18688, 2621.6250, 1827.6433, 11.0234, 0.0000, 0.0000, 0.0000); //fire
	Todak[61] = CreateObject(19124, 2632.8876, 1829.8011, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[62] = CreateObject(19124, 2632.8876, 1829.8011, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[63] = CreateObject(19124, 2625.9438, 1829.8011, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[64] = CreateObject(19124, 2625.9438, 1829.8011, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[65] = CreateObject(19124, 2625.9438, 1819.2702, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[66] = CreateObject(19124, 2625.9438, 1819.2702, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[67] = CreateObject(19124, 2632.7741, 1819.2702, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[68] = CreateObject(19124, 2632.7741, 1819.2702, 10.5886, 0.0000, 0.0000, 0.0000); //BollardLight4
	Todak[69] = CreateObject(19353, 2633.8046, 1824.5815, 9.9659, 0.0000, 90.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[69], 0, 2127, "cj_kitchen", "CJ_RED", 0x00000000);
	Todak[70] = CreateObject(19353, 2633.8046, 1821.3818, 9.9659, 0.0000, 90.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[70], 0, 2127, "cj_kitchen", "CJ_RED", 0x00000000);
	Todak[71] = CreateObject(19353, 2630.3239, 1821.3818, 9.9659, 0.0000, 90.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[71], 0, 2127, "cj_kitchen", "CJ_RED", 0x00000000);
	Todak[72] = CreateObject(19353, 2626.8430, 1821.3818, 9.9659, 0.0000, 90.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[72], 0, 2127, "cj_kitchen", "CJ_RED", 0x00000000);
	Todak[73] = CreateObject(19353, 2626.8430, 1824.5925, 9.9659, 0.0000, 90.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[73], 0, 2127, "cj_kitchen", "CJ_RED", 0x00000000);
	Todak[74] = CreateObject(19353, 2630.3442, 1824.5925, 9.9659, 0.0000, 90.0000, 0.0000); //wall001
	SetObjectMaterial(Todak[74], 0, 2127, "cj_kitchen", "CJ_RED", 0x00000000);
	Todak[75] = CreateObject(19356, 2618.6206, 1781.6687, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[75], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[76] = CreateObject(19128, 2615.4631, 1790.6193, 9.9264, 0.0000, 0.0000, 0.0000); //DanceFloor1
	Todak[77] = CreateObject(1502, 2620.3664, 1792.7321, 9.9335, 0.0000, 0.0000, 0.0000); //Gen_doorINT04
	Todak[78] = CreateObject(19356, 2618.6206, 1788.0780, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[78], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[79] = CreateObject(19356, 2618.6206, 1791.2475, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[79], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[80] = CreateObject(19356, 2615.1274, 1791.2475, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[80], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[81] = CreateObject(19356, 2615.1198, 1788.0780, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[81], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[82] = CreateObject(19356, 2615.1198, 1784.8784, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[82], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[83] = CreateObject(19356, 2615.1198, 1781.6588, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[83], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[84] = CreateObject(19356, 2622.1103, 1791.2475, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[84], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[85] = CreateObject(19356, 2622.1103, 1788.0275, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[85], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[86] = CreateObject(19356, 2622.1103, 1784.8468, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[86], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[87] = CreateObject(19356, 2622.1103, 1781.6770, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[87], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[88] = CreateObject(19356, 2625.5996, 1791.2475, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[88], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[89] = CreateObject(19356, 2625.5996, 1788.0280, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[89], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[90] = CreateObject(19356, 2625.5996, 1784.8172, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[90], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[91] = CreateObject(19356, 2625.5996, 1781.6763, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[91], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[92] = CreateObject(19356, 2624.7053, 1792.7827, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[92], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[93] = CreateObject(19356, 2625.7363, 1792.7827, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[93], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[94] = CreateObject(19356, 2618.7861, 1792.7827, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[94], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[95] = CreateObject(19356, 2615.5849, 1792.7827, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[95], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[96] = CreateObject(19356, 2614.9946, 1792.7827, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[96], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[97] = CreateObject(1502, 2623.3586, 1792.7529, 9.9335, 0.0000, 0.0000, 179.6002); //Gen_doorINT04
	Todak[98] = CreateObject(19356, 2615.1486, 1783.7487, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[98], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[99] = CreateObject(8572, 2617.4519, 1781.2327, 11.2687, 0.0000, 0.0000, 0.0000); //vgsSstairs02_lvs
	Todak[100] = CreateObject(19356, 2618.6206, 1784.8685, 9.8806, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[100], 0, 10101, "2notherbuildsfe", "Bow_Abpave_Gen", 0xFFFFFFFF);
	Todak[101] = CreateObject(19356, 2618.6401, 1783.7487, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[101], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[102] = CreateObject(19356, 2613.4338, 1781.6629, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[102], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[103] = CreateObject(19356, 2613.4338, 1791.2633, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[103], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[104] = CreateObject(19356, 2613.4338, 1788.0533, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[104], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[105] = CreateObject(19356, 2613.4338, 1784.8432, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[105], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[106] = CreateObject(19356, 2614.9746, 1780.1219, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[106], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[107] = CreateObject(19356, 2625.5805, 1786.9288, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[107], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[108] = CreateObject(19356, 2618.1147, 1780.1219, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[108], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[109] = CreateObject(19356, 2621.2551, 1780.1219, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[109], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[110] = CreateObject(19356, 2624.4155, 1780.1219, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[110], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[111] = CreateObject(19356, 2625.7465, 1780.1219, 10.6965, 0.0000, 0.0000, 90.0000); //wall004
	SetObjectMaterial(Todak[111], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[112] = CreateObject(19356, 2627.2575, 1781.6629, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[112], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[113] = CreateObject(19356, 2627.2575, 1784.8028, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[113], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[114] = CreateObject(19356, 2627.2575, 1788.0031, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[114], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[115] = CreateObject(19356, 2627.2575, 1791.2332, 10.7065, 0.0000, 0.0000, 360.0000); //wall004
	SetObjectMaterial(Todak[115], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF708090);
	Todak[116] = CreateObject(19356, 2622.1303, 1783.7487, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[116], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[117] = CreateObject(19356, 2625.5805, 1783.7487, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[117], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[118] = CreateObject(19356, 2625.5805, 1781.6490, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[118], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[119] = CreateObject(19356, 2622.0397, 1781.6490, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[119], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[120] = CreateObject(19356, 2625.5805, 1790.1405, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[120], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[121] = CreateObject(19356, 2625.5805, 1791.2513, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[121], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[122] = CreateObject(19356, 2622.0971, 1791.2513, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[122], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[123] = CreateObject(19356, 2618.6564, 1791.2513, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[123], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[124] = CreateObject(19356, 2615.1669, 1788.0908, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[124], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[125] = CreateObject(19356, 2615.1669, 1791.2513, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[125], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[126] = CreateObject(19356, 2615.1669, 1786.9498, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[126], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[127] = CreateObject(19356, 2618.6401, 1786.9290, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[127], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[128] = CreateObject(19356, 2618.6401, 1788.7994, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[128], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[129] = CreateObject(19356, 2622.1303, 1786.9390, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[129], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);
	Todak[130] = CreateObject(19356, 2622.1303, 1788.3892, 12.4206, 0.0000, 90.0000, 0.0000); //wall004
	SetObjectMaterial(Todak[130], 0, 10101, "2notherbuildsfe", "ferry_build14", 0xFF000000);

	new Kapak[158];
	new BudakActor[2];
	Kapak[0] = CreateObject(19380, 1417.9956, 2837.6245, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[0], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[1] = CreateObject(3749, 1532.7065, 2772.9553, 15.5697, 0.0000, 0.0000, 90.0000); //ClubGate01_LAx
	Kapak[2] = CreateObject(19380, 1417.9956, 2828.0156, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[2], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[3] = CreateObject(19380, 1417.9956, 2847.2238, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[3], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[4] = CreateObject(19380, 1417.9956, 2856.8640, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[4], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[5] = CreateObject(19380, 1417.9956, 2866.4838, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[5], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[6] = CreateObject(19380, 1417.9956, 2876.0937, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[6], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[7] = CreateObject(19380, 1417.9753, 2878.2644, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[7], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[8] = CreateObject(19380, 1422.8564, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[8], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[9] = CreateObject(19380, 1432.4659, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[9], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[10] = CreateObject(19380, 1442.0659, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[10], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[11] = CreateObject(19380, 1451.6756, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[11], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[12] = CreateObject(19380, 1470.8944, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[12], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[13] = CreateObject(19380, 1461.2949, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[13], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[14] = CreateObject(19380, 1480.4841, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[14], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[15] = CreateObject(19380, 1490.0937, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[15], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[16] = CreateObject(19380, 1499.7331, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[16], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[17] = CreateObject(19380, 1509.3225, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[17], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[18] = CreateObject(19380, 1518.9426, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[18], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[19] = CreateObject(19380, 1528.5522, 2883.0236, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[19], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[20] = CreateObject(19380, 1529.7423, 2883.0336, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[20], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[21] = CreateObject(19380, 1534.5522, 2878.1943, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[21], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[22] = CreateObject(19380, 1534.5522, 2868.5949, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[22], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[23] = CreateObject(19380, 1534.5522, 2859.0053, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[23], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[24] = CreateObject(19380, 1534.5522, 2849.4755, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[24], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[25] = CreateObject(19380, 1534.5522, 2839.8957, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[25], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[26] = CreateObject(19380, 1534.5522, 2830.3168, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[26], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[27] = CreateObject(19380, 1534.5522, 2820.7680, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[27], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[28] = CreateObject(19380, 1534.5522, 2811.1789, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[28], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[29] = CreateObject(19380, 1534.5522, 2801.5815, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[29], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[30] = CreateObject(19380, 1534.5522, 2792.0312, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[30], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[31] = CreateObject(19380, 1534.5322, 2787.4895, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[31], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[32] = CreateObject(19380, 1529.7912, 2783.1860, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[32], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[33] = CreateObject(19126, 1532.3084, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[34] = CreateObject(19380, 1534.5322, 2748.6806, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[34], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[35] = CreateObject(19380, 1534.5322, 2739.0517, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[35], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[36] = CreateObject(19380, 1534.5322, 2729.4624, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[36], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[37] = CreateObject(19380, 1534.4919, 2728.0014, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[37], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[38] = CreateObject(19380, 1529.7320, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[38], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[39] = CreateObject(19380, 1520.1329, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[39], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[40] = CreateObject(19380, 1510.5039, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[40], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[41] = CreateObject(19380, 1500.8951, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[41], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[42] = CreateObject(19380, 1491.2755, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[42], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[43] = CreateObject(19380, 1481.6562, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[43], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[44] = CreateObject(19380, 1472.0362, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[44], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[45] = CreateObject(19380, 1462.4366, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[45], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[46] = CreateObject(19380, 1452.8470, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[46], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[47] = CreateObject(19380, 1443.2578, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[47], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[48] = CreateObject(19380, 1433.6970, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[48], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[49] = CreateObject(19380, 1419.0854, 2750.3300, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[49], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[50] = CreateObject(19380, 1419.0854, 2740.7805, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[50], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[51] = CreateObject(19380, 1419.0854, 2731.2214, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[51], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[52] = CreateObject(19380, 1419.0854, 2728.0407, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[52], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[53] = CreateObject(19380, 1424.0975, 2723.2609, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[53], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[54] = CreateObject(19380, 1423.8271, 2723.2810, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[54], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[55] = CreateObject(19380, 1417.9956, 2818.4670, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[55], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[56] = CreateObject(19380, 1417.9956, 2808.8977, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[56], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[57] = CreateObject(19380, 1417.9956, 2799.2973, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[57], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[58] = CreateObject(19380, 1422.7956, 2794.5654, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[58], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[59] = CreateObject(14791, 1519.1202, 2740.9633, 11.8091, 0.0000, 0.0000, 0.0000); //a_vgsGymBoxa
	Kapak[60] = CreateObject(19380, 1520.2513, 2783.1860, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[60], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[61] = CreateObject(19380, 1518.1909, 2783.2060, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[61], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[62] = CreateObject(19380, 1529.7330, 2763.1926, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[62], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[63] = CreateObject(19380, 1520.1334, 2763.1926, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[63], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[64] = CreateObject(19380, 1518.6124, 2763.2226, 14.9503, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[64], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[65] = CreateObject(970, 1513.1146, 2785.2863, 10.3486, 0.0000, 0.0000, 97.5998); //fencesmallb
	Kapak[66] = CreateObject(970, 1512.9012, 2786.8837, 10.3486, 0.0000, 0.0000, 97.5998); //fencesmallb
	Kapak[67] = CreateObject(970, 1511.7915, 2790.8181, 10.3486, 0.0000, 0.0000, 114.3000); //fencesmallb
	Kapak[68] = CreateObject(970, 1510.0836, 2794.6010, 10.3486, 0.0000, 0.0000, 114.3000); //fencesmallb
	Kapak[69] = CreateObject(970, 1508.1501, 2798.2216, 10.3486, 0.0000, 0.0000, 121.9000); //fencesmallb
	Kapak[70] = CreateObject(970, 1507.1522, 2799.8256, 10.3486, 0.0000, 0.0000, 121.9000); //fencesmallb
	Kapak[71] = CreateObject(970, 1504.3387, 2802.6997, 10.3486, 0.0000, 0.0000, 147.4001); //fencesmallb
	Kapak[72] = CreateObject(970, 1500.8602, 2804.9250, 10.3486, 0.0000, 0.0000, 147.4001); //fencesmallb
	Kapak[73] = CreateObject(970, 1497.8531, 2806.8483, 10.3486, 0.0000, 0.0000, 147.4001); //fencesmallb
	Kapak[74] = CreateObject(970, 1473.3802, 2808.2341, 10.3486, 0.0000, 0.0000, 0.0000); //fencesmallb
	Kapak[75] = CreateObject(970, 1469.2308, 2808.2341, 10.3486, 0.0000, 0.0000, 0.0000); //fencesmallb
	Kapak[76] = CreateObject(970, 1465.1107, 2808.2341, 10.3486, 0.0000, 0.0000, 0.0000); //fencesmallb
	Kapak[77] = CreateObject(970, 1460.9709, 2808.2341, 10.3486, 0.0000, 0.0000, 0.0000); //fencesmallb
	Kapak[78] = CreateObject(970, 1456.8415, 2808.2341, 10.3486, 0.0000, 0.0000, 0.0000); //fencesmallb
	Kapak[79] = CreateObject(19121, 1507.0609, 2728.2329, 21.6616, 0.0000, 0.0000, 0.0000); //BollardLight1
	Kapak[80] = CreateObject(18850, 1519.7762, 2740.7353, 9.0886, 0.0000, 0.0000, 0.0000); //HeliPad1
	Kapak[81] = CreateObject(19121, 1532.3714, 2728.2329, 21.6616, 0.0000, 0.0000, 0.0000); //BollardLight1
	Kapak[82] = CreateObject(19121, 1532.3714, 2753.4365, 21.6616, 0.0000, 0.0000, 0.0000); //BollardLight1
	Kapak[83] = CreateObject(19121, 1507.0898, 2753.4365, 21.6616, 0.0000, 0.0000, 0.0000); //BollardLight1
	Kapak[84] = CreateObject(3279, 1529.4681, 2759.2048, 5.2666, 0.0000, 0.0000, 0.0000); //a51_spottower
	Kapak[85] = CreateObject(3505, 1487.4040, 2764.4694, 9.5944, 0.0000, 0.0000, 0.0000); //VgsN_nitree_y01
	Kapak[86] = CreateObject(19380, 1528.1125, 2745.1496, 14.2403, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[86], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[87] = CreateObject(19380, 1528.1424, 2736.8393, 14.2403, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[87], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[88] = CreateObject(19380, 1523.3020, 2731.5793, 14.2403, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[88], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[89] = CreateObject(19380, 1515.1120, 2731.5893, 14.2403, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[89], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[90] = CreateObject(19380, 1515.1120, 2749.7709, 14.2403, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[90], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[91] = CreateObject(19380, 1523.2541, 2749.8010, 14.2403, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Kapak[91], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[92] = CreateObject(3507, 1487.1621, 2758.7678, 9.7543, 0.0000, 0.0000, 0.0000); //VgsN_nitree_g01
	Kapak[93] = CreateObject(3505, 1487.4145, 2783.1467, 9.5944, 0.0000, 0.0000, 0.0000); //VgsN_nitree_y01
	Kapak[94] = CreateObject(744, 1485.8249, 2769.6389, 8.5930, 0.0000, 0.0000, 0.0000); //sm_scrub_rock4
	Kapak[95] = CreateObject(19380, 1487.1308, 2773.7944, 7.5503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[95], 0, -1, "none", "none", 0xFF000000);
	Kapak[96] = CreateObject(19360, 1487.1147, 2780.1872, 11.0502, 0.0000, 0.0000, 0.0000); //wall008
	SetObjectMaterial(Kapak[96], 0, 3850, "carshowglass_sfsx", "ws_glass_balustrade_better", 0x00000000);
	Kapak[97] = CreateObject(19360, 1487.1147, 2767.4045, 11.0502, 0.0000, 0.0000, 0.0000); //wall008
	SetObjectMaterial(Kapak[97], 0, 3850, "carshowglass_sfsx", "ws_glass_balustrade_better", 0x00000000);
	Kapak[98] = CreateObject(9833, 1486.8867, 2780.5771, 12.7376, 0.0000, 0.0000, 0.0000); //fountain_SFW
	Kapak[99] = CreateObject(9833, 1486.8867, 2767.2556, 12.7376, 0.0000, 0.0000, 0.0000); //fountain_SFW
	Kapak[100] = CreateObject(3507, 1487.1621, 2787.4985, 9.7543, 0.0000, 0.0000, 0.0000); //VgsN_nitree_g01
	Kapak[101] = CreateObject(3469, 1478.6804, 2732.1279, 12.7488, 0.0000, 0.0000, 90.0000); //vegenmotel1
	Kapak[102] = CreateObject(19353, 1487.1456, 2773.9858, 11.2903, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterialText(Kapak[102], "KAPAK", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 100, 1, 0xFFFFFFFF, 0x00000000, 1);
	Kapak[103] = CreateObject(980, 1533.1977, 2772.9001, 12.6380, 0.0000, 0.0000, 90.0000); //PAGAR Kapak
	Kapak[104] = CreateObject(744, 1485.8249, 2777.7690, 8.5930, 0.0000, 0.0000, 0.0000); //sm_scrub_rock4
	Kapak[105] = CreateObject(744, 1483.9757, 2776.6486, 6.5131, 0.0000, 0.0000, 0.0000); //sm_scrub_rock4
	Kapak[106] = CreateObject(744, 1483.9757, 2773.9885, 6.5131, 0.0000, 0.0000, 0.0000); //sm_scrub_rock4
	Kapak[107] = CreateObject(744, 1483.9757, 2771.4672, 6.5131, 0.0000, 0.0000, 0.0000); //sm_scrub_rock4
	Kapak[108] = CreateObject(6965, 1484.9831, 2774.1030, 8.6716, 0.0000, 0.0000, 0.0000); //venefountain02
	Kapak[109] = CreateObject(19122, 1485.0239, 2774.1047, 12.3439, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[110] = CreateObject(19122, 1485.0239, 2774.1047, 12.3439, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[111] = CreateObject(19122, 1482.8341, 2776.8552, 11.3739, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[112] = CreateObject(19122, 1482.8341, 2776.8552, 11.3739, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[113] = CreateObject(19122, 1482.8341, 2771.6542, 11.3739, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[114] = CreateObject(19122, 1482.8341, 2771.6542, 11.3739, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[115] = CreateObject(19122, 1533.7893, 2786.7639, 10.0953, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[116] = CreateObject(19122, 1533.7893, 2786.7639, 10.0953, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[117] = CreateObject(19122, 1533.7893, 2796.1884, 10.0953, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[118] = CreateObject(19122, 1533.7893, 2796.1884, 10.0953, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[119] = CreateObject(19122, 1533.7893, 2805.0908, 10.0953, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[120] = CreateObject(19122, 1533.7893, 2805.0908, 10.0953, 0.0000, 0.0000, 0.0000); //BollardLight2
	Kapak[121] = CreateObject(3471, 1536.0946, 2766.6879, 10.6406, 0.0000, 0.0000, 0.0000); //vgschinalion1
	Kapak[122] = CreateObject(3471, 1536.0946, 2779.6887, 10.6406, 0.0000, 0.0000, 0.0000); //vgschinalion1
	Kapak[123] = CreateObject(18688, 1536.3529, 2766.6093, 10.5641, 0.0000, 0.0000, 0.0000); //fire
	Kapak[124] = CreateObject(18688, 1536.3529, 2779.5412, 10.5641, 0.0000, 0.0000, 0.0000); //fire
	Kapak[125] = CreateObject(19353, 1535.1343, 2768.8137, 17.0355, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Kapak[125], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Kapak[126] = CreateObject(19126, 1534.3077, 2778.5021, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[127] = CreateObject(19126, 1534.3077, 2778.5021, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[128] = CreateObject(19126, 1537.8879, 2779.9426, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[129] = CreateObject(19126, 1537.8879, 2779.9426, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[130] = CreateObject(19126, 1539.3188, 2783.5419, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[131] = CreateObject(19126, 1539.3188, 2783.5419, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[132] = CreateObject(19126, 1539.3188, 2763.1191, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[133] = CreateObject(19126, 1539.3188, 2763.1191, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[134] = CreateObject(19126, 1537.8581, 2766.4694, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[135] = CreateObject(19126, 1534.5766, 2767.8601, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[136] = CreateObject(19126, 1534.5766, 2767.8601, 9.8423, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[137] = CreateObject(19380, 1534.5322, 2758.2795, 14.9503, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Kapak[137], 0, 14581, "ab_mafiasuitea", "ab_wood01", 0xFFFFFFFF);
	Kapak[138] = CreateObject(19126, 1532.3084, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[139] = CreateObject(19126, 1527.0583, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[140] = CreateObject(19126, 1527.0583, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[141] = CreateObject(19126, 1520.6478, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[142] = CreateObject(19126, 1520.6478, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[143] = CreateObject(19126, 1513.6971, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[144] = CreateObject(19126, 1513.6971, 2767.9038, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[145] = CreateObject(19126, 1529.7779, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[146] = CreateObject(19126, 1529.7779, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[147] = CreateObject(19126, 1523.7381, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[148] = CreateObject(19126, 1523.7381, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[149] = CreateObject(19126, 1518.8374, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[150] = CreateObject(19126, 1518.8374, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[151] = CreateObject(19126, 1513.8271, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[152] = CreateObject(19126, 1513.8271, 2778.7773, 10.0069, 0.0000, 0.0000, 0.0000); //BollardLight6
	Kapak[153] = CreateObject(19353, 1535.1343, 2771.9833, 17.0355, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Kapak[153], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Kapak[154] = CreateObject(19353, 1535.1343, 2775.1823, 17.0355, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Kapak[154], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Kapak[155] = CreateObject(19353, 1535.1343, 2777.2707, 17.0355, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterial(Kapak[155], 0, 10765, "airportgnd_sfse", "black64", 0x00000000);
	Kapak[156] = CreateObject(19353, 1535.1343, 2771.2019, 16.8755, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterialText(Kapak[156], "BASE", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 85, 1, 0xFFFFFFFF, 0x00000000, 1);
	Kapak[157] = CreateObject(19353, 1535.1343, 2775.0822, 16.8755, 0.0000, 0.0000, 0.0000); //wall001
	SetObjectMaterialText(Kapak[157], "KAPAL", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 85, 1, 0xFFFFFFFF, 0x00000000, 1);
	BudakActor[0] = CreateActor(164, 1533.7862, 2767.9104, 10.8203, -87.7997); //White Bouncer
	BudakActor[1] = CreateActor(164, 1533.7784, 2778.2792, 10.8203, -87.7997); //White Bouncer
//SPAWN RAKYAT
	new g_Object[103];
	g_Object[0] = CreateObject(19368, 1122.3005, -2037.5487, 75.4052, 0.0000, 0.0000, 0.0000); //wall016
	SetObjectMaterial(g_Object[0], 0, -1, "none", "none", 0xFF000000);
	g_Object[1] = CreateObject(19122, 1174.9882, -2036.9901, 75.8329, 0.0000, 0.0000, 0.0000); //BollardLight2
	g_Object[2] = CreateObject(19368, 1122.3005, -2036.4981, 75.4052, 0.0000, 0.0000, 0.0000); //wall016
	SetObjectMaterial(g_Object[2], 0, -1, "none", "none", 0xFF000000);
	g_Object[3] = CreateObject(19368, 1122.3005, -2034.2486, 75.4052, 0.0000, 0.0000, 0.0000); //wall016
	SetObjectMaterial(g_Object[3], 0, -1, "none", "none", 0xFF000000);
	g_Object[4] = CreateObject(19368, 1122.3005, -2039.7491, 75.4052, 0.0000, 0.0000, 0.0000); //wall016
	SetObjectMaterial(g_Object[4], 0, -1, "none", "none", 0xFF000000);
	g_Object[5] = CreateObject(19368, 1122.3205, -2038.6782, 75.4052, 0.0000, 0.0000, 0.0000); //wall016
	SetObjectMaterialText(g_Object[5], "SPAWN", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 70, 1, 0xFFFFFFFF, 0x00000000, 1);
	g_Object[6] = CreateObject(19368, 1122.3205, -2035.5883, 75.4052, 0.0000, 0.0000, 0.0000); //wall016
	SetObjectMaterialText(g_Object[6], "RAKYAT", 0, OBJECT_MATERIAL_SIZE_256x128, "Arial", 70, 1, 0xFFFFFFFF, 0x00000000, 1);
	g_Object[7] = CreateObject(19127, 1137.3505, -2040.4304, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[8] = CreateObject(19127, 1137.3505, -2040.4304, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[9] = CreateObject(19127, 1137.3505, -2033.5601, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[10] = CreateObject(19127, 1137.3505, -2033.5601, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[11] = CreateObject(19127, 1143.7508, -2033.5601, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[12] = CreateObject(19127, 1143.7508, -2033.5601, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[13] = CreateObject(19127, 1143.7508, -2040.4108, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[14] = CreateObject(19127, 1143.7508, -2040.4108, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[15] = CreateObject(19127, 1150.1621, -2040.4108, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[16] = CreateObject(19127, 1150.1621, -2040.4108, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[17] = CreateObject(19127, 1150.1621, -2033.5595, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[18] = CreateObject(19127, 1150.1621, -2033.5595, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[19] = CreateObject(19127, 1155.4827, -2033.5595, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[20] = CreateObject(19127, 1155.4827, -2033.5595, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[21] = CreateObject(19127, 1155.4827, -2040.4005, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[22] = CreateObject(19127, 1155.4827, -2040.4005, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[23] = CreateObject(19127, 1164.1330, -2040.4005, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[24] = CreateObject(19127, 1164.1330, -2040.4005, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[25] = CreateObject(19127, 1164.1330, -2033.5500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[26] = CreateObject(19127, 1164.1330, -2033.5500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[27] = CreateObject(19127, 1185.4333, -2033.5500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[28] = CreateObject(19127, 1185.4333, -2033.5500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[29] = CreateObject(19127, 1185.4333, -2040.3802, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[30] = CreateObject(19127, 1185.4333, -2040.3802, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[31] = CreateObject(19127, 1192.0932, -2040.3802, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[32] = CreateObject(19127, 1192.0932, -2040.3802, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[33] = CreateObject(19127, 1192.0932, -2033.5999, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[34] = CreateObject(19127, 1192.0932, -2033.5999, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[35] = CreateObject(19127, 1198.3328, -2033.5999, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[36] = CreateObject(19127, 1198.3328, -2033.5999, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[37] = CreateObject(19127, 1198.3328, -2040.3500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[38] = CreateObject(19127, 1198.3328, -2040.3500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[39] = CreateObject(19127, 1210.5328, -2040.3500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[40] = CreateObject(19127, 1210.5328, -2040.3500, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[41] = CreateObject(19127, 1210.5328, -2033.6596, 68.3730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[42] = CreateObject(6965, 1175.0031, -2037.0491, 70.8838, 0.0000, 0.0000, 0.0000); //venefountain02
	g_Object[43] = CreateObject(19126, 1240.0366, -2038.6854, 60.7494, 0.0000, 0.0000, 0.0000); //BollardLight6
	g_Object[44] = CreateObject(19122, 1174.9882, -2036.9901, 75.8329, 0.0000, 0.0000, 0.0000); //BollardLight2
	g_Object[45] = CreateObject(974, 1212.6927, -2040.3955, 66.5271, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[46] = CreateObject(974, 1219.3029, -2040.3955, 64.8571, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[47] = CreateObject(974, 1225.9433, -2040.3955, 62.8972, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[48] = CreateObject(974, 1232.5535, -2040.3955, 61.1673, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[49] = CreateObject(974, 1235.1248, -2040.4255, 58.6474, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[50] = CreateObject(974, 1235.1248, -2033.6145, 58.6474, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[51] = CreateObject(974, 1231.8249, -2033.5444, 60.8374, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[52] = CreateObject(974, 1225.1851, -2033.5444, 63.0374, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[53] = CreateObject(974, 1218.5250, -2033.5444, 64.9474, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[54] = CreateObject(974, 1214.1053, -2033.5444, 66.7473, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[55] = CreateObject(19127, 1213.9726, -2033.5295, 66.6030, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[56] = CreateObject(19127, 1213.9726, -2033.5295, 66.6030, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[57] = CreateObject(19127, 1220.0130, -2033.5295, 64.3430, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[58] = CreateObject(19127, 1220.0130, -2033.5295, 64.3430, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[59] = CreateObject(19127, 1226.7130, -2033.5295, 62.0230, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[60] = CreateObject(19127, 1226.7130, -2033.5295, 62.0230, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[61] = CreateObject(19127, 1233.3331, -2033.5295, 59.9730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[62] = CreateObject(19127, 1233.3331, -2033.5295, 59.9730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[63] = CreateObject(19127, 1237.6629, -2033.5295, 58.9830, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[64] = CreateObject(19127, 1237.6629, -2033.5295, 58.9830, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[65] = CreateObject(19127, 1237.6629, -2040.4208, 58.9830, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[66] = CreateObject(19127, 1237.6629, -2040.4208, 58.9830, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[67] = CreateObject(19127, 1233.1112, -2040.4208, 59.7730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[68] = CreateObject(19127, 1233.1112, -2040.4208, 59.7730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[69] = CreateObject(19127, 1226.5706, -2040.4208, 61.9630, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[70] = CreateObject(19127, 1226.5706, -2040.4208, 61.9630, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[71] = CreateObject(19127, 1220.1887, -2040.4208, 64.1030, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[72] = CreateObject(19127, 1220.1887, -2040.4208, 64.1030, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[73] = CreateObject(19127, 1214.0678, -2040.4208, 66.2730, 0.0000, 0.0000, 0.0000); //BollardLight7
	g_Object[74] = CreateObject(19126, 1240.0366, -2035.4857, 60.7494, 0.0000, 0.0000, 0.0000); //BollardLight6
	g_Object[75] = CreateObject(974, 1241.9187, -2002.8850, 59.2134, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[76] = CreateObject(974, 1248.6085, -2002.8850, 59.2134, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[77] = CreateObject(974, 1255.2893, -2002.8850, 59.2134, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[78] = CreateObject(974, 1261.9490, -2002.8850, 59.2134, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[79] = CreateObject(974, 1268.6391, -2002.8850, 59.2134, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[80] = CreateObject(974, 1275.3190, -2002.8850, 59.2134, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[81] = CreateObject(974, 1280.6591, -2002.8850, 59.2134, 0.0000, 0.0000, 0.0000); //tall_fence
	g_Object[82] = CreateObject(974, 1284.0396, -2006.0955, 59.2134, 0.0000, 0.0000, 90.0000); //tall_fence
	g_Object[83] = CreateObject(974, 1284.0396, -2012.7354, 59.2134, 0.0000, 0.0000, 90.0000); //tall_fence
	g_Object[84] = CreateObject(974, 1284.0396, -2019.3955, 59.2134, 0.0000, 0.0000, 90.0000); //tall_fence
	g_Object[85] = CreateObject(974, 1284.0396, -2026.0452, 59.2134, 0.0000, 0.0000, 90.0000); //tall_fence
	g_Object[86] = CreateObject(974, 1284.0396, -2032.6955, 59.2134, 0.0000, 0.0000, 90.0000); //tall_fence
	g_Object[87] = CreateObject(974, 1284.0396, -2039.3255, 59.2134, 0.0000, 0.0000, 90.0000); //tall_fence
	g_Object[88] = CreateObject(974, 1284.0697, -2043.5266, 59.2134, 0.0000, 0.0000, 90.0000); //tall_fence
	g_Object[89] = CreateObject(971, 1279.6630, -2046.7623, 58.4436, 0.0000, 0.0000, 0.0000); //subwaygate
	g_Object[90] = CreateObject(971, 1273.8923, -2046.7623, 58.4436, 0.0000, 0.0000, 0.0000); //subwaygate
	g_Object[91] = CreateObject(971, 1254.3114, -2046.7623, 58.4436, 0.0000, 0.0000, 0.0000); //subwaygate
	g_Object[92] = CreateObject(971, 1245.5100, -2046.7623, 58.4436, 0.0000, 0.0000, 0.0000); //subwaygate
	g_Object[93] = CreateObject(971, 1242.7790, -2046.7623, 58.4436, 0.0000, 0.0000, 0.0000); //subwaygate
	g_Object[94] = CreateObject(967, 1270.4521, -2045.7781, 57.8134, 0.0000, 0.0000, 180.0000); //bar_gatebox01
	g_Object[95] = CreateObject(19121, 1258.8641, -2046.7698, 58.7724, 0.0000, 0.0000, 0.0000); //BollardLight1
	g_Object[96] = CreateObject(19121, 1258.8641, -2046.7698, 58.7724, 0.0000, 0.0000, 0.0000); //BollardLight1
	g_Object[97] = CreateObject(19121, 1269.5245, -2046.7698, 58.7724, 0.0000, 0.0000, 0.0000); //BollardLight1
	g_Object[98] = CreateObject(19121, 1269.5245, -2046.7698, 58.7724, 0.0000, 0.0000, 0.0000); //BollardLight1
	g_Object[99] = CreateObject(19425, 1268.1064, -2046.0070, 58.2438, 0.0000, 1.3000, 0.0000); //speed_bump01
	g_Object[100] = CreateObject(19425, 1264.8367, -2046.0070, 58.3180, 0.0000, 1.3000, 0.0000); //speed_bump01
	g_Object[101] = CreateObject(19425, 1261.5474, -2046.0070, 58.3926, 0.0000, 1.3000, 0.0000); //speed_bump01
	g_Object[102] = CreateObject(19425, 1258.3181, -2046.0070, 58.4658, 0.0000, 1.3000, 0.0000); //speed_bump01

//==================HOSPITAL & PARK=======================
	CreateObject(8399, 1236.97119, -1377.63831, 7.62490,   0.00000, 0.00000, 0.00000);
	CreateObject(8399, 1237.12219, -1351.49963, 7.62490,   0.00000, 0.00000, 0.00000);
	CreateObject(8399, 1236.92957, -1325.30322, 7.62490,   0.00000, 0.00000, 0.00000);
	CreateObject(8399, 1236.89917, -1299.14270, 7.62490,   0.00000, 0.00000, 0.00000);
	CreateObject(8399, 1219.49158, -1299.29578, 7.60490,   0.00000, 0.00000, 0.00000);
	CreateObject(8399, 1223.02429, -1325.36646, 7.60490,   0.00000, 0.00000, 0.00000);
	CreateObject(8399, 1224.07861, -1351.60706, 7.60490,   0.00000, 0.00000, 0.00000);
	CreateObject(8399, 1224.12183, -1377.81750, 7.60490,   0.00000, 0.00000, 0.00000);
	CreateObject(628, 1177.85925, -1319.26807, 14.90920,   0.00000, 0.00000, 0.00000);
	CreateObject(628, 1178.25879, -1328.18127, 14.90920,   0.00000, 0.00000, 0.00000);
	CreateObject(948, 1172.18652, -1318.90930, 14.35140,   0.00000, 0.00000, 0.00000);
	CreateObject(948, 1172.47925, -1328.22437, 14.38900,   0.00000, 0.00000, 0.00000);
	CreateObject(753, 1178.25037, -1316.34241, 13.15100,   0.00000, 0.00000, 0.00000);
	CreateObject(753, 1175.50220, -1316.63721, 12.99100,   0.00000, 0.00000, 0.00000);
	CreateObject(753, 1174.90039, -1313.56445, 12.99100,   0.00000, 0.00000, 0.00000);
	CreateObject(753, 1177.72510, -1313.21729, 13.15100,   0.00000, 0.00000, 0.00000);
	CreateObject(870, 1178.48206, -1333.68579, 13.33860,   0.00000, 0.00000, 0.00000);
	CreateObject(870, 1175.29822, -1333.96753, 13.33860,   0.00000, 0.00000, 0.00000);
	CreateObject(870, 1175.04382, -1330.81958, 13.33860,   0.00000, 0.00000, 0.00000);
	CreateObject(870, 1177.68750, -1330.78723, 13.33860,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.02258, -1383.44885, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.00256, -1380.93738, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.93237, -1376.60217, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.00659, -1378.31653, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.01489, -1374.74670, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.95410, -1367.79797, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.03760, -1372.16394, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.02356, -1369.54321, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.00330, -1365.93127, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.99780, -1363.32056, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.00708, -1360.63721, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.96912, -1358.69055, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.97485, -1356.83203, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.98462, -1354.22644, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.99573, -1351.62158, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.97339, -1349.83142, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.94324, -1348.07373, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.94312, -1345.43127, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.94214, -1342.82813, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.95422, -1340.91931, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.97913, -1339.08618, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.98792, -1336.50903, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.99707, -1333.91968, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.98206, -1332.08276, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.93774, -1330.22742, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.93335, -1327.59802, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.92993, -1324.98535, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.89612, -1323.06604, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.94861, -1321.12756, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.95483, -1318.48572, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.96533, -1315.82532, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1200.90784, -1313.96082, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.89978, -1312.24329, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.90820, -1309.59949, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1200.91516, -1306.98755, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1201.01318, -1305.15503, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.00903, -1303.40247, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.02539, -1300.78149, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.05334, -1298.18115, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(1290, 1201.10583, -1296.37170, 17.64840,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.05933, -1294.61462, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(638, 1201.10742, -1291.99341, 12.96550,   0.00000, 0.00000, 0.00000);
	CreateObject(7033, 1229.50012, -1335.63000, 16.80150,   0.00000, 0.00000, -90.00000);
	CreateObject(7033, 1229.52673, -1311.41174, 16.80150,   0.00000, 0.00000, -90.00000);
	CreateObject(7033, 1229.63086, -1359.94824, 16.80150,   0.00000, 0.00000, -90.00000);
	CreateObject(19868, 1218.74805, -1290.97998, 12.17990,   0.00000, 0.00000, 0.00000);
	CreateObject(19868, 1223.88391, -1290.94275, 12.17990,   0.00000, 0.00000, 0.00000);
	CreateObject(19868, 1229.05042, -1290.92786, 12.17990,   0.00000, 0.00000, 0.00000);
	CreateObject(19868, 1234.23401, -1290.91479, 12.17990,   0.00000, 0.00000, 0.00000);
	CreateObject(19868, 1239.39661, -1290.91418, 12.17990,   0.00000, 0.00000, 0.00000);
	CreateObject(19868, 1243.44446, -1290.93750, 12.17990,   0.00000, 0.00000, 0.00000);
	CreateObject(19868, 1245.82410, -1293.64673, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.74084, -1298.86047, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.68799, -1304.00830, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.61389, -1309.16272, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.57507, -1314.38000, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.52112, -1319.55859, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.45496, -1324.75415, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.37024, -1329.91125, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.31421, -1335.09570, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.28198, -1340.29590, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.24829, -1345.50293, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.22717, -1350.73950, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.20093, -1355.92834, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.18970, -1361.12183, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.15063, -1366.26599, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1245.08716, -1371.42590, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1244.98792, -1376.60669, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1244.89856, -1381.75232, 12.17990,   0.00000, 0.00000, -91.00000);
	CreateObject(19868, 1242.37451, -1384.33057, 12.17990,   0.00000, 0.00000, -181.00000);
	CreateObject(19868, 1237.21387, -1384.26855, 12.17990,   0.00000, 0.00000, -181.00000);
	CreateObject(19868, 1232.03247, -1384.29333, 12.17990,   0.00000, 0.00000, -181.00000);
	CreateObject(19868, 1226.85120, -1384.13489, 12.17990,   0.00000, 0.00000, -181.00000);
	CreateObject(19868, 1221.72998, -1384.15417, 12.17990,   0.00000, 0.00000, -181.00000);
	CreateObject(19868, 1218.58398, -1384.20032, 12.17990,   0.00000, 0.00000, -181.00000);
	CreateObject(19868, 1216.01233, -1381.62280, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.01086, -1376.45251, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1215.98999, -1371.26685, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.06384, -1366.10681, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.08179, -1360.93298, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.02771, -1355.74268, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1215.99585, -1350.57043, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1215.94836, -1345.29688, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.28149, -1326.83435, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.25244, -1321.67603, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.20935, -1316.47791, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.16931, -1311.29163, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.14954, -1306.10437, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.14124, -1300.96350, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.22302, -1295.82397, 12.17990,   0.00000, 0.00000, -270.00000);
	CreateObject(19868, 1216.35059, -1293.54590, 12.17990,   0.00000, 0.00000, -270.00000);

// BALAI PPR
	CreateObject(3666, 1537.59717, -1663.68518, 13.05560,   0.00000, 0.00000, 0.00000);
	CreateObject(3666, 1535.71582, -1663.67456, 13.05560,   0.00000, 0.00000, 0.00000);
	CreateObject(1419, 1534.69641, -1661.61719, 13.02370,   0.00000, 0.00000, 90.00000);
	CreateObject(1419, 1534.65222, -1656.67566, 13.02370,   0.00000, 0.00000, 90.00000);
	CreateObject(1419, 1534.68518, -1651.69727, 13.02370,   0.00000, 0.00000, 90.00000);
	CreateObject(1419, 1534.62878, -1646.69519, 13.02370,   0.00000, 0.00000, 90.00000);
	CreateObject(1419, 1534.64392, -1641.79126, 13.02370,   0.00000, 0.00000, 90.00000);
	CreateObject(1419, 1535.40405, -1636.80408, 13.02370,   0.00000, 0.00000, 71.00000);
	CreateObject(3666, 1534.72815, -1659.17676, 13.05560,   0.00000, 0.00000, 0.00000);
	CreateObject(3666, 1534.69336, -1654.17371, 13.05560,   0.00000, 0.00000, 0.00000);
	CreateObject(3666, 1534.73267, -1649.23291, 13.05560,   0.00000, 0.00000, 0.00000);
	CreateObject(3666, 1534.70203, -1644.25305, 13.05560,   0.00000, 0.00000, 0.00000);
	CreateObject(3666, 1534.74341, -1639.25757, 13.05560,   0.00000, 0.00000, -13.00000);
	CreateObject(3666, 1536.54822, -1634.53455, 13.05560,   0.00000, 0.00000, -13.00000);
	CreateObject(1419, 1539.06787, -1633.77930, 13.02370,   0.00000, 0.00000, 3.00000);	

//BASE BLACKSHARK 	

	new BASEBLACKSHARK[53];
	BASEBLACKSHARK[0] = CreateObject(19380, 1086.2951, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[0], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[1] = CreateObject(3749, 1097.0655, 2393.4077, 15.4960, 0.0000, 0.0000, 90.0000); //ClubGate01_LAx
	BASEBLACKSHARK[2] = CreateObject(19380, 1095.7949, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[2], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[3] = CreateObject(19380, 1076.8153, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[3], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[4] = CreateObject(19380, 1067.3061, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[4], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[5] = CreateObject(19380, 1057.8270, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[5], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[6] = CreateObject(19380, 1048.3574, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[6], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[7] = CreateObject(19380, 1038.7487, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[7], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[8] = CreateObject(19380, 1029.2791, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[8], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[9] = CreateObject(19380, 1019.7293, 2303.2253, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[9], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[10] = CreateObject(19380, 1014.9786, 2307.9587, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[10], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[11] = CreateObject(19380, 1014.9786, 2317.5307, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[11], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[12] = CreateObject(19380, 1014.9786, 2327.0312, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[12], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[13] = CreateObject(19380, 1014.9786, 2336.6105, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[13], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[14] = CreateObject(19380, 1014.9786, 2346.1604, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[14], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[15] = CreateObject(19380, 1014.9786, 2355.5900, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[15], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[16] = CreateObject(19380, 1014.9786, 2365.0800, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[16], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[17] = CreateObject(19380, 1014.9786, 2374.5690, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[17], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[18] = CreateObject(19380, 1014.9686, 2381.5998, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[18], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[19] = CreateObject(19380, 1019.7187, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[19], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[20] = CreateObject(19380, 1029.2902, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[20], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[21] = CreateObject(19380, 1038.8106, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[21], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[22] = CreateObject(19380, 1048.3009, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[22], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[23] = CreateObject(19380, 1057.8314, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[23], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[24] = CreateObject(19380, 1067.3212, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[24], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[25] = CreateObject(19380, 1076.8420, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[25], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[26] = CreateObject(19380, 1086.4112, 2386.3728, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[26], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[27] = CreateObject(19380, 1092.8021, 2386.4028, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[27], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[28] = CreateObject(19380, 1092.8021, 2398.4460, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[28], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[29] = CreateObject(19380, 1083.1715, 2398.4460, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[29], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[30] = CreateObject(19380, 1073.6015, 2398.4460, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[30], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[31] = CreateObject(19361, 1097.5435, 2400.0000, 14.8703, 0.0000, 0.0000, 0.0000); //wall009
	SetObjectMaterial(BASEBLACKSHARK[31], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[32] = CreateObject(19361, 1097.5435, 2400.0000, 18.3203, 0.0000, 0.0000, 0.0000); //wall009
	SetObjectMaterial(BASEBLACKSHARK[32], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[33] = CreateObject(19361, 1097.5435, 2400.0000, 11.4403, 0.0000, 0.0000, 0.0000); //wall009
	SetObjectMaterial(BASEBLACKSHARK[33], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[34] = CreateObject(19361, 1097.5235, 2401.6315, 11.4403, 0.0000, 0.0000, 0.0000); //wall009
	SetObjectMaterial(BASEBLACKSHARK[34], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[35] = CreateObject(19361, 1097.5235, 2401.6315, 14.8703, 0.0000, 0.0000, 0.0000); //wall009
	SetObjectMaterial(BASEBLACKSHARK[35], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[36] = CreateObject(19361, 1097.5235, 2401.6315, 18.2903, 0.0000, 0.0000, 0.0000); //wall009
	SetObjectMaterial(BASEBLACKSHARK[36], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[37] = CreateObject(19380, 1102.4117, 2403.2644, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[37], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[38] = CreateObject(19380, 1112.0019, 2403.2644, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[38], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[39] = CreateObject(19380, 1116.8203, 2398.4238, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[39], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[40] = CreateObject(19380, 1116.8203, 2388.9145, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[40], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[41] = CreateObject(19380, 1116.8203, 2379.3552, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[41], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[42] = CreateObject(19380, 1116.8203, 2369.7966, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[42], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[43] = CreateObject(19380, 1116.8203, 2360.2673, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[43], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[44] = CreateObject(19380, 1116.8203, 2350.6674, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[44], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[45] = CreateObject(19380, 1116.8203, 2341.0869, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[45], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[46] = CreateObject(19380, 1116.8603, 2336.0854, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[46], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[47] = CreateObject(19380, 1112.1110, 2331.4162, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[47], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[48] = CreateObject(19380, 1105.2301, 2331.4462, 14.8203, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[48], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[49] = CreateObject(19380, 1100.5000, 2326.6757, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[49], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[50] = CreateObject(19380, 1100.5000, 2317.1645, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[50], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[51] = CreateObject(19380, 1100.5000, 2307.9445, 14.8203, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(BASEBLACKSHARK[51], 0, 14535, "ab_wooziec", "ab_woodborder", 0x00000000);
	BASEBLACKSHARK[52] = CreateObject(980, 1097.5070, 2392.6855, 12.5867, 0.0000, 0.0000, 90.0000); //airportgate
// DRIFT MAP
	CreateObject(8355, 631.624938, -2238.426269, 11.877180, 0.000000, 0.000000, -39.100006, 300.00); 
	CreateObject(8355, 836.765808, -2274.776367, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(8343, 812.879089, -2392.226806, 11.877180, 0.000000, 0.000000, -179.800003, 300.00); 
	CreateObject(8355, 836.765808, -2136.516113, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(8344, 706.190002, -2417.755859, 11.937181, 0.000000, 0.000000, -109.599830, 300.00); 
	CreateObject(8344, 610.374084, -2477.421386, 11.937181, 0.000000, 0.000000, 70.300193, 300.00); 
	CreateObject(8343, 511.759063, -2442.688476, 11.877180, 0.000000, 0.000000, 70.999992, 300.00); 
	CreateObject(8355, 544.446044, -2345.698486, 11.877180, 0.000000, 0.000000, -39.100006, 300.00); 
	CreateObject(8344, 730.107177, -2195.327880, 11.937181, 0.000000, 0.000000, -144.700180, 300.00); 
	CreateObject(8355, 800.054809, -2252.108886, 11.817178, 0.000000, 0.000000, 35.700000, 300.00); 
	CreateObject(898, 804.714843, -2392.043945, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 809.434997, -2386.683837, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 812.405212, -2377.002929, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 800.365051, -2393.993164, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 795.434814, -2394.963623, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 789.714599, -2395.234863, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 782.544433, -2393.553222, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 777.104248, -2391.974121, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 769.924133, -2389.303955, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 763.714416, -2386.814208, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 756.324340, -2384.584960, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 749.183898, -2382.403076, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 741.433837, -2379.533935, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 732.503417, -2376.534179, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 725.293273, -2373.435302, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 716.573242, -2370.684570, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 707.963195, -2368.453369, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 700.163208, -2368.453369, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 691.962890, -2368.453369, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 685.122680, -2368.453369, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 678.682495, -2371.233886, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 669.802429, -2375.454589, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 659.872375, -2381.943847, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 651.582641, -2388.774414, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 646.732727, -2394.935302, 11.937181, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 642.324584, -2399.743164, 11.937181, 0.000000, 0.000000, 21.600000, 300.00); 
	CreateObject(898, 638.922363, -2406.712646, 11.937181, 0.000000, 0.000000, 21.600000, 300.00); 
	CreateObject(898, 634.900695, -2416.683593, 11.937181, 0.000000, 0.000000, 21.600000, 300.00); 
	CreateObject(898, 632.661865, -2425.917236, 11.937181, 0.000000, 0.000000, 21.600000, 300.00); 
	CreateObject(898, 631.375427, -2435.769531, 11.937181, 0.000000, 0.000000, 110.500007, 300.00); 
	CreateObject(898, 633.960876, -2444.403320, 11.937181, 0.000000, 0.000000, -70.799980, 300.00); 
	CreateObject(898, 637.500366, -2450.615722, 11.937181, 0.000000, 0.000000, -70.799980, 300.00); 
	CreateObject(898, 638.770812, -2455.997314, 11.937181, 0.000000, 0.000000, -70.799980, 300.00); 
	CreateObject(898, 638.534729, -2462.986572, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 635.322692, -2470.551025, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 630.052551, -2475.281738, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 619.602661, -2479.700927, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 613.330383, -2479.275634, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 605.162414, -2476.890869, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 595.823181, -2474.163085, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 586.887329, -2471.552734, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 577.459045, -2467.029052, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 567.294372, -2464.061035, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 556.768127, -2459.446533, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 549.473327, -2457.317138, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 539.191467, -2453.820556, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 529.157165, -2450.442382, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 519.963012, -2445.758300, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 515.702026, -2439.775390, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 513.644042, -2431.921142, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 513.522338, -2423.864746, 11.937181, 0.000000, 0.000000, -153.199935, 300.00); 
	CreateObject(898, 517.327270, -2414.680175, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 526.374816, -2404.737548, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 532.172851, -2399.113525, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 536.149047, -2392.568847, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 542.658447, -2384.743652, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 548.197326, -2378.380615, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 551.983825, -2372.472412, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 558.526184, -2365.916503, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 564.847839, -2355.920898, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 572.814086, -2348.756835, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 580.332275, -2340.923339, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 584.784301, -2333.609130, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 593.352966, -2325.116455, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 599.984924, -2315.981445, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 606.554626, -2308.109863, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 612.997009, -2299.773681, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 618.936157, -2292.669921, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 624.519226, -2284.769042, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 630.991455, -2277.449218, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 637.314086, -2269.618896, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 643.945922, -2261.378662, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 650.949584, -2253.345458, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 658.191223, -2245.478759, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 664.198547, -2236.811279, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 668.355407, -2231.632812, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 672.001708, -2225.088623, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 677.582275, -2219.014648, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 685.757141, -2210.922607, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 689.917175, -2205.064453, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 693.771118, -2198.241210, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 699.293640, -2192.263916, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 707.289733, -2187.785400, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 714.315063, -2186.442626, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 721.759033, -2188.302978, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 729.851745, -2194.725830, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 734.125549, -2200.730957, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 740.362792, -2208.910400, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 745.570312, -2216.649902, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 750.509765, -2223.900634, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 755.319641, -2231.535156, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 761.509643, -2239.283691, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 767.592590, -2247.832031, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 772.230651, -2254.827880, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 777.414367, -2262.553466, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 781.868713, -2269.721435, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 787.158264, -2276.399169, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 792.602416, -2282.913818, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 796.971984, -2289.337402, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 802.879882, -2296.746093, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 808.650817, -2304.590332, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 812.845886, -2309.390136, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 814.013061, -2316.531250, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 814.584899, -2326.536132, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 813.914550, -2338.358642, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 813.244201, -2349.040283, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 814.283630, -2358.772216, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 814.110534, -2367.707275, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 814.091308, -2374.479736, 11.937181, 0.000000, 0.000000, -165.799957, 300.00); 
	CreateObject(898, 474.298461, -2397.651123, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 469.672912, -2404.874267, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 467.529083, -2413.319824, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 465.764007, -2423.740966, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 465.431884, -2435.131591, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 467.720428, -2443.737060, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 471.604339, -2456.039062, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 478.699920, -2466.464355, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 485.376953, -2475.391357, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 492.489807, -2481.445068, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 501.450195, -2488.507324, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 511.173065, -2491.030029, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 583.338256, -2516.855468, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 593.070556, -2519.703369, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 603.110290, -2522.635986, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 612.632080, -2525.417968, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 621.411499, -2526.710937, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 629.714721, -2525.928710, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 640.573059, -2523.567626, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 649.169616, -2519.110107, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 658.990539, -2512.602050, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 666.917846, -2505.906982, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 670.869140, -2500.340332, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 675.549011, -2494.633056, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 679.310485, -2485.584228, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 682.139831, -2475.909423, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 684.915771, -2466.416992, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 685.660217, -2456.497558, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 682.537841, -2446.583740, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 680.011596, -2439.937744, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 680.592712, -2432.430175, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 683.571899, -2423.454345, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 689.069152, -2417.945312, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 699.683715, -2416.347412, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 706.635681, -2417.691406, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 716.147583, -2420.466308, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 726.139831, -2423.383056, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 736.563598, -2426.425537, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 747.345825, -2429.919189, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 757.230041, -2433.846191, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 766.534729, -2437.689208, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 775.922058, -2440.431884, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 784.291809, -2442.874267, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 792.748779, -2444.520996, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 801.342895, -2443.561767, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 801.342895, -2443.561767, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 812.980102, -2441.211425, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 820.602783, -2439.407958, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 831.062927, -2434.348632, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 839.275451, -2425.291015, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 846.188293, -2418.789306, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 851.257934, -2408.934814, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 857.554626, -2399.657958, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.453063, -2389.212402, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.796752, -2375.854736, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.787963, -2365.340576, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.391357, -2352.657470, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.142211, -2341.468994, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 858.500488, -2329.092041, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 861.373840, -2318.555175, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.055725, -2308.065673, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 859.127075, -2295.635986, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.219726, -2286.412109, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.453063, -2277.563964, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.830017, -2267.901611, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 861.425231, -2257.814453, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 859.850219, -2244.854736, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 861.208618, -2234.937255, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.051269, -2221.442626, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 814.476196, -2231.817138, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.328186, -2236.169677, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 817.094055, -2246.196777, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 522.304443, -2497.654052, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 530.908020, -2502.310302, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 540.736694, -2503.320312, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 549.907714, -2505.859375, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 558.724304, -2509.724853, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 569.220520, -2511.540039, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 576.436645, -2514.911376, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 576.436645, -2514.911376, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 479.823120, -2387.933593, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 484.625671, -2382.290527, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 490.983764, -2374.820312, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 497.756744, -2366.862792, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 505.145294, -2358.181640, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 512.585693, -2349.439208, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 512.585693, -2349.439208, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 520.382751, -2340.277587, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 526.980163, -2329.964111, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 533.849426, -2320.735595, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 542.359252, -2310.736328, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 550.946655, -2300.647460, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 559.501892, -2290.594970, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 567.655273, -2281.014892, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 575.400512, -2271.913574, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 583.748413, -2262.104736, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 591.357360, -2253.164794, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 599.614746, -2243.462646, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 607.340332, -2234.385742, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 612.778198, -2223.150634, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 620.659362, -2213.889648, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 629.123596, -2203.943847, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 636.039123, -2195.818603, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 643.939697, -2186.535400, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 651.859741, -2177.229248, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 659.637084, -2168.091064, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 667.083923, -2159.341064, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 675.360534, -2149.614746, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 685.523071, -2143.753417, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 696.442993, -2140.428222, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 706.434936, -2139.240966, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 718.817199, -2139.813476, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 730.333557, -2142.668212, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 740.619079, -2144.423095, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 747.196594, -2148.760253, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 754.246276, -2152.881835, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 762.910949, -2157.590332, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 768.263977, -2165.402587, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 771.393859, -2171.768798, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 777.610107, -2178.938476, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 784.336975, -2185.923828, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 789.561462, -2194.781005, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 794.664245, -2204.245117, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 799.314086, -2210.985839, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(898, 806.542785, -2220.329589, 11.937181, 0.000000, 0.000000, 49.600006, 300.00); 
	CreateObject(19425, 816.793273, -2254.529785, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.798645, -2257.730468, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.804138, -2260.970703, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.809875, -2264.241943, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.815795, -2267.542236, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.821411, -2270.832519, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.827026, -2274.103271, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.832641, -2277.373291, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.838500, -2280.653320, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.844482, -2283.933593, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.850280, -2287.264648, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.856079, -2290.555419, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.861938, -2293.836181, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.867736, -2297.126220, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.873413, -2300.376220, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.879455, -2303.686767, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 816.879455, -2303.686767, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.120056, -2252.906250, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.125854, -2256.185791, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.131530, -2259.485595, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.137084, -2262.627685, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.142761, -2265.927246, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.148254, -2269.198486, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.153625, -2272.448974, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.159362, -2275.759277, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.165039, -2279.019287, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.170715, -2282.289794, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.176391, -2285.460937, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.182189, -2288.802246, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.187866, -2292.052978, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.193542, -2295.333496, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.199707, -2298.655761, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(19425, 813.199707, -2298.655761, 11.927182, 0.000000, 0.000000, 90.099945, 300.00); 
	CreateObject(898, 815.389587, -2209.386962, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.254760, -2198.376220, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 814.861083, -2188.393798, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.258911, -2176.987304, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.222900, -2164.467285, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.070739, -2155.544921, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 814.651306, -2148.287353, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.001098, -2139.504150, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 814.258850, -2130.463378, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 814.924255, -2119.354492, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.125244, -2107.587158, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 814.347351, -2097.671630, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 814.963500, -2090.079345, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.503540, -2081.142578, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 815.128540, -2070.242919, 11.937181, 0.000000, 0.000000, -106.299980, 300.00); 
	CreateObject(898, 860.194641, -2072.067382, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.238647, -2081.237060, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(19425, 821.917419, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 825.217529, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 828.447998, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 831.737731, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 834.997741, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 838.227844, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 841.377807, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 844.677734, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 847.917968, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 851.177917, -2068.584716, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 851.177917, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 847.918029, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 844.627746, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 841.347839, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 838.027587, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 834.737548, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 831.297607, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 828.057495, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 824.757507, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 821.507263, -2071.365722, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 821.507263, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 824.817077, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 827.938110, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 831.257690, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 834.467529, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 837.747558, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 840.977539, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 844.247680, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 847.507568, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(19425, 850.958190, -2073.497802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(898, 860.807128, -2092.462158, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.813537, -2103.076171, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 861.445434, -2115.551513, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.833923, -2126.606689, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.375244, -2137.124755, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.438476, -2150.238769, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.901367, -2159.377441, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.949768, -2169.038085, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.517883, -2177.711669, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.984924, -2186.929931, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.330566, -2195.755126, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.850830, -2206.032226, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.156127, -2215.048828, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(898, 860.668640, -2225.166503, 11.937181, 0.000000, 0.000000, -87.099983, 300.00); 
	CreateObject(1568, 853.524353, -2076.192626, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2085.872802, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2097.574951, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2108.177246, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2119.297851, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2131.408691, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2142.549804, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2154.139404, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2163.399902, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2172.430419, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2181.451904, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2190.312011, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2200.023437, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2209.593994, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2219.425781, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2229.076416, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2238.227294, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2251.197998, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2260.398681, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
	CreateObject(1568, 853.524353, -2271.089599, 11.877180, 0.000000, 0.000000, 0.000000, 300.00); 
//CAR DEALER
	new CAR_DEALER[22];
	new DEALER_CAR[3];
	CAR_DEALER[0] = CreateObject(19360, 1784.7860, -1302.8562, 13.9458, 0.0000, 0.0000, 0.0000); //wall008
	SetObjectMaterial(CAR_DEALER[0], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[1] = CreateObject(19360, 1784.8060, -1304.8459, 13.9458, 0.0000, 0.0000, 0.0000); //wall008
	SetObjectMaterial(CAR_DEALER[1], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[2] = CreateObject(19360, 1786.4257, -1306.4958, 13.9458, 0.0000, 0.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[2], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[3] = CreateObject(19360, 1788.9947, -1306.5058, 13.9458, 0.0000, 0.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[3], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[4] = CreateObject(19360, 1788.6959, -1304.8459, 13.9458, 0.0000, 0.0000, 0.0000); //wall008
	SetObjectMaterial(CAR_DEALER[4], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[5] = CreateObject(19360, 1788.6652, -1302.7545, 13.9458, 0.0000, 0.0000, 0.0000); //wall008
	SetObjectMaterial(CAR_DEALER[5], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[6] = CreateObject(19360, 1786.3356, -1304.8151, 15.6158, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[6], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[7] = CreateObject(19360, 1786.3356, -1302.9444, 15.5858, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[7], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[8] = CreateObject(19360, 1787.1164, -1302.8944, 15.6358, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[8], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[9] = CreateObject(19360, 1787.1164, -1304.8244, 15.6558, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[9], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[10] = CreateObject(19360, 1785.4969, -1303.1745, 119.1758, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[10], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[11] = CreateObject(19360, 1788.5467, -1303.1745, 119.1758, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[11], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[12] = CreateObject(19360, 1782.2965, -1303.1745, 119.1758, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[12], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[13] = CreateObject(19360, 1782.2965, -1306.6047, 119.1758, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[13], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[14] = CreateObject(19360, 1785.4960, -1306.6047, 119.1758, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[14], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[15] = CreateObject(19360, 1788.7072, -1306.6047, 119.1758, 0.0000, 90.0000, 90.0000); //wall008
	SetObjectMaterial(CAR_DEALER[15], 0, 10756, "airportroads_sfse", "ws_white_wall1", 0x00000000);
	CAR_DEALER[16] = CreateObject(18070, 1774.3084, -1302.9168, 119.5632, 0.0000, 0.0000, 90.0000); //GAP_COUNTER
	SetObjectMaterial(CAR_DEALER[16], 0, 14650, "ab_trukstpc", "sa_wood08_128", 0x00000000);
	CAR_DEALER[17] = CreateObject(2626, 1776.1179, -1303.7324, 119.5158, 0.0000, 0.0000, 90.0000); //CJ_URB_COUNTER
	CAR_DEALER[18] = CreateObject(2626, 1776.1179, -1301.5517, 119.5158, 0.0000, 0.0000, 90.0000); //CJ_URB_COUNTER
	CAR_DEALER[19] = CreateObject(19380, 1816.4046, -1279.8420, 120.8056, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(CAR_DEALER[19], 0, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
	CAR_DEALER[20] = CreateObject(19380, 1825.9940, -1279.8420, 120.8056, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(CAR_DEALER[20], 0, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
	CAR_DEALER[21] = CreateObject(19380, 1831.2145, -1279.8420, 120.8056, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(CAR_DEALER[21], 0, 1419, "break_fence3", "CJ_FRAME_Glass", 0x00000000);
	DEALER_CAR[0] = CreateVehicle(411, 1830.2661, -1275.1063, 119.7769, 0.0009, 0, 0, -1); //Infernus
	DEALER_CAR[1] = CreateVehicle(451, 1818.5472, -1275.1451, 119.7259, 0.2005, 6, 0, -1); //Turismo
	DEALER_CAR[2] = CreateVehicle(560, 1823.1657, -1275.0623, 119.8147, 359.9999, 1, 0, -1); //Sultan

//TENJIKU GENG
	new Tenjiku_Geng[100];
	Tenjiku_Geng[0] = CreateObject(19380, 2757.8269, 1288.6356, 14.7284, 0.0000, 0.0000, 0.7999); //wall028
	SetObjectMaterial(Tenjiku_Geng[0], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[1] = CreateObject(3036, 2757.5148, 1307.3572, 12.9240, 0.0000, 0.0000, 270.0000); //ct_gatexr
	Tenjiku_Geng[2] = CreateObject(19380, 2757.6926, 1298.2248, 14.7284, 0.0000, 0.0000, 0.7999); //wall028
	SetObjectMaterial(Tenjiku_Geng[2], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[3] = CreateObject(19380, 2757.9606, 1279.0559, 14.7284, 0.0000, 0.0000, 0.7999); //wall028
	SetObjectMaterial(Tenjiku_Geng[3], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[4] = CreateObject(19380, 2757.9321, 1269.4648, 14.7284, 0.0000, 0.0000, 0.7999); //wall028
	SetObjectMaterial(Tenjiku_Geng[4], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[5] = CreateObject(19380, 2758.0664, 1259.8557, 14.7284, 0.0000, 0.0000, -0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[5], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[6] = CreateObject(19380, 2758.0664, 1250.2554, 14.7284, 0.0000, 0.0000, -0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[6], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[7] = CreateObject(19380, 2758.0664, 1240.6250, 14.7284, 0.0000, 0.0000, -0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[7], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[8] = CreateObject(19380, 2758.0664, 1231.0153, 14.7284, 0.0000, 0.0000, -0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[8], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[9] = CreateObject(19380, 2758.0363, 1228.1838, 14.7284, 0.0000, 0.0000, -0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[9], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[10] = CreateObject(19380, 2762.9182, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[10], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[11] = CreateObject(19380, 2772.5390, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[11], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[12] = CreateObject(19380, 2782.1289, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[12], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[13] = CreateObject(19380, 2791.7299, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[13], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[14] = CreateObject(19380, 2801.3100, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[14], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[15] = CreateObject(19380, 2810.8901, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[15], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[16] = CreateObject(19380, 2820.4792, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[16], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[17] = CreateObject(19380, 2830.0485, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[17], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[18] = CreateObject(19380, 2839.6181, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[18], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[19] = CreateObject(19380, 2849.2077, 1223.4730, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[19], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[20] = CreateObject(19380, 2856.2573, 1223.5030, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[20], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[21] = CreateObject(19380, 2861.0175, 1228.3328, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[21], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[22] = CreateObject(19380, 2861.0175, 1237.9432, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[22], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[23] = CreateObject(19380, 2861.0175, 1247.5437, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[23], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[24] = CreateObject(19380, 2861.0175, 1257.1540, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[24], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[25] = CreateObject(19380, 2861.0175, 1266.7734, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[25], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[26] = CreateObject(19380, 2861.0175, 1276.3934, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[26], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[27] = CreateObject(19380, 2861.0175, 1286.0128, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[27], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[28] = CreateObject(19380, 2861.0175, 1295.6625, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[28], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[29] = CreateObject(19380, 2861.0175, 1305.2631, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[29], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[30] = CreateObject(19380, 2861.0175, 1314.8627, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[30], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[31] = CreateObject(19380, 2861.0175, 1324.4523, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[31], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[32] = CreateObject(19380, 2861.0175, 1334.0926, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[32], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[33] = CreateObject(19380, 2861.0175, 1343.7122, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[33], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[34] = CreateObject(19380, 2861.0175, 1353.3327, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[34], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[35] = CreateObject(19380, 2861.0175, 1362.9423, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[35], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[36] = CreateObject(19380, 2861.0175, 1372.5318, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[36], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[37] = CreateObject(19380, 2860.9775, 1378.2023, 14.7284, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[37], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[38] = CreateObject(19380, 2856.2258, 1382.9434, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[38], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[39] = CreateObject(19380, 2846.5856, 1382.9434, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[39], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[40] = CreateObject(19380, 2842.0153, 1382.8734, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[40], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[41] = CreateObject(19380, 2812.3239, 1382.8734, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[41], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[42] = CreateObject(19380, 2802.7238, 1382.8734, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[42], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[43] = CreateObject(19380, 2797.6335, 1378.1236, 14.7284, 0.0000, 0.0000, -1.1999); //wall028
	SetObjectMaterial(Tenjiku_Geng[43], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[44] = CreateObject(19380, 2797.4038, 1368.5070, 14.7284, 0.0000, 0.0000, -1.2999); //wall028
	SetObjectMaterial(Tenjiku_Geng[44], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[45] = CreateObject(19380, 2797.3510, 1358.9233, 14.7284, 0.0000, 0.0000, 1.5000); //wall028
	SetObjectMaterial(Tenjiku_Geng[45], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[46] = CreateObject(19380, 2797.6030, 1349.2969, 14.7284, 0.0000, 0.0000, 1.5000); //wall028
	SetObjectMaterial(Tenjiku_Geng[46], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[47] = CreateObject(19380, 2797.6633, 1339.7297, 14.7284, 0.0000, 0.0000, 0.2999); //wall028
	SetObjectMaterial(Tenjiku_Geng[47], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[48] = CreateObject(19380, 2797.6350, 1330.0998, 14.7284, 0.0000, 0.0000, -0.7000); //wall028
	SetObjectMaterial(Tenjiku_Geng[48], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[49] = CreateObject(19380, 2797.5456, 1328.1597, 14.7284, 0.0000, 0.0000, -0.7000); //wall028
	SetObjectMaterial(Tenjiku_Geng[49], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[50] = CreateObject(19380, 2792.7441, 1323.3398, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[50], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[51] = CreateObject(19380, 2783.1337, 1323.3398, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[51], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[52] = CreateObject(19380, 2773.5134, 1323.3398, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[52], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[53] = CreateObject(19380, 2763.9218, 1323.3398, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[53], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[54] = CreateObject(19380, 2762.2304, 1323.2797, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[54], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[55] = CreateObject(9482, 2757.3793, 1313.0024, 17.4962, 0.0000, 0.0000, 0.0000); //chinagate
	Tenjiku_Geng[56] = CreateObject(3036, 2757.5148, 1307.3572, 16.4140, 0.0000, 0.0000, 270.0000); //ct_gatexr
	Tenjiku_Geng[57] = CreateObject(3036, 2757.5148, 1323.1577, 16.4140, 0.0000, 0.0000, 270.0000); //ct_gatexr
	Tenjiku_Geng[58] = CreateObject(3036, 2757.5148, 1323.1577, 12.9340, 0.0000, 0.0000, 270.0000); //ct_gatexr
	Tenjiku_Geng[59] = CreateObject(980, 2757.2319, 1313.1009, 13.8686, 0.0000, 0.0000, 90.0000); //PAGAR TENJIKI GENG
	Tenjiku_Geng[60] = CreateObject(19380, 2821.9067, 1382.8734, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[60], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[61] = CreateObject(19380, 2831.5366, 1382.8734, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[61], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[62] = CreateObject(19380, 2835.9472, 1382.9234, 14.7284, 0.0000, 0.0000, 90.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[62], 0, 18901, "matclothes", "bandblack", 0x00000000);
	Tenjiku_Geng[63] = CreateObject(19357, 2757.3022, 1316.6826, 18.3969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[63], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[64] = CreateObject(19357, 2757.3022, 1313.6430, 18.3969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[64], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[65] = CreateObject(19357, 2757.3022, 1310.6627, 18.3969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[65], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[66] = CreateObject(19357, 2757.3022, 1309.3719, 18.3969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[66], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[67] = CreateObject(19357, 2757.3022, 1309.3719, 21.0969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[67], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[68] = CreateObject(19357, 2757.3022, 1312.4919, 21.0969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[68], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[69] = CreateObject(19357, 2757.3022, 1315.6717, 21.0969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[69], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[70] = CreateObject(19357, 2757.3022, 1316.5622, 21.0969, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterial(Tenjiku_Geng[70], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[71] = CreateObject(19357, 2757.2722, 1313.6014, 20.9669, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterialText(Tenjiku_Geng[71], "BASE", 0, OBJECT_MATERIAL_SIZE_256x128, "Cambria", 100, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[72] = CreateObject(19357, 2757.2722, 1315.6116, 18.4769, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterialText(Tenjiku_Geng[72], "TENJIKI", 0, OBJECT_MATERIAL_SIZE_256x128, "Cambria", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[73] = CreateObject(19357, 2757.2722, 1311.9018, 18.4769, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterialText(Tenjiku_Geng[73], "GENG", 0, OBJECT_MATERIAL_SIZE_256x128, "Cambria", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[74] = CreateObject(19357, 2757.2722, 1316.2719, 20.9469, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterialText(Tenjiku_Geng[74], "BA", 0, OBJECT_MATERIAL_SIZE_256x128, "GTAWEAPON3", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[75] = CreateObject(19357, 2757.2722, 1310.5218, 20.9469, 0.0000, 0.0000, 0.0000); //wall005
	SetObjectMaterialText(Tenjiku_Geng[75], "BA", 0, OBJECT_MATERIAL_SIZE_256x128, "GTAWEAPON3", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[76] = CreateObject(19121, 2755.5219, 1308.0111, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[77] = CreateObject(19121, 2755.5219, 1308.0111, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[78] = CreateObject(19121, 2755.5219, 1318.4019, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[79] = CreateObject(19121, 2755.5219, 1318.4019, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[80] = CreateObject(19121, 2749.8000, 1318.4019, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[81] = CreateObject(19121, 2749.8000, 1318.4019, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[82] = CreateObject(19121, 2749.8000, 1308.0010, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[83] = CreateObject(19121, 2749.8000, 1308.0010, 11.8306, 0.0000, 0.0000, 0.0000); //BollardLight1
	Tenjiku_Geng[84] = CreateObject(6965, 2819.1577, 1305.3682, 12.6236, 0.0000, 0.0000, 0.0000); //venefountain02
	Tenjiku_Geng[85] = CreateObject(6965, 2819.1577, 1276.0773, 12.6236, 0.0000, 0.0000, 0.0000); //venefountain02
	Tenjiku_Geng[86] = CreateObject(9833, 2818.8271, 1295.4708, 11.9449, 0.0000, 0.0000, 0.0000); //fountain_SFW
	Tenjiku_Geng[87] = CreateObject(9833, 2818.8271, 1283.8400, 11.9449, 0.0000, 0.0000, 0.0000); //fountain_SFW
	Tenjiku_Geng[88] = CreateObject(19380, 2819.2204, 1286.0357, 9.6409, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[88], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[89] = CreateObject(19380, 2819.2204, 1293.7950, 9.6409, 0.0000, 0.0000, 0.0000); //wall028
	SetObjectMaterial(Tenjiku_Geng[89], 0, 3314, "ce_burbhouse", "black_128", 0x00000000);
	Tenjiku_Geng[90] = CreateObject(19355, 2819.2060, 1292.8718, 13.8109, 0.0000, 0.0000, 0.0000); //wall003
	SetObjectMaterialText(Tenjiku_Geng[90], "TENJIKI", 0, OBJECT_MATERIAL_SIZE_256x128, "Cambria", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[91] = CreateObject(19355, 2819.2060, 1289.0820, 13.8109, 0.0000, 0.0000, 0.0000); //wall003
	SetObjectMaterialText(Tenjiku_Geng[91], "GENG", 0, OBJECT_MATERIAL_SIZE_256x128, "Cambria", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[92] = CreateObject(19355, 2819.2060, 1292.7919, 11.9709, 0.0000, 0.0000, 0.0000); //wall003
	SetObjectMaterialText(Tenjiku_Geng[92], "NI", 0, OBJECT_MATERIAL_SIZE_256x128, "Cambria", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[93] = CreateObject(19355, 2819.2060, 1289.8620, 11.9709, 0.0000, 0.0000, 0.0000); //wall003
	SetObjectMaterialText(Tenjiku_Geng[93], "BOSS", 0, OBJECT_MATERIAL_SIZE_256x128, "Cambria", 80, 1, 0xFFFFFFFF, 0x00000000, 1);
	Tenjiku_Geng[94] = CreateObject(19124, 2819.5439, 1291.6336, 8.6461, 0.0000, 0.0000, 0.0000); //BollardLight4
	Tenjiku_Geng[95] = CreateObject(19124, 2819.5439, 1291.6336, 8.6461, 0.0000, 0.0000, 0.0000); //BollardLight4
	Tenjiku_Geng[96] = CreateObject(18688, 2819.1582, 1287.4584, 12.9509, 0.0000, 0.0000, 0.0000); //fire
	Tenjiku_Geng[97] = CreateObject(18688, 2819.1582, 1287.4584, 12.9509, 0.0000, 0.0000, 0.0000); //fire
	Tenjiku_Geng[98] = CreateObject(18688, 2819.1582, 1293.7188, 12.9509, 0.0000, 0.0000, 0.0000); //fire
	Tenjiku_Geng[99] = CreateObject(18688, 2819.1582, 1293.7188, 12.9509, 0.0000, 0.0000, 0.0000); //fire

//PARACHUTE
	new PARACHUTE[1];
	PARACHUTE[0] = CreateObject(19380, 1138.4443, -1478.9737, 775.8761, 0.0000, 90.0000, 0.0000); //wall028
	SetObjectMaterial(PARACHUTE[0], 0, 10023, "bigwhitesfe", "sfe_arch6", 0x00000000);

//================ KENDERAAN SYSTEM ===========================================
	Textdraw0 = TextDrawCreate(602.500000, 332.522216, "usebox");
	TextDrawLetterSize(Textdraw0, 0.122000, 8.795476);
	TextDrawTextSize(Textdraw0, 485.500000, 4.355555);
	TextDrawAlignment(Textdraw0, 1);
	TextDrawColor(Textdraw0, 0);
	TextDrawUseBox(Textdraw0, true);
	TextDrawBoxColor(Textdraw0, 102);
	TextDrawSetShadow(Textdraw0, 0);
	TextDrawSetOutline(Textdraw0, 0);
	TextDrawFont(Textdraw0, 0);

	Textdraw1 = TextDrawCreate(505.000000, 318.577758, "hud:radar_truck");
	TextDrawLetterSize(Textdraw1, 0.769999, 1.711111);
	TextDrawTextSize(Textdraw1, 23.000000, 21.155574);
	TextDrawAlignment(Textdraw1, 1);
	TextDrawColor(Textdraw1, -1);
	TextDrawUseBox(Textdraw1, true);
	TextDrawBoxColor(Textdraw1, 102);
	TextDrawSetShadow(Textdraw1, 0);
	TextDrawSetOutline(Textdraw1, 0);
	TextDrawFont(Textdraw1, 4);

	Textdraw2 = TextDrawCreate(529.000000, 316.711090, "Kenderaan");
	TextDrawLetterSize(Textdraw2, 0.692499, 2.160000);
	TextDrawAlignment(Textdraw2, 1);
	TextDrawColor(Textdraw2, -1);
	TextDrawSetShadow(Textdraw2, 0);
	TextDrawSetOutline(Textdraw2, 1);
	TextDrawBackgroundColor(Textdraw2, 51);
	TextDrawFont(Textdraw2, 0);
	TextDrawSetProportional(Textdraw2, 1);

		//================ PMRP LOGIN LOGO ==============================
	PMRPLoginLogo[0] = TextDrawCreate(319.000000, -1.000000, "_");
	TextDrawFont(PMRPLoginLogo[0], 1);
	TextDrawLetterSize(PMRPLoginLogo[0], 0.600000, 11.300003);
	TextDrawTextSize(PMRPLoginLogo[0], 298.500000, 642.000000);
	TextDrawSetOutline(PMRPLoginLogo[0], 1);
	TextDrawSetShadow(PMRPLoginLogo[0], 0);
	TextDrawAlignment(PMRPLoginLogo[0], 2);
	TextDrawColor(PMRPLoginLogo[0], -1);
	TextDrawBackgroundColor(PMRPLoginLogo[0], 255);
	TextDrawBoxColor(PMRPLoginLogo[0], 225);
	TextDrawUseBox(PMRPLoginLogo[0], 1);
	TextDrawSetProportional(PMRPLoginLogo[0], 1);
	TextDrawSetSelectable(PMRPLoginLogo[0], 0);

	PMRPLoginLogo[1] = TextDrawCreate(319.000000, 346.000000, "_");
	TextDrawFont(PMRPLoginLogo[1], 1);
	TextDrawLetterSize(PMRPLoginLogo[1], 0.600000, 11.300003);
	TextDrawTextSize(PMRPLoginLogo[1], 298.500000, 647.000000);
	TextDrawSetOutline(PMRPLoginLogo[1], 1);
	TextDrawSetShadow(PMRPLoginLogo[1], 0);
	TextDrawAlignment(PMRPLoginLogo[1], 2);
	TextDrawColor(PMRPLoginLogo[1], -1);
	TextDrawBackgroundColor(PMRPLoginLogo[1], 255);
	TextDrawBoxColor(PMRPLoginLogo[1], 225);
	TextDrawUseBox(PMRPLoginLogo[1], 1);
	TextDrawSetProportional(PMRPLoginLogo[1], 1);
	TextDrawSetSelectable(PMRPLoginLogo[1], 0);

	PMRPLoginLogo[2] = TextDrawCreate(93.000000, 24.000000, "SELAMAT");
	TextDrawFont(PMRPLoginLogo[2], 1);
	TextDrawLetterSize(PMRPLoginLogo[2], 0.600000, 3.500000);
	TextDrawTextSize(PMRPLoginLogo[2], 400.000000, 17.000000);
	TextDrawSetOutline(PMRPLoginLogo[2], 1);
	TextDrawSetShadow(PMRPLoginLogo[2], 0);
	TextDrawAlignment(PMRPLoginLogo[2], 1);
	TextDrawColor(PMRPLoginLogo[2], -1);
	TextDrawBackgroundColor(PMRPLoginLogo[2], 255);
	TextDrawBoxColor(PMRPLoginLogo[2], 50);
	TextDrawUseBox(PMRPLoginLogo[2], 0);
	TextDrawSetProportional(PMRPLoginLogo[2], 1);
	TextDrawSetSelectable(PMRPLoginLogo[2], 0);

	PMRPLoginLogo[3] = TextDrawCreate(256.000000, 62.000000, "KE SERVER");
	TextDrawFont(PMRPLoginLogo[3], 1);
	TextDrawLetterSize(PMRPLoginLogo[3], 0.600000, 3.500000);
	TextDrawTextSize(PMRPLoginLogo[3], 400.000000, 17.000000);
	TextDrawSetOutline(PMRPLoginLogo[3], 1);
	TextDrawSetShadow(PMRPLoginLogo[3], 0);
	TextDrawAlignment(PMRPLoginLogo[3], 1);
	TextDrawColor(PMRPLoginLogo[3], -1);
	TextDrawBackgroundColor(PMRPLoginLogo[3], 255);
	TextDrawBoxColor(PMRPLoginLogo[3], 50);
	TextDrawUseBox(PMRPLoginLogo[3], 0);
	TextDrawSetProportional(PMRPLoginLogo[3], 1);
	TextDrawSetSelectable(PMRPLoginLogo[3], 0);

	PMRPLoginLogo[4] = TextDrawCreate(446.000000, 24.000000, "DATANG");
	TextDrawFont(PMRPLoginLogo[4], 1);
	TextDrawLetterSize(PMRPLoginLogo[4], 0.600000, 3.500000);
	TextDrawTextSize(PMRPLoginLogo[4], 400.000000, 17.000000);
	TextDrawSetOutline(PMRPLoginLogo[4], 1);
	TextDrawSetShadow(PMRPLoginLogo[4], 0);
	TextDrawAlignment(PMRPLoginLogo[4], 1);
	TextDrawColor(PMRPLoginLogo[4], -1);
	TextDrawBackgroundColor(PMRPLoginLogo[4], 255);
	TextDrawBoxColor(PMRPLoginLogo[4], 50);
	TextDrawUseBox(PMRPLoginLogo[4], 0);
	TextDrawSetProportional(PMRPLoginLogo[4], 1);
	TextDrawSetSelectable(PMRPLoginLogo[4], 0);

	PMRPLoginLogo[5] = TextDrawCreate(266.000000, 352.000000, "PENANG");
	TextDrawFont(PMRPLoginLogo[5], 1);
	TextDrawLetterSize(PMRPLoginLogo[5], 0.600000, 3.500000);
	TextDrawTextSize(PMRPLoginLogo[5], 400.000000, 17.000000);
	TextDrawSetOutline(PMRPLoginLogo[5], 2);
	TextDrawSetShadow(PMRPLoginLogo[5], 0);
	TextDrawAlignment(PMRPLoginLogo[5], 1);
	TextDrawColor(PMRPLoginLogo[5], 1097458175);
	TextDrawBackgroundColor(PMRPLoginLogo[5], 255);
	TextDrawBoxColor(PMRPLoginLogo[5], 50);
	TextDrawUseBox(PMRPLoginLogo[5], 0);
	TextDrawSetProportional(PMRPLoginLogo[5], 1);
	TextDrawSetSelectable(PMRPLoginLogo[5], 0);

	PMRPLoginLogo[6] = TextDrawCreate(96.000000, 402.000000, "MALAYSIA");
	TextDrawFont(PMRPLoginLogo[6], 1);
	TextDrawLetterSize(PMRPLoginLogo[6], 0.600000, 3.500000);
	TextDrawTextSize(PMRPLoginLogo[6], 400.000000, 17.000000);
	TextDrawSetOutline(PMRPLoginLogo[6], 2);
	TextDrawSetShadow(PMRPLoginLogo[6], 0);
	TextDrawAlignment(PMRPLoginLogo[6], 1);
	TextDrawColor(PMRPLoginLogo[6], 1097458175);
	TextDrawBackgroundColor(PMRPLoginLogo[6], 255);
	TextDrawBoxColor(PMRPLoginLogo[6], 50);
	TextDrawUseBox(PMRPLoginLogo[6], 0);
	TextDrawSetProportional(PMRPLoginLogo[6], 1);
	TextDrawSetSelectable(PMRPLoginLogo[6], 0);

	PMRPLoginLogo[7] = TextDrawCreate(436.000000, 402.000000, "ROLEPLAY");
	TextDrawFont(PMRPLoginLogo[7], 1);
	TextDrawLetterSize(PMRPLoginLogo[7], 0.600000, 3.500000);
	TextDrawTextSize(PMRPLoginLogo[7], 400.000000, 17.000000);
	TextDrawSetOutline(PMRPLoginLogo[7], 2);
	TextDrawSetShadow(PMRPLoginLogo[7], 0);
	TextDrawAlignment(PMRPLoginLogo[7], 1);
	TextDrawColor(PMRPLoginLogo[7], 1097458175);
	TextDrawBackgroundColor(PMRPLoginLogo[7], 255);
	TextDrawBoxColor(PMRPLoginLogo[7], 50);
	TextDrawUseBox(PMRPLoginLogo[7], 0);
	TextDrawSetProportional(PMRPLoginLogo[7], 1);
	TextDrawSetSelectable(PMRPLoginLogo[7], 0);
	//===================== PHONE SYSTEM ===============================
	PhoneTD[0] = TextDrawCreate(568.000000, 207.000000, "_");
	TextDrawFont(PhoneTD[0], 1);
	TextDrawLetterSize(PhoneTD[0], 0.600000, 25.450000);
	TextDrawTextSize(PhoneTD[0], 298.500000, 104.500000);
	TextDrawSetOutline(PhoneTD[0], 1);
	TextDrawSetShadow(PhoneTD[0], 0);
	TextDrawAlignment(PhoneTD[0], 2);
	TextDrawColor(PhoneTD[0], -1);
	TextDrawBackgroundColor(PhoneTD[0], 255);
	TextDrawBoxColor(PhoneTD[0], 235);
	TextDrawUseBox(PhoneTD[0], 1);
	TextDrawSetProportional(PhoneTD[0], 1);
	TextDrawSetSelectable(PhoneTD[0], 0);

	PhoneTD[1] = TextDrawCreate(568.000000, 210.000000, "_");
	TextDrawFont(PhoneTD[1], 1);
	TextDrawLetterSize(PhoneTD[1], 0.600000, 2.700002);
	TextDrawTextSize(PhoneTD[1], 298.500000, 100.000000);
	TextDrawSetOutline(PhoneTD[1], 1);
	TextDrawSetShadow(PhoneTD[1], 0);
	TextDrawAlignment(PhoneTD[1], 2);
	TextDrawColor(PhoneTD[1], -1);
	TextDrawBackgroundColor(PhoneTD[1], 255);
	TextDrawBoxColor(PhoneTD[1], -48);
	TextDrawUseBox(PhoneTD[1], 1);
	TextDrawSetProportional(PhoneTD[1], 1);
	TextDrawSetSelectable(PhoneTD[1], 0);

	PhoneTD[2] = TextDrawCreate(568.000000, 410.000000, "_");
	TextDrawFont(PhoneTD[2], 1);
	TextDrawLetterSize(PhoneTD[2], 0.600000, 2.450002);
	TextDrawTextSize(PhoneTD[2], 298.500000, 100.000000);
	TextDrawSetOutline(PhoneTD[2], 1);
	TextDrawSetShadow(PhoneTD[2], 0);
	TextDrawAlignment(PhoneTD[2], 2);
	TextDrawColor(PhoneTD[2], -1);
	TextDrawBackgroundColor(PhoneTD[2], 255);
	TextDrawBoxColor(PhoneTD[2], -48);
	TextDrawUseBox(PhoneTD[2], 1);
	TextDrawSetProportional(PhoneTD[2], 1);
	TextDrawSetSelectable(PhoneTD[2], 0);

	PhoneTD[3] = TextDrawCreate(517.000000, 230.000000, "_");
	TextDrawFont(PhoneTD[3], 1);
	TextDrawLetterSize(PhoneTD[3], 0.600000, 19.700002);
	TextDrawTextSize(PhoneTD[3], 298.500000, -5.500000);
	TextDrawSetOutline(PhoneTD[3], 1);
	TextDrawSetShadow(PhoneTD[3], 0);
	TextDrawAlignment(PhoneTD[3], 2);
	TextDrawColor(PhoneTD[3], -1);
	TextDrawBackgroundColor(PhoneTD[3], 255);
	TextDrawBoxColor(PhoneTD[3], -48);
	TextDrawUseBox(PhoneTD[3], 1);
	TextDrawSetProportional(PhoneTD[3], 1);
	TextDrawSetSelectable(PhoneTD[3], 0);

	PhoneTD[4] = TextDrawCreate(619.000000, 230.000000, "_");
	TextDrawFont(PhoneTD[4], 1);
	TextDrawLetterSize(PhoneTD[4], 0.600000, 19.700002);
	TextDrawTextSize(PhoneTD[4], 298.500000, -5.500000);
	TextDrawSetOutline(PhoneTD[4], 1);
	TextDrawSetShadow(PhoneTD[4], 0);
	TextDrawAlignment(PhoneTD[4], 2);
	TextDrawColor(PhoneTD[4], -1);
	TextDrawBackgroundColor(PhoneTD[4], 255);
	TextDrawBoxColor(PhoneTD[4], -48);
	TextDrawUseBox(PhoneTD[4], 1);
	TextDrawSetProportional(PhoneTD[4], 1);
	TextDrawSetSelectable(PhoneTD[4], 0);

	PhoneTD[5] = TextDrawCreate(560.000000, 413.000000, "ld_beat:cross");
	TextDrawFont(PhoneTD[5], 4);
	TextDrawLetterSize(PhoneTD[5], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[5], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[5], 1);
	TextDrawSetShadow(PhoneTD[5], 0);
	TextDrawAlignment(PhoneTD[5], 1);
	TextDrawColor(PhoneTD[5], -1);
	TextDrawBackgroundColor(PhoneTD[5], 255);
	TextDrawBoxColor(PhoneTD[5], 50);
	TextDrawUseBox(PhoneTD[5], 1);
	TextDrawSetProportional(PhoneTD[5], 1);
	TextDrawSetSelectable(PhoneTD[5], 1);

	PhoneTD[6] = TextDrawCreate(560.000000, 211.000000, "ld_beat:chit");
	TextDrawFont(PhoneTD[6], 4);
	TextDrawLetterSize(PhoneTD[6], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[6], 19.000000, 19.500000);
	TextDrawSetOutline(PhoneTD[6], 1);
	TextDrawSetShadow(PhoneTD[6], 0);
	TextDrawAlignment(PhoneTD[6], 1);
	TextDrawColor(PhoneTD[6], 255);
	TextDrawBackgroundColor(PhoneTD[6], 255);
	TextDrawBoxColor(PhoneTD[6], 50);
	TextDrawUseBox(PhoneTD[6], 1);
	TextDrawSetProportional(PhoneTD[6], 1);
	TextDrawSetSelectable(PhoneTD[6], 1);

	PhoneTD[7] = TextDrawCreate(568.000000, 221.000000, "_");
	TextDrawFont(PhoneTD[7], 1);
	TextDrawLetterSize(PhoneTD[7], 0.600000, 0.100002);
	TextDrawTextSize(PhoneTD[7], 298.500000, 100.000000);
	TextDrawSetOutline(PhoneTD[7], 1);
	TextDrawSetShadow(PhoneTD[7], 0);
	TextDrawAlignment(PhoneTD[7], 2);
	TextDrawColor(PhoneTD[7], -1);
	TextDrawBackgroundColor(PhoneTD[7], 255);
	TextDrawBoxColor(PhoneTD[7], 212);
	TextDrawUseBox(PhoneTD[7], 1);
	TextDrawSetProportional(PhoneTD[7], 1);
	TextDrawSetSelectable(PhoneTD[7], 0);

	PhoneTD[8] = TextDrawCreate(552.000000, 240.000000, "00:00");
	TextDrawFont(PhoneTD[8], 3);
	TextDrawLetterSize(PhoneTD[8], 0.554166, 2.449999);
	TextDrawTextSize(PhoneTD[8], 400.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[8], 2);
	TextDrawSetShadow(PhoneTD[8], 0);
	TextDrawAlignment(PhoneTD[8], 2);
	TextDrawColor(PhoneTD[8], -1);
	TextDrawBackgroundColor(PhoneTD[8], 255);
	TextDrawBoxColor(PhoneTD[8], 50);
	TextDrawUseBox(PhoneTD[8], 0);
	TextDrawSetProportional(PhoneTD[8], 1);
	TextDrawSetSelectable(PhoneTD[8], 0);

	PhoneTD[9] = TextDrawCreate(587.000000, 243.000000, "HUD:fist");
	TextDrawFont(PhoneTD[9], 4);
	TextDrawLetterSize(PhoneTD[9], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[9], 27.000000, 32.000000);
	TextDrawSetOutline(PhoneTD[9], 1);
	TextDrawSetShadow(PhoneTD[9], 0);
	TextDrawAlignment(PhoneTD[9], 1);
	TextDrawColor(PhoneTD[9], -1);
	TextDrawBackgroundColor(PhoneTD[9], 255);
	TextDrawBoxColor(PhoneTD[9], 50);
	TextDrawUseBox(PhoneTD[9], 1);
	TextDrawSetProportional(PhoneTD[9], 1);
	TextDrawSetSelectable(PhoneTD[9], 1);

	PhoneTD[10] = TextDrawCreate(533.000000, 296.000000, "samaps:map");
	TextDrawFont(PhoneTD[10], 4);
	TextDrawLetterSize(PhoneTD[10], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[10], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[10], 1);
	TextDrawSetShadow(PhoneTD[10], 0);
	TextDrawAlignment(PhoneTD[10], 1);
	TextDrawColor(PhoneTD[10], -1);
	TextDrawBackgroundColor(PhoneTD[10], 255);
	TextDrawBoxColor(PhoneTD[10], 50);
	TextDrawUseBox(PhoneTD[10], 1);
	TextDrawSetProportional(PhoneTD[10], 1);
	TextDrawSetSelectable(PhoneTD[10], 1);

	PhoneTD[11] = TextDrawCreate(579.000000, 296.000000, "HUD:radar_gangn");
	TextDrawFont(PhoneTD[11], 4);
	TextDrawLetterSize(PhoneTD[11], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[11], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[11], 1);
	TextDrawSetShadow(PhoneTD[11], 0);
	TextDrawAlignment(PhoneTD[11], 1);
	TextDrawColor(PhoneTD[11], -1);
	TextDrawBackgroundColor(PhoneTD[11], 255);
	TextDrawBoxColor(PhoneTD[11], 50);
	TextDrawUseBox(PhoneTD[11], 1);
	TextDrawSetProportional(PhoneTD[11], 1);
	TextDrawSetSelectable(PhoneTD[11], 1);

	PhoneTD[12] = TextDrawCreate(579.000000, 336.000000, "HUD:radar_bulldozer");
	TextDrawFont(PhoneTD[12], 4);
	TextDrawLetterSize(PhoneTD[12], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[12], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[12], 1);
	TextDrawSetShadow(PhoneTD[12], 0);
	TextDrawAlignment(PhoneTD[12], 1);
	TextDrawColor(PhoneTD[12], -1);
	TextDrawBackgroundColor(PhoneTD[12], 255);
	TextDrawBoxColor(PhoneTD[12], 50);
	TextDrawUseBox(PhoneTD[12], 1);
	TextDrawSetProportional(PhoneTD[12], 1);
	TextDrawSetSelectable(PhoneTD[12], 1);

	PhoneTD[13] = TextDrawCreate(535.000000, 336.000000, "HUD:radar_modgarage");
	TextDrawFont(PhoneTD[13], 4);
	TextDrawLetterSize(PhoneTD[13], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[13], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[13], 1);
	TextDrawSetShadow(PhoneTD[13], 0);
	TextDrawAlignment(PhoneTD[13], 1);
	TextDrawColor(PhoneTD[13], -1);
	TextDrawBackgroundColor(PhoneTD[13], 255);
	TextDrawBoxColor(PhoneTD[13], 50);
	TextDrawUseBox(PhoneTD[13], 1);
	TextDrawSetProportional(PhoneTD[13], 1);
	TextDrawSetSelectable(PhoneTD[13], 0);

	PhoneTD[14] = TextDrawCreate(535.000000, 376.000000, "HUD:radar_qmark");
	TextDrawFont(PhoneTD[14], 4);
	TextDrawLetterSize(PhoneTD[14], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[14], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[14], 1);
	TextDrawSetShadow(PhoneTD[14], 0);
	TextDrawAlignment(PhoneTD[14], 1);
	TextDrawColor(PhoneTD[14], -1);
	TextDrawBackgroundColor(PhoneTD[14], 255);
	TextDrawBoxColor(PhoneTD[14], 50);
	TextDrawUseBox(PhoneTD[14], 1);
	TextDrawSetProportional(PhoneTD[14], 1);
	TextDrawSetSelectable(PhoneTD[14], 0);

	PhoneTD[15] = TextDrawCreate(580.000000, 376.000000, "HUD:radar_qmark");
	TextDrawFont(PhoneTD[15], 4);
	TextDrawLetterSize(PhoneTD[15], 0.600000, 2.000000);
	TextDrawTextSize(PhoneTD[15], 17.000000, 17.000000);
	TextDrawSetOutline(PhoneTD[15], 1);
	TextDrawSetShadow(PhoneTD[15], 0);
	TextDrawAlignment(PhoneTD[15], 1);
	TextDrawColor(PhoneTD[15], -1);
	TextDrawBackgroundColor(PhoneTD[15], 255);
	TextDrawBoxColor(PhoneTD[15], 50);
	TextDrawUseBox(PhoneTD[15], 1);
	TextDrawSetProportional(PhoneTD[15], 1);
	TextDrawSetSelectable(PhoneTD[15], 0);
//=========================== PENANG LOGO ==========================================
	PenangLOGO[0] = TextDrawCreate(2.000000, 428.000000, "PENANG");
	TextDrawFont(PenangLOGO[0], 1);
	TextDrawLetterSize(PenangLOGO[0], 0.600000, 2.000000);
	TextDrawTextSize(PenangLOGO[0], 400.000000, 17.000000);
	TextDrawSetOutline(PenangLOGO[0], 1);
	TextDrawSetShadow(PenangLOGO[0], 0);
	TextDrawAlignment(PenangLOGO[0], 1);
	TextDrawColor(PenangLOGO[0], 1097458175);
	TextDrawBackgroundColor(PenangLOGO[0], 255);
	TextDrawBoxColor(PenangLOGO[0], 50);
	TextDrawUseBox(PenangLOGO[0], 0);
	TextDrawSetProportional(PenangLOGO[0], 1);
	TextDrawSetSelectable(PenangLOGO[0], 0);

	PenangLOGO[1] = TextDrawCreate(93.000000, 428.000000, "ROLEPLAY");
	TextDrawFont(PenangLOGO[1], 1);
	TextDrawLetterSize(PenangLOGO[1], 0.600000, 2.000000);
	TextDrawTextSize(PenangLOGO[1], 400.000000, 17.000000);
	TextDrawSetOutline(PenangLOGO[1], 1);
	TextDrawSetShadow(PenangLOGO[1], 0);
	TextDrawAlignment(PenangLOGO[1], 1);
	TextDrawColor(PenangLOGO[1], -1);
	TextDrawBackgroundColor(PenangLOGO[1], 255);
	TextDrawBoxColor(PenangLOGO[1], 50);
	TextDrawUseBox(PenangLOGO[1], 0);
	TextDrawSetProportional(PenangLOGO[1], 1);
	TextDrawSetSelectable(PenangLOGO[1], 0);
//================ TIMER =======================================================
	SetTimer("SendMSG", 300000, true);

//================ PICKUP  ==============================================
    SKINM = CreatePickup(19606,1,2244.2114,-1665.4669,15.4766);//MASUK KEDAI SKIN 
    WEAPM = CreatePickup(19606,1,1368.5294,-1279.7916,13.5469);//MASUK KEDAI WEAPON
    TESTM = CreatePickup(19606,1,301.7150,-76.7496,1001.5156);//MASUK TEST WEAPON
    MARTM = CreatePickup(19606,1,1352.4052,-1759.2434,13.5078);//MASUK 7 ELEVEN
    PPRM = CreatePickup(19606,1,1555.5023,-1675.6263,16.1953);//PDRM MASUK
	PJPM = CreatePickup(19606,1,1653.9277,-1654.7585,22.5156);//JPJ MASUK
    MPRM = CreatePickup(19606,1,1172.9039,-1326.3842,15.3991);//KKM MASUK
    BANKM = CreatePickup(19606,1,1219.2843,-1811.9636,16.5938);//MASUK BANK

//PICKUP MASUK PINTU
    SKINK = CreatePickup(19606,1,204.2613,-168.7077,1000.5234);//KELUAR KEDAI SKIN 
    BANKK = CreatePickup(19606,1,2304.7639,-16.5873,26.7422);//KELUAR BANK
    WEAPK = CreatePickup(19606,1,285.7311,-86.5816,1001.5229);//KELUAR KEDAI WEAPON
    TESTK = CreatePickup(19606,1,304.4970,-142.0448,1004.0625);//KELUAR TEST WEAPON
    MARTK = CreatePickup(19606,1,-27.4457,-58.2742,1003.5469);//KELUAR 7 ELEVEN
    PPRK = CreatePickup(19606,1,246.8044,62.3260,1003.6406);//PDRM KELUAR
    PJPK = CreatePickup(19606,1,288.8270,166.9302,1007.1719);//JPJ KELUAR
    MPRK = CreatePickup(19606,1,390.1909,173.8760,1008.3828);//KKM KLUAR

//PICKUP ONDUTY
    CreatePickup(1275, 1, 260.7803, 192.0011, 1008.1719);//ON DUTY PJP
    CreatePickup(1275, 1, 258.0135, 77.1498, 1003.6406);//ON DUTY PPR
    CreatePickup(1275, 1, 361.7836, 199.9121, 1008.3828);//ON DUTY MPR
    CreatePickup(1275, 1, 1771.3925, -1305.1746, 120.2586);//ON DUTY VEHICLE DEALER
    CreatePickup(1275, 1, 1032.7764, 2316.0195, 11.4683);//ON DUTY BLACK SHARK
    CreatePickup(1275, 1, 1463.1082, 767.6326, 11.0310);//ON DUTY KING 302
    CreatePickup(1275, 1, 2625.1487, 1781.9670, 10.9665);//ON DUTY TODAK97
    CreatePickup(1275,1,204.4534,-159.3505,1000.5234);//KEDAI SKIN | PICKUP KEDAI SKIN KO
    CreatePickup(1275,1,-23.2843,-55.6420,1003.5469);//KAUNTER 7 ELEVEN
    CreatePickup(19134,1,1479.691772,-1723.332153,13.546875);//SPAWN CITY HALL
    CreatePickup(19134,1,1601.62195, -1710.08447, 6.09494);//SPAWN BALAI
    CreatePickup(19134,1,1232.245605,-1305.731689,13.422698);//SPAWN HOSPITAl
    CreatePickup(19134,1,1254.1116,-2008.1271,59.5882);//SPAWN RAKYAT
    CreatePickup(19134,1,1660.6512,-1702.6805,20.4772);//SPAWN ARD
    CreatePickup(19134,1,1830.7057,880.2685,10.6904);//SPAWN SPG
    CreatePickup(1277, 1, CHECKPOINT_TAXI1);//TAXI JOB
    CreatePickup(1277, 1, CHECKPOINT_BUS1);//BUS JOB
    CreatePickup(1277, 1, 1396.0826, -1897.6947, 13.5008);//SWEEPER JOB
    CreatePickup(1277, 1, 950.8722, -1355.4741, 13.3438);//DUNKIN JOB
    CreatePickup(1277, 1, 1243.9570, -1258.0762, 13.1609);//PEMBANGGUNAN JOBS
    CreatePickup(1277, 1, 359.4925,-2031.5813,7.8359);//JUAL IKAN
    CreatePickup(1277, 1, 950.8722, -1355.4741, 13.3438);//PEMBERSIH JALAN JOB
    CreatePickup(19134,1,2809.5859,1336.7074,10.7500);//SPAWN DOUBLE SEVEN
    CreatePickup(1275,1,295.8563,-80.8114,1001.5156);//KEDAI WEAPON

//TEXT3D
    Create3DTextLabel("{3FFF4C}[DUTY]\n{FFFFFF}ALT Untuk On Duty", -1,260.7803, 192.0011, 1008.1719, 20.0, 0, 1);
    Create3DTextLabel("{3FFF4C}[DUTY]\n{FFFFFF}ALT Untuk On Duty", -1,258.0135, 77.1498, 1003.6406, 20.0, 0, 1);
    Create3DTextLabel("{3FFF4C}[DUTY]\n{FFFFFF}ALT Untuk On Duty", -1,361.7836, 199.9121, 1008.3828, 20.0, 0, 1);
    Create3DTextLabel("{3FFF4C}[DUTY]\n{FFFFFF}ALT Untuk On Duty", -1,2625.1487, 1781.9670, 10.9665, 20.0, 0, 1);
    Create3DTextLabel("{3FFF4C}[DUTY]\n{FFFFFF}ALT Untuk On Duty", -1,1771.3925,-1305.1746,120.2586, 20.0, 0, 1);//DUTY VEHICLE DEALER
    Create3DTextLabel("{3FFF4C}KEDAI SKIN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}ALT",-1,204.4534,-159.3505,1000.5234, 20.0, 0, 1);//
    Create3DTextLabel("{3FFF4C}7 ELEVEN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}ALT",-1,-23.2843,-55.6420,1003.5469, 20.0, 0, 1);//
    Create3DTextLabel("{3FFF4C}KEDAI WEAPON\n{FFFFFF}Sila Mengklik Butang {3FFF4C}ALT",-1,295.8563,-80.8114,1001.5156, 20.0, 0, 1);//
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",-1,1479.691772,-1723.332153,13.546875, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",-1,1232.245605,-1305.731689,13.422698, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",0xFFFFFFFF,1601.62195, -1710.08447, 6.09494, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",0xFFFFFFFF,1254.1116,-2008.1271,59.5882, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",0xFFFFFFFF,1660.6512,-1702.6805,20.4772, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",0xFFFFFFFF,1830.7057,880.2685,10.6904, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",-1,1781.369506,-1435.649780,13.585937, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",-1,2809.5859,1336.7074,10.7500, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",-1,2109.0417,-1780.4921,13.3892, 20.0, 0, 1);
	Create3DTextLabel("{3FFF4C}SPAWN KENDERAAN\n{FFFFFF}Sila Mengklik Butang {3FFF4C}Y",-1,1300.7775,-1867.6708,13.5469, 20.0, 0, 1);
	Create3DTextLabel("Y Untuk Start Elevator",-1,1786.3865,-1304.2927,13.5887, 5, 0, 0);//ELEVATOR CAR DEALER
	Create3DTextLabel("Y Untuk Start Elevator",-1,1786.6069,-1303.9678,120.2618, 5, 0, 0);//ELEVATOR TINGKAT ATAS CAR DEALER
    Create3DTextLabel("Y Untuk Start Job", COLOR_WHITE, CHECKPOINT_TAXI1, 5, 0, 0); // JOB TAXI
    Create3DTextLabel("Y Untuk Start Job", COLOR_WHITE, CHECKPOINT_BUS1, 5, 0, 0); // JOB BUS
    Create3DTextLabel("Y Untuk Start Job", COLOR_WHITE, 950.8722, -1355.4741, 13.3438, 5, 0, 0);// JOB DUNKIN BELL
    Create3DTextLabel("Y Untuk Start Job", COLOR_WHITE, 1396.0826, -1897.6947, 13.5008, 5, 0, 0);//JOB SWEEPER
    Create3DTextLabel("Y Untuk Start Job", COLOR_WHITE, 1243.9570, -1258.0762, 13.1609, 5, 0, 0);//JOB PEMBANGGUNAN
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 354.5531,-2088.7981,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 362.2408,-2088.7473,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 367.3840,-2088.7974,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 369.7735,-2088.4351,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 374.9326,-2088.7158,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 383.4378,-2088.7524,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 390.9579,-2088.7939,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 396.0686,-2088.7634,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 398.5834,-2088.5872,7.8359, 3, 0, 0);
    Create3DTextLabel("{3FFF4C}/tangkapikan\n{FFFFFF} Untuk Tangkap Ikan", COLOR_WHITE, 403.8837,-2088.7896,7.8359, 3, 0, 0);

//TEXT3D PINTU MASUK
    Create3DTextLabel("POLIS ROLEPLAY MALAYSIA",0xFFFFFFFF,1555.5023,-1675.6263,16.1953, 20.0, 0, 1);
    Create3DTextLabel("JABATAN PENGANGKUTAN JALAN",0xFFFFFFFF,1653.9277,-1654.7585,22.5156, 20.0, 0, 1);
    Create3DTextLabel("KEDAI BAJU",0xFFFFFFFF,2244.2114,-1665.4669,15.4766, 20.0, 0, 1);
    Create3DTextLabel("PENJARA", 0xFFFFFFFF, 266.7469,77.6233,1001.0391, 20.0, 0, 1);
    Create3DTextLabel("7 ELEVEN", 0xFFFFFFFF, 1352.4052,-1759.2434,13.5078, 20.0, 0, 1);
    return 1;
}

public OnGameModeExit()
{
	return 1;
}

public OnPlayerRequestClass(playerid)
{
        new string[300];
		if(fexist(UserPath(playerid)))
	    {
	        INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
	  		format(string, sizeof(string), ""COL_WHITE"SELAMAT KEMBALI KE "COL_LBLUE"PENANG ROLEPLAY\n\n"COL_WHITE"NAMA AKAUN: "COL_LBLUE"%s\n\n"COL_WHITE"SILA MASUKKAN KATA LALUAN ANDA", GetName(playerid));
            ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "LOG MASUK", string, "Masuk", "Keluar");
            GivePlayerMoney(playerid, PlayerInfo[playerid][pDuit]);
	        SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
			SetPlayerHealth(playerid, PlayerInfo[playerid][pHealth]);
			SetPlayerArmour(playerid, PlayerInfo[playerid][pArmour]);
            SetPlayerFacingAngle(playerid, 0);
	        SetPlayerInterior(playerid, 0);
	        PlayAudioStreamForPlayer(playerid, "http://www.mboxdrive.com/lv_0_20210702155343.mp4");
	        TogglePlayerControllable(playerid, false);
		    GameTextForPlayer(playerid, "~y~PENANG RP V2", 1000, 1);
		    TogglePlayerSpectating(playerid, 1);
		    SetPlayerCameraPos(playerid, 1476.0200, -912.2500, 91.1000);
            SetPlayerCameraLookAt(playerid, 1475.6700, -911.3200, 90.7600);
	    }
	    else
	    {
            format(string, sizeof(string), ""COL_WHITE"SELAMAT DATANG KE "COL_LBLUE"PENANG ROLEPLAY\n"COL_WHITE"NAMA : "COL_LBLUE"%s\n"COL_WHITE"SILA MASUKKAN KATA LALUAN\nUNTUK MENDAFTAR AKAUN INI", GetName(playerid));
            ShowPlayerDialog(playerid, REGISTER, DIALOG_STYLE_PASSWORD, "PENDAFTARAN", string, "Daftar", "Keluar");
	        SetPlayerFacingAngle(playerid, 0);
	        GameTextForPlayer(playerid, "~y~PENANG ROLEPLAY MALAYSIA", 1000, 1);
	        SetPlayerInterior(playerid, 0);
	        PlayAudioStreamForPlayer(playerid, "http://www.mboxdrive.com/lv_0_20210702155343.mp4");
	        TogglePlayerControllable(playerid, false);
	        TogglePlayerSpectating(playerid, 1);
	        return 1;
	    }
	    gPlayerLogged[playerid] = 1;
	    Spawned[playerid] = 0;
		HelmetEnabled[playerid] = 0;
	    MaskEnabled[playerid] = 0;
	    afk[playerid] = 0;
		return 1;
}

public OnPlayerConnect(playerid)
{
	TextDrawShowForPlayer(playerid, PenangLOGO[0]);
	TextDrawShowForPlayer(playerid, PenangLOGO[1]);
    SetPlayerMapIcon(playerid,1,1555.5023,-1675.6263,16.1953,30,0,MAPICON_LOCAL);//PDRM ICON
	SetPlayerMapIcon(playerid,3,1653.9277,-1654.7585,22.5156,20,0,MAPICON_LOCAL);//Jps ICON
	StopAudioStreamForPlayer(playerid);
	//================== WHITELIST SYSTEM ==============================
    new name[MAX_PLAYER_NAME+1];
    GetPlayerName(playerid, name, sizeof(name));
    new player[200];
    format(player,sizeof(player),"/UsersWhitelist/%s.txt",name);
    if(!dini_Exists(player))
    {
        SendClientMessage(playerid, COLOR_RED, "Anda Belum Di Whitelist!");

    }
    else
    {
            SendClientMessage(playerid,COLOR_RED,"INFO : {FFFFFF}Akaun Anda telah disenaraikan di dalam whitelist.");
    }
	//==================REMOVE BUILDING=================================
//PARK
	RemoveBuildingForPlayer(playerid, 5929, 1230.8906, -1337.9844, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1341.8516, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1328.0938, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 739, 1231.1406, -1356.2109, 12.7344, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1374.6094, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1356.5547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1190.7734, -1320.8594, 15.9453, 0.25);
	RemoveBuildingForPlayer(playerid, 1297, 1210.8047, -1337.8359, 15.7734, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 5812, 1230.8906, -1337.9844, 12.5391, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1335.0547, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1317.7422, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1222.6641, -1300.9219, 12.2969, 0.25);
	RemoveBuildingForPlayer(playerid, 620, 1240.9219, -1300.9219, 12.2969, 0.25);
//TENKIJU GENG
	RemoveBuildingForPlayer(playerid, 647, 2819.2199, 1291.4799, 11.3359, 0.10); // new_bushsm
//==================KENDERAAN SYSTEM=============================================
	Textdraw3[playerid] = CreatePlayerTextDraw(playerid, 548.500000, 392.622161, "~R~SUPER GT");
	PlayerTextDrawLetterSize(playerid, Textdraw3[playerid], 0.321500, 1.475554);
	PlayerTextDrawAlignment(playerid, Textdraw3[playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw3[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw3[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw3[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw3[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw3[playerid], 3);
	PlayerTextDrawSetProportional(playerid, Textdraw3[playerid], 1);

	Textdraw4[playerid] = CreatePlayerTextDraw(playerid, 545.000000, 348.822143, "SPEED ~R~123 KM/H");
	PlayerTextDrawLetterSize(playerid, Textdraw4[playerid], 0.364500, 1.425777);
	PlayerTextDrawAlignment(playerid, Textdraw4[playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw4[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw4[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw4[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw4[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw4[playerid], 3);
	PlayerTextDrawSetProportional(playerid, Textdraw4[playerid], 1);

	Textdraw5[playerid] = CreatePlayerTextDraw(playerid, 546.500000, 372.222229, "Health ~R~100.0");
	PlayerTextDrawLetterSize(playerid, Textdraw5[playerid], 0.367000, 1.488000);
	PlayerTextDrawAlignment(playerid, Textdraw5[playerid], 2);
	PlayerTextDrawColor(playerid, Textdraw5[playerid], -1);
	PlayerTextDrawSetShadow(playerid, Textdraw5[playerid], 0);
	PlayerTextDrawSetOutline(playerid, Textdraw5[playerid], 1);
	PlayerTextDrawBackgroundColor(playerid, Textdraw5[playerid], 51);
	PlayerTextDrawFont(playerid, Textdraw5[playerid], 3);
	PlayerTextDrawSetProportional(playerid, Textdraw5[playerid], 1);
	hSpeedActiv[playerid] = 1;

//=================  SHOW IC  ==================================================

//================= RESET VARIABLE =============================================
    adminduty[playerid] = 0;
	return 1;
}

public OnPlayerDisconnect(playerid, reason)
{
	if(Spawned[playerid] == 1)
	{
		new string[400];
		Delete3DTextLabel(playerLabels[playerid]);
		format(string, sizeof(string), ""COL_RED"[INFO]:"COL_WHITE" %s Telah Keluar Daripada Server", GetName(playerid));
		SendClientMessageToAll(0xE01B1B, string);
	    Spawned[playerid] = 0;
	    SaveAccountInfo(playerid);
	    format(string,sizeof(string),":man_standing:*LEAVE SERVER*\n``Nama : %s\nTelah Keluar Dari Server!``",GetName(playerid));
        DCC_SendChannelMessage(JoinLeaveChannel,string);
	}
    else
    {
    	new string[400];
    	format(string, sizeof(string), ""COL_RED"[INFO]:"COL_WHITE" %s Telah Keluar Daripada Server", GetName(playerid));
    	SendClientMessageToAll(0xE01B1B, string);
    	format(string,sizeof(string),":man_standing:*LEAVE SERVER*\n``Nama : %s\nTelah Keluar Dari Server!``",GetName(playerid));
        DCC_SendChannelMessage(JoinLeaveChannel,string);
    }
	return 1;
}

public OnPlayerSpawn(playerid)
{
	if(PlayerInfo[playerid][pMati] == 1)
	{
	   SetPlayerPos(playerid,347.2485,193.6119,1014.1875);
	   SetPlayerInterior(playerid,3);
	   SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	   PlayerInfo[playerid][pMati] = 0;
	}
	return 1;
}

public RacingPosTimer(playerid)
{
	new Float:x,Float:y,Float:z,Float:a, vehid;
	GetPlayerPos(playerid,x,y,z);
	GetPlayerFacingAngle(playerid,a);
	vehid = CreateVehicle(411,x+1,y+1,z,a,1,1,10000);
	PutPlayerInVehicle(playerid, vehid, 0);
	TogglePlayerControllable(playerid, 0);
	SetTimerEx("AdminRacingTimer", 1500, false, "i", playerid);
}

public FreezeTimer(playerid)
{
	TogglePlayerControllable(playerid,1);
	return 1;
}

public FishTimer(playerid)
{
	TogglePlayerControllable(playerid,1);
	new RandFISH = random(sizeof(RandomFISH));
	GameTextForPlayer(playerid, RandomFISH[RandFISH], 5000, 1);
	return 1;
} 

public AdminRacingTimer(playerid)
{
	GameTextForPlayer(playerid, "READY", 1000, 1);
	SetTimerEx("FiveSecondTimer", 1500, false, "i", playerid);
	return 1;
}

public FiveSecondTimer(playerid)
{
	GameTextForPlayer(playerid, ":. FIVE .: ", 1000, 1);
	SetTimerEx("FourSecondTimer", 1500, false, "i", playerid);
	return 1;
}
public FourSecondTimer(playerid)
{
	GameTextForPlayer(playerid, ":. FOUR .: ", 1000, 1);
	SetTimerEx("TreeSecondTimer", 1500, false, "i", playerid);
	return 1;
}
public TreeSecondTimer(playerid)
{
	GameTextForPlayer(playerid, ":. TREE .: ", 1000, 1);
	SetTimerEx("TwoSecondTimer", 1500, false, "i", playerid);
	return 1;
}
public TwoSecondTimer(playerid)
{
	GameTextForPlayer(playerid, ":. TWO .: ", 1000, 1);
	SetTimerEx("OneSecondTimer", 1500, false, "i", playerid);
	return 1;
}
public OneSecondTimer(playerid)
{
	GameTextForPlayer(playerid, ":. ONE .: ", 1000, 1);
	SetTimerEx("AdminRacingFreezeTimer", 1500, false, "i", playerid);
	return 1;
}
public AdminRacingFreezeTimer(playerid)
{
	TogglePlayerControllable(playerid, 1);
	SetPlayerCheckpoint(playerid, CHECKPOINT_RACING1, 10);
	return 1;
}

public OnPlayerDeath(playerid, killerid, reason)
{
	PlayerInfo[playerid][pMati] = 1;
	GameTextForPlayer(playerid, "~r~INNALILLAH", 1000, 3);
	DisablePlayerCheckpoint(playerid);
	GivePlayerMoney(playerid,-100);
    PlayerInfo[playerid][pDuit] -= 100;
    new string[400];
    format(string,sizeof(string),"``` %s TELAH MENINGGAL DUNIA\nPEMBUNUH %s```",playerid, killerid);
    DCC_SendChannelMessage(DeathChannel,string);
	return 1;
}

public OnPlayerText(playerid, text[])
{
    if (realchat)
	{
        for(new i = 0; i < MAX_PLAYERS; i++)
        {
	        new string[128];
		    format(string, sizeof(string), "[CHAT] %s : %s", GetName(playerid), text);
  		    ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
		    format(string, sizeof(string), "%s", text);
		    SetPlayerChatBubble(playerid,string,COLOR_WHITE,5.0,5000);
	        return 0;
		}
	}
	return 1;
}

public OnPlayerEnterVehicle(playerid, vehicleid, ispassenger)
{
    if(!ispassenger)
	{
		if(IsABike(vehicleid))
		{
			if(PlayerInfo[playerid][pLesenMotor] == 1)
			{
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[BOT]:"COL_WHITE" Sila Pakai Helmet/Seatbelt Atau Anda Akan Disaman Oleh"COL_RED"Pihak Yang Berkuasa!");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
				new vehid = GetPlayerVehicleID(playerid);
				SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			}
			if(PlayerInfo[playerid][pLesenMotor] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[INFO Jps]:"COL_WHITE" Anda Tidak Mempunyai Lesen Motor");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
				new vehid = GetPlayerVehicleID(playerid);
				SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			}
		}
	}
	if(!ispassenger)
	{
		if(IsAVehicle(vehicleid))
		{
			if(PlayerInfo[playerid][pLesenKereta] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_PJP"[INFO Jps]:"COL_WHITE" Anda Tidak Mempunyai Lesen Kereta");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
				new vehid = GetPlayerVehicleID(playerid);
				SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			}
		}
	}
	if(!ispassenger)
	{
		if(IsALORI(vehicleid))
		{
			if(PlayerInfo[playerid][pLesenLori] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_PJP"[INFO JPS]:"COL_WHITE" Anda Tidak Mempunyai Lesen Lori");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
				new vehid = GetPlayerVehicleID(playerid);
				SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			}
		}
	}
    if(!ispassenger)
	{
		if(IsAPlane(vehicleid) || IsAHelicopter(vehicleid))
		{	
			if(PlayerInfo[playerid][pLesenKapalTerbang] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_PJP"[INFO JPS]:"COL_WHITE" Anda Tidak Mempunyai Lesen Udara");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
				new vehid = GetPlayerVehicleID(playerid);
				SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			}
		}
	}
    if(!ispassenger)
	{
		if(IsABoat(vehicleid))
		{
			if(PlayerInfo[playerid][pLesenBot] == 1)
			{
				SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Enjin Kenderaan Anda Belum Di Start. Sila Tulis /engine Untuk Start Enjin Anda!");
			}
			if(PlayerInfo[playerid][pLesenBot] == 0)
			{
				RemovePlayerFromVehicle(playerid);
				new Float:slx, Float:sly, Float:slz;
				GetPlayerPos(playerid, slx, sly, slz);
				SetPlayerPos(playerid, slx, sly, slz);
				SendClientMessage(playerid, COLOR_GRAD2, ""COL_PJP"[INFO JPS]:"COL_WHITE" Anda Tidak Mempunyai Lesen Bot");
				PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
				new vehid = GetPlayerVehicleID(playerid);
				SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			}
		}
	}
	return 1;
}

public SendMSG()
{
    new randMSG = random(sizeof(RandomMSG));
    SendClientMessageToAll(COLOR_RED, RandomMSG[randMSG]);
}

public OnPlayerExitVehicle(playerid, vehicleid)
{
	return 1;
}

public OnPlayerStateChange(playerid, newstate, oldstate)
{
	if(hSpeedActiv[playerid] == 1)
	{
		if(newstate == PLAYER_STATE_DRIVER)
		{
			TextDrawShowForPlayer(playerid,Textdraw0);
			TextDrawShowForPlayer(playerid,Textdraw1);
			TextDrawShowForPlayer(playerid,Textdraw2);
			PlayerTextDrawShow(playerid, Textdraw3[playerid]);
			PlayerTextDrawShow(playerid, Textdraw4[playerid]);
			PlayerTextDrawShow(playerid, Textdraw5[playerid]);
	        hspeedinfotimer[playerid] = SetTimerEx("hSpeedINFO",1000,1,"d",playerid);
		}
		if(oldstate == PLAYER_STATE_DRIVER)
		{
			TextDrawHideForPlayer(playerid,Textdraw0);
			TextDrawHideForPlayer(playerid,Textdraw1);
			TextDrawHideForPlayer(playerid,Textdraw2);
			PlayerTextDrawHide(playerid, Textdraw3[playerid]);
			PlayerTextDrawHide(playerid, Textdraw4[playerid]);
			PlayerTextDrawHide(playerid, Textdraw5[playerid]);
			KillTimer(hspeedinfotimer[playerid]);
		}
	}
	return 1;
}

public OnPlayerEnterCheckpoint(playerid)
{
	new vehicleid, string[128];
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == VehPizzaboy)
	{
	    if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell1))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell2, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell2))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell3, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell3))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell4, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell4))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell5, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell5))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell6, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell6))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell7, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell7))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell8, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell8))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell9, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell9))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell10, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell10))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell11, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell11))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, DunkinBell12, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,DunkinBell12))
		{
			GivePlayerMoney(playerid, 1500);
			GameTextForPlayer(playerid, "~g~ANDA TELAH SELESAI BEKERJA, INI GAJI ANDA RM1500", 3000, 3);
			SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Menyelesaikan Kerja Anda!");
			DisablePlayerCheckpoint(playerid);
			GetPlayerVehicleID(playerid);
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(vehicleid);
		}
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == VehTaxi)
	{
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI2))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI3, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI3))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI4, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI4))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI5, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI5))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI6, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI6))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI7, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI7))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI8, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI8))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI9, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_TAXI9))
		{
			GivePlayerMoney(playerid, 10000);
			GameTextForPlayer(playerid, "~g~ANDA TELAH SELESAI BEKERJA, INI GAJI ANDA RM10000", 3000, 3);
			SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Menyelesaikan Kerja Anda!");
			DisablePlayerCheckpoint(playerid);
			GetPlayerVehicleID(playerid);
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(vehicleid);
		}
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == VehBus)
	{
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS2))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS3, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS3))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS4, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS4))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS5, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS5))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS6, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS6))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS7, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS7))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS8, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS8))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS9, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS9))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS10, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS10))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS11, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS11))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_BUS12, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_BUS12))
		{
			GivePlayerMoney(playerid, 15000);
			GameTextForPlayer(playerid, "~g~ANDA TELAH SELESAI BEKERJA, INI GAJI ANDA RM15000", 3000, 3);
			SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Menyelesaikan Kerja Anda!");
			DisablePlayerCheckpoint(playerid);
			GetPlayerVehicleID(playerid);
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(vehicleid);
		}
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == VehSweeper)
	{
	    if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER1))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER2, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER2))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER3, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER3))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER4, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER4))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER5, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER5))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER6, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER6))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER7, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER7))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER8, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER8))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER9, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER9))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER10, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER10))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER11, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER11))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER12, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER12))
	    {
	    	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
	        SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER13, 7.0);
			GameTextForPlayer(playerid, "~g~Berjaya Mencuci, Sila Tunggu!", 3000, 3);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_SWEEPER13))
		{
			GivePlayerMoney(playerid, 1000);
			GameTextForPlayer(playerid, "~g~ANDA TELAH SELESAI BEKERJA, INI GAJI ANDA RM1000", 3000, 3);
			SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Menyelesaikan Kerja Anda!");
			DisablePlayerCheckpoint(playerid);
			GetPlayerVehicleID(playerid);
			RemovePlayerFromVehicle(playerid);
			DestroyVehicle(vehicleid);
		}
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN1))
	{
	   	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
	    TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN2, 7.0);
	    GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN2))
	{
	   	SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
	    TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN3, 7.0);
		GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN3))
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN4, 7.0);
		GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN4))
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN5, 7.0);
		GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN5))
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN6, 7.0);
		GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN6))
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN7, 7.0);
		GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN7))
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN8, 7.0);
		GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN8))
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		TogglePlayerControllable(playerid, false);
	    SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN9, 7.0);
		GameTextForPlayer(playerid, "~g~Berjaya Menghantar, Sila Tunggu!", 3000, 3);
	}
	if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_PEMBANGGUNAN9))
	{
		SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
		GivePlayerMoney(playerid, 3000);
		GameTextForPlayer(playerid, "~g~ANDA TELAH SELESAI BEKERJA, INI GAJI ANDA RM3000", 3000, 3);
		SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Menyelesaikan Kerja Anda!");
		DisablePlayerCheckpoint(playerid);
	}
	if(GetVehicleModel(GetPlayerVehicleID(playerid)) == VehInfernus)
	{
	    if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING1))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING2, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING2))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING3, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING3))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING4, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING4))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING5, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING5))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING6, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING6))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING7, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING7))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING8, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING8))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING9, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING9))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING10, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING10))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING11, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING11))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING12, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING12))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING13, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING13))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING14, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING14))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING15, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING15))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING16, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING16))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING17, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING17))
	    {
	        SetPlayerCheckpoint(playerid, CHECKPOINT_RACING18, 7.0);
		}
		if (IsPlayerInRangeOfPoint(playerid, 7.0,CHECKPOINT_RACING18))
	    {
	    	SetPlayerPos(playerid, 1125.3066, -2037.0031, 69.8816);
	        format(string,sizeof(string),"%s Telah Menghabiskan Race!",GetName(playerid));
	        SendClientMessageToAll(COLOR_GREEN, string);
	        GivePlayerMoney(playerid, 25000);
		}
	}
	return 1;
}

public OnPlayerClickTextDraw(playerid, Text:clickedid)
{
	if(clickedid == PhoneTD[5])
	{
		CancelSelectTextDraw(playerid);
		TextDrawHideForPlayer(playerid, PhoneTD[0]);
		TextDrawHideForPlayer(playerid, PhoneTD[1]);
		TextDrawHideForPlayer(playerid, PhoneTD[2]);
		TextDrawHideForPlayer(playerid, PhoneTD[3]);
		TextDrawHideForPlayer(playerid, PhoneTD[4]);
		TextDrawHideForPlayer(playerid, PhoneTD[5]);
		TextDrawHideForPlayer(playerid, PhoneTD[6]);
		TextDrawHideForPlayer(playerid, PhoneTD[7]);
		TextDrawHideForPlayer(playerid, PhoneTD[8]);
		TextDrawHideForPlayer(playerid, PhoneTD[9]);
		TextDrawHideForPlayer(playerid, PhoneTD[10]);
		TextDrawHideForPlayer(playerid, PhoneTD[11]);
		TextDrawHideForPlayer(playerid, PhoneTD[12]);
		TextDrawHideForPlayer(playerid, PhoneTD[13]);
		TextDrawHideForPlayer(playerid, PhoneTD[14]);
		TextDrawHideForPlayer(playerid, PhoneTD[15]);

	}
	if(clickedid == PhoneTD[9])
	{
		ShowPlayerDialog(playerid, DIALOG_WEAPON, DIALOG_STYLE_LIST, "Equipt Weapon", "Kantana\nSilenced Pistol\nDesert Eagle\nShotgun\nMicro Uzi\nMp5\nAk-47\nM4\nSniper", "Pilih", "Batal");
	}
	if(clickedid == PhoneTD[10])
	{
		ShowPlayerDialog(playerid, DIALOG_MAP, DIALOG_STYLE_LIST, "GPS", "Spawn Rakyat\nBalai Polis Penang Roleplay\nBalai Pengangkutan Jalanraya Penang\nHospital\nSimpang\nBase Kapak\nBase Black Shark\nBase King302\nBase Todak97\nBase Tenjiku Geng", "Pilih", "Batal");
	}
	if(clickedid == PhoneTD[11])
	{
		SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/pm (playerid) (text)");
	}
	if(clickedid == PhoneTD[12])
	{
		SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Available Job : Dunkin Bell, Taxi, Bus, Pembersih Jalan, Pembanggunan [MORE COMING SOON]");
	}
	if(clickedid == PhoneTD[13])
	{
		new vehicleid;
		SetVehicleHealth(vehicleid, 100);
		SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Repair Kenderaan Anda!");
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
	return 1;
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
	if(pickupid == PPRM)
	{
		TogglePlayerControllable(playerid, true);
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~BALAI PPR",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,246.9048,65.0237,1003.6406);
	    SetPlayerInterior(playerid,6);
	}
	if(pickupid == PPRK)
	{
		TogglePlayerControllable(playerid, true);
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~SILA TUNGGU",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,1553.1385,-1675.5641,16.1953);
	    SetPlayerInterior(playerid,0);
	}
	if(pickupid == PJPM)
	{
		TogglePlayerControllable(playerid, true);
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~BALAI PJP",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,288.6422,169.7922,1007.1794);
	    SetPlayerInterior(playerid,3);
	}
	if(pickupid == PJPK)
	{
		TogglePlayerControllable(playerid, true);
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~SILA TUNGGU",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,1654.0428,-1656.7917,22.5156);
	    SetPlayerInterior(playerid,0);
	}
	if(pickupid == MPRM)
	{
		TogglePlayerControllable(playerid, true);
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~HOSPITAL",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,384.808624,173.804992,1008.382812);
	    SetPlayerInterior(playerid,3);
	}
	if(pickupid == MPRK)
	{
		TogglePlayerControllable(playerid, true);
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~SILA TUNGGU",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,1172.5834,-1321.3494,15.3986);
	    SetPlayerInterior(playerid,0);
	    PlayerInfo[playerid][pMati] =0;
	}
	if(pickupid == SKINM)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~KEDAI BAJU",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,204.3224,-165.8127,1000.5234);
	    SetPlayerInterior(playerid,14);
	}
	if(pickupid == SKINK)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~SILA TUNGGU",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,2241.8540,-1661.8450,15.4766);
	    SetPlayerInterior(playerid,0);// BILA KLUAR
	}
	if(pickupid == BANKM)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~BANK NEGARA",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,2315.952880,-1.618174,26.742187);
	    SetPlayerInterior(playerid,0);// BILA KLUAR
	}
	if(pickupid == BANKK)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~w~SILA TUNGGU",5000,3);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,1214.6244,-1815.4487,16.5938);
	    SetPlayerInterior(playerid,0);// BILA KLUAR
	}
	if(pickupid == WEAPM)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~KEDAI WEAPON",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,286.800994,-82.547599,1001.515625);
	    SetPlayerInterior(playerid,4);
	}
	if(pickupid == WEAPK)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~SILA TUNGGU",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,1366.3990,-1285.3678,13.5469);
	    SetPlayerInterior(playerid,0);
	}
	if(pickupid == TESTM)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~WEAPON RANGE",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,302.292877,-143.139099,1004.062500);
	    SetPlayerInterior(playerid,7);
	}
	if(pickupid == TESTK)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~SILA TUNGGU",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,286.800994,-82.547599,1001.515625);
	    SetPlayerInterior(playerid,4);
	}
	if(pickupid == MARTM)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~7 ELEVEN MART",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,-26.691598,-55.714897,1003.546875);
	    SetPlayerInterior(playerid,6);
	}
	if(pickupid == MARTK)
	{
	    SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
		GameTextForPlayer(playerid,"~b~7 ELEVEN MART",5000,1);
		TogglePlayerControllable(playerid, false);
	    SetPlayerPos(playerid,1350.3181,-1757.6569,13.5078);
	    SetPlayerInterior(playerid,0);
	}
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
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInAnyVehicle(playerid))
		{
			new vehid = GetPlayerVehicleID(playerid);
			VehInfo[vehid][vEngine] = 1;
			SetVehicleParamsEx(vehid, 1, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			SendClientMessage(playerid, COLOR_WHITE, "Engine Kenderaan Anda Telah Berjaya Start!");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,295.8563,-80.8114,1001.5156))//KEDAI WEAPON
		{
            ShowPlayerDialog(playerid, WEAPON, DIALOG_STYLE_LIST,"KEDAI WEAPON",""COL_WHITE"KNIFE  [$500]\n"COL_WHITE"BASEBALL BAT  [$1,500]\n"COL_WHITE"SILENCED PISTOL [$5,000]\n"COL_WHITE"DESERT EAGLE  [$10,000]\n"COL_WHITE"SHOTGUN  [$50,000]\n"COL_WHITE"MP5  [$70,000]\n"COL_WHITE"AK47  [$90,000]\n"COL_WHITE"M4  [$150,000]\n"COL_WHITE"SNIPER RIFLE  [$200,000]","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,-23.2843,-55.6420,1003.5469))//7 ELEVEN
		{
            ShowPlayerDialog(playerid, MART, DIALOG_STYLE_LIST,"7 ELEVEN",""COL_WHITE"BAGPACK  [$500]\n"COL_WHITE"MAGGIE  [$300]\n"COL_WHITE"KEROPOK [$250]\n"COL_WHITE"ROTI  [$100]\n"COL_WHITE"BURGER  [$800]\n"COL_WHITE"PEPSI  [$700]\n"COL_WHITE"COCACOLA  [$800]\n"COL_WHITE"ICE LEMON TEA  [$600]\n"COL_WHITE"SLURPHY  [$900]","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1479.691772,-1723.332153,13.546875))//SPAWN CITY HALL
		{
           ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen\nKenderaan Kerajaan", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1408.489868,-2322.851074,13.546875))//SPAWN RAKYAT
		{
           ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen\nKenderaan Kerajaan", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1601.62195, -1710.08447, 6.09494))//SPAWN PDRM
		{
           ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen\nKenderaan Kerajaan", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1232.245605,-1305.731689,13.422698))//SPAWN HOSPITAL
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen\nKenderaan Kerajaan", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1781.369506,-1435.649780,13.585937))//SPAWN BANK
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen\nKenderaan Kerajaan", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1516.9962,-692.5700,94.7500))//SPAWN YAKUZA
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,287.4553,-1160.3076,80.9099))//SPAWN PIRATES
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1660.6512,-1702.6805,20.4772))//SPAWN Jps
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen\nKenderaan Kerajaan", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,2809.5859,1336.7074,10.7500))//SPAWN DOUBLE SEVEN
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1830.7057,880.2685,10.6904))//SPAWN SPG
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen", "Pilih", "Tutup");
		}
	}
    if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,1254.1116,-2008.1271,59.5882))//SPAWN RAKYAT
		{
            ShowPlayerDialog(playerid,  SPAWN,  DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta\n"COL_WHITE"Motor\n"COL_WHITE"Lori Dan Van\n"COL_WHITE"Tiada Lesen", "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,204.4534,-159.3505,1000.5234))//SKIN 
		{
            ShowPlayerDialog(playerid,  KEDAI,  DIALOG_STYLE_LIST, "BELI BAJU", "Lelaki\n"COL_WHITE"Perempuan\n\n"COL_WHITE, "Pilih", "Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,-29.0704,1815.4844,17.6634))//INFO Jps
		{
			ShowPlayerDialog(playerid, LESEN, DIALOG_STYLE_LIST,""COL_WHITE"Jabatan Pengangkutan Jalan",""COL_WHITE"Peraturan Jalan Raya\nHarga Lesen Kenderaan","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pPpr] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 258.0135, 77.1498, 1003.6406))//PPR DUTY
		{
            ShowPlayerDialog(playerid, DUTY_PPR, DIALOG_STYLE_LIST,"POLIS PENANG ROLEPLAY",""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"LEVEL 4\n"COL_WHITE"LEVEL 5\n"COL_WHITE"LEVEL 6\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pPjp] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 260.7803, 192.0011, 1008.1719))//PJP DUTY
		{
            ShowPlayerDialog(playerid, DUTY_PJP, DIALOG_STYLE_LIST,"PENGANGKUTAN JALANRAYA PENANG",""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"LEVEL 4\n"COL_WHITE"LEVEL 5\n"COL_WHITE"LEVEL 6\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pMpr] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 361.7836, 199.9121, 1008.3828))//MPR DUTY
		{
            ShowPlayerDialog(playerid, DUTY_MPR, DIALOG_STYLE_LIST,"MEDIC PENANG ROLEPLAY",""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pVEH] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 1771.3925, -1305.1746, 120.2586))//VEHICLE DEALER DUTY
		{
            ShowPlayerDialog(playerid, DUTY_VEHICLEDEALER, DIALOG_STYLE_LIST,"VEHICLE DEALER",""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pKapak] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 1483.3389, 2724.5396, 13.9274))//Kapak DUTY
		{
			ShowPlayerDialog(playerid, DUTY_Kapak, DIALOG_STYLE_LIST,"Kapak", ""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"LEVEL 4\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pTenjikuGeng] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 204.4534,-159.3505,1000.5234))//TENJIKU GENG DUTY
		{
			ShowPlayerDialog(playerid, DUTY_TENJIKUGENG, DIALOG_STYLE_LIST,"Tenjiku Geng", ""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"LEVEL 4\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pBlackShark] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 1032.7764, 2316.0195, 11.4683))//Black Shark DUTY
		{
			ShowPlayerDialog(playerid, DUTY_BLACKSHARK, DIALOG_STYLE_LIST,"Black Shark", ""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"LEVEL 4\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pKing302] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 1463.1082, 767.6326, 11.0310))//King302 DUTY
		{
			ShowPlayerDialog(playerid, DUTY_KING302, DIALOG_STYLE_LIST,"King302", ""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"LEVEL 4\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_WALK))
	{
		if(PlayerInfo[playerid][pTodak97] >= 1)
		if(IsPlayerInRangeOfPoint(playerid,5, 2625.1487, 1781.9670, 10.9665))//TODAK97 DUTY
		{
            ShowPlayerDialog(playerid, DUTY_TODAK97, DIALOG_STYLE_LIST,"TODAK97",""COL_WHITE"LEVEL 1\n"COL_WHITE"LEVEL 2\n"COL_WHITE"LEVEL 3\n"COL_WHITE"LEVEL 4\n"COL_WHITE"OFFDUTY","Pilih","Tutup");
		}
	}
	if(PRESSED(KEY_YES))
	{
		new vehicleid;
		if(IsPlayerInRangeOfPoint(playerid,5,950.8722, -1355.4741, 13.3438))//JOB DUNKIN BELL
		{
			if(IsPlayerInVehicle(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Perlu Turun Dari Kenderaan Dahulu!");
			new Float:x,Float:y,Float:z,Float:a, vehid;
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,a);
			vehid = CreateVehicle(VehPizzaboy,x+1,y+1,z,a,1,1,10000);
			PutPlayerInVehicle(playerid, vehid, 0);
			TogglePlayerControllable(playerid, true);
			SetPlayerCheckpoint(playerid, DunkinBell1, 3.0);
			GameTextForPlayer(playerid, "~g~Anda Sudah Bekerja Sebagai DunkinBell Delivery Guys!", 3000, 3);
		}
	}
	if(PRESSED(KEY_YES))
	{
		new vehicleid;
		if(IsPlayerInRangeOfPoint(playerid,5,CHECKPOINT_TAXI1))//JOB TAXI
		{
			if(IsPlayerInVehicle(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Perlu Turun Dari Kenderaan Dahulu!");
			new Float:x,Float:y,Float:z,Float:a, vehid;
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,a);
			vehid = CreateVehicle(VehTaxi,x+1,y+1,z,a,1,1,10000);
			PutPlayerInVehicle(playerid, vehid, 0);
			TogglePlayerControllable(playerid, true);
			SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
			SetPlayerCheckpoint(playerid, CHECKPOINT_TAXI2, 3.0);
			GameTextForPlayer(playerid, "~g~Anda Sudah Bekerja Sebagai Taxi!", 3000, 3);
		}
	}
	if(PRESSED(KEY_YES))
	{
		new vehicleid;
		if(IsPlayerInRangeOfPoint(playerid,5,CHECKPOINT_BUS1))//JOB BUS
		{
			if(IsPlayerInVehicle(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Perlu Turun Dari Kenderaan Dahulu!");
			new Float:x,Float:y,Float:z,Float:a, vehid;
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,a);
			vehid = CreateVehicle(VehBus,x+1,y+1,z,a,1,1,10000);
			PutPlayerInVehicle(playerid, vehid, 0);
			TogglePlayerControllable(playerid, true);
			SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
			TogglePlayerControllable(playerid, false);
			SetPlayerCheckpoint(playerid, CHECKPOINT_BUS2, 3.0);
			GameTextForPlayer(playerid, "~g~Anda Sudah Bekerja Sebagai Bus!", 3000, 3);
		}
	}
	if(PRESSED(KEY_YES))
	{
		new vehicleid;
		if(IsPlayerInRangeOfPoint(playerid,5, 1396.0826, -1897.6947, 13.5008))//JOB PEMBERSIH JALAN
		{
			if(IsPlayerInVehicle(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Perlu Turun Dari Kenderaan Dahulu!");
			new Float:x,Float:y,Float:z,Float:a, vehid;
			GetPlayerPos(playerid,x,y,z);
			GetPlayerFacingAngle(playerid,a);
			vehid = CreateVehicle(VehSweeper,x+1,y+1,z,a,1,1,10000);
			PutPlayerInVehicle(playerid, vehid, 0);
			TogglePlayerControllable(playerid, true);
			SetPlayerCheckpoint(playerid, CHECKPOINT_SWEEPER1, 3.0);
			GameTextForPlayer(playerid, "~g~Anda Sudah Bekerja Sebagai Pembersih Jalanraya!", 3000, 3);
		}
	}
	if(PRESSED(KEY_YES))
	{
		new vehicleid;
		if(IsPlayerInRangeOfPoint(playerid,5,1243.9570,-1258.0762,13.1609))//JOB PEMBANGGUNAN
		{
			if(IsPlayerInVehicle(playerid, vehicleid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Perlu Turun Dari Kenderaan Dahulu!");
			SetPlayerSkin(playerid, 16);
			TogglePlayerControllable(playerid, true);
			SetPlayerCheckpoint(playerid, CHECKPOINT_PEMBANGGUNAN1, 3.0);
			GameTextForPlayer(playerid, "~g~Anda Sudah Bekerja Sebagai Pembanggunan!", 3000, 3);
		}
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid,5,359.3281,-2031.3894,7.8359))//KEDAI IKAN
		ShowPlayerDialog(playerid, KEDAI_IKAN, DIALOG_STYLE_LIST, "Kedai Ikan", "Joran [1500$]\nJual Ikan", "Pilih", "Tutup");
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid, 5, 1786.3865, -1304.2927, 13.5887))//ELEVATOR CAR DEALER
		SetPlayerPos(playerid, 1786.6069, -1303.9678, 120.2618);
		SetPlayerInterior(playerid, 0);
	}
	if(PRESSED(KEY_YES))
	{
		if(IsPlayerInRangeOfPoint(playerid, 5, 1786.6069, -1303.9678, 120.2618))//ELEVATOR TINGKAT ATAS CAR DEALER
		SetPlayerPos(playerid, 1786.3865, -1304.2927, 13.5887);
		SetPlayerInterior(playerid, 0);
	}
	return 1;
}

public OnPlayerClickMap(playerid, Float:fX, Float:fY, Float:fZ)
{
	if(adminduty[playerid] == 1)
	{
    	SetPlayerPosFindZ(playerid, fX, fY, fZ); 
    }
    return 1;
}

public OnRconLoginAttempt(ip[], password[], success)
{
	return 1;
}

public OnPlayerUpdate(playerid)
{
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
    new string[128];
	switch(dialogid)
    {
		case REGISTER:
	    {
	    	if (!response) return Kick(playerid);
	     	if(response)
	      	{
	       		if(!strlen(inputtext)) return ShowPlayerDialog(playerid, REGISTER, DIALOG_STYLE_PASSWORD,"Daftar","\t"COL_RED"Penang Roleplay\n\n"COL_WHITE"Selamat Datang Ke "COL_RED"Penang Roleplay\nSila masukkan Kata Laluan Anda","Daftar","Keluar");
	            new INI:File = INI_Open(UserPath(playerid));
        		INI_WriteString(File, "Password", inputtext);
        		INI_Close(File);
				ShowPlayerDialog(playerid, JANTINA,DIALOG_STYLE_MSGBOX,"SILA PILIH","JANTINA ANDA","LELAKI","PEREMPUAN");
			}
	   	}
		case JANTINA:
		{
			if(response)
			{
				PlayerInfo[playerid][pJantina] = 1;
                SetPlayerSkin(playerid,SkinNewbie[random(8)]);
				SetSpawnInfo(playerid, 0, SkinNewbie[random(8)],1125.3066,-2037.0031,69.8816, -90, 0, 0, 0, 0, 0, 0);
	   			SpawnPlayer(playerid);
	   			Spawned[playerid] = 1;
	            ResetPlayerWeapons(playerid);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerScore(playerid, 0);
	            TogglePlayerSpectating(playerid, 0);
				GivePlayerMoney(playerid, 1500);
	            SetCameraBehindPlayer(playerid);
				TogglePlayerSpectating(playerid, 0);
				format(string,sizeof(string),"~w~SELAMAT DATANG~n~~b~%s",GetName(playerid));
	        	GameTextForPlayer(playerid, string, 5000, 1);
				SetPlayerColor(playerid,COLOR_WHITE);
   				format(string,sizeof(string),""COL_WHITE"[RAKYAT]%s "COL_WHITE"Telah Menyertai Server!...",GetName(playerid));
				SendClientMessageToAll(COLOR_RED,string);
				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				new INI:File = INI_Open(UserPath(playerid));
				INI_WriteInt(File,"Skin",PlayerInfo[playerid][pSkin]);
				INI_WriteInt(File,"Jantina",PlayerInfo[playerid][pJantina]);
				INI_Close(File);

			}
			else
			{
				PlayerInfo[playerid][pJantina] = 2;
				SetPlayerSkin(playerid,SkinNewbie[random(8)]);
				SetSpawnInfo(playerid, 0, SkinNewbie[random(8)],1125.3066,-2037.0031,69.8816, -90, 0, 0, 0, 0, 0, 0);
	   			SpawnPlayer(playerid);
	   			Spawned[playerid] = 1;
	            ResetPlayerWeapons(playerid);
				SetPlayerInterior(playerid,0);
				SetPlayerVirtualWorld(playerid, 0);
	            SetPlayerScore(playerid, 0);
	            TogglePlayerSpectating(playerid, 0);
				GivePlayerMoney(playerid, 250);
	            SetCameraBehindPlayer(playerid);
				TogglePlayerSpectating(playerid, 0);
				format(string,sizeof(string),"~w~SELAMAT DATANG~n~~b~%s",GetName(playerid));
	        	GameTextForPlayer(playerid, string, 5000, 1);
				SetPlayerColor(playerid,COLOR_WHITE);
   				format(string,sizeof(string),""COL_WHITE"[RAKYAT]%s "COL_WHITE"Telah Menyertai Server!...",GetName(playerid));
				SendClientMessageToAll(COLOR_RED,string);
				PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
				new INI:File = INI_Open(UserPath(playerid));
				INI_WriteInt(File,"Skin",PlayerInfo[playerid][pSkin]);
				INI_WriteInt(File,"Jantina",PlayerInfo[playerid][pJantina]);
				INI_Close(File);
			}
		}
		case LOGIN:
	   	{
			if ( !response ) return Kick ( playerid );
	   		if( response )
	        {
	        	INI_ParseFile(UserPath(playerid), "GetUserPassword", .bExtra = true, .extra = playerid);
	        	if(strcmp(PlayerInfo[playerid][pPassword], inputtext, false) == 0)
	         	{
	          		INI_ParseFile(UserPath(playerid), "LoadUser_%s", .bExtra = true, .extra = playerid);
                    SpawnPlayer(playerid);
					PlayerPlaySound(playerid,1057,0.0,0.0,0.0);
					TogglePlayerSpectating(playerid, 0);
					if(PlayerInfo[playerid][pAdmin] == 1)
					{
						format(string,sizeof(string),""COL_LGREEN"[STAFF]%s "COL_WHITE"Staff Korang Dah Join!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid,COLOR_STAFF);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
						SetPlayerInterior(playerid,0);
						SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pAdmin] == 2)
					{
						format(string,sizeof(string),""COL_LBLUE"[ADMIN]%s "COL_WHITE"Admin Korang Dah Join!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid,COLOR_ADMIN);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
						SetPlayerInterior(playerid,0);
						SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pAdmin] == 3)
					{
						format(string,sizeof(string),""COL_ADEV"[ASSISTANCE DEV]%s "COL_WHITE"Developer Korang Dah Join!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid,COLOR_ADEV);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
						SetPlayerInterior(playerid,0);
						SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pAdmin] == 4)
					{
						format(string,sizeof(string),""COL_RED"[DEVELOPER]%s "COL_WHITE"Idola Korang Dah Join!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid,COLOR_DEV);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
						SetPlayerInterior(playerid,0);
						SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pAdmin] == 5)
					{
						format(string,sizeof(string),""COL_RED"[CO OWNER]%s "COL_WHITE"Budak Femes Korang Dah Join!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid,COLOR_DEV);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
						SetPlayerInterior(playerid,0);
						SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pAdmin] == 6)
					{
						format(string,sizeof(string),""COL_GREEN"[OWNER]%s "COL_WHITE"Budak Femes Dah Join!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid,COLOR_GREEN);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
						SetPlayerInterior(playerid,0);
						SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}

					else if(PlayerInfo[playerid][pJail] == 1)
					{
						format(string,sizeof(string),""COL_OREN"[PENJENAYAH]%s "COL_WHITE"Insaflah Wahai Anak Muda!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerPos(playerid, 197.6661, 173.8179, 1003.0234);
                        SetPlayerInterior(playerid, 3);
                        SetPlayerColor(playerid, COLOR_OREN);
                        SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pGari] == 1)
					{
						format(string,sizeof(string),""COL_OREN"[PENJENAYAH]%s "COL_WHITE"Pemain Relog Cuff!BUUUUUUU!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
                        SetPlayerPos(playerid, 197.6661, 173.8179, 1003.0234);
                        SetPlayerInterior(playerid, 3);
                        SetPlayerColor(playerid, COLOR_OREN);
                        SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pPpr] >= 1)
					{
						format(string,sizeof(string),""COL_PPR"[POLIS PENANG ROLEPLAY]%s "COL_WHITE"Welcome Back FrontLiner!...",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,262.3247,70.8864,1003.2422);
	                    SetPlayerInterior(playerid,6);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pPjp] >= 1)
					{
						format(string,sizeof(string),""COL_PJP"[PENGANGKUTAN JALANRAYA PENANG]%s "COL_WHITE"Welcome Back FrontLiner!...",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,245.7127,186.0254,1008.1719);
	                    SetPlayerInterior(playerid,3);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pMpr] >= 1)
					{
						format(string,sizeof(string),""COL_MPR"[MEDIC PENANG ROLEPLAY]%s "COL_WHITE"Welcome Back FrontLiner!...",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,359.2422,207.1943,1008.3828);
	                    SetPlayerInterior(playerid,3);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pVEH] >= 1)
					{
						format(string,sizeof(string),""COL_VEHICLE"[PENANG VEHICLE DEALER]%s "COL_WHITE"Telah Kembali Bertugas!...",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
	                    SetPlayerInterior(playerid,0);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pKapak] >= 1)
					{
						format(string,sizeof(string),""COL_RED"[WARN!]"Col_Kapak"[KAPAK]%s "COL_WHITE"Is Here!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
	                    SetPlayerInterior(playerid,0);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pTenjikuGeng] >= 1)
					{
						format(string,sizeof(string),""COL_RED"[WARN!]"COL_TENJIKUGENG"[TENJIKU GENG]%s "COL_WHITE"Is Here!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
	                    SetPlayerInterior(playerid,0);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pBlackShark] >= 1)
					{
						format(string,sizeof(string),""COL_RED"[WARN!]"COL_BLACKSHARK"[BLACK SHARK]%s "COL_WHITE"Is Here!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid, 1083.9751, 2365.7832, 10.8203);
	                    SetPlayerInterior(playerid,0);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pKing302] >= 1)
					{
						format(string,sizeof(string),""COL_RED"[WARN!]"COL_KING302"[KING 302]%s "COL_WHITE"Is Here!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid, 1455.3088, 750.9246, 11.0234);
	                    SetPlayerInterior(playerid,0);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pTodak97] >= 1)
					{
						format(string,sizeof(string),""COL_RED"[WARN!]"COL_KING302"[TODAK97]%s "COL_WHITE"Is Here!",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
	                    SetPlayerInterior(playerid,0);
	                    SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
					else if(PlayerInfo[playerid][pAdmin] == 0)
					{
						format(string,sizeof(string),""COL_WHITE"[RAKYAT]%s "COL_WHITE"Telah Menyertai Server!...",GetName(playerid));
						SendClientMessageToAll(COLOR_RED,string);
						SetPlayerColor(playerid, COLOR_WHITE);
						SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
						SetPlayerInterior(playerid,0);
						SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					}
				}
	       		else
	       		{
					new str[1000];
                    format(str, sizeof(str), ""COL_WHITE"SELAMAT KEMBALI KE"COL_LBLUE" PENANG ROLEPLAY\n"COL_WHITE"NAMA INI TELAH PON MENDAFTAR\n\n"COL_WHITE"NAMA AKAUN : "COL_LBLUE"%s\n"COL_RED"KATA LALUAN SALAH!", GetName(playerid));
                    ShowPlayerDialog(playerid, LOGIN, DIALOG_STYLE_PASSWORD, "LOG MASUK", str, "Masuk", "Keluar");
	       		}
	       		return 1;
	        }
			else
	        {
		        Kick(playerid);
	        }
		}
		case AMENU:
		{
		    if(response)
		    {
				switch(listitem)
				{
					case 0:
					{
		            	new str[520];
		            	if(PlayerInfo[playerid][pAdmin] <= 0) return SendClientMessage(playerid,-1,""COL_RED"[STAFF]"COL_WHITE" Hanya Staff Keatas Sahaja Boleh Guna Command Ini");
						strcat(str, ""COL_LGREEN"/amenu"COL_WHITE" - Admin Menu\n");
						strcat(str, ""COL_LGREEN"/setskin"COL_WHITE" - Set Skin\n");
						strcat(str, ""COL_LGREEN"/ra"COL_WHITE" - Chat Admin Only\n");
						strcat(str, ""COL_LGREEN"/tarik"COL_WHITE" - Teleport Pemain Ke Posisi Anda\n");
						strcat(str, ""COL_LGREEN"/goto"COL_WHITE" - Teleport Ke Pemain\n");
						strcat(str, ""COL_LGREEN"/gotoc"COL_WHITE" - Teleport Ke City Hall\n");
						strcat(str, ""COL_LGREEN"/slap"COL_WHITE" - Menampar Pemain\n");
						strcat(str, ""COL_LGREEN"/ann"COL_WHITE" - Announcement Ingame\n");
						strcat(str, ""COL_LGREEN"/cc"COL_WHITE" - Clear Chat\n");
						strcat(str, ""COL_LGREEN"/ajail"COL_WHITE" - Admin Jail\n");
						strcat(str, ""COL_LGREEN"/aunjail"COL_WHITE" - Admin Unjail\n");
						strcat(str, ""COL_LGREEN"/av"COL_WHITE" - Admin Spawn Vehicle\n");
						ShowPlayerDialog(playerid, AMENU,  DIALOG_STYLE_MSGBOX, "STAFF", str, "Tutup", "");
					}
					case 1:
					{
		            	new str[520];
		            	if(PlayerInfo[playerid][pAdmin] <= 1) return SendClientMessage(playerid,-1,""COL_RED"[ADMIN]"COL_WHITE" Hanya Admin Keatas Sahaja Boleh Guna Command Ini");
						strcat(str, ""COL_LGREEN"/setwaktu"COL_WHITE" - Set Waktu\n");
						strcat(str, ""COL_LGREEN"/setcuaca"COL_WHITE" - Set Cuaca\n");
						strcat(str, ""COL_LGREEN"/setarmor"COL_WHITE" - Set Armor Pemain\n");
						strcat(str, ""COL_LGREEN"/healall"COL_WHITE" - Heal Semua Pemain\n");
						ShowPlayerDialog(playerid, AMENU,  DIALOG_STYLE_MSGBOX, "ADMIN", str, "Tutup", "");
					}
					case 2:
					{
		            	new str[520];
		            	if(PlayerInfo[playerid][pAdmin] <= 2) return SendClientMessage(playerid,-1,""COL_RED"[ASS DEVELOPER]"COL_WHITE" Hanya Assistance Dev Keatas Sahaja Boleh Guna Command Ini");
						strcat(str, ""COL_LGREEN"/kick"COL_WHITE" - Kick Pemain\n");
						strcat(str, ""COL_LGREEN"/ban"COL_WHITE" - Ban Pemain\n");
						strcat(str, ""COL_LGREEN"/tariksemua"COL_WHITE" - Tarik Semua\n");
						strcat(str, ""COL_LGREEN"/aduty"COL_WHITE" - Onduty Developer\n");
						strcat(str, ""COL_LGREEN"/rac"COL_WHITE" - Respawn Kenderaan\n");
						strcat(str, ""COL_LGREEN"/dac"COL_WHITE" - Hancurkan Semua Kenderaan\n");
						strcat(str, ""COL_LGREEN"/delveh"COL_WHITE" - Hancurkan Kenderaan\n");
						strcat(str, ""COL_LGREEN"/fixveh"COL_WHITE" - Baiki Kenderaan\n");
						strcat(str, ""COL_LGREEN"/fixvehall"COL_WHITE" - Baiki Semua Kenderaan\n");
						strcat(str, ""COL_LGREEN"/sp"COL_WHITE" - Spec pemain\n");
						strcat(str, ""COL_LGREEN"/spoff"COL_WHITE" - Spec off\n");
						ShowPlayerDialog(playerid, AMENU,  DIALOG_STYLE_MSGBOX, "ASSISTANCE DEVELOPER", str, "Tutup", "");
					}
					case 3:
					{
		            	new str[520];
		            	if(PlayerInfo[playerid][pAdmin] <= 3) return SendClientMessage(playerid,-1,""COL_RED"[DEVELOPER]"COL_WHITE" Hanya Developer Sahaja Boleh Guna Command Ini");
						strcat(str, ""COL_LGREEN"/sethp"COL_WHITE" - Set Nyawa\n");
						strcat(str, ""COL_LGREEN"/jetpack"COL_WHITE" - Memakai Jetpack\n");
						ShowPlayerDialog(playerid, AMENU, DIALOG_STYLE_MSGBOX, "Developer", str, "Tutup", "");
					}
					case 4:
					{
		            	new str[520];
		            	if(PlayerInfo[playerid][pAdmin] <= 4) return SendClientMessage(playerid,-1,""COL_RED"[CO OWNER]"COL_WHITE" Hanya Co Owner Sahaja Boleh Guna Command Ini");
						strcat(str, ""COL_LGREEN"/gotoint"COL_WHITE" - Teleport Kedalam Interior\n");
						strcat(str, ""COL_LGREEN"/givemoney"COL_WHITE" - Berikan Duit\n");
						strcat(str, ""COL_LGREEN"/givegun"COL_WHITE" - Memberikaan Senjata\n");
						ShowPlayerDialog(playerid, AMENU, DIALOG_STYLE_MSGBOX, "CO OWNER COMMANDS", str, "Tutup", "");
					}
					case 5:
					{
		            	new str[520];
		            	if(PlayerInfo[playerid][pAdmin] <= 5) return SendClientMessage(playerid,-1,""COL_RED"[OWNER]"COL_WHITE" Hanya Owner Sahaja Boleh Guna Command Ini");
						strcat(str, ""COL_LGREEN"/setvip"COL_WHITE" - Setvip\n");
						strcat(str, ""COL_LGREEN"/setadmin"COL_WHITE" - Set Admin\n");
						strcat(str, ""COL_LGREEN"/makeleader"COL_WHITE" - Set Leader\n");
						ShowPlayerDialog(playerid, AMENU, DIALOG_STYLE_MSGBOX, "OWNER COMMANDS", str, "Tutup", "");
					}
				}
			}
		}
		case SPAWN:
		{
			if(response)
		    {
     			if(listitem == 0)
				{
					if(PlayerInfo[playerid][pLesenKereta] == 0) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Anda Tidak Mempunyai Lesen Kereta!");
		           	ShowPlayerDialog(playerid, KERETA,  DIALOG_STYLE_LIST, "Kereta", "Infernus\nSultan\nElegy\nBlista Compact\nTampa\nHuntley\nSabre\nCheetah\nBullet\nBuffalo\nStretch\nBanshee", "Pilih", "Tutup");
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pLesenMotor] == 0) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Anda Tidak Mempunyai Lesen Motor!");
		           	ShowPlayerDialog(playerid, MOTOR,  DIALOG_STYLE_LIST, "Motor", "BF400\nNRG500\nFCR900\nPCJ600\nFREEWAY\nWAYFARER\nSANCHEZ\nQUADBIKE", "Pilih", "Tutup");
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pLesenLori] == 0) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Anda Tidak Mempunyai Lesen Lori!");
		           	ShowPlayerDialog(playerid, LORI,  DIALOG_STYLE_LIST, "Lori", "Burrito\nFlatbed\nDFT-30\nTanker\nMule", "Pilih", "Tutup");
				}
				if(listitem == 3)
				{
		           	ShowPlayerDialog(playerid, FREE,  DIALOG_STYLE_LIST, "Tiada Lesen", "Basikal Mountain\nMountain Bike\nFaggio\nSlamvan", "Pilih", "Tutup");
				}
				if(listitem == 4)
				{
		           	ShowPlayerDialog(playerid, KERAJAAN,  DIALOG_STYLE_LIST, "Kenderaan Kerajaan", "KERETA PRM\nVAN PRM\nRANGER PRM\nSWAT PRM\nENFORCER PRM\nMOTOR PRM\nRANHER JPS\nVAN JPS\nMOTOR JPS", "Pilih", "Tutup");
				}
			}
		}
		case KEDAI:
		{
			if(response)
		    {
     			if(listitem == 0)
				{
		            ShowPlayerDialog(playerid, LELAKI,  DIALOG_STYLE_LIST, "LELAKI", "Truth\nMaccer\nMale01\nBmycr\nWmybmx\nWmybp\nWmydrug\nHmyri\nHmycr\nHmyst\nomokung\nvbmybox\nvwmybox\nwmycr\ncwmyhb1", "Beli", "Batal");
				}
				if(listitem == 1)
				{
		           	ShowPlayerDialog(playerid, PEREMPUAN,  DIALOG_STYLE_LIST, "PEREMPUAN", "Bfyri\nvwfypro\nWfyri\nWfyst\nWfybu\nSofyri\nSwfyri\nSwfyst", "Beli", "Batal");
				}
			}
		}
		case INV:
		{
			if(response)
		    {
     			if(listitem == 0)
				{
		            ShowPlayerDialog(playerid, WEAPONINV,  DIALOG_STYLE_LIST, "WEAPON INVENTORY", "KNIFE\nBASEBALL BAT\nSILENCED PISTOL\nDESERT EAGLE\nSHOTGUN\nMP5\nAK47\nM4\nSNIPER RIFLE,", "Pilih", "Tutup");
				}
				if(listitem == 1)
				{
		            ShowPlayerDialog(playerid, MAKANANINV,  DIALOG_STYLE_LIST, "MAKANAN INVENTORY", "MEGGI\nKEROPOK\nROTI\nBURGER,", "Pilih", "Tutup");
				}
				if(listitem == 2)
				{
		            ShowPlayerDialog(playerid, MINUMANINV,  DIALOG_STYLE_LIST, "MINUMAN INVENTORY", "PEPSI\nCOCACOLA\nICE LEMON TEA\nSLURPHY", "Pilih", "Tutup");
				}
			}
		}
		case KERETA://SPAWN KERETA
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pInfernus] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Bernama Infernus!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					vehid = CreateVehicle(411,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 1)
				{
                    if(PlayerInfo[playerid][pSultan] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Bernama Sultan!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
                    vehid = CreateVehicle(560,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
		    	if(listitem == 2)
				{
                    if(PlayerInfo[playerid][pElegy] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE"Anda Tidak Mempunyai Bernama Elegy!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					vehid = CreateVehicle(562,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 3)
				{
                    if(PlayerInfo[playerid][pBlista] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Blista Compact!");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(496,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 4)
				{
                    if(PlayerInfo[playerid][pTampa] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Tampa!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					vehid = CreateVehicle(549,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 5)
				{
                    if(PlayerInfo[playerid][pHuntley] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Huntley!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					vehid = CreateVehicle(475,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 6)
				{
                    if(PlayerInfo[playerid][pSabre] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Sabre!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					vehid = CreateVehicle(415,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 7)
				{
                    if(PlayerInfo[playerid][pCheetah] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Cheetah!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					vehid = CreateVehicle(541,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 8)
				{
                    if(PlayerInfo[playerid][pBullet] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Bullet!");
                    new Float:x,Float:y,Float:z,Float:a, vehid;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					vehid = CreateVehicle(541,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, vehid, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 9)
				{
                    if(PlayerInfo[playerid][pBuffalo] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Buffalo!");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(402,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 10)
				{
                    if(PlayerInfo[playerid][pStretch] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Stretch");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(409,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 11)
				{
                    if(PlayerInfo[playerid][pBanshee] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Banshee");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(429,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
			}
		}
		case MOTOR://SPAWN MOTOR
		{
			if(response)
			{
				if(listitem == 0) 
				{
                    if(PlayerInfo[playerid][pBF400] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan BF 400");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(581,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 1)
				{
                    if(PlayerInfo[playerid][pNRG500] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan NRG500");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(522,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 2)
				{
                    if(PlayerInfo[playerid][pFCR900] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai KENDERAAN FCR900");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(521,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 3)
				{
                    if(PlayerInfo[playerid][pPCJ600] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai KENDERAAN PCJ600");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(461,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 4)
				{
                    if(PlayerInfo[playerid][pFREEWAY] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai KENDERAAN FREEWAY");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(463,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 5)
				{
                    if(PlayerInfo[playerid][pWAYFARER] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai KENDERAAN WAYFARER");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(586,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 6)
				{
                    if(PlayerInfo[playerid][pSANCHEZ] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai KENDERAAN SANCHEZ");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(468,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 7)
				{
                    if(PlayerInfo[playerid][pQUADBIKE] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai KENDERAAN QUADBIKE");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(471,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
			}
		}
		case LORI://SPAWN LORI
		{
			if(response)
			{
				if(listitem == 0)
				{
                    if(PlayerInfo[playerid][pBurrito] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Burrito");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(482,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 1)
				{
                    if(PlayerInfo[playerid][pFlatbed] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan Flatbed");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(455,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 2)
				{
                    if(PlayerInfo[playerid][pDFT30] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Kenderaan DFT-30");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(578,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 3)
				{
                    if(PlayerInfo[playerid][pTanker] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Tanker");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(514,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 4)
				{
                    if(PlayerInfo[playerid][pMule] == 0) return SendClientMessage(playerid,-1,""COL_PJP"[JPS]:"COL_WHITE" Anda Tidak Mempunyai Mule");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(414,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
			}
		}
		case FREE://SPAWN BASIKAL
		{
			if(response)
			{
				if(listitem == 0)
				{
                    SendClientMessage(playerid,-1,""COL_RED"[PENTADBIRAN]"COL_WHITE" Anda Telah Menyewa Basikal");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(509,x+1,y+1,z,a,1,1,10000);
					GivePlayerMoney(playerid, -500);
					PlayerInfo[playerid][pDuit] = -500;
					PutPlayerInVehicle(playerid, veh, 0);
				}
				if(listitem == 1)
				{
                    SendClientMessage(playerid,-1,""COL_RED"[PENTADBIRAN]"COL_WHITE" Anda Telah Menyewa Mountain Bike");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(510,x+1,y+1,z,a,1,1,10000);
					GivePlayerMoney(playerid, -500);
					PlayerInfo[playerid][pDuit] = -500;
					PutPlayerInVehicle(playerid, veh, 0);
				}
				if(listitem == 2)
				{
                    SendClientMessage(playerid,-1,""COL_RED"[PENTADBIRAN]"COL_WHITE" Anda Telah Menyewa Faggio");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(462,x+1,y+1,z,a,1,1,10000);
					GivePlayerMoney(playerid, -1000);
					PlayerInfo[playerid][pDuit] = -1000;
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 3)
				{
                    SendClientMessage(playerid,-1,""COL_RED"[PENTADBIRAN]"COL_WHITE" Anda Telah Menyewa Slamvan");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(535,x+1,y+1,z,a,1,1,10000);
					GivePlayerMoney(playerid, -2500);
					PlayerInfo[playerid][pDuit] = -2500;
					PutPlayerInVehicle(playerid, veh, 0);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
			}
		}
		case KERAJAAN://SPAWN KERAJAAN
		{
			if(response)
			{
				if(listitem == 0)
				{
                    if(PlayerInfo[playerid][pPpr] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota Polis Roleplay Malaysia");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(597,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 1)
				{
                    if(PlayerInfo[playerid][pPpr] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota Polis Roleplay Malaysia");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(498,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 2)
				{
                    if(PlayerInfo[playerid][pPpr] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota Polis Roleplay Malaysia");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(599,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 3)
				{
                    if(PlayerInfo[playerid][pPpr] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota Polis Roleplay Malaysia");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(601,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 4)
				{
                    if(PlayerInfo[playerid][pPpr] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota Polis Roleplay Malaysia");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(427,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 5)
				{
                    if(PlayerInfo[playerid][pPpr] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota Polis Roleplay Malaysia");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(523,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 6)
				{
                    if(PlayerInfo[playerid][pPjp] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota JPJ Penang Samp");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(490,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 7)
				{
                    if(PlayerInfo[playerid][pPjp] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota JPJ Penang Samp");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(609,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
				if(listitem == 8)
				{
                    if(PlayerInfo[playerid][pPjp] == 0) return SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Bukan Anggota JPJ Penang Samp");
                    new Float:x,Float:y,Float:z,Float:a, veh;
					GetPlayerPos(playerid,x,y,z);
					GetPlayerFacingAngle(playerid,a);
					veh = CreateVehicle(523,x+1,y+1,z,a,1,1,10000);
					PutPlayerInVehicle(playerid, veh, 0);
					ChangeVehicleColor(veh, 0,1);
					AddVehicleComponent(veh, 1080);
					SendClientMessage(playerid, COLOR_RED, "[ERROR]{FFFFFF}Untuk Start Enjin Kenderaan, Tulis /engine");
				}
			}
		}
		case WEAPONINV://WEAPON INVENTORY
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pKnife] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON KNIFE");
					GivePlayerWeapon(playerid,4,1);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON KNIFE DARI BELAKANG.");				
				}
				if(listitem == 1)
				{
                    if(PlayerInfo[playerid][pBat] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON BASEBALL BAT");
					GivePlayerWeapon(playerid,5,1);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON BASEBALL BAT DARI BELAKANG.");	
				}
				if(listitem == 2)
				{
                    if(PlayerInfo[playerid][pSilenced] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON SILENCED PISTOL");
					GivePlayerWeapon(playerid,23,999999999);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON SILENCED PISTOL DARI BELAKANG.");	
				}
				if(listitem == 3)
				{
                    if(PlayerInfo[playerid][pDesert] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON DESERT EAGLE");
					GivePlayerWeapon(playerid,24,999999999);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON DESERT EAGLE DARI BELAKANG.");	
				}
				if(listitem == 4)
				{
                    if(PlayerInfo[playerid][pShotgun] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON SHOTGUN");
					GivePlayerWeapon(playerid,25,999999999);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON SHOTGUN DARI BELAKANG.");	
				}
				if(listitem == 5)
				{
                    if(PlayerInfo[playerid][pMp5] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON MP5");
					GivePlayerWeapon(playerid,29,999999999);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON MP5 DARI BELAKANG.");	
				}
				if(listitem == 6)
				{
                    if(PlayerInfo[playerid][pAk47] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON AK 47");
					GivePlayerWeapon(playerid,30,999999999);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON AK 47 DARI BELAKANG.");	
				}
				if(listitem == 7)
				{
                    if(PlayerInfo[playerid][pM4] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON M4");
					GivePlayerWeapon(playerid,31,999999999);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON M4 DARI BELAKANG.");	
				}
				if(listitem == 8)
				{
                    if(PlayerInfo[playerid][pSniper] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI WEAPON SNIPER");
					GivePlayerWeapon(playerid,34,999999999);
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH MENGELUARKAN WEAPON SNIPER DARI BELAKANG.");	
				}
			}
		}
		case MAKANANINV://MAKANAN INVENTORY
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pMeggi] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI MEGGI");
					format(string, sizeof string, " %s Makan Maggie", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);		
					PlayerInfo[playerid][pMeggi] -= 1;
				}
				if(listitem == 1)
				{
                    if(PlayerInfo[playerid][pKeropok] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI KEROPOK");
					format(string, sizeof string, " %s Makan Keropok", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);	
					PlayerInfo[playerid][pKeropok] -= 1;		
				}
				if(listitem == 2)
				{
                    if(PlayerInfo[playerid][pSilenced] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI ROTI");
					format(string, sizeof string, " %s Memakan Roti", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);	
					PlayerInfo[playerid][pRoti] -= 1;
				}
				if(listitem == 3)
				{
                    if(PlayerInfo[playerid][pDesert] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI BURGER");
					format(string, sizeof string, " %s Makan Burger", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);	
					PlayerInfo[playerid][pBurger] -= 1;			
				}
			}
		}
		case MINUMANINV://MAKANAN INVENTORY
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pMeggi] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI PEPSI");
					format(string, sizeof string, " %s Minum Pepsi", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);	
					PlayerInfo[playerid][pPepsi] -= 1;	
				}
				if(listitem == 1)
				{
                    if(PlayerInfo[playerid][pBat] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI COCALCOLA");
					format(string, sizeof string, " %s Minum Cocacola", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);		
					PlayerInfo[playerid][pCoke] -= 1;	
				}
				if(listitem == 2)
				{
                    if(PlayerInfo[playerid][pSilenced] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI ICE LEMON TEA");
					format(string, sizeof string, " %s Minum Ice Lemon Tea", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);	
					PlayerInfo[playerid][pLemontea] -= 1;		
				}
				if(listitem == 3)
				{
                    if(PlayerInfo[playerid][pDesert] ==0) return SendClientMessage(playerid,-1, ""COL_RED"[ERROR]"COL_WHITE"ANDA TIDAK MEMPUNYAI SLURPHY");
					format(string, sizeof string, " %s Minum Slurphy", GetName(playerid));
					ProxDetector(30.0, playerid, string,COLOR_PURPLE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
					SetPlayerChatBubble(playerid,string,COLOR_PURPLE,5.0,5000);	
					PlayerInfo[playerid][pSlurphy] -= 1;				
				}
			}
		}				
		case LELAKI:
		{
			if(response)
			{
				if(listitem == 0)
				{
				    SetPlayerSkin(playerid,1);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 1;
				}
				if(listitem == 1)
				{
					SetPlayerSkin(playerid,2);
					GivePlayerMoney(playerid,-5000);
					PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 2;
				}
				if(listitem == 2)
				{
				    SetPlayerSkin(playerid,7);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 7;
				}
				if(listitem == 3)
				{
				    SetPlayerSkin(playerid,21);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 21;
				}
				if(listitem == 4)
				{
				    SetPlayerSkin(playerid,23);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 23;
				}
				if(listitem == 5)
				{
				    SetPlayerSkin(playerid,26);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 26;
				}
				if(listitem == 6)
				{
				    SetPlayerSkin(playerid,29);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 29;
				}
				if(listitem == 7)
				{
				    SetPlayerSkin(playerid,46);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 46;
				}
				if(listitem == 8)
				{
				    SetPlayerSkin(playerid,47);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 47;
				}
				if(listitem == 9)
				{
				    SetPlayerSkin(playerid,48);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 48;
				}
				if(listitem == 10)
				{
				    SetPlayerSkin(playerid,49);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 49;
				}
				if(listitem == 11)
				{
				    SetPlayerSkin(playerid,80);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 80;
				}
				if(listitem == 12)
				{
				    SetPlayerSkin(playerid,81);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 81;
				}
				if(listitem == 13)
				{
				    SetPlayerSkin(playerid,100);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 100;
				}
				if(listitem == 14)
				{
				    SetPlayerSkin(playerid,120);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 120;
				}
			}
		}
		case PEREMPUAN://SKIN PEREMPUAN
		{
			if(response)
			{
				if(listitem == 0)
				{
				    SetPlayerSkin(playerid,12);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 12;
				}
				if(listitem == 1)
				{
					SetPlayerSkin(playerid,85);
					GivePlayerMoney(playerid,-5000);
					PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 85;
				}
				if(listitem == 2)
				{
				    SetPlayerSkin(playerid,91);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 91;
				}
				if(listitem == 3)
				{
				    SetPlayerSkin(playerid,93);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 93;
				}
				if(listitem == 4)
				{
				    SetPlayerSkin(playerid,141);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 141;
				}
				if(listitem == 5)
				{
				    SetPlayerSkin(playerid,150);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 150;
				}
				if(listitem == 6)
				{
				    SetPlayerSkin(playerid,216);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 216;
				}
				if(listitem == 7)
				{
				    SetPlayerSkin(playerid,233);
				    GivePlayerMoney(playerid,-5000);
				    PlayerInfo[playerid][pDuit] = -5000;
				    PlayerInfo[playerid][pSkin] = 233;
				}
			}
		}
		case WEAPON://BELI WEAPON
		{
			if(response)
			{
				if(listitem == 0)
				{
					GivePlayerWeapon(playerid,4,1);
    				GivePlayerMoney(playerid,-500);
    				PlayerInfo[playerid][pDuit] =-500;
    				PlayerInfo[playerid][pKnife] = 1;
				}
				if(listitem == 1)
				{
					GivePlayerWeapon(playerid,5,1);
    				GivePlayerMoney(playerid,-1000);
    				PlayerInfo[playerid][pDuit] =-1000;
    				PlayerInfo[playerid][pBat] = 1;
				}
				if(listitem == 2)
				{
					GivePlayerWeapon(playerid,23,999999999);
    				GivePlayerMoney(playerid,-5000);
    				PlayerInfo[playerid][pDuit] =-5000;
    				PlayerInfo[playerid][pSilenced] = 1;
				}
				if(listitem == 3)
				{
					GivePlayerWeapon(playerid,24,999999999);
    				GivePlayerMoney(playerid,-10000);
    				PlayerInfo[playerid][pDuit] =-10000;
    				PlayerInfo[playerid][pDesert] = 1;
				}
				if(listitem == 4)
				{
					GivePlayerWeapon(playerid,25,999999999);
    				GivePlayerMoney(playerid,-50000);
    				PlayerInfo[playerid][pDuit] =-50000;
    				PlayerInfo[playerid][pShotgun] = 1;
				}
				if(listitem == 5)
				{
					GivePlayerWeapon(playerid,29,999999999);
    				GivePlayerMoney(playerid,-70000);
    				PlayerInfo[playerid][pDuit] =-70000;
    				PlayerInfo[playerid][pMp5] = 1;
				}
				if(listitem == 6)
				{
					GivePlayerWeapon(playerid,30,999999999);
    				GivePlayerMoney(playerid,-90000);
    				PlayerInfo[playerid][pDuit] =-90000;
    				PlayerInfo[playerid][pAk47] = 1;
				}
				if(listitem == 7)
				{
					GivePlayerWeapon(playerid,31,999999999);
    				GivePlayerMoney(playerid,-150000);
    				PlayerInfo[playerid][pDuit] =-150000;
    				PlayerInfo[playerid][pM4] = 1;
				}
				if(listitem == 8)
				{
					GivePlayerWeapon(playerid,34,999999999);
    				GivePlayerMoney(playerid,-200000);
    				PlayerInfo[playerid][pDuit] =-200000;
    				PlayerInfo[playerid][pSniper] = 1;
				}
				if(listitem == 9)
				{
					SendClientMessage(playerid, COLOR_WHITE, "TERIMA KASIH KERANA SUDI MEMBELI WEAPON DI KEDAI KAMI. ~ANNEYONG~");

				}
			}
		}
		case MART://BELI BARANG 7 ELEVEN
		{
			if(response)
			{
				if(listitem == 0)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI BACKPACK!");
    				GivePlayerMoney(playerid, -500);
    				PlayerInfo[playerid][pBag] += 1;
    				PlayerInfo[playerid][pDuit] = -500;
				}
				if(listitem == 1)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI MEGGI!");
    				GivePlayerMoney(playerid, -300);
    				PlayerInfo[playerid][pMeggi] += 1;
    				PlayerInfo[playerid][pDuit] = -300;
    				if(PlayerInfo[playerid][pMeggi] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}MEGGI ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 2)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI KEROPOK!");
    				GivePlayerMoney(playerid, -250);
    				PlayerInfo[playerid][pKeropok]+= 1;
    				PlayerInfo[playerid][pDuit] = -250;
    				if(PlayerInfo[playerid][pKeropok] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}KEROPOK ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 3)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI ROTI!");
    				GivePlayerMoney(playerid, -100);
    				PlayerInfo[playerid][pRoti] += 1;
    				PlayerInfo[playerid][pDuit] = -100;
    				if(PlayerInfo[playerid][pRoti] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}ROTI ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 4)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI BURGER!");
    				GivePlayerMoney(playerid, -800);
    				PlayerInfo[playerid][pBurger] += 1;
    				PlayerInfo[playerid][pDuit] = -800;
    				if(PlayerInfo[playerid][pBurger] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}BURGER ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 5)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI PEPSI!");
    				GivePlayerMoney(playerid, -700);
    				PlayerInfo[playerid][pPepsi] += 1;
    				PlayerInfo[playerid][pDuit] = -700;
    				if(PlayerInfo[playerid][pPepsi] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}PEPSI ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 6)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI COCACOLA!");
    				GivePlayerMoney(playerid, -800);
    				PlayerInfo[playerid][pCoke] += 1;
    				PlayerInfo[playerid][pDuit] = -800;
    				if(PlayerInfo[playerid][pCoke] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}COCALCOLA ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 7)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI ICE LEMON TEA!");
    				GivePlayerMoney(playerid, -600);
    				PlayerInfo[playerid][pLemontea] += 1;
    				PlayerInfo[playerid][pDuit] = -600;
    				if(PlayerInfo[playerid][pLemontea] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}ICE LEMON TEA ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 8)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI SLURPHY!");
    				GivePlayerMoney(playerid, -900);
    				PlayerInfo[playerid][pSlurphy] += 1;
    				PlayerInfo[playerid][pDuit] = -900;
    				if(PlayerInfo[playerid][pSlurphy] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}SLURPHY ANDA SUDAH PENUH!");
    				}
				}
				if(listitem == 9)
				{
					SendClientMessage(playerid, COLOR_WHITE, "TERIMA KASIH KERANA SUDI MEMBELI MAKANAN/MINUMAN DI KEDAI KAMI. ~ANNEYONG~");

				}
			}
		}
		case INVENTORY://INVENTORY
		{
			if(response)
			{
				if(listitem == 0)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI BACKPACK!");
    				GivePlayerMoney(playerid, -500);
    				PlayerInfo[playerid][pBag] = 1;
    				PlayerInfo[playerid][pDuit] = -500;
				}
				if(listitem == 1)
				{
					SendClientMessage(playerid, COLOR_PPR, "[INFO]{FFFFFF}ANDA TELAH BERJAYA MEMBELI MEGGI!");
    				GivePlayerMoney(playerid, -300);
    				PlayerInfo[playerid][pMeggi] += 1;
    				PlayerInfo[playerid][pDuit] = -300;
    				if(PlayerInfo[playerid][pMeggi] > MAX_ITEM)
    				{
    					return SendClientMessage(playerid,COLOR_RED,"[ERROR]{FFFFFF}MEGGI ANDA SUDAH PENUH!");
    				}
				}
			}
		}		
        case DIALOG_WHITELIST:
        {
            new player[200];
            format(player,sizeof(player),"/whitelist/%s.txt",inputtext);
            if(response == 1)
                {
                        if(!dini_Exists(player))
                        {
                            format(string,sizeof(string),"{00FFFF}%s{FFFFFF} Telah Di Whitelist.", inputtext);
                            SendClientMessage(playerid,COLOR_WHITE,string);
                            dini_Create(player);

                            ShowPlayerDialog(playerid,DIALOG_WHITELIST,DIALOG_STYLE_INPUT,"{00FFFF}Whitelist","{FF0000}Player Name.","Continue","Cancel");
                        }
                        else
                        {
                            format(string,sizeof(string),"{00FFFF}%s{FFFFFF} Masih Belum Di Whitelist.", inputtext);
                            SendClientMessage(playerid,COLOR_WHITE,string);
                            ShowPlayerDialog(playerid,DIALOG_WHITELIST,DIALOG_STYLE_INPUT,"{00FFFF}Whitelist","{FF0000}Player Name.\n* Unknown Player!","Continue","Cancel");
                        }
                }
        }
        case DIALOG_REMOVE:
        {
            new player[200];
            format(player,sizeof(player),"/whitelist/%s.txt",inputtext);
            if(response == 1)
            {
                if(dini_Exists(player))
                {
                dini_Remove(player);
                format(string,sizeof(string),"{00FFFF}%s{FFFFFF} Telah Di Blacklist.", inputtext);
                SendClientMessage(playerid,COLOR_WHITE,string);

                ShowPlayerDialog(playerid,DIALOG_REMOVE,DIALOG_STYLE_INPUT,"{00FFFF}Blacklist","{FF0000}Player Name.","Continue","Cancel");
                }
                else
                {
                format(string,sizeof(string),"{00FFFF}%s{FFFFFF} Masih Belum Di Blacklist.", inputtext);
                SendClientMessage(playerid,COLOR_WHITE,string);
                ShowPlayerDialog(playerid,DIALOG_REMOVE,DIALOG_STYLE_INPUT,"{00FFFF}Blacklist","{FF0000}PlayerName.\n* Unknown Player!","Continue","Cancel");
                }
            }
        }
        case DIALOG_TELEPORT:
		{
			if(response)
			{
				if(listitem == 0)
				{
					SetPlayerPos(playerid, 1169.9183, -1489.9886, 22.7559);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Spawn Rakyat!");
				}
				if(listitem == 1)
				{
					SetPlayerPos(playerid, 1538.5210, -1674.9945, 13.5469);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Balai PPR!");
				}
				if(listitem == 2)
				{
					SetPlayerPos(playerid, 1655.7126, -1669.9480, 21.4375);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Balai PJP!");
				}
				if(listitem == 3)
				{
					SetPlayerPos(playerid, 1189.1656, -1326.0255, 13.5674);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Hospital!");
				}
				if(listitem == 4)
				{
					SetPlayerPos(playerid, 1547.0375, 2771.8433, 10.7884);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Base Kapak!");
				}
				if(listitem == 5)
				{
					SetPlayerPos(playerid, 1092.2290, 2392.3662, 10.7821);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Base Blackshark!");
				}
				if(listitem == 6)
				{
					SetPlayerPos(playerid, 1566.1134,814.5935,12.8546);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Base King 302!");
				}
				if(listitem == 7)
				{
					SetPlayerPos(playerid, 2507.1301, 1820.8181, 10.8320);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Base Todak97!");
				}
				if(listitem == 8)
				{
					SetPlayerPos(playerid, 2507.1301, 1820.8181, 10.8320);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Teleport Ke Base Tenjiku Geng!");
				}
			}
		}
		case DIALOG_ROLE:
		{
			if (!response) return Kick (playerid);
            if(response)
            {
            	if(listitem == 0)
				{
					new count = 0, str[MAX_PLAYERS], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pPpr] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pPpr]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "POLIS PENANG ROLEPLAY", "{FF0000}Maaf, Tiada Anggota Ppr Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah PPR Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "POLIS PENANG ROLEPLAY", str, "Tutup", "");
    				}
				}
				if(listitem == 1)
				{
					new count = 0, str[MAX_PLAYERS], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pPjp] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pPjp]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "PENGANGKUTAN JALANRAYA PENANG", "{FF0000}Maaf, Tiada Anggota Pjp Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah Pjp Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "PENGANGKUTAN JALANRAYA PENANG", str, "Tutup", "");
    				}
				}
				if(listitem == 2)
				{
					new count = 0, str[MAX_PLAYERS], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pMpr] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pMpr]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "MEDIC PENANG ROLEPLAY", "{FF0000}Maaf, Tiada Anggota Mpr Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah Mpr Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "MEDIC PENANG ROLEPLAY", str, "Tutup", "");
    				}
				}
				if(listitem == 3)
				{
					new count = 0, str[MAX_PLAYERS], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pKapak] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pKapak]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Kapak", "{FF0000}Maaf, Tiada Ahli Kapak Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah Kapak Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Kapak", str, "Tutup", "");
    				}
				}
				if(listitem == 4)
				{
					new count = 0, str[MAX_PLAYERS], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pBlackShark] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pBlackShark]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "BLACK SHARK", "{FF0000}Maaf, Tiada Ahli Black Shark Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah Blackshark Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Black Shark", str, "Tutup", "");
    				}
				}
				if(listitem == 5)
				{
					new count = 0, str[MAX_PLAYERS], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pKing302] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pKing302]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "KING 302", "{FF0000}Maaf, Tiada Ahli King 302 Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah King 302 Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "KING302", str, "Tutup", "");
    				}
				}
				if(listitem == 6)
				{
					new count = 0, str[MAX_PLAYERS], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pTodak97] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pTodak97]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TODAK97", "{FF0000}Maaf, Tiada Ahli Todak97 Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah Todak97 Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TODAK97", str, "Tutup", "");
    				}
				}
				if(listitem == 7)
				{
					new count = 0, str[400], line[MAX_PLAYERS];
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
            				if(PlayerInfo[i][pAdmin] > 1)
            				{
                				format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d \n", GetName(i), i, PlayerInfo[i][pAdmin]);
                				strcat(str, line);
                				count ++;
                			}
            			}
        			}
    				if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Administrator", "{FF0000}Maaf, tiada admins yang online pada masa ini!", "Tutup", "");
    				else
    				{
       					format(line, sizeof(line), "\r\n{00FF00}Jumlah Administrator Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Administrator", str, "Tutup", "");
					}
				}
				if(listitem == 8)
				{
    				new count = 0, str[400], line[MAX_PLAYERS];
    				new i_dateTime[2][3];
					gettime(i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2]);
					getdate(i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2]);
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
            				if(PlayerInfo[i][pJail] > 0)
            				{
                				format(line, sizeof(line), "{FFFFFF}%s ID (%d) | Waktu Dijail : [%i/%i/%i - %i:%i:%i]\n", GetName(i), i, i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2], i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2]);
                				strcat(str, line);
                				count ++;
            				}
        				}
    				}
    				if(count == 0) return ShowPlayerDialog(playerid, 433, DIALOG_STYLE_MSGBOX, "PENJENAYAH", "{FF0000}Maaf,Tiada Penjenayah Didalam Jail Buat Masa Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah Penjenayah Dalam Jail: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "PENJENAYAH", str, "Tutup", "");
    				}
    			}
    			if(listitem == 9)
				{
    				for(new i = 0; i < MAX_PLAYERS; i++)
    				{
        				if(IsPlayerConnected(i))
        				{
        					if(PlayerInfo[i][pTenjikuGeng] > 0)
        					{
        						format(line, sizeof(line), "{FFFFFF}%s(%d) Level %d\n", GetName(i), i, PlayerInfo[i][pTenjikuGeng]);
                				strcat(str, line);
                				count ++;
        					}
        				}
        			}
        			if(count == 0) return ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TENJIKU GENG", "{FF0000}Maaf, Tiada Ahli Tenjiku Geng Yang Online\nPada Waktu Ini", "Tutup", "");
    				else
    				{
        				format(line, sizeof(line), "\r\n{00FF00}Jumlah Tenjiku Geng Dalam Talian: %d", count);
        				strcat(str, line);
        				ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "TENJIKU GENG", str, "Tutup", "");
    				}
				}
			}
		}
		case MENU:
		{
			if(response)
			{
				if(listitem == 0)
				{		
        			ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Quotes Commands", "WB = Welcome Back \nWBB = Welcome Back Baby\nwbs = Welcome Back Staff\nwba = Welcome Back Admin\nwbd = Welcome Back Developer\naslm = Assalamualaikum\nwslm = Waalaikumsalam\nty = Thank You\ngay = Jadi Budak Gay\ncomel = Jadi Budak Comel\nhensem = Jadi Budak Hensem", "Tutup", "");
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Player Commands", "menu = Lihat Commands\nrole = Tengok Roles Yang Online\nhelm = Pakai Helmet\nmask = Pakai Mask\npm = Mesej Orang\nblockpm = Block Mesej Orang\nsendlocation = Send Location Ke Orang\niklan = Buat Iklan\nme = Chat All\n/fb = Facebook Chat\nbayar = Bayar Orang Duit\n/changemode = Tukar Gamemode", "Tutup", "");
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pPpr] >= 1)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Goodside Role Commands", "setppr = invite player masuk role ppr\njail = jail penjahat\nunjail - unjail penjahat\ncuff = cuff penjahat\nuncuff = uncuff penjahat\ntazer = Taze player", "Tutup", "");
					}
					else if(PlayerInfo[playerid][pPjp] >= 1)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Goodside Role Commands", "setpjp = Invite Player Masuk Role PJP\nsaman = Saman Player\ntazer = Taze Player\ncuff = Cuff Penjahat\nuncuff = Uncuff Penjahat", "Tutup", "");
					}
					else if(PlayerInfo[playerid][pMpr] >= 1)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Goodside Role Commands", "setmpr = Invite Player Mausk Role MPR\nheal = Heal Player", "Tutup", "");
					}
					else
					{
						SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Kau Bukan Goodside!");
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pKapak] >= 1)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Badside Role Commands", "setbf = Invite Player Masuk Role Kapak", "Tutup", "");
					}
					else if(PlayerInfo[playerid][pBlackShark] >= 2)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Badside Role Commands", "setbs = Invite Player Masuk Role Black Shark", "Tutup", "");
					}
					else if(PlayerInfo[playerid][pKing302] >= 1)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Badside Role Commands", "setking = Invite Player Masuk Role King 302", "Tutup", "");
					}
					else if(PlayerInfo[playerid][pTodak97] >= 1)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Badside Role Commands", "settodak = Invite Player Masuk Role Todak", "Tutup", "");
					}
					else if(PlayerInfo[playerid][pTenjikuGeng] >= 1)
					{
						ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, "Badside Role Commands", "settenjikugeng = Invite Player Masuk Role Tenjiku", "Tutup", "");
					}
					else
					{
						SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Kau Bukan Badside!");
					}
				}
			}
		}
		case DUTY_PPR:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pPpr] >= 1)
					{
						SetPlayerSkin(playerid, 284);
						GivePlayerWeapon(playerid, 334, 500);
						GivePlayerWeapon(playerid, 348, 500);
						SetPlayerColor(playerid, COLOR_DBLUE);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pPpr] >= 2)
					{
						SetPlayerSkin(playerid, 280);
						GivePlayerWeapon(playerid, 334, 500);
						GivePlayerWeapon(playerid, 349, 500);
						SetPlayerColor(playerid, COLOR_DBLUE);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pPpr] >= 3)
					{
						SetPlayerSkin(playerid, 281);
						GivePlayerWeapon(playerid, 352, 500);
						GivePlayerWeapon(playerid, 334, 500);
						GivePlayerWeapon(playerid, 349, 500);
						SetPlayerColor(playerid, COLOR_DBLUE);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pPpr] >= 4)
					{
						SetPlayerSkin(playerid, 282);
						GivePlayerWeapon(playerid, 334, 500);
						GivePlayerWeapon(playerid, 349, 500);
						GivePlayerWeapon(playerid, 356, 500);
						SetPlayerColor(playerid, COLOR_DBLUE);
					}
				}
				if(listitem == 4)
				{
					if(PlayerInfo[playerid][pPpr] >= 5)
					{
						SetPlayerSkin(playerid, 285);
						GivePlayerWeapon(playerid, 334, 500);
						GivePlayerWeapon(playerid, 356, 500);
						GivePlayerWeapon(playerid, 353, 500);
						GivePlayerWeapon(playerid, 347, 500);
						SetPlayerColor(playerid, COLOR_DBLUE);
					}
				}
				if(listitem == 5)
				{
					if(PlayerInfo[playerid][pPpr] >= 6)
					{
						SetPlayerSkin(playerid, 288);
						GivePlayerWeapon(playerid, 334, 500);
						GivePlayerWeapon(playerid, 356, 500);
						GivePlayerWeapon(playerid, 353, 500);
						GivePlayerWeapon(playerid, 351, 500);
						SetPlayerColor(playerid, COLOR_DBLUE);
					}
				}
				if(listitem == 6)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_PJP:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pPjp] >= 1)
					{
						SetPlayerSkin(playerid, 280);
						GivePlayerWeapon(playerid, 23, 500);
						SetPlayerColor(playerid, COLOR_PJP);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pPjp] >= 2)
					{
						SetPlayerSkin(playerid, 267);
						GivePlayerWeapon(playerid, 24, 500);
						SetPlayerColor(playerid, COLOR_PJP);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pPjp] >= 3)
					{
						SetPlayerSkin(playerid, 266);
						GivePlayerWeapon(playerid, 26, 500);
						SetPlayerColor(playerid, COLOR_PJP);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pPjp] >= 4)
					{
						SetPlayerSkin(playerid, 282);
						GivePlayerWeapon(playerid, 27, 500);
						SetPlayerColor(playerid, COLOR_PJP);
					}
				}
				if(listitem == 4)
				{
					if(PlayerInfo[playerid][pPjp] >= 5)
					{
						SetPlayerSkin(playerid, 288);
						GivePlayerWeapon(playerid, 29, 500);
						SetPlayerColor(playerid, COLOR_PJP);
					}
				}
				if(listitem == 5)
				{
					if(PlayerInfo[playerid][pPjp] >= 6)
					{
						SetPlayerSkin(playerid, 283);
						GivePlayerWeapon(playerid, 30, 500);
						SetPlayerColor(playerid, COLOR_PJP);
					}
				}
				if(listitem == 6)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_MPR:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pMpr] >= 1)
					{
						SetPlayerSkin(playerid, 71);
						SetPlayerColor(playerid, COLOR_MPR);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pMpr] >= 2)
					{
						SetPlayerSkin(playerid, 71);
						SetPlayerColor(playerid, COLOR_MPR);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pMpr] >= 3)
					{
						SetPlayerSkin(playerid, 70);
						SetPlayerColor(playerid, COLOR_MPR);
					}
				}
				if(listitem == 3)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_VEHICLEDEALER:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pVEH] >= 1)
					{
						SetPlayerSkin(playerid, 20);
						SetPlayerColor(playerid, COLOR_VEHICLE);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pVEH] >= 2)
					{
						SetPlayerSkin(playerid, 187);
						SetPlayerColor(playerid, COLOR_VEHICLE);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pVEH] >= 3)
					{
						SetPlayerSkin(playerid, 295);
						SetPlayerColor(playerid, COLOR_VEHICLE);
					}
				}
				if(listitem == 3)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_Kapak:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pKapak] >= 1)
					{
						SetPlayerSkin(playerid, 46);
						GivePlayerWeapon(playerid, 7, 500);
						SetPlayerColor(playerid, COLOR_KAPAK);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pKapak] >= 2)
					{
						SetPlayerSkin(playerid, 126);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 8, 500);
						SetPlayerColor(playerid, COLOR_KAPAK);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pKapak] >= 3)
					{
						SetPlayerSkin(playerid, 123);
						GivePlayerWeapon(playerid, 22, 500);
						GivePlayerWeapon(playerid, 30, 500);
						GivePlayerWeapon(playerid, 25, 500);
						SetPlayerColor(playerid, COLOR_KAPAK);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pKapak] >= 4)
					{
						SetPlayerSkin(playerid, 59);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 31, 500);
						GivePlayerWeapon(playerid, 8, 500);
						GivePlayerWeapon(playerid, 25, 500);
						SetPlayerColor(playerid, COLOR_KAPAK);
					}
				}
				if(listitem == 4)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_TENJIKUGENG:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pTenjikuGeng] >= 1)
					{
						SetPlayerSkin(playerid, 173);
						GivePlayerWeapon(playerid, 4, 500);
						SetPlayerColor(playerid, COLOR_TenjikuGeng);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pTenjikuGeng] >= 2)
					{
						SetPlayerSkin(playerid, 174);
						GivePlayerWeapon(playerid, 4, 500);
						GivePlayerWeapon(playerid, 24, 500);
						SetPlayerColor(playerid, COLOR_TenjikuGeng);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pTenjikuGeng] >= 3)
					{
						SetPlayerSkin(playerid, 175);
						GivePlayerWeapon(playerid, 4, 500);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 27, 500);
						SetPlayerColor(playerid, COLOR_TenjikuGeng);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pTenjikuGeng] >= 4)
					{
						SetPlayerSkin(playerid, 113);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 27, 500);
						GivePlayerWeapon(playerid, 31, 500);
						SetPlayerColor(playerid, COLOR_TenjikuGeng);
					}
				}
				if(listitem == 4)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_BLACKSHARK:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pBlackShark] >= 1)
					{
						SetPlayerSkin(playerid, 33);
						GivePlayerWeapon(playerid, 335, 500);
						GivePlayerWeapon(playerid, 347, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pBlackShark] >= 2)
					{
						SetPlayerSkin(playerid, 33);
						GivePlayerWeapon(playerid, 335, 500);
						GivePlayerWeapon(playerid, 347, 500);
						GivePlayerWeapon(playerid, 353, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pBlackShark] >= 3)
					{
						SetPlayerSkin(playerid, 117);
						GivePlayerWeapon(playerid, 335, 500);
						GivePlayerWeapon(playerid, 347, 500);
						GivePlayerWeapon(playerid, 355, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pBlackShark] >= 4)
					{
						SetPlayerSkin(playerid, 165);
						GivePlayerWeapon(playerid, 335, 500);
						GivePlayerWeapon(playerid, 347, 500);
						GivePlayerWeapon(playerid, 335, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 4)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_KING302:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pKing302] >= 1)
					{
						SetPlayerSkin(playerid, 124);
						GivePlayerWeapon(playerid, 5, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pKing302] >= 2)
					{
						SetPlayerSkin(playerid, 125);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 2, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pKing302] >= 3)
					{
						SetPlayerSkin(playerid, 164);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 30, 500);
						GivePlayerWeapon(playerid, 4, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pKing302] >= 4)
					{
						SetPlayerSkin(playerid, 113);
						GivePlayerWeapon(playerid, 24, 500);
						GivePlayerWeapon(playerid, 30, 500);
						GivePlayerWeapon(playerid, 8, 500);
						SetPlayerColor(playerid, COLOR_BLACKSHARK);
					}
				}
				if(listitem == 4)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case DUTY_TODAK97:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pTodak97] >= 1)
					{
						SetPlayerSkin(playerid, 292);
						GivePlayerWeapon(playerid, 4, 500);
						GivePlayerWeapon(playerid, 24, 500);
						SetPlayerColor(playerid, COLOR_TODAK);
					}
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pTodak97] >= 2)
					{
						SetPlayerSkin(playerid, 122);
						GivePlayerWeapon(playerid, 23, 500);
						GivePlayerWeapon(playerid, 8, 500);
						GivePlayerWeapon(playerid, 28, 500);
						SetPlayerColor(playerid, COLOR_TODAK);
					}
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pTodak97] >= 3)
					{
						SetPlayerSkin(playerid, 294);
						GivePlayerWeapon(playerid, 30, 500);
						GivePlayerWeapon(playerid, 31, 500);
						GivePlayerWeapon(playerid, 8, 500);
						SetPlayerColor(playerid, COLOR_TODAK);
					}
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pTodak97] >= 4)
					{
						SetPlayerSkin(playerid, 120);
						GivePlayerWeapon(playerid, 30, 500);
						GivePlayerWeapon(playerid, 31, 500);
						GivePlayerWeapon(playerid, 29, 500);
						GivePlayerWeapon(playerid, 8, 500);
						SetPlayerColor(playerid, COLOR_TODAK);
					}
				}
				if(listitem == 4)
				{
					ResetPlayerWeapons(playerid);
					SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
					SetPlayerColor(playerid, COLOR_WHITE);
				}
			}
		}
		case CREATEVOTE:
		{
	    	if(response)
	    	{
	        	format(string, sizeof(string), "{00FFFF}NEW VOTE: {FFFFFF}%s", inputtext);
            	SendClientMessageToAll(-1, string);
            	SendClientMessageToAll(-1, "UNTUK VOTE{FFFF00}/setuju {FFFFFF}ATAU {FF0000}/taksetuju");
            	VoteData[voteExists] = true;
			}
		}
		case DIALOG_WEAPON:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pKantana] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 8, 1);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Kantana!");
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pSilenced] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 23, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Silenced Pistol!");
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pDesert] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 24, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Desert Eagle!");
				}
				if(listitem == 3)
				{
					if(PlayerInfo[playerid][pShotgun] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 25, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Shotgun!");
				}
				if(listitem == 4)
				{
					if(PlayerInfo[playerid][pUzi] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 28, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Micro Uzi!");
				}
				if(listitem == 5)
				{
					if(PlayerInfo[playerid][pMp5] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 29, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Mp5!");
				}
				if(listitem == 6)
				{
					if(PlayerInfo[playerid][pAk47] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 30, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Ak-47!");
				}
				if(listitem == 7)
				{
					if(PlayerInfo[playerid][pM4] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 31, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon M4!");
				}
				if(listitem == 8)
				{
					if(PlayerInfo[playerid][pSniper] == 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Weapon Ini!");
					GivePlayerWeapon(playerid, 34, 500);
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Spawn Weapon Sniper!");
				}
			}
		}
		case DIALOG_MAP:
		{
			if(response)
			{
				if(listitem == 0)
				{
					SetPlayerCheckpoint(playerid, 1169.9183, -1489.9886, 22.7559, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Spawn Rakyat");
				}
				if(listitem == 1)
				{
					SetPlayerCheckpoint(playerid, 1538.5210, -1674.9945, 13.5469, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Balai Polis Penang Roleplay");
				}
				if(listitem == 2)
				{
					SetPlayerCheckpoint(playerid, 1655.7126, -1669.9480, 21.4375, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Balai Pengangkutan Jalanraya Penang");
				}
				if(listitem == 3)
				{
					SetPlayerCheckpoint(playerid, 1189.1656, -1326.0255, 13.5674, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Hospital");
				}
				if(listitem == 4)
				{
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Takkan LV Pun Tak Tahu?");
				}
				if(listitem == 5)
				{
					SetPlayerCheckpoint(playerid, 1547.0375, 2771.8433, 10.7884, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Base Kapak");
				}
				if(listitem == 6)
				{
					SetPlayerCheckpoint(playerid, 2360.4336, 2403.2490, 10.8203, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Base Black Shark");
				}
				if(listitem == 7)
				{
					SetPlayerCheckpoint(playerid, 1566.1134,814.5935,12.8546, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Base King302");
				}
				if(listitem == 8)
				{
					SetPlayerCheckpoint(playerid, 2507.1301, 1820.8181, 10.8320, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Base Todak97");
				}
				if(listitem == 9)
				{
					SetPlayerCheckpoint(playerid, 2507.1301, 1820.8181, 10.8320, 10);
					SendClientMessage(playerid, COLOR_GREEN, "[GPS]"COL_WHITE"Destinasi : Base Tenjiku Geng");
				}
			}
		}
		case KEDAI_IKAN:
		{
			if(response)
			{
				if(listitem == 0)
				{
					SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"Anda Telah Membeli Joran!");
					PlayerInfo[playerid][pJoran] = 1;
				}
				if(listitem == 1)
				{
					ShowPlayerDialog(playerid, JUAL_IKAN, DIALOG_STYLE_LIST, "Jual Ikan", "Ikan Bawal\nIkan Patin\nIkan Siakap", "Pilih", "Tutup");
				}
			}
		}
		case JUAL_IKAN:
		{
			if(response)
			{
				if(listitem == 0)
				{
					if(PlayerInfo[playerid][pIkanBawal] >= 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Ikan Ini!");
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "[IKAN]"COL_WHITE"Anda Telah Menjual Seekor Ikan!");
					GivePlayerMoney(playerid, 1000);
					PlayerInfo[playerid][pIkanBawal] -= 1;
				}
				if(listitem == 1)
				{
					if(PlayerInfo[playerid][pIkanPatin] >= 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Ikan Ini!");
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "[IKAN]"COL_WHITE"Anda Telah Menjual Seekor Ikan!");
					GivePlayerMoney(playerid, 1300);
					PlayerInfo[playerid][pIkanPatin] -= 1;
				}
				if(listitem == 2)
				{
					if(PlayerInfo[playerid][pIkanSiakap] >= 1) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Anda Tidak Mempunyai Ikan Ini!");
					SendClientMessage(playerid, COLOR_LIGHTBLUE, "[IKAN]"COL_WHITE"Anda Telah Menjual Seekor Ikan!");
					GivePlayerMoney(playerid, 1500);
					PlayerInfo[playerid][pIkanSiakap] -= 1;
				}
			}
		}
		case ADMIN_CHANGEMODE:
		{
			if(response)
			{
				if(listitem == 0)
				{

				}
				if(listitem == 1)
				{
					SetPlayerPos(playerid, -2522.2556, -608.4470, 132.5625);
					SetTimerEx("RacingPosTimer", 1500, false, "i", playerid);
				}
			}
		}
		case CHANGE_MODE:
		{
			if(response)
			{
				if(listitem == 0)
				{
					SendClientMessage(playerid, COLOR_RED, "OTW!");
				}
				if(listitem == 1)
				{
					ResetPlayerWeapons(playerid);
					GivePlayerWeapon(playerid, 46, 1);
					SetPlayerPos(playerid, 1138.3563,-1479.6339,776.9621);
					SetPlayerInterior(playerid, 0);
				}
				if(listitem == 2)
				{
					SendClientMessage(playerid, COLOR_RED, "OTW!");
				}
				if(listitem == 3)
				{
					SendClientMessage(playerid, COLOR_RED, "OTW!");
				}
			}
		}
	}
    return 1;
}

hook OnPlayerUpdate( playerid )
{
    static s_iVehicle ;
       
    if (VehicleSpeed[playerid] != 0.0 && GetPlayerState(playerid) == PLAYER_STATE_DRIVER)
    {
        s_iVehicle = GetPlayerVehicleID(playerid);
        if (s_iVehicle)
        {
            static
            Float:s_fX,
            Float:s_fY,
            Float:s_fZ,
            Float:s_fVX,
            Float:s_fVY,
            Float:s_fVZ
            ;      
            GetVehiclePos(s_iVehicle, s_fX, s_fY, s_fZ);
            GetVehicleVelocity(s_iVehicle, s_fVX, s_fVY, s_fVZ);
                       
            if (!IsPlayerInRangeOfPoint(playerid, VehicleSpeed[playerid] + 0.05, s_fX + s_fVX, s_fY + s_fVY, s_fZ + s_fVZ))
            {
                static Float:s_fLength;              
                s_fLength = floatsqroot( ( s_fVX * s_fVX ) + ( s_fVY * s_fVY ) + ( s_fVZ * s_fVZ ) );              
                s_fVX = ( s_fVX / s_fLength ) * VehicleSpeed[ playerid ];
                s_fVY = ( s_fVY / s_fLength ) * VehicleSpeed[ playerid ];
                s_fVZ = ( s_fVZ / s_fLength ) * VehicleSpeed[ playerid ];
                               
                if (s_iVehicle)
                SetVehicleVelocity(s_iVehicle, s_fVX, s_fVY, s_fVZ);
                else
                SetPlayerVelocity(playerid, s_fVX, s_fVY, s_fVZ);
            }
        }
    }   
    return 1;
}

public SetPlayerSpeedCap( playerid, Float:value )
{
    if ( 0 <= playerid < sizeof( VehicleSpeed ) )
    VehicleSpeed[ playerid ] = value;
}
 
public DisablePlayerSpeedCap( playerid )
{
    if ( 0 <= playerid < sizeof( VehicleSpeed ) )
    VehicleSpeed[ playerid ] = 0.0;
}

public OnPlayerClickPlayer(playerid, clickedplayerid, source)
{
	return 1;
}

forward Delay_Kick(playerid);
public Delay_Kick(playerid)
{
    Kick(playerid);
    return 1;
}

//=========== COMMANDS STARTED =================================================

//BASIC COMMANDS
CMD:gay(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {F6A000}telah menjadi budak paling gay dalam server", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
}

CMD:comel(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {F6A000}telah menjadi budak paling comel dalam server", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
}

CMD:hensem(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {F6A000}telah menjadi budak paling hensem dalam server", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
}

CMD:ty(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:THANK YOU", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}
	
CMD:aslm(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:Assalamualaikum", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}
	
CMD:wslm(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:Waalaikumussalam", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}
	
CMD:wbd(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:WELCOME BACK {FF0000}DEVELOPER !", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}
	
CMD:wba(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:WELCOME BACK {00FFFF}ADMIN !", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}
	
CMD:wbs(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:WELCOME BACK {3FFF4C} STAFF !", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}

CMD:wbb(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:WELCOME BACK BABY !", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}

CMD:wb(playerid,params[])
{
	new name[MAX_PLAYERS];
    new stringa[256];
	GetPlayerName(playerid, name, sizeof(name));
    format(stringa, sizeof(stringa), "{FFFFFF}%s {2865CF}:WELCOME BACK !", name);
    SendClientMessageToAll(0xFAFFFFFF,stringa);
	return 1;
	}



//ADMIN COMMANDS
CMD:amenu(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
    	ShowPlayerDialog(playerid, AMENU, DIALOG_STYLE_LIST, ""COL_WHITE"Admin Command", ""COL_WHITE"STAFF\nADMIN\nASSISTANCE DEV\nDEVELOPER\nCO OWNER\nOWNER", "Pilih", "Tutup");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:ra(playerid, params[])
{
	new text[300];
	new ctext[400];
	new string[500];
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
        if(sscanf(params, "s[300]", text)) return SendClientMessage(playerid, 0x46E850FF, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /ra [text]");
        if(PlayerInfo[playerid][pAdmin] == 1){ ctext = "STAFF"; }
		if(PlayerInfo[playerid][pAdmin] == 2){ ctext = "ADMIN"; }
		if(PlayerInfo[playerid][pAdmin] == 3){ ctext = "ASSISTANCE DEV"; }
		if(PlayerInfo[playerid][pAdmin] == 4){ ctext = "DEVELOPER"; }
		if(PlayerInfo[playerid][pAdmin] == 5){ ctext = "CO OWNER";}
		if(PlayerInfo[playerid][pAdmin] == 6){ ctext = "OWNER";}
		format(string, sizeof(string), ""COL_RED"[%s]"COL_WHITE"%s: %s", ctext, GetName(playerid), text);
		if(PlayerInfo[playerid][pAdmin] > 0)
		{
			SendAdminMessage(COLOR_DEV, string);
		}
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:gotoc(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
    	SetPlayerPos(playerid,1480.3267,-1739.9960,13.5469);
        SetPlayerInterior(playerid,0);
        SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Teleport Ke City Hall");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:sp(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 3)
    {
		new specplayerid;
		if(sscanf(params,"u", specplayerid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /spec [playerid]");
		{
			TogglePlayerSpectating(playerid, 1);
			PlayerSpectatePlayer(playerid, specplayerid);
			SetPlayerInterior(playerid,GetPlayerInterior(specplayerid));
			gSpectateID[playerid] = specplayerid;
			gSpectateType[playerid] = ADMIN_SPEC_TYPE_PLAYER;
		}
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:spoff(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 3)
    {
		TogglePlayerSpectating(playerid, 0);
	    gSpectateID[playerid] = INVALID_PLAYER_ID;
	    gSpectateType[playerid] = ADMIN_SPEC_TYPE_NONE;
        SetPlayerPos(playerid,1480.3267,-1739.9960,13.5469);
        SetPlayerInterior(playerid,0);
	    SendClientMessage(playerid, -1, ""COL_DC"[BOT]:"COL_WHITE" Spectating Off");
	}
    else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
    return 1;
}

CMD:adminchangemode(playerid, parmas[])
{
	if(PlayerInfo[playerid][pAdmin] >= 2)
	{
		ShowPlayerDialog(playerid, ADMIN_CHANGEMODE, DIALOG_STYLE_LIST, "Change Mode", "Global War\nRacing", "Pilih", "Batal");
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:setcuaca(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 2)
    {
		new amount, string[128];
	    if(sscanf(params,"i", amount)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setcuaca [weather id]");
	    SetWeather(amount);
	    format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Admin %s Telah Menukar Cuaca", GetName(playerid));
		SendClientMessageToAll(-1, string);
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:setwaktu(playerid,params[])
{
   for(new i = 0; i < MAX_PLAYERS; i++)
   {
        new id, string[128];
	    if(sscanf(params,"i", id)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setwaktu [0-23]");
	    if(id < 0 || id > 23) return SendClientMessage(playerid, COLOR_WHITE, "Oi Bodo Tak Wujud Pukul Tu (0-23).");
        if (PlayerInfo[playerid][pAdmin] >= 2)
        if(IsPlayerConnected(i))
        {
        PlayerPlaySound(i, 1057, 0.0, 0.0, 0.0);
	    SetPlayerTime(i, id, 0);
        format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE"Admin %s Telah Set Waktu Kepada %d", GetName(playerid), id);
	    SendClientMessageToAll(-1, string);
        }
        }
   return 1;
}

CMD:setarmor(playerid, params[])
{
    new string[128], playa, armour;
    if(sscanf(params, "ud", playa, armour))
	{
        SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setarmor [playerid] [armor]");
        return 1;
    }
    if(PlayerInfo[playa][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Anda tidak dapat set armor admin level lebih tinggi daripada anda");
    if (PlayerInfo[playerid][pAdmin] >= 6)
	{
        if(IsPlayerConnected(playa))
		{
            if(playa!= INVALID_PLAYER_ID)
			{
                SetPlayerArmour(playa, armour);
                format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Anda telah set armor %s kepada %d.", GetName(playa), armour);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" %s telah set armor anda kepada %d.", GetName(playerid), armour);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            }
        }
    }
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
    return 1;
}

CMD:setadmin(playerid, params[])
{
    new targetid, amount;
	if(PlayerInfo[playerid][pAdmin] < 5 && !IsPlayerAdmin(playerid)) return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	else if (sscanf(params, "ud", targetid, amount)) return SendClientMessage(playerid, -1,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setadmin [playerid] [level]");
	else if(targetid == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_GRAD2,""COL_DC"[ERROR]:"COL_WHITE" Pemain itu tidak online");
	else
	{
		new string[500];
	    format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Anda Telah Memberikan Role Admin Level %d Kepada %s", amount, GetName(targetid));
	    SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
	    format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Owner %s Telah Memberikan Anda Role Admin Level %d",GetName(playerid), amount);
	    SendClientMessage(targetid, COLOR_LIGHTBLUE, string);
	    PlayerInfo[targetid][pAdmin] = amount;
		new INI:File = INI_Open(UserPath(playerid));
		INI_WriteInt(File,"Admin",PlayerInfo[targetid][pAdmin]);
		INI_Close(File);
    }
    return 1;
}

CMD:kick(playerid,params[])
{

    new id,name1[MAX_PLAYER_NAME], reason[35], string[128], logstring[256];
    if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_GRAD2,NOPERMS);
    else if(sscanf(params,"uz",id,reason)) return SendClientMessage(playerid, COLOR_WHITE,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /kick [playerid] [sebab]");
    else if(!IsPlayerConnected(id)) return SendClientMessage(playerid, COLOR_COLOR_GREY,""COL_DC"[ERROR]:"COL_WHITE" Pemain itu tidak online");
    else if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Level anda belum cukup tinggi untuk menggunakan command ini");
    else
    {
        new year, month, day;
		getdate(year, month, day);
	    GetPlayerName(id,name1,sizeof(name1));
	    format(string, sizeof(string),""COL_DC"[BOT]:"COL_WHITE" %s telah ditendang keluar oleh admin %s, kerana: "COL_RED"%s",name1, GetName(playerid), reason);
	    SendClientMessageToAll(COLOR_LIGHTRED,string);
	    Kick(id);
   		format(logstring, sizeof(logstring), "[ADMIN]: %s telah ditendang keluar oleh admin %s, kerana: %s (%d-%d-%d).", name1, GetName(playerid), reason, month, day, year);
		KickLog(logstring);
    }
    return 1;
}

CMD:slap(playerid,params[],help)
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    new Float:x,Float:y,Float:z;
	    new id;
	    new reason[80];
	    if(sscanf(params,"uz",id,reason)) return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /slap [playerid] [sebab]");
	    if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid,COLOR_RED,""COL_DC"[BOT]:"COL_WHITE" Pemain itu tidak online");
	    {
			new string[300];
            format(string, sizeof(string),""COL_DC"[BOT]:"COL_WHITE" %s telah ditampar oleh %s sehingga ke istana ayah pink sebab "COL_RED"%s",GetName(id), GetName(playerid), reason);
	        SendClientMessageToAll(COLOR_LIGHTRED,string);
			PlayerPlaySound(id,1190,0.0,0.0,0.0);
			GetPlayerPos(id,x,y,z);
			SetPlayerPos(id,x,y,z+500);
		}
	}
	else return SendClientMessage(playerid, COLOR_RED, NOPERMS);
	return 1;
}

CMD:ann(playerid,params[],help)
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    new text[64],string[128];
		if(sscanf(params,"s[64]",text)) return SendClientMessage(playerid,COLOR_RED,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /ann [text]");
		format(string,sizeof(string),"~y~PERHATIAN~n~~w~%s",text);
		GameTextForAll(string,5000,3);
		PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
	}
	else SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:cc(playerid,params[],help)
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    for(new i = 0; i < 250; i++) SendClientMessageToAll(0x00000000," ");
	}
	else return SendClientMessage(playerid, COLOR_RED, NOPERMS);
	return 1;
}

CMD:ban(playerid, params[])
{

	new id, reason[35], name2[MAX_PLAYER_NAME], name1[MAX_PLAYER_NAME], string[128];
	if(PlayerInfo[playerid][pAdmin] < 2) return SendClientMessage(playerid, COLOR_GRAD2,NOPERMS);
	if(sscanf(params,"uz", id, reason)) return SendClientMessage(playerid, COLOR_WHITE,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /ban [playerid] [sebab]");
	if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, COLOR_COLOR_GREY,""COL_DC"[ERROR]:"COL_WHITE" Pemain itu tidak online");
	else
	{
		if(PlayerInfo[id][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Level anda belum cukup tinggi untuk menggunakan command ini");
		new year, month, day;
		new logstring[256];
		getdate(year, month, day);
		GetPlayerName(id, name2, sizeof(name2));
		GetPlayerName(playerid, name1, sizeof(name1));
 		format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" %s Telah DI Ban Oleh Administor %s, Kerana: %s", name2, GetName(playerid), reason);
 		format(logstring, sizeof(logstring), "[BOT]: %s Telah Ditendang Keluar Oleh %s, Kerana: %s (%d-%d-%d).", name2, GetName(playerid), reason, month, day, year);
		BanLog(logstring);
 		SendClientMessageToAll(COLOR_LIGHTRED, string);
	 	new plrIP[16];
	 	GetPlayerIp(id,plrIP, sizeof(plrIP));
	  	SendClientMessage(id,COLOR_YELLOW,"|___________[BAN INFO]___________|");
	  	format(string, sizeof(string), "Nama anda: %s.",name2);
	  	SendClientMessage(id, COLOR_WHITE, string);
	  	format(string, sizeof(string), "IP: %s.",plrIP);
	  	SendClientMessage(id, COLOR_WHITE, string);
	  	format(string, sizeof(string), "Nama Yang Ban Anda: %s.",name1);
	  	SendClientMessage(id, COLOR_WHITE, string);
	  	format(string, sizeof(string), "Sebab: %s.",reason);
	  	SendClientMessage(id, COLOR_WHITE, string);
	  	SendClientMessage(id,COLOR_YELLOW,"|___________[BAN INFO]___________|");
	  	format(string,sizeof(string),""COL_DC"[BOT]:"COL_WHITE" Sila Screenshot Dan Hantar Kepada Pihak Developer Untuk Membuat Rayuan Unban",GetName(playerid));
  		SendClientMessage(playerid, COLOR_YELLOW,string);
		Ban(id);
	}
	return 1;
}

CMD:jetpack(playerid)
{
   	if(PlayerInfo[playerid][pAdmin] >= 4)
	{
	    GivePlayerWeapon(playerid,21,1);
	    SetPlayerSpecialAction(playerid, SPECIAL_ACTION_USEJETPACK);
	    SendClientMessage(playerid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Mengambil Jetpack");
	}
	if(PlayerInfo[playerid][pAdmin] == 0)
	{
	    SendClientMessage(playerid,-1,""COL_DC"[ERROR]:"COL_WHITE" Maaf, Command Ini Khas Untuk Admin Sahaja");
	}
	return 1;
}

CMD:carry(playerid)
{
	SetPlayerSpecialAction(playerid, SPECIAL_ACTION_CARRY);
	return 1;
}

CMD:aduty(playerid)
{
	if(PlayerInfo[playerid][pAdmin] >= 1 && adminduty[playerid] == 0)
	{
	    GivePlayerWeapon(playerid,4,1);
	    GivePlayerWeapon(playerid,22,99999);
	    GivePlayerWeapon(playerid,29,99999);
	    GivePlayerWeapon(playerid,38,99999);
	    GivePlayerWeapon(playerid,34,99999);
	    SetPlayerColor(playerid, COLOR_RED);
	    adminduty[playerid] = 1;
	}
	else if(PlayerInfo[playerid][pAdmin] >=1 && adminduty[playerid] == 1)
	{
		ResetPlayerWeapons(playerid);
		SetPlayerColor(playerid, COLOR_WHITE);
		adminduty[playerid] = 0;
	}
	if(PlayerInfo[playerid][pAdmin] == 0)
	{
	    SendClientMessage(playerid,-1,""COL_DC"[ERROR]:"COL_WHITE" Maaf, Command Ini Khas Untuk Admin Sahaja");
	}
	return 1;
}

CMD:goto(playerid, params[])
{
    new ID;
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    if(sscanf(params, "u", ID)) SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /goto [playerid]");
	    else if(!IsPlayerConnected(ID)) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Pemain itu tidak online");
		else if(playerid == ID) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Anda tidak boleh teleport kepada diri sendiri");
		else
	    {
	        new pinterior = GetPlayerInterior(ID);
		    new Float:x, Float:y, Float:z;
		    GetPlayerPos(ID, x, y, z);
		    SetPlayerPos(playerid, x+1, y+1, z);
			SetPlayerInterior(playerid, pinterior);
		}
    }
    else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
    return 1;
}

CMD:givegun(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 5)
    {
        new target, gun, string[128];
        if(sscanf(params, "ud", target, gun))
        {
            SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /givegun [playerid] [weaponid]");
            return 1;
        }
        if(gun < 1 || gun > 46) { SendClientMessage(playerid, COLOR_COLOR_GREY, ""COL_DC"[ERROR]:"COL_WHITE" Jangan kurang daripada 1 atau lebih daripada 47"); return 1; }
        if(IsPlayerConnected(target))
        {
            if(target!= INVALID_PLAYER_ID)
            {
				if(gun == 21)
				{
					SetPlayerSpecialAction(target, SPECIAL_ACTION_USEJETPACK);
				}
                GivePlayerWeapon(target, gun, 999999);
                format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Anda telah memberi senjata %d kepada %s!", gun, GetName(target));
                SendClientMessage(playerid, COLOR_GRAD1, string);
                format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Admin %s telah memberi anda senjata %d ",GetName(playerid),gun);
                SendClientMessage(playerid, COLOR_GRAD1, string);
            }
        }
    }
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
    return 1;
}

CMD:gotoint(playerid, params[])
{
	new Interior, Float: X, Float: Y, Float: Z;
	if( sscanf( params, "dfff", Interior, X, Y, Z ) )
	{
	    if (PlayerInfo[playerid][pAdmin] >= 5)
	    {
			SendClientMessage( playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE" /gotoint [Interior ID] [x point] [y point] [z point]" );
		}
	}
	else
	{
		if (PlayerInfo[playerid][pAdmin] >= 4)
		{
		    SetPlayerPos( playerid, X, Y, Z );
		    SetPlayerInterior( playerid, Interior );
		    SendClientMessage( playerid, COLOR_GRAD2, ""COL_DC"[BOT]:"COL_WHITE" Anda Telah Teleport Ketempat Yang Anda Mahukan");
		}
	}
	return 1;
}

CMD:rac(playerid, params[])
{
    new string[128];
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		format(string, sizeof(string),""COL_DC"[BOT]:"COL_WHITE" Admin %s telah respawn semua kenderaan", GetName(playerid));
	    SendClientMessageToAll(COLOR_GRAD2,string);
	    for(new i = 1; i <= MAX_VEHICLES; i++)
		{
			SetVehicleToRespawn(i);
		}
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}
CMD:dac(playerid, params[])
{
    new string[128];
	if(PlayerInfo[playerid][pAdmin] >= 3)
	{
		format(string, sizeof(string),""COL_DC"[BOT]:"COL_WHITE" Admin %s telah buang semua kenderaan", GetName(playerid));
	    SendClientMessageToAll(COLOR_GRAD2,string);
	    for(new i = 1; i <= MAX_VEHICLES; i++)
		{
			DestroyVehicle(i);
		}
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}
CMD:delveh(playerid, params[])
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerInfo[playerid][pAdmin] < 2)
		{
            SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
            return 1;
        }
        if(IsPlayerInAnyVehicle(playerid))
		{
            DestroyVehicle(GetPlayerVehicleID(playerid));
            SendClientMessage(playerid, COLOR_COLOR_GREY, ""COL_DC"[BOT]:"COL_WHITE" Kenderaan Telah Dibuang");
        }
    }
    return 1;
}
CMD:fixveh(playerid, params[])
{
    if(IsPlayerConnected(playerid))
	{
        if(PlayerInfo[playerid][pAdmin] == 0)
		{
            SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
            return 1;
        }
        if(PlayerInfo[playerid][pVEH] >= 1)
        if(IsPlayerInAnyVehicle(playerid))
		{
            RepairVehicle(GetPlayerVehicleID(playerid));
            SendClientMessage(playerid, COLOR_COLOR_GREY, ""COL_DC"[BOT]:"COL_WHITE" Kenderaan telah dibaiki");
        }
    }
    return 1;
}

CMD:ajail(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
	    new text[50];
		new targetid;
		new string[300];
       	if(sscanf(params, "uz", targetid, text)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /ajail [playerid] [sebab]");
        SetPlayerPos(targetid,264.37381, 76.99860, 1001.09906);
        SetPlayerInterior(targetid, 6);
        PlayerInfo[targetid][pJail] = 1;
        GameTextForPlayer(targetid,"~r~ANDA TELAH DIJAIL OLEH ADMIN" ,5000, 1);
        format(string, sizeof(string), ""COL_RED"[INFO ADMIN]"COL_WHITE" %s telah memenjarakan %s sebab "COL_RED"%s", GetName(playerid),GetName(targetid),text);
        SendClientMessageToAll(0xE01B1B, string);
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:av(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
        ShowPlayerDialog(playerid, SPAWN, DIALOG_STYLE_LIST, "Spawn Kenderaan", "Kereta \n"COL_WHITE"Motor \n"COL_WHITE"Lori Dan Van \n"COL_WHITE"Tiada Lesen\nKenderaan Kerajaan", "Pilih", "Tutup");
        return 1;
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
}

CMD:setvip(playerid,params[])
{
	new id, level;
   	if(sscanf(params,"ud",id,level) ) return SendClientMessage(playerid,COLOR_RED,"USUAGE: /setvip [id][ level]");
	if(!IsPlayerAdmin(playerid) ) return SendClientMessage(playerid,COLOR_RED,"Anda Bukan RCON Admin!");
    if(level > MAX_VIP) return SendClientMessage(playerid,COLOR_RED,"Invalid Level");
 	if(!IsPlayerConnected(id) ) return SendClientMessage(playerid,COLOR_RED,"Player is not connected");
	 else
	 {
 	new name[MAX_PLAYER_NAME], playername[MAX_PLAYER_NAME];
 	GetPlayerName(playerid,name,sizeof(name));
 	GetPlayerName(id,playername,sizeof(playername));

	new fstring[256], zstring[256];

	format(fstring,sizeof(fstring),"Pihak Admin Bernama %s Telah Menjadikan Anda VIP Level %d",name,level);
 	format(zstring,sizeof(zstring),"Anda Telah Menjadikan %s VIP Level %d",playername,level);

	SendClientMessage(playerid,COLOR_RED,zstring);
 	SendClientMessage(id,COLOR_RED,fstring);
	PlayerInfo[id][pVip] = level;
	 }
  	return 1;
}

CMD:setleader(playerid,params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 5)
	{
		new targetid, roleid, string[900];
		if(sscanf(params,"ui",targetid, roleid)) return SendClientMessage(playerid, -1,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setleader [playerid][Role Id]");
		{
            if(roleid == 1)
            {
                SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Polis Penang Roleplay");
                PlayerInfo[targetid][pPpr] = 6;
                format(string,sizeof(string),":police_officer:  *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Polis Penang Roleplay ```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 2)
            {
                SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Pengangkutan Jalanraya Penang");
                PlayerInfo[targetid][pPjp] = 6;
                format(string,sizeof(string),":police_officer: *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Pengangkutan Jalanraya Penang```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 3)
            {
                SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Medic Penang Roleplay");
                PlayerInfo[targetid][pMpr] = 6;
                format(string,sizeof(string),":hospital: *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Medic Penang Roleplay```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 4)
            {
                SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Kapak");
                PlayerInfo[targetid][pKapak] = 6;
                format(string,sizeof(string),":hotel: *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Kapak```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 5)
            {
                SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Black Shark");
                PlayerInfo[targetid][pBlackShark] = 6;
                format(string,sizeof(string),":shark: *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Black Shark```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 6)
            {
                SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role King 302");
                PlayerInfo[targetid][pKing302] = 6;
                format(string,sizeof(string),":u55b6: *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : King 302```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 7)
            {
                SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Todak97");
                PlayerInfo[targetid][pTodak97] = 6;
                format(string,sizeof(string),":dragon: *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Todak97```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 8)
            {
            	SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Car Dealer");
                PlayerInfo[targetid][pVEH] = 6;
                format(string,sizeof(string),":blue_car:  *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Car Dealer```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
            if(roleid == 9)
            {
            	SendClientMessage(targetid,-1,""COL_DC"[BOT]:"COL_WHITE" Anda Telah Dilantik Menjadi Leader Role Tenjiku Geng");
                PlayerInfo[targetid][pTenjikuGeng] = 6;
                format(string,sizeof(string),":u55b6: *LEADER ROLE*\n```Nama Admin: %s\nNama Diberi Role : %s\n Role : Tenjiku Geng```", GetName(playerid), GetName(targetid));
        		DCC_SendChannelMessage(RoleChannel,string);
            }
        }
	}
	return 1;
}

CMD:aunjail(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		new targetid;
		new string[300];
       	if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /aunjail [playerid]");
       	SetPlayerPos(targetid,1553.1385,-1675.5641,16.1953);
        SetPlayerInterior(targetid,0);
        PlayerInfo[targetid][pJail] = 0;
        GameTextForPlayer(targetid,"~g~JADILAH MANUSIA YANG BERGUNA...",5000,3);

        format(string, sizeof(string), ""COL_RED"[INFO ADMIN]"COL_WHITE" %s telah mengeluarkan %s daripada penjara", GetName(playerid),GetName(targetid));
        SendClientMessageToAll(0xE01B1B, string);
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}


CMD:fixvehall(playerid, params[])
{
	new string[128];
    if(IsPlayerConnected(playerid)) {
        if(PlayerInfo[playerid][pAdmin] < 2)
		{
            SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
            return 1;
        }
		for(new v = 0; v < MAX_VEHICLES; v++) {
            RepairVehicle(v);
        }
		format(string, sizeof(string),""COL_DC"[BOT]:"COL_WHITE" Admin %s telah membaiki semua kenderaan", GetName(playerid));
	    SendClientMessageToAll(COLOR_GRAD2,string);
    }
    return 1;
}

CMD:givemoney(playerid, params[])
{
	if (PlayerInfo[playerid][pAdmin] >= 5)
	{
		new string[128], giveplayerid, money;
		if(sscanf(params, "ud", giveplayerid, money)) return SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /givemoney [playerid] [jumlah]");

		if(IsPlayerConnected(giveplayerid))
		{
			GivePlayerMoney(giveplayerid, money);
			format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Anda telah memberi duit kepada %s sebanyak "COL_GREEN"RM%d.",GetName(giveplayerid),money);
			SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
			format(string, sizeof(string),""COL_DC"[BOT]:"COL_WHITE" Admin %s telah memberi anda duit sebanyak RM%d", GetName(playerid),money);
	    	SendClientMessage(giveplayerid,COLOR_GRAD2,string);
			new ip[32], ipex[32];
   			new i_dateTime[2][3];
			gettime(i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2]);
			getdate(i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2]);
			GetPlayerIp(playerid, ip, sizeof(ip));
			GetPlayerIp(giveplayerid, ipex, sizeof(ipex));
			format(string, sizeof(string), "[%i/%i/%i - %i:%i:%i] %s (IP:%s) Telah Membayar RM%d Kepada %s (IP:%s)", i_dateTime[1][0], i_dateTime[1][1], i_dateTime[1][2], i_dateTime[0][0], i_dateTime[0][1], i_dateTime[0][2], GetName(playerid), ip, money, GetName(giveplayerid), ipex);
			PayLog(string);
			PlayerInfo[playerid][pDuit] += money;
			PlayerInfo[giveplayerid][pDuit] += money;

		}
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
	return 1;
}

CMD:sethp(playerid, params[])
{
    new string[128], playa, armor;
    if(sscanf(params, "ud", playa, armor))
	{
        SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /sethp [playerid] [health]");
        return 1;
    }
    if(PlayerInfo[playa][pAdmin] > PlayerInfo[playerid][pAdmin]) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Anda tidak dapat set nyawa admin level lebih tinggi daripada anda");
    if (PlayerInfo[playerid][pAdmin] >= 6) {
        if(IsPlayerConnected(playa)) {
            if(playa != INVALID_PLAYER_ID)
			{
                SetPlayerHealth(playa, armor);
                format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" Anda telah set nyawa %s kepada %d.", GetName(playa), armor);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
                format(string, sizeof(string), ""COL_DC"[BOT]:"COL_WHITE" %s telah set nyawa anda kepada %d.", GetName(playerid), armor);
                SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            }
        }
        else SendClientMessage(playerid, COLOR_GRAD1, ""COL_DC"[BOT]:"COL_WHITE" Pemain itu tidak online");
    }
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
    return 1;
}

CMD:setskin(playerid, params[])
{
     new name[MAX_PLAYER_NAME], targetname[MAX_PLAYER_NAME], id, skinid, string[128];
     if(PlayerInfo[playerid][pAdmin] < 0) return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
     else if(sscanf(params, "ui", id, skinid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setskin [playerid] [skinid]");
     GetPlayerName(playerid, name, MAX_PLAYER_NAME);
     GetPlayerName(id, targetname, MAX_PLAYER_NAME);
     if(id == INVALID_PLAYER_ID) return SendClientMessage(playerid, -1, ""COL_RED"[BOT]"COL_WHITE" Pemain Itu Tidak Wujud");
     if(skinid < 1 || skinid > 311) { SendClientMessage(playerid, COLOR_COLOR_GREY, ""COL_DC"[ERROR]:"COL_WHITE" Jangan kurang daripada 1 atau lebih daripada 311 [skin 0 tidak diterima"); return 1; }
     else
     {
	     SetPlayerSkin(id, skinid);
	     format(string, 128, ""COL_DC"[BOT]:"COL_WHITE" Admin %s telah set skin anda kepada skin %d.", name, skinid);
	     SendClientMessage(id, COLOR_LIGHTBLUE, string);
	     format(string, 128, ""COL_DC"[BOT]:"COL_WHITE" Anda telah set skin %s kepada skin %d.", targetname, skinid);
	     SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
     }
     PlayerInfo[id][pSkin] = skinid;
     return 1;
}

CMD:healall(playerid,params[])
{
   for(new i = 0; i < MAX_PLAYERS; i++)
   {
        if (PlayerInfo[playerid][pAdmin] >= 2)
        if(IsPlayerConnected(i))
        {
        SetPlayerHealth(i, 120.0);
        SendClientMessage(i, -1,""COL_DC"[BOT] {FFFFFF}Developer/Assistance Dev Telah Heal Semua Pemain");
        }
        }
   return 1;
}

CMD:djadmin(playerid, params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
        if(isnull(params))
        {
            SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" PENGGUNAAN: /djadmin [URL]");
        }
        else
        {
            new string[128], name[24];
            GetPlayerName(playerid,name,24);
            format(string,sizeof(string),""COL_LGREEN"[SPOTIFY]"COL_WHITE" %s Telah Memainkan Lagu Untuk Semua!",name);
            SendClientMessageToAll(-1,string);
            for(new i;i<MAX_PLAYERS;i++)
            {
                PlayAudioStreamForPlayer(i, params);
            }
        }
    }
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
    return 1;
}

CMD:tarik(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
	    new targetid, Float:x, Float:y, Float:z;
		new vw = GetPlayerVirtualWorld(playerid);
		if(sscanf(params, "u", targetid)) return SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /tarik [playerid]");
        else if(playerid == targetid) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Anda Tidak Boleh Tarik Diri Sendiri");
		if(!IsPlayerConnected(targetid)) return SendClientMessage(playerid, COLOR_GRAD2, ""COL_DC"[ERROR]:"COL_WHITE" Pemain itu tidak online");
        new interior = GetPlayerInterior(playerid);
		GetPlayerPos(playerid, x, y, z);
	    SetPlayerPos(targetid, x+1, y+1, z);
	    GetPlayerVirtualWorld(playerid);
	    SetPlayerVirtualWorld(targetid, vw);
	    SetPlayerInterior(targetid, interior);
	}
	else return SendClientMessage(playerid, COLOR_GRAD2, NOPERMS);
    return 1;
}

CMD:teleport(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	{
		ShowPlayerDialog(playerid, DIALOG_TELEPORT, DIALOG_STYLE_LIST, ""COL_WHITE"Teleport", ""COL_WHITE"Spawn Rakyat\nBalai PPR\nBalai PJP\nHospital\nBase Kapak\n Base Black Shark\nBase King 302\nBase Todak97\nBase Tenjiku Geng", "Pilih", "Tutup");
	}
	return 1;
}

CMD:tariksemua(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 4)
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
	   }
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[BOT]"COL_WHITE" Hanya Assistance Dev Dan Developer Sahaja Boleh Guna Command Ini");
    return 1;
}

//=================== PLAYER COMMANDS ==========================================

CMD:phone(playerid, params[])
{
	SelectTextDraw(playerid, COLOR_WHITE);
	TextDrawShowForPlayer(playerid, PhoneTD[0]);
	TextDrawShowForPlayer(playerid, PhoneTD[1]);
	TextDrawShowForPlayer(playerid, PhoneTD[2]);
	TextDrawShowForPlayer(playerid, PhoneTD[3]);
	TextDrawShowForPlayer(playerid, PhoneTD[4]);
	TextDrawShowForPlayer(playerid, PhoneTD[5]);
	TextDrawShowForPlayer(playerid, PhoneTD[6]);
	TextDrawShowForPlayer(playerid, PhoneTD[7]);
	TextDrawShowForPlayer(playerid, PhoneTD[8]);
	TextDrawShowForPlayer(playerid, PhoneTD[9]);
	TextDrawShowForPlayer(playerid, PhoneTD[10]);
	TextDrawShowForPlayer(playerid, PhoneTD[11]);
	TextDrawShowForPlayer(playerid, PhoneTD[12]);
	TextDrawShowForPlayer(playerid, PhoneTD[13]);
	TextDrawShowForPlayer(playerid, PhoneTD[14]);
	TextDrawShowForPlayer(playerid, PhoneTD[15]);
	return 1;
}

CMD:dchat(playerid, params[])
{
	new string[160];
	if(PlayerInfo[playerid][pDuit] <150) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Duit Anda Tidak Cukup!");
	if(isnull(params)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"/dchat [text]");
	else
	{
		format(string,160, COL_DC"[TO DISCORD]"COL_WHITE"%s : %s", GetName(playerid), params);
		SendClientMessageToAll(COLOR_LIGHTBLUE, string);
		format(string,160, "[SERVER]%s : %s", GetName(playerid), params);
		DCC_SendChannelMessage(DiscordChat,string);
	}
	return 1;
}
CMD:fb(playerid, params[])
{
	new string[160];
	if(PlayerInfo[playerid][pDuit] <150) return SendClientMessage(playerid, COLOR_RED, "[ERROR]"COL_WHITE"Duit Anda Tidak Cukup!");
	if(isnull(params)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"/fb [text]");
	else
	{
		format(string,160, COL_BLUE"[FACEBOOK]"COL_WHITE"%s : %s", GetName(playerid), params);
		SendClientMessageToAll(COLOR_LIGHTBLUE, string);
	}
	return 1;
}

CMD:help(playerid, params[])
{
	ShowPlayerDialog(playerid, 0, DIALOG_STYLE_MSGBOX, ""COL_WHITE"What To Do?", ""COL_WHITE"1. Buat IC\n2. Buat Lesen\n3. Bekerja\n4. Beli Kenderaan\n5. Enjoy", "Tutup", "");
	return 1;
}

CMD:menu(playerid, params[])
{
	ShowPlayerDialog(playerid, MENU, DIALOG_STYLE_LIST, ""COL_WHITE"Command", ""COL_WHITE"Quotes Commands\nPlayer Commands\nGoodside Role Commands\nBadside Role Commands", "Pilih", "Tutup");
	return 1;
}

CMD:role(playerid, params[])
{
	ShowPlayerDialog(playerid, DIALOG_ROLE, DIALOG_STYLE_LIST, ""COL_WHITE"Role", ""COL_WHITE"Polis Penang Roleplay\nPengangkutan Jalanraya Penang\nMedic Penang Roleplay\nKapak\nBlack Shark\nKing 302\nTodak97\nAdmin\nPenjenayah\nTenjiku Geng", "Pilih", "Tutup");
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

CMD:changemode(playerid, parmas[])
{
	ShowPlayerDialog(playerid, CHANGE_MODE, DIALOG_STYLE_LIST, "Change Mode", "DeathMatch\nParachute\nRacing\nCapture Flag", "Pilih", "Batal");
	return 1;
}

CMD:pm(playerid, params[])
{
    new str2[128], id;
    if(sscanf(params, "us[128]", id, str2)) return SendClientMessage(playerid, COLOR_WHITE, "Usage: /pm [playerid] [message]");
    if(!IsPlayerConnected(id)) return GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~ERROR: Player Ini Tidak Online", 3000, 3);
    if(playerid == id) return GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~KESIAN TKDE MEMBER PM DIRI SENDIRI HAHAHA!", 3000, 3);
    if(GetPVarInt(id, "BlockPM") == 1) return GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Player Ini Sudah OFF Kan Telefon", 3000, 3);
    new Name1[MAX_PLAYER_NAME], Name2[MAX_PLAYER_NAME], str[128];
    GetPlayerName(playerid, Name1, sizeof(Name1));
    GetPlayerName(id, Name2, sizeof(Name2));
    format(str, sizeof(str), "PM Kepada %s : %s", Name2, str2);
    SendClientMessage(playerid, COLOR_YELLOW, str);
    format(str, sizeof(str), "PM Daripada %s : %s", Name1, str2);
    SendClientMessage(id, COLOR_YELLOW, str);
    return 1;
}

CMD:blockpm(playerid, params[])
{
    if(GetPVarInt(playerid, "BlockPM") == 1)
    {
        SetPVarInt(playerid, "BlockPM", 0);
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Anda Telah Mengaktifkan Telefon Anda", 3000, 3);
    }
    else
    {
        SetPVarInt(playerid, "BlockPM", 1);
        GameTextForPlayer(playerid, "~n~~n~~n~~n~~n~~n~~n~~n~~n~~w~Anda Telah Off Kan Telefon Anda", 3000, 3);
    }
    return 1;
}

CMD:me(playerid, params[])
{
	new string[160];
	if(isnull(params)) return SendClientMessage(playerid, -1,""COL_OREN"[INFO]"COL_WHITE"GUNAKAN: /me [text]");
	else
	{
		format(string,160,""COL_RED"[CHAT ALL]"COL_WHITE"%s : %s", GetName(playerid), params);
		printf(""COL_RED"[CHAT ALL]"COL_WHITE"%s : %s", GetName(playerid), string);
		OOCOff(COLOR_OOC,string);
		GivePlayerMoney(playerid,-10);
		PlayerInfo[playerid][pDuit] -= 10;
		GameTextForPlayer(playerid, "~r~-RM10", 2000, 1);
	}
	return 1;
}

CMD:bayar(playerid, params[])
{
	new string[400], targetid, amount;
	if(sscanf(params, "ui", targetid, amount)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /bayar [playerid] [jumlah]");
 	if(amount <= 0) return SendClientMessage(playerid, -1, ""COL_DC"[ERROR]:"COL_WHITE" Anda Tidak Boleh Membayar Dengan Harga RM0");
    if(amount > GetPlayerMoney(playerid)) return SendClientMessage(playerid, -1, ""COL_DC"[ERROR]:"COL_WHITE" Duit Anda Tidak Mencukupi");
    if(playerid == targetid) return SendClientMessage(playerid, -1, ""COL_DC"[ERROR]:"COL_WHITE" Anda Tidak Boleh Memberi Duit Kepada Diri Sendiri");
    if(!IsPlayerNearPlayer(playerid, targetid, 3)) return SendClientMessage(playerid, -1, ""COL_DC"[ERROR]:"COL_WHITE" Pemain Itu Terlalu Jauh Daripada Anda");
	PlayerInfo[playerid][pDuit] -= amount;
    GivePlayerMoney(playerid, -amount);
	PlayerInfo[targetid][pDuit] += amount;
	RemovePlayerAttachedObject(playerid, 5);
	GivePlayerMoney(targetid, amount);
	ApplyAnimation(playerid, "DEALER", "SHOP_PAY", 4.1, 0, 1, 1, 1, 1, 1);
	format(string, sizeof(string), ""COL_LGREEN"Anda Telah Memberikan RM%d Kepada %s", amount, GetName(targetid));
	SendClientMessage(playerid, -1, string);
	format(string, sizeof(string), ""COL_LGREEN"Anda Telah Diberikan RM%d Daripada %s", amount, GetName(playerid));
	SendClientMessage(targetid,-1, string);
	return 1;
}

CMD:tangkapikan(playerid, params[])
{
	if(IsPlayerInRangeOfPoint(playerid, 3, 354.5531,-2088.7981,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 362.2408,-2088.7473,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 367.3840,-2088.7974,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 369.7735,-2088.4351,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 374.9326,-2088.7158,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 83.4378,-2088.7524,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 390.9579,-2088.7939,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 396.0686,-2088.7634,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 398.5834,-2088.5872,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	if(IsPlayerInRangeOfPoint(playerid, 3, 403.8837,-2088.7896,7.8359))
	{
		if(PlayerInfo[playerid][pJoran] == 1)
		{
			TogglePlayerControllable(playerid, false);
			SetTimerEx("FishTimer", 5000, false, "i", playerid);
			GameTextForPlayer(playerid,"~b~SILA TUNGGU",2000,1);
		}
		else return SendClientMessage(playerid, COLOR_RED, "Anda Tidak Mempunyai Joran!");
	}
	return 1;
}
//====================== ROLE COMMANDS =========================================
//======================== PDRM ================================================
CMD:setppr(playerid, params[])
{
	if(PlayerInfo[playerid][pPpr] == 5)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setppr [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Ppr Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Ppr Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI PPR", 5000, 1);
      	PlayerInfo[targetid][pPpr] = level;
      	format(string,sizeof(string),":police_officer: *POLIS PENANG ROLEPLAY*\n```Nama Leader: %s\nNama Ahli : %s\n Level : %s```", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

CMD:jail(playerid, params[])
{
	if(PlayerInfo[playerid][pPpr] >= 1)
	{
	    new text[50];
		new targetid;
		new string[300];
		if(sscanf(params, "uz", targetid, text)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /jail [playerid] [sebab]");
        GameTextForPlayer(targetid,"~w~SILA TUNGGU!",5000,1);
        format(string, sizeof(string), ""COL_PPR"[INFO PDRM]"COL_WHITE" Pegawai %s telah memenjarakan %s sebab "COL_RED"%s", GetName(playerid),GetName(targetid),text);
        SendClientMessageToAll(0xE01B1B, string);
        SetPlayerPos(targetid, 264.37381, 76.99860, 1001.09906);
        SetPlayerInterior(targetid, 6);
        PlayerInfo[targetid][pJail] = 1;
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Hanya PDRM Sahaja Yang Boleh Guna Command Ini");
	return 1;
}

CMD:unjail(playerid, params[])
{
	if(PlayerInfo[playerid][pPpr] >= 1)
	{
		new targetid;
		new string[300];
       	if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /unjail [playerid]");
       	SetPlayerPos(targetid,268.488372,81.896331,1001.039062);
        SetPlayerInterior(targetid,6);
        PlayerInfo[targetid][pJail] = 0;
        GameTextForPlayer(targetid,"~g~JADILAH MANUSIA YANG BERGUNA....",5000,1);

        format(string, sizeof(string), ""COL_PPR"[INFO PDRM]"COL_WHITE" %s telah mengeluarkan %s daripada penjara", GetName(playerid),GetName(targetid));
        SendClientMessageToAll(0xE01B1B, string);
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Anda Hanya Boleh Unjail Di Penjara PDRM Sahaja");
	return 1;
}

CMD:cuff(playerid, params[])
{
	if(PlayerInfo[playerid][pPpr] >= 1)
	{
		new targetid;
		new string[300];
       	if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /cuff [playerid]");
        PlayerInfo[targetid][pGari] = 1;
        TogglePlayerControllable(targetid,0);
        format(string, sizeof(string), ""COL_PPR"[INFO PDRM]"COL_WHITE" %s Telah Mengari %s", GetName(playerid),GetName(targetid));
        SendClientMessageToAll(0xE01B1B, string);
	}
	else if(PlayerInfo[playerid][pPjp] >= 1)
	{
		new targetid;
		new string[300];
       	if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /cuff [playerid]");
        PlayerInfo[targetid][pGari] = 1;
        TogglePlayerControllable(targetid,0);
        format(string, sizeof(string), ""COL_PPR"[INFO PDRM]"COL_WHITE" %s Telah Mengari %s", GetName(playerid),GetName(targetid));
        SendClientMessageToAll(0xE01B1B, string);
	}
	else
	{
		SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"Hanya Orang Tertentu Sahaja Dibenarkan Menggunakan Commands Ini!");
	}
	return 1;
}

CMD:uncuff(playerid, params[])
{
	if(PlayerInfo[playerid][pPpr] >= 1)
	{
		new targetid;
		new string[300];
       	if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /uncuff [playerid]");
        PlayerInfo[targetid][pGari] = 0;
        TogglePlayerControllable(targetid, 1);
        format(string, sizeof(string), ""COL_PPR"[INFO PDRM]"COL_WHITE" %s Telah Membuang Gari %s", GetName(playerid),GetName(targetid));
        SendClientMessageToAll(0xE01B1B, string);
	}
	else if(PlayerInfo[playerid][pPjp] >= 1)
	{
		new targetid;
		new string[300];
       	if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /uncuff [playerid]");
        PlayerInfo[targetid][pGari] = 0;
        TogglePlayerControllable(targetid, 1);
        format(string, sizeof(string), ""COL_PJP"[INFO JPJ]"COL_WHITE" %s Telah Membuang Gari %s", GetName(playerid),GetName(targetid));
        SendClientMessageToAll(0xE01B1B, string);
	}
	else
	{
		SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"Hanya Orang Tertentu Sahaja Dibenarkan Menggunakan Commands Ini!");
	}
	return 1;
}

CMD:tazer(playerid, params[])
{
	if(PlayerInfo[playerid][pPjp]>= 1)
	{
		new targetid, string[300];
		if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO JPJ]"COL_WHITE" /tazer [playerid]");
		format(string, sizeof(string), ""COL_PJP"[INFO JPS]"COL_WHITE" Anda Telah Taze %s!", GetName(targetid));
        SendClientMessage(targetid,-1, string);
        format(string, sizeof(string), ""COL_PJP"[INFO JPS]"COL_WHITE" Anda Telah Ditaze Oleh %s!", GetName(playerid));
        SendClientMessage(playerid,-1, string);
        TogglePlayerControllable(targetid,0);
        SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
        TogglePlayerControllable(targetid,1);
	}
	if(PlayerInfo[playerid][pPpr]>= 1)
	{
		new targetid, string[300];
		if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO PPR]"COL_WHITE" /tazer [playerid]");
		format(string, sizeof(string), ""COL_PPR"[INFO PPR]"COL_WHITE" Anda Telah Taze %s!", GetName(targetid));
        SendClientMessage(targetid,-1, string);
        format(string, sizeof(string), ""COL_PPR"[INFO PPR]"COL_WHITE" Anda Telah Ditaze Oleh %s!", GetName(playerid));
        SendClientMessage(playerid,-1, string);
        TogglePlayerControllable(targetid,0);
        SetTimerEx("FreezeTimer", 5000, false, "i", playerid);
        TogglePlayerControllable(targetid,1);
	}
	return 1;
}

//PENGANGKUTAN JALANRAYA PENANG
CMD:setpjp(playerid, params[])
{
	if(PlayerInfo[playerid][pPjp] >= 5)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setpjp [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Pjp Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Pjp Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI PJP", 5000, 1);
      	PlayerInfo[targetid][pPjp] = level;
      	format(string,sizeof(string),":police_officer: *Pengangkutan Jalanraya Penang*\n```Nama Leader: %s\nNama Ahli : %s\n Level : %s``", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

CMD:saman(playerid, params[])
{
	if(PlayerInfo[playerid][pPjp]>= 1)
	{
		new targetid, amount, string[300];
		if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO JPS]"COL_WHITE" /saman [playerid] [amount]");
		format(string, sizeof(string), ""COL_PJP"[INFO JPS]"COL_WHITE" %s Telah Saman Rakyat Bernama %s Sebanyak %s!", GetName(playerid),GetName(targetid), amount);
        SendClientMessageToAll(0xE01B1B, string);
        GameTextForPlayer(targetid, "~g~ANDA TELAH DISAMAN!", 5000, 1);
        GivePlayerMoney(targetid, -amount);
        PlayerInfo[targetid][pDuit] -= amount;
	}
	return 1;
}

CMD:bagiic(playerid, params[])
{
	new string[128], item[32], targetid;
	if(PlayerInfo[playerid][pPjp] >= 1)
	{
		if(sscanf(params, "s[32]", item))
		{
			SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"/bagiic [Lelaki/Perempuan]");
			return 1;
		}
		if(strcmp(item, "lelaki", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/bagiic [lelaki] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Memberi Anda IC Lelaki!", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 30, 500);
			PlayerInfo[playerid][pIdentityCard] = 1;
			PlayerInfo[playerid][pJantina] = 1;
		}
		if(strcmp(item, "perempuan", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/bagiic [perempuan] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Memberi Anda IC Perempuan!", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 30, 500);
			PlayerInfo[playerid][pIdentityCard] = 2;
			PlayerInfo[playerid][pJantina] = 2;
		}
	}
	return 1;
}

CMD:lesen(playerid, params[])
{
    if(PlayerInfo[playerid][pPjp] >= 1)
    {
        new string[128], item[32], targetid;
        if(sscanf(params, "s[32] ", item)) {
            SendClientMessage(playerid, -1, ""COL_RED"[INFO]: "COL_WHITE"/sellcar [lesen]");
            SendClientMessage(playerid, -1, ""COL_YELLOW"[LESEN]: "COL_WHITE"Kereta | Motor | Lori | Bot | Udara");
            return 1;
        }
        if(strcmp(item,"kereta",true) == 0) 
        {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /lesen kereta [playerid]");
            GameTextForPlayer(targetid, "~b~Anda Telah Mendapat Lesen Kereta", 3000, 1);
            format(string, sizeof(string), ""COL_PJP"[INFO PJP]"COL_WHITE" Anda Telah Memberi %s Lesen Kereta", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(targetid, -2500);
            GivePlayerMoney(playerid, 2500);
			PlayerInfo[targetid][pLesenKereta] = 1;
        }
        if(strcmp(item,"motor",true) == 0) 
        {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /lesen motor [playerid]");
            GameTextForPlayer(targetid, "~b~Anda Telah Mendapat Lesen Motor", 3000, 1);
            format(string, sizeof(string), ""COL_PJP"[INFO PJP]"COL_WHITE" Anda Telah Memberi %s Lesen Motor", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(targetid, -1500);
            GivePlayerMoney(playerid, 1500);
			PlayerInfo[targetid][pLesenMotor] = 1;
        }
        if(strcmp(item,"lori",true) == 0) 
        {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /lesen lori [playerid]");
            GameTextForPlayer(targetid, "~b~Anda Telah Mendapat Lesen Lori", 3000, 1);
            format(string, sizeof(string), ""COL_PJP"[INFO PJP]"COL_WHITE" Anda Telah Memberi %s Lesen Lori", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(targetid, -3500);
            GivePlayerMoney(playerid, 3500);
			PlayerInfo[targetid][pLesenLori] = 1;
        }
        if(strcmp(item,"bot",true) == 0) 
        {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /lesen bot [playerid]");
            GameTextForPlayer(targetid, "~b~Anda Telah Mendapat Lesen Bot", 3000, 1);
            format(string, sizeof(string), ""COL_PJP"[INFO PJP]"COL_WHITE" Anda Telah Memberi %s Lesen Bot", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(targetid, -2500);
            GivePlayerMoney(playerid, 2500);
			PlayerInfo[targetid][pLesenBot] = 1;
        }
        if(strcmp(item,"udara",true) == 0) 
        {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /lesen udara [playerid]");
            GameTextForPlayer(targetid, "~b~Anda Telah Mendapat Lesen Udara", 3000, 1);
            format(string, sizeof(string), ""COL_PJP"[INFO PJP]"COL_WHITE" Anda Telah Memberi %s Lesen Udara", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(targetid, -2500);
            GivePlayerMoney(playerid, 2500);
			PlayerInfo[targetid][pLesenKapalTerbang] = 1;
        }
    }
    return 1;
}


//MEDIC PENANG ROLEPLAY
CMD:setmpr(playerid, params[])
{
	if(PlayerInfo[playerid][pPpr] >= 2)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setmpr [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Ppr Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Ppr Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI PPR", 5000, 1);
      	PlayerInfo[targetid][pPpr] = level;
      	format(string,sizeof(string),":hospital:  *Medic Penang Roleplay*\n```Nama Leader: %s\nNama Ahli : %s\nLevel : %s```", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

CMD:heal(playerid, params[])
{
	if(PlayerInfo[playerid][pMpr] >= 1)
	{
		new targetid;
		new string[300];
       	if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE" /heal [playerid]");
        SetPlayerHealth(targetid, 100);
        format(string, sizeof(string), ""COL_MPR"[INFO HOSPITAL]"COL_WHITE" %s Telah Berjaya Merawat Pesakit Covid19 Bernama %s!", GetName(playerid),GetName(targetid));
        SendClientMessageToAll(0xE01B1B, string);
	}
	else return SendClientMessage(playerid,-1,""COL_RED"[INFO]"COL_WHITE" Hanya MPR Sahaja Yang Boleh Gunakan Command Ini");
	return 1;
}

CMD:jualweapon(playerid, params[])
{
	new string[128], item[32], targetid;
	if(PlayerInfo[playerid][pTodak97] >= 1)
	{
		if(sscanf(params, "s[32]", item))
		{
			SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"/jualweapon [ID WEAPON]");
			SendClientMessage(playerid, -1, ""COL_RED"[ID WEAPON]"COL_WHITE"AK47, M4, DESERT, SILENCED");
			return 1;
		}
		if(strcmp(item, "ak47", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [AK47] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID 30 Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 30, 500);
			PlayerInfo[playerid][pAk47] = 1;
		}
		if(strcmp(item, "m4", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [M4] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID 31 Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 31, 500);
			PlayerInfo[playerid][pM4] = 1;
		}
		if(strcmp(item, "desert", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [DESERT] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID 24 Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 24, 500);
			PlayerInfo[playerid][pDesert] = 1;
		}
		if(strcmp(item, "silenced", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [SILENCED] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID 23 Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 23, 500);
			PlayerInfo[playerid][pSilenced] = 1;
		}
	}
	else if(PlayerInfo[playerid][pKapak] >= 1)
	{
		if(sscanf(params, "s[32]", item))
		{
			SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"/jualweapon [ID WEAPON]");
			SendClientMessage(playerid, -1, ""COL_RED"[ID WEAPON]"COL_WHITE"DESERT, SHOTGUN, MP5, M4");
			return 1;
		}
		if(strcmp(item, "desert", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [DESERT] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Desert Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 24, 500);
			PlayerInfo[playerid][pDesert] = 1;
		}
		if(strcmp(item, "shotgun", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [SHOTGUN] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Shotgun Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 25, 500);
			PlayerInfo[playerid][pShotgun] = 1;
		}
		if(strcmp(item, "mp5", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [MP5] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Mp5 Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 29, 500);
			PlayerInfo[playerid][pMp5] = 1;
		}
		if(strcmp(item, "m4", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [M4] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Shotgun Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 31, 500);
			PlayerInfo[playerid][pM4] = 1;
		}
	}
	else if(PlayerInfo[playerid][pKing302] >= 1)
	{
		if(sscanf(params, "s[32]", item))
		{
			SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"/jualweapon [ID WEAPON]");
			SendClientMessage(playerid, -1, ""COL_RED"[ID WEAPON]"COL_WHITE"KANTANA, DESERT, MP5, UZI");
			return 1;
		}
		if(strcmp(item, "kantana", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [KANTANA] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Kantana Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 8, 500);
			PlayerInfo[playerid][pKantana] = 1;
		}
		if(strcmp(item, "desert", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [DESERT] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Desert Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 24, 500);
			PlayerInfo[playerid][pDesert] = 1;
		}
		if(strcmp(item, "mp5", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [MP5] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Mp5 Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 29, 500);
			PlayerInfo[playerid][pMp5] = 1;
		}
		if(strcmp(item, "uzi", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [UZI] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Uzi Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 28, 500);
			PlayerInfo[playerid][pUzi] = 1; 
		}
	}
	else if(PlayerInfo[playerid][pKing302] >= 1)
	{
		if(sscanf(params, "s[32]", item))
		{
			SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"/jualweapon [ID WEAPON]");
			SendClientMessage(playerid, -1, ""COL_RED"[ID WEAPON]"COL_WHITE"Shotgun, Uzi, Ak47, Sniper");
			return 1;
		}
		if(strcmp(item, "shotgun", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [SHOTGUN] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Shotgun Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 25, 500);
			PlayerInfo[playerid][pShotgun] = 1;
		}
		if(strcmp(item, "uzi", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [UZI] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Uzi Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 28, 500);
			PlayerInfo[playerid][pUzi] = 1;
		}
		if(strcmp(item, "ak47", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [AK47] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID AK47 Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 30, 500);
			PlayerInfo[playerid][pAk47] = 1;
		}
		if(strcmp(item, "sniper", true) == 0)
		{
			if(sscanf(params, "s[32]u", item, targetid)) return SendClientMessage(playerid, COLOR_RED, "[INFO]"COL_WHITE"/jualweapon [SNIPER] [playerid]");
			format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE"%s Telah Menjual Weapon ID Sniper Kepada Anda", GetName(playerid));
			SendClientMessage(targetid, COLOR_WHITE, string);
			GivePlayerWeapon(targetid, 34, 500);
			PlayerInfo[playerid][pSniper] = 1;
		}
	}
	else return SendClientMessage(playerid, COLOR_RED, NOPERMS);
	return 1;
}
//Kapak
CMD:setkapak(playerid, params[])
{
	if(PlayerInfo[playerid][pKapak] >= 3)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setkapak [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Kapak Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Kapak Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI Kapak", 5000, 1);
      	PlayerInfo[targetid][pKapak] = level;
      	format(string,sizeof(string),":homes: *Kapak*\n```Nama Leader: %s\nNama Ahli : %s\n Level : %s```", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

//BLACK SHARK
CMD:setbs(playerid, params[])
{
	if(PlayerInfo[playerid][pBlackShark] >= 3)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setbs [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Black Shark Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Black Shark Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI BLACK SHARK", 5000, 1);
      	PlayerInfo[targetid][pBlackShark] = level;
      	format(string,sizeof(string),":shark: *Black Shark*\n```Nama Leader: %s\nNama Ahli : %s\n Level : %s```", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

//King 302
CMD:setking(playerid, params[])
{
	if(PlayerInfo[playerid][pKing302] >= 3)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setking302 [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli King302 Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli King302 Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI KING302", 5000, 1);
      	PlayerInfo[targetid][pKing302] = level;
      	format(string,sizeof(string),":u55b6: *King 302*\n```Nama Leader: %s\nNama Ahli : %s\n Level : %s```", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

//TODAK97
CMD:settodak(playerid, params[])
{
	if(PlayerInfo[playerid][pTodak97] >= 3)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /setTodak97 [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Todak97 Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Todak97 Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI TODAK97", 5000, 1);
      	PlayerInfo[targetid][pTodak97] = level;
      	format(string,sizeof(string),":dragon: *Todak97*\n```Nama Leader: %s\nNama Ahli : %s\n Level : %s```", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

//TENJIKU GENG
CMD:settenjiku(playerid, params[])
{
	if(PlayerInfo[playerid][pTenjikuGeng] >= 3)
   	{
	  	new targetid, level, string[400];
	  	if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /settenjiku [playerid] [level]");
	  	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Tenjiku Level %d",targetid, level);
      	SendClientMessage(playerid, -1, string);
      	format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Tenjiku Level %d",GetName(playerid), level);
      	SendClientMessage(targetid, -1, string);
      	GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI Tenjiku", 5000, 1);
      	PlayerInfo[targetid][pKapak] = level;
      	format(string,sizeof(string),":homes: *Tenjiku*\n```Nama Leader: %s\nNama Ahli : %s\n Level : %s```", GetName(playerid), GetName(targetid), level);
        DCC_SendChannelMessage(RoleChannel,string);
   	}
	return 1;
}

CMD:r(playerid, params[]) return cmd_radio(playerid, params);
CMD:radio(playerid, params[])
{
	new string[128], text[128], ctext[60], pname[MAX_PLAYER_NAME+1];
	GetPlayerName(playerid, pname, sizeof(pname));
	if(sscanf(params, "s[128]", text)) return SendClientMessage(playerid, 0x46E850FF, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /radio [text]");
	if(PlayerInfo[playerid][pPpr] >= 1)
	{
        if(PlayerInfo[playerid][pPpr] == 1){ ctext = "Level 1"; }
		if(PlayerInfo[playerid][pPpr] == 2){ ctext = "Level 2"; }
		if(PlayerInfo[playerid][pPpr] == 3){ ctext = "Level 3"; }
		if(PlayerInfo[playerid][pPpr] == 4){ ctext = "Level 4"; }
		if(PlayerInfo[playerid][pPpr] == 5){ ctext = "Level 5"; }
		if(PlayerInfo[playerid][pPpr] == 6){ ctext = "Level 6"; }
		format(string, sizeof(string), ""COL_PPR"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pPpr] > 0)
		{
			SendPprMessage(COLOR_PPR, string);
		}
	}
	if(PlayerInfo[playerid][pPjp] >= 1)
	{
        if(PlayerInfo[playerid][pPjp] == 1){ ctext = "KADET"; }
		if(PlayerInfo[playerid][pPjp] == 2){ ctext = "PEGAWAI"; }
		if(PlayerInfo[playerid][pPjp] == 3){ ctext = "PEGAWAI ATASAN"; }
		if(PlayerInfo[playerid][pPjp] == 4){ ctext = "INSPEKTOR"; }
		if(PlayerInfo[playerid][pPjp] == 5){ ctext = "TIMBALAN PESURUHJAYA"; }
		if(PlayerInfo[playerid][pPjp] == 6){ ctext = "PESURUHJAYA"; }
		format(string, sizeof(string), ""COL_PJP"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pPjp] > 0)
		{
			SendPjpMessage(COLOR_PJP, string);
		}
	}
	if(PlayerInfo[playerid][pMpr] >= 1)
	{
        if(PlayerInfo[playerid][pMpr] == 1){ ctext = "NURSE"; }
		if(PlayerInfo[playerid][pMpr] == 2){ ctext = "JUNIOR DOCTOR"; }
		if(PlayerInfo[playerid][pMpr] == 3){ ctext = "EXPERT DOCTOR"; }
		if(PlayerInfo[playerid][pMpr] == 4){ ctext = "SENIOR DOCTOR"; }
		if(PlayerInfo[playerid][pMpr] == 5){ ctext = "PAKAR BEDAH"; }
		if(PlayerInfo[playerid][pMpr] == 6){ ctext = "PROFFESOR"; }
		format(string, sizeof(string), ""COL_MPR"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pMpr] > 0)
		{
			SendMprMessage(COLOR_MPR, string);
		}
	}
	if(PlayerInfo[playerid][pKapak] >= 1)
	{
        if(PlayerInfo[playerid][pKapak] == 1){ ctext = "ADIK ADIK"; }
		if(PlayerInfo[playerid][pKapak] == 2){ ctext = "ABANG LONG"; }
		if(PlayerInfo[playerid][pKapak] == 3){ ctext = "TAIKO"; }
		if(PlayerInfo[playerid][pKapak] == 4){ ctext = "BOSS"; }
		format(string, sizeof(string), ""Col_Kapak"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pKapak] > 0)
		{
			SendKapakMessage(COLOR_KAPAK, string);
		}
	}
	if(PlayerInfo[playerid][pTenjikuGeng] >= 1)
	{
        if(PlayerInfo[playerid][pTenjikuGeng] == 1){ ctext = "ADIK ADIK"; }
		if(PlayerInfo[playerid][pTenjikuGeng] == 2){ ctext = "ABANG NGAH"; }
		if(PlayerInfo[playerid][pTenjikuGeng] == 3){ ctext = "ABANG LONG"; }
		if(PlayerInfo[playerid][pTenjikuGeng] == 4){ ctext = "AYAHANDA"; }
		format(string, sizeof(string), ""Col_Kapak"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pTenjikuGeng] > 0)
		{
			SendTenjikuMessage(COLOR_TenjikuGeng, string);
		}
	}
	if(PlayerInfo[playerid][pBlackShark] >= 1)
	{
        if(PlayerInfo[playerid][pBlackShark] == 1){ ctext = "ANAK BUAH"; }
		if(PlayerInfo[playerid][pBlackShark] == 2){ ctext = "ANAK BUAH"; }
		if(PlayerInfo[playerid][pBlackShark] == 3){ ctext = "PA LEADER"; }
		if(PlayerInfo[playerid][pBlackShark] == 4){ ctext = "AYAHANDA"; }
		format(string, sizeof(string), ""COL_BLACKSHARK"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pBlackShark] > 0)
		{
			SendBlackSharkMessage(COLOR_BLACKSHARK, string);
		}
	}
	if(PlayerInfo[playerid][pKing302] >= 1)
	{
        if(PlayerInfo[playerid][pKing302] == 1){ ctext = "ADIK ADIK"; }
		if(PlayerInfo[playerid][pKing302] == 2){ ctext = "ABANG ABANG"; }
		if(PlayerInfo[playerid][pKing302] == 3){ ctext = "ABANG LONG"; }
		if(PlayerInfo[playerid][pKing302] == 4){ ctext = "AYAHANDA"; }
		format(string, sizeof(string), ""COL_KING302"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pKing302] > 0)
		{
			SendKing302Message(COLOR_KING302, string);
		}
	}
	if(PlayerInfo[playerid][pTodak97] >= 1)
	{
        if(PlayerInfo[playerid][pTodak97] == 1){ ctext = "ADIK ADIK"; }
		if(PlayerInfo[playerid][pTodak97] == 2){ ctext = "ABANG LONG"; }
		if(PlayerInfo[playerid][pTodak97] == 3){ ctext = "CO"; }
		if(PlayerInfo[playerid][pTodak97] == 4){ ctext = "AYAHANDA"; }
		format(string, sizeof(string), ""COL_TODAK"[%s]"COL_WHITE"%s: %s", ctext, pname, text);
		if(PlayerInfo[playerid][pTodak97] > 0)
		{
			SendTodak97Message(COLOR_TODAK, string);
		}
	}
	return 1;
}
//==================================PENANG VEHICLE DEALER ================================
CMD:makedealer(playerid, params[])
{
   if(PlayerInfo[playerid][pVEH] >= 3)
   {
	  new targetid, level, string[128];
	  if(sscanf(params, "ud", targetid, level)) return SendClientMessage(playerid, -1, ""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /makedealer [playerid] [level]");
	  format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" Anda Telah Menjadikan %s Ahli Vehicle Dealer Level  %d",targetid, level);
      SendClientMessage(playerid, -1, string);
      format(string, sizeof(string), ""COL_RED"[INFO]"COL_WHITE" %s Telah Menjadikan Anda Ahli Vehicle Dealer %d",GetName(playerid), level);
      SendClientMessage(targetid, -1, string);
      GameTextForPlayer(targetid, "~g~ANDA TELAH MENJADI AHLI Vehicle Dealer", 5000, 1);
      PlayerInfo[targetid][pVEH] = level;
   }
   return 1;
}

CMD:sellcar(playerid, params[])
{
    if(PlayerInfo[playerid][pVEH] >= 1)
    {
        new string[128], item[32], targetid;
        if(sscanf(params, "s[32] ", item)) {
            SendClientMessage(playerid, -1, ""COL_RED"[INFO]: "COL_WHITE"/sellcar [item]");
            SendClientMessage(playerid, -1, ""COL_YELLOW"[ITEM]: "COL_WHITE"banshee, buffalo, stretch, sabre, sultan, infernus, elegy, blista, tampa, huntley, sabre, cheetah, bullet");
            return 1;
        }
        if(strcmp(item,"infernus",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar infernus [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Infernus!", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Infernus", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Infernus", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-105000);
            PlayerInfo[targetid][pDuit] = -105000;
			PlayerInfo[targetid][pInfernus] = 1;
        }
        if(strcmp(item,"banshee",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar banshee [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Banshee!", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Banshee", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Banshee", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-105000);
            PlayerInfo[targetid][pDuit] = -105000;
			PlayerInfo[targetid][pBanshee] = 1;
        }
        else if(strcmp(item,"buffalo",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar buffalo [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Buffalo", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Buffalo", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Buffalo", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-150000);
            PlayerInfo[targetid][pDuit] = -150000;
			PlayerInfo[targetid][pBuffalo] = 1;
        }
        else if(strcmp(item,"stretch",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar stretch [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Stretch", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Stretch", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Stretch", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-1500000);
            PlayerInfo[targetid][pDuit] = -1500000;
			PlayerInfo[targetid][pStretch] = 1;
        }
        else if(strcmp(item,"bullet",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar bullet [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Bullet", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Bullet", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Bullet", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-200000);
            PlayerInfo[targetid][pDuit] = -200000;
			PlayerInfo[targetid][pBullet] = 1;
        }
        else if(strcmp(item,"cheetah",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar cheetah [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Cheetah", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Cheetah", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Cheetah", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-150000);
            PlayerInfo[targetid][pDuit] = -150000;
			PlayerInfo[targetid][pCheetah] = 1;
        }
        else if(strcmp(item,"sabre",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar sabre [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Sabre", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Sabre", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Sabre", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-250000);
            PlayerInfo[targetid][pDuit] = -250000;
			PlayerInfo[targetid][pSabre] = 1;
        }
        else if(strcmp(item,"huntley",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar huntley [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Huntley", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Huntley", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Huntley", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-500000);
            PlayerInfo[targetid][pDuit] = -500000;
			PlayerInfo[targetid][pHuntley] = 1;
        }
        else if(strcmp(item,"tampa",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar tampa [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Tampa", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Tampa", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Tampa", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-50000);
            PlayerInfo[targetid][pDuit] = -50000;
			PlayerInfo[targetid][pTampa] = 1;
        }
        else if(strcmp(item,"blista",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar blista [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Blista", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Blista", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Blista", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-50000);
            PlayerInfo[targetid][pDuit] = -50000;
			PlayerInfo[targetid][pBlista] = 1;
        }
        else if(strcmp(item,"elegy",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar elegy [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Elegy", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Elegy", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Elegy", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-350000);
            PlayerInfo[targetid][pDuit] = -350000;
			PlayerInfo[targetid][pElegy] = 1;
        }
        else if(strcmp(item,"sultan",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar sultan [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama Sultan", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama Sultan", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan Sultan", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-400000);
            PlayerInfo[targetid][pDuit] = -400000;
			PlayerInfo[targetid][pSultan] = 1;
        }
    }
    else return SendClientMessage(playerid, COLOR_RED, "Hanya Vehicle Dealer Sahaja Boleh Gunakan Command Ini");
    return 1;
}

CMD:sellmotor(playerid, params[])
{
    if(PlayerInfo[playerid][pVEH] >= 1)
    {
        new string[128], item[32], targetid;
        if(sscanf(params, "s[32] ", item)) {
            SendClientMessage(playerid, -1, ""COL_RED"[INFO]: "COL_WHITE"/sellmotor [item]");
            SendClientMessage(playerid, -1, ""COL_YELLOW"[ITEM]: "COL_WHITE"bf400, nrg500, fcr900, pcj600, freeway, wayfarer, sanchez, quadbike");
            return 1;
        }
        if(strcmp(item,"bf400",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar BF400 [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama BF400!", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama BF400", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan BF400", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-50000);
            PlayerInfo[targetid][pDuit] = -50000;
			PlayerInfo[targetid][pBF400] = 1;
        }
        else if(strcmp(item,"nrg500",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar NRG500 [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama NRG500", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama NRG500", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan NRG500", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-200000);
            PlayerInfo[targetid][pDuit] = -200000;
			PlayerInfo[targetid][pNRG500] = 1;
        }
        else if(strcmp(item,"fcr900",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar FCR900 [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama FCR900", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama FCR900", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan FCR900", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-1500000);
            PlayerInfo[targetid][pDuit] = -150000;
			PlayerInfo[targetid][pFCR900] = 1;
        }
        else if(strcmp(item,"pcj600",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar PCJ600 [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama PCJ600", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama PCJ600", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan PCJ600", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-200000);
            PlayerInfo[targetid][pDuit] = -100000;
			PlayerInfo[targetid][pPCJ600] = 1;
        }
        else if(strcmp(item,"freeway",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar FREEWAY [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama FREEWAY", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama FREEWAY", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan FREEWAY", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-150000);
            PlayerInfo[targetid][pDuit] = -350000;
			PlayerInfo[targetid][pFREEWAY] = 1;
        }
        else if(strcmp(item,"wayfarer",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar WAYFARER [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama WAYFARER", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama WAYFARER", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan WAYFARER", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-250000);
            PlayerInfo[targetid][pDuit] = -200000;
			PlayerInfo[targetid][pWAYFARER] = 1;
        }
        else if(strcmp(item,"sahchez",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar SANCHEZ [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama SANCHEZ", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama SANCHEZ", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan SANCHEZ", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-500000);
            PlayerInfo[targetid][pDuit] = -50000;
			PlayerInfo[targetid][pSANCHEZ] = 1;
        }
        else if(strcmp(item,"quadbike",true) == 0) {
            if(sscanf(params, "s[32]u",item, targetid)) return SendClientMessage(playerid, -1, "USAGE: /sellcar QUADBIKE [playerid]");
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Rakyat %s Telah Membeli Kenderaan Bernama QUADBIKE", GetName(targetid));
            SendClientMessageToAll(COLOR_LIGHTBLUE, string);
            GameTextForPlayer(targetid, "~b~Anda Telah Membeli Kenderaan Bernama QUADBIKE", 3000, 1);
            format(string, sizeof(string), ""COL_VEHICLE"[INFO VEHICLE]"COL_WHITE" Anda Telah Menjual %s Kenderaan QUADBIKE", GetName(targetid));
            SendClientMessage(playerid, COLOR_LIGHTBLUE, string);
            GivePlayerMoney(playerid,-50000);
            PlayerInfo[targetid][pDuit] = -50000;
			PlayerInfo[targetid][pQUADBIKE] = 1;
        }
    }
    else return SendClientMessage(playerid, COLOR_RED, "Hanya Vehicle Dealer Sahaja Boleh Gunakan Command Ini");
    return 1;
}

//==============================VIP COMMANDS=====================================
CMD:vips(playerid, params[])
{
	new
	    count = 0;

	new
	    string[256],
	    string2[3000]
	;

	strcat(string2, ""COL_YELLOW"");
	strcat(string2, ".:: VIP PENANG RP ::.\n");

    foreach(Player,x)
    {
	    if(PlayerInfo[x][pVip] >= 1 || PlayerInfo[x][pVip] >= 2 || PlayerInfo[x][pVip] >= 3)
	    {
	        count++;
            format(string, sizeof(string),"»"COL_COLOR_GREY"VIP %s[%d]\n", GetName(x), x, PlayerInfo[x]);
            strcat(string2, string);
        }
    }
    if(count == 0)
    {
        strcat(string2, ""COL_RED"");
        strcat(string2, "Tiada VIP Yang Online Sekarang.");
    }

    ShowPlayerDialog(playerid, N, DIALOG_STYLE_MSGBOX, ""COL_RED"VIP", string2, "TUTUP", "");
	return 1;
}

CMD:vtag(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] == 1 )
	{
		if(PlayerInfo[playerid][pVip] == 1 )
		{
		    playerLabels[playerid] = Create3DTextLabel("VIP PENANG RP!", 0x33CCFF99, 0.0, 0.0, 0.0, 40.0, 0, 1);
			Attach3DTextLabelToPlayer(playerLabels[playerid], playerid, 0.0, 0.0, -0.6);
    		SendClientMessage(playerid, 0x33AA33AA, "ANDA TELAH MEMASANG TAG VIP");
		}

	}
	else
	{
	    SendClientMessage(playerid, -1, "» "COL_RED"Anda Tidak Dibenarkan Menggunakan Command Ini.");
	}
	return 1;
}
CMD:vchat(playerid,params[])
{
	new string[140];
 	if(isnull(params)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /vchat [TEXT]");
  	if(PlayerInfo[playerid][pVip] == 1)
   	{
		format(string, 140, ""COL_YELLOW"[VIP CHAT]%s :%s", GetName(playerid), params);
  	}
    SendClientMessageToAll(playerid,string);
	return 1;
}

CMD:clearmychat(playerid,params[])
{
	if(PlayerInfo[playerid][pVip] == 1 )
   	{
	ClearMyChat(playerid);
   	   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "COL_COLOR_GREY"Anda Tidak Dibenarkan Menggunakan Command Ini.");
	}
	return 1;
}

CMD:vmyw(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] == 1)
	{
	new weather, string[128];
	if(sscanf(params, "i", weather)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /vmyw [0 - 45]");
	if(weather < 0 || weather > 45) return SendClientMessage(playerid, -1, "» "COL_COLOR_GREY"ID Cuaca Hanya Ada Di Angkara <0 - 45>");
	SetPlayerWeather(playerid, weather);
	format(string, sizeof(string), "{F8FF00}Anda Telah Menukar Cuca");
	SendClientMessage(playerid, COLOR_GREEN, string);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "COL_COLOR_GREY"Anda Tidak Dibenarkan Menggunakan Command Ini.");
	}
	return 1;
}
CMD:vmyweather(playerid, params[]) return cmd_vmyw(playerid, params);

CMD:vmytime(playerid, params[])
{
	if(PlayerInfo[playerid][pVip] == 1)
	{
	new time, string[128];
	if(sscanf(params, "i", time)) return SendClientMessage(playerid, COLOR_RED, "USAGE: /vmytime [0 - 23]");
	if(time < 0 || time > 23) return SendClientMessage(playerid, -1, "» "COL_COLOR_GREY"ID Cuaca Hanya Ada Di Angkara <0 - 23>");
	format(string, sizeof(string), "{F8FF00}Anda Telah Menukar Cuaca");
	SendClientMessage(playerid, COLOR_GREEN, string);
	SetPlayerTime(playerid, time, 0);
	}
	else
	{
	    SendClientMessage(playerid, -1, "» "COL_COLOR_GREY"Anda Tidak Dibenarkan Menggunakan Command Ini.");
	}
	return 1;
}
CMD:myt(playerid, params[]) return cmd_vmytime(playerid, params);

CMD:varmour(playerid,params[])
{
  	if(PlayerInfo[playerid][pVip] == 1)
   	{
	SetPlayerArmour(playerid, 100);
 	SendClientMessage(playerid, -1, "» {F8FF00}Armour Anda Telah Di Set.");

   	}
	else
	{
	    SendClientMessage(playerid, -1, "» "COL_COLOR_GREY"Anda Tidak Dibenarkan Menggunakan Command Ini.");
	}
	return 1;
}

// ============================ EXTRA ==========================
CMD:sendlocation(playerid, params[])
{
    new targetid, Float:x, Float:y, Float:z, Float:a;
    if(sscanf(params, "ui", targetid))
    {
        return SendClientMessage(playerid, COLOR_WHITE, "Usage: /sendlocation [playerid]");
    }
    if(!IsPlayerConnected(targetid))
    {
        return SendClientMessage(playerid, COLOR_WHITE, "Player Itu Tidak Online!");
    }

    GetPlayerPos(playerid, x, y, z);
    GetPlayerFacingAngle(playerid, a);

    SetPlayerCheckpoint(targetid, x, y, z, 3.0);
    OnPlayerEnterCheckpoint(targetid);
    return 1;
}

CMD:fixspawn(playerid, params[])
{
	SetPlayerPos(playerid,1125.3066,-2037.0031,69.8816);
	SetPlayerInterior(playerid,0);
	SendClientMessage(playerid, COLOR_WHITE, "Anda Telah Fix Spawn!");
	SetPlayerSkin(playerid, PlayerInfo[playerid][pSkin]);
	return 1;
}

CMD:ikat(playerid, params[])
{
	new targetid;
	new string[300];
    if(sscanf(params, "ui", targetid)) return SendClientMessage(playerid, -1, COL_RED"[INFO]"COL_WHITE" /ikat [playerid]");
    TogglePlayerControllable(targetid,0);
    format(string, sizeof(string), ""COL_RED"[WARNING!]"COL_WHITE" %s Telah Mengikat Anda!!", GetName(playerid));
    SendClientMessage(targetid, COLOR_WHITE, string);
    format(string, sizeof(string), COL_WHITE" Anda Telah Mengikat %s", GetName(targetid));
    SendClientMessage(playerid, COLOR_WHITE, string);
	return 1;
}

CMD:iklan(playerid, params[])
{
	new string[128], text[128];
 	if(sscanf(params,"s[64]",text)) return SendClientMessage(playerid,COLOR_RED,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /iklan [text]");
	format(string,sizeof(string),"[IKLAN]%s",text);
    SendClientMessageToAll(COLOR_OOC, string);
	PlayerPlaySound(playerid,1085,0.0,0.0,0.0);
	return 1;
}
//ENGINE

CMD:engine(playerid, params[])
{
	if(IsPlayerInAnyVehicle(playerid))
	{
		new vehid = GetPlayerVehicleID(playerid);
		if(VehInfo[vehid][vEngine] == 0)
		{
			VehInfo[vehid][vEngine] = 1;
			SetVehicleParamsEx(vehid, 1, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			SendClientMessage(playerid, COLOR_WHITE, "Engine Kenderaan Telah Start!");
		}
		else
		{
			VehInfo[vehid][vEngine] = 0;
			SetVehicleParamsEx(vehid, 0, VehInfo[vehid][vEngine], VehInfo[vehid][vLampu], VehInfo[vehid][vAlarm], VehInfo[vehid][vBoot], VehInfo[vehid][vBonnet], VehInfo[vehid][vObj]);
			SendClientMessage(playerid, COLOR_WHITE, "Engine Kenderaan Tidak Berjaya Start!");
		}
	}
	return 1;
}
CMD:b(playerid, params[])
{
	new string[128], text[128];
	format(string, sizeof(string), "( %s : %s )", GetName(playerid), text);
	ProxDetector(30.0, playerid, string,COLOR_WHITE,COLOR_FADE2,COLOR_FADE3,COLOR_FADE4,COLOR_FADE5);
	if(sscanf(params,"s[64]",text)) return SendClientMessage(playerid,COLOR_RED,""COL_RED"[INFO]"COL_WHITE"GUNAKAN: /b [local ooc]");
	format(string,sizeof(string),"(%s : %s)", GetName(playerid),text);
    SetPlayerChatBubble(playerid,string,COLOR_WHITE,5.0,5000);

	return 1;
}

CMD:inv(playerid, params[])
{
	ShowPlayerDialog(playerid, INV, DIALOG_STYLE_LIST, ""COL_WHITE"INVENTORY", ""COL_WHITE"WEAPON\nMAKANAN\nMINUMAN", "Pilih", "Tutup");
	return 1;
}
//================= VOTE SYSTEM ===============================
CMD:vote(playerid, params[])
{
	if(PlayerInfo[playerid][pAdmin] >= 1)
	if(isnull(params))
	    return SendClientMessage(playerid, -1, "/vote [create/end]");
	    
	if(!strcmp(params, "create", true))
	{
		if(VoteData[voteExists]) return SendClientMessage(playerid, -1, "Dah Ada Vote, Kena End Dulu Yang Sebelum Ni Punya!");
			
	    ShowPlayerDialog(playerid, CREATEVOTE, DIALOG_STYLE_INPUT, "Vote Create", "Sila Letak Vote Apa Yang Anda Nak Buat", "Start", "Cancel");
	}
	else if(!strcmp(params, "end", true))
	{
	    if(!VoteData[voteExists])
	        return SendClientMessage(playerid, -1, "Tiada Vote Sekarang!");
	       
		new str[128];
		format(str, sizeof(str), "Vote Tamat, Total Setuju : {FFFF00}%d {FFFFFF}Total Tidak Setuju :{FF0000}%d", VoteData[voteYes], VoteData[voteNo]);
		SendClientMessageToAll(-1, str);
		ResetVote();
		for (new i = 1; i != MAX_PLAYERS; i ++) if(HasVoted[i])
		{
			HasVoted[i] = false;
		}
	}
	else
	    SendClientMessage(playerid, -1, "Invalid option!");
	return 1;
}

CMD:setuju(playerid, params[])
{
	if(VoteData[voteExists] == false) return SendClientMessage(playerid, -1, "Tiada Vote Sekarang Ni!");

	if(HasVoted[playerid] == true) return SendClientMessage(playerid, -1, "Anda Sudah Vote!");

	HasVoted[playerid] = true;
	VoteData[voteYes]++;
	SendClientMessage(playerid, -1, "Anda Telah Vote {FFFF00}Setuju");
	return 1;
}

CMD:taksetuju(playerid, params[])
{
	if(VoteData[voteExists] == false) return SendClientMessage(playerid, -1, "Tiada Vote Sekarang Ni!");

	if(HasVoted[playerid] == true) return SendClientMessage(playerid, -1, "Anda Sudah Vote!");

	HasVoted[playerid] = true;
	VoteData[voteNo]++;
	SendClientMessage(playerid, -1, "Anda Telah Vote {FF0000}Tidak Setuju!");
	return 1;
}
//=============================== WHITELIST ==================================
CMD:whitelist(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
    ShowPlayerDialog(playerid,DIALOG_WHITELIST,DIALOG_STYLE_INPUT,"{00FFFF}Whitelist","{FF0000}Player Name.","Continue","Cancel");
    return 1;
    }
    else SendClientMessage(playerid, COLOR_YELLOW, "Maaf Bang, Admin Je Bole Whitelist UwU.");
    return 1;
}

CMD:blacklist(playerid,params[])
{
    if(PlayerInfo[playerid][pAdmin] >= 1)
    {
    ShowPlayerDialog(playerid,DIALOG_REMOVE,DIALOG_STYLE_INPUT,"{00FFFF}Blacklist","{FF0000}Player Name.","Continue","Cancel");
    return 1;
    }
    else SendClientMessage(playerid, COLOR_YELLOW, "Maaf Bang, Admin Je Bole Blacklist UwU.");
    return 1;
}

//==============================================================================
public OnPlayerCommandPerformed(playerid, cmdtext[], success)
{
    if(!success) SendClientMessage(playerid, COLOR_WHITE, ""COL_RED"Maaf, Command Tidak Sah. Gunakan /menu Untuk Senarai Menu Commands!");
    return 1;
}

public OnVehicleSpawn(vehicleid)
{
	VehInfo[vehicleid][vEngine] = 0;
	VehInfo[vehicleid][vLampu] = 0;
	VehInfo[vehicleid][vAlarm] = 0;
	VehInfo[vehicleid][vBoot] = 0;
	VehInfo[vehicleid][vBonnet] = 0;
	VehInfo[vehicleid][vObj] = 0;
	SetVehicleParamsEx(vehicleid, 0, VehInfo[vehicleid][vEngine], VehInfo[vehicleid][vLampu], VehInfo[vehicleid][vAlarm], VehInfo[vehicleid][vBoot], VehInfo[vehicleid][vBonnet], VehInfo[vehicleid][vObj]);
	return 1;
}
public hSpeedINFO(PlayerId)
{
	new String[150];
	format(String,150,"~R~%s",VehicleNames[GetVehicleModel(GetPlayerVehicleID(PlayerId))-400]);
    PlayerTextDrawSetString(PlayerId, Textdraw3[PlayerId], String);
	new Float:X;
	new Float:Y;
	new Float:Z;
	GetVehicleVelocity(GetPlayerVehicleID(PlayerId),X,Y,Z);
	format(String,150,"SPEED ~R~%d KM/H",floatround(floatsqroot(X * X + Y * Y + Z * Z) * 200.0000));
    PlayerTextDrawSetString(PlayerId, Textdraw4[PlayerId], String);
	new Float:Health;
	GetVehicleHealth(GetPlayerVehicleID(PlayerId),Health);
	format(String,150,"Health ~R~%d.0",floatround(Health / 10));
    PlayerTextDrawSetString(PlayerId, Textdraw5[PlayerId], String);
	return 1;
}

stock DCC_OnMessageCreate(DCC_Message:message);
public DCC_OnMessageCreate(DCC_Message:message)
{
	new DCC_Channel:channel;
 
    DCC_GetMessageChannel(message, channel);
 
    if(channel != AdminPanel)
        return 1;

    new DCC_User:author;
    DCC_GetMessageAuthor(message, author);
 
    new bool:isBot;
    DCC_IsUserBot(author, isBot);
 
    if(isBot){      
        return 1;
    }
        
    new str[900];
    new command[32], params[128];
 
    DCC_GetMessageContent(message, str);
 
 
    sscanf(str, "s[32]s[128]", command, params);
 
 
    if(!strcmp(command, "/wl", true)){
        new msg[128];
 
        sscanf(params, "s[128]",msg);

        new data[256];
        new string[900];
        format(data,sizeof(data),"UsersWhitelist/%s.txt",msg);
        {
        	if(!strlen(msg)) return DCC_SendChannelMessage(AdminPanel, "Jangan Kosong!");
        	if(!dini_Exists(data))
        	{
        		format(str,sizeof(str),"%s telah disenaraikan di dalam whitelist.",msg);
        		DCC_SendChannelMessage(AdminPanel,str);

        		dini_Create(data);

        		format(string,sizeof(string),":unlock:*INFO WHITELIST*\n``Nama : %s\nMantap Cokk Nama Anda Telah Disenaraikan Whitelisted! Tahniah!!``",msg);
        		DCC_SendChannelMessage(WhitelistChannel,string);
        	}

        	else
        	{
        		format(string,sizeof(string),"%s Nama Player Ini Sudah Ada Dalam Whitelist!",msg);
        		DCC_SendChannelMessage(AdminPanel,string);
        	}
        }
    }
    DCC_GetMessageContent(message, str);
 
 
    sscanf(str, "s[32]s[128]", command, params);
 
 
    if(!strcmp(command, "/bl", true)){
        new msg[128];
 
        sscanf(params, "s[128]",msg);

        new data[256];
        new string[900];
        format(data,sizeof(data),"UsersWhitelist/%s.txt",msg);
        {
        	if(!strlen(msg)) return DCC_SendChannelMessage(AdminPanel, "Jangan Kosong!");
        	if(dini_Exists(data))
        	{
        		format(str,sizeof(str),"%s telah disenaraikan di dalam Blacklist.",msg);
        		DCC_SendChannelMessage(AdminPanel,str);

        		dini_Remove(data);

        		format(string,sizeof(string),":lock:*INFO BLACKLIST*\n``Nama : %s\nNama Anda Telah Disenaraikan Blacklist!Kan Bodoh HAHAHAA!``",msg);
        		DCC_SendChannelMessage(BlacklistChannel,string);
        	}

        	else
        	{
        		format(string,sizeof(string),"%s Nama Player Ini Tidak Berada Di Dalam Whitelist Ataupun Sudah Di Blacklist!",msg);
        		DCC_SendChannelMessage(AdminPanel,string);
        	}
        }
    }
    DCC_GetMessageContent(message, str);
 
 
    sscanf(str, "s[32]s[128]", command, params);
 
 
    if(!strcmp(command, "/deldata", true)){
        new msg[128];
 
        sscanf(params, "s[128]",msg);

        new data[256];
        new string[900];
        format(data,sizeof(data),"Users/%s.ini",msg);
        {
        	if(!strlen(msg)) return DCC_SendChannelMessage(AdminPanel, "Jangan Kosong!");
        	if(!dini_Exists(data))
        	{
        		format(str,sizeof(str),"%s Telah Di Delete Database Player.",msg);
        		DCC_SendChannelMessage(AdminPanel,str);

        		dini_Remove(data);
        	}

        	else
        	{
        		format(string,sizeof(string),"%s Nama Player Ini Tidak Berada Di Dalam Data Server",msg);
        		DCC_SendChannelMessage(AdminPanel,string);
        	}
        }
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

stock SendPprMessage(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pPpr] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock SendPjpMessage(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pPjp] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock SendMprMessage(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pMpr] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock SendKapakMessage(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pKapak] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock SendTenjikuMessage(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pTenjikuGeng] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock SendBlackSharkMessage(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pBlackShark] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock SendKing302Message(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pKing302] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock SendTodak97Message(col, string[])
{
	for(new i = 0; i < MAX_PLAYERS; i++)
	{
		if(PlayerInfo[i][pTodak97] >= 1)
		SendClientMessage(i, col, string);
	}
	return 1;
}

stock IsNumeric(string[])
{
    for(new i = 0, j = strlen(string); i < j; i++)
    {
        if(string[i] > '9' || string[i] < '0')
        return 0;
    }
    return 1;
}

stock PlayerToPoint(Float:radi, playerid, Float:x, Float:y, Float:z)
{
    if(IsPlayerConnected(playerid))
    {
         new Float:oldposx, Float:oldposy, Float:oldposz;
         new Float:tempposx, Float:tempposy, Float:tempposz;
         GetPlayerPos(playerid, oldposx, oldposy, oldposz);
         tempposx = (oldposx -x);
         tempposy = (oldposy -y);
         tempposz = (oldposz -z);
         if (((tempposx < radi) && (tempposx > -radi)) && ((tempposy < radi) && (tempposy > -radi)) && ((tempposz < radi) && (tempposz > -radi))) return 1;
    }
    return 0;
}

stock AddFlitsPaal(playerid, modelid, Float:xx, Float:yy, Float:zz, radius, speed)
{
	new fine[MAX_PLAYERS];
 	new str[256];

 	if(objectcreated!=maxobject)
  	{
    	CreateObject(modelid, xx, yy, zz, 0.0, 0.0, 10);
     	objectcreated++;
  	}
  	if((distance1[playerid])>speed)
  	{
		if(IsPlayerInCircle(playerid, xx, yy, radius)  && GetPlayerState(playerid)== PLAYER_STATE_DRIVER)
		{
			fine[playerid]=((distance1[playerid]*17/10)-speed);
			GivePlayerMoney(playerid, -2000);
			format(str,sizeof(str), "[SPEEDCAM] Speed Limit Adalah :%d KM/H. Anda Melebihi %d KM/H. Anda Telah Disaman Akibat Melebihi Had!",speed, distance1[playerid] ,fine[playerid]);
            SendClientMessage(playerid, COLOR_GREEN, str);
			PlayerPlaySound(playerid, 1132, 0.0, 0.0, 0.0);
		}
	}
}

stock ResetVote()
{
    VoteData[voteExists] = false;
	VoteData[voteYes] = 0;
	VoteData[voteNo] = 0;
}

stock IsPlayerName(playerid)
{
	new name[MAX_PLAYERS];
	GetPlayerName(playerid, name, sizeof(name));
	return name;
}

stock ClearMyChat(playerid)
{
	for(new i=0; i<200; i++)
	{
	    SendClientMessage(playerid, -1, " ");
	}
	return 1;
}