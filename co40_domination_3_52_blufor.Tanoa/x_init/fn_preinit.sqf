// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_preinit.sqf"
#include "..\x_setup.sqf"
diag_log format ["############################# %1 #############################", missionName];
diag_log [diag_frameno, diag_ticktime, time, "Executing Dom fn_preinit.sqf"];

#ifndef __TT__
d_tt_ver = false;
#else
d_tt_ver = true;
#endif

#ifndef __TANOA__
d_tanoa = false;
#else
d_tanoa = true;
#endif

#ifdef __TANOATT__
d_tt_tanoa = true;
d_tanoa = true;
#else
d_tt_tanoa = false;
#endif

d_HeliHEmpty = "Land_HelipadEmpty_F";

// BLUFOR, OPFOR or INDEPENDENT for own side, setup in x_setup.sqf
#ifdef __OWN_SIDE_BLUFOR__
d_own_side = "WEST";
d_enemy_side = "EAST";
d_enemy_side_short = "E";
#endif
#ifdef __OWN_SIDE_OPFOR__
d_own_side = "EAST";
d_enemy_side = "WEST";
d_enemy_side_short = "W";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
d_own_side = "GUER";
d_enemy_side = "EAST";
d_enemy_side_short = "E";
#endif
#ifdef __TT__
d_own_side = "WEST";
d_enemy_side = "GUER";
d_enemy_side_short = "G";
#endif

d_side_enemy = switch (d_enemy_side_short) do {
	case "E": {opfor};
	case "W": {blufor};
	case "G": {independent};
};

d_side_player =
#ifdef __OWN_SIDE_OPFOR__
	opfor;
#endif
#ifdef __OWN_SIDE_BLUFOR__
	blufor;
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	independent;
#endif
#ifdef __TT__
	blufor;
#endif

d_version_string =
#ifdef __OWN_SIDE_OPFOR__
	"Opfor";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"Blufor";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"GUER";
#endif
#ifdef __TT__
	"Two Teams";
#endif

d_e_marker_color =
#ifdef __OWN_SIDE_OPFOR__
	"ColorBLUFOR";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"ColorOPFOR";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"ColorOPFOR";
#endif
#ifdef __TT__
	"ColorYellow";
#endif

d_rep_truck = switch (d_own_side) do {
	case "EAST": {"O_Truck_03_repair_F"};
	case "WEST": {"B_Truck_01_Repair_F"};
	case "GUER": {"I_Truck_02_box_F"};
};

#ifdef __ALTIS__
d_sm_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_UGV_01_F","I_UGV_01_rcws_F"]};
	case "WEST": {["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F","B_UGV_01_F","B_UGV_01_rcws_F","B_MBT_01_TUSK_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F"]};
	case "EAST": {["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Plane_CAS_02_F"]};
};
#endif
#ifdef __CUP_CHERNARUS__
d_sm_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_UGV_01_F","I_UGV_01_rcws_F"]};
	case "WEST": {
		["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F",
		"B_UGV_01_F","B_UGV_01_rcws_F","B_MBT_01_TUSK_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F",
		"I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F",
		"CUP_B_AH1_BAF","CUP_B_AH1_AT_BAF","CUP_B_AW159_Armed_BAF","CUP_I_Mi24_D_UN","CUP_I_BMP2_UN","CUP_B_A10_CAS_USA","CUP_B_A10_AT_USA","CUP_B_AH64D_USA","CUP_B_M163_USA","CUP_B_M1A1_Woodland_US_Army",
		"CUP_B_M1A2_TUSK_MG_US_Army","CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M6LineBacker_USA_W","CUP_B_AV8B_Hydra19","CUP_B_AH1Z","CUP_B_UH1Y_GUNSHIP_USMC"]
	};
	case "EAST": {["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Plane_CAS_02_F"]};
};
#endif
#ifdef __CUP_TAKISTAN__
d_sm_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_UGV_01_F","I_UGV_01_rcws_F"]};
	case "WEST": {
		["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F",
		"B_UGV_01_F","B_UGV_01_rcws_F","B_MBT_01_TUSK_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F",
		"I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F",
		"CUP_B_AH1_BAF","CUP_B_AH1_AT_BAF","CUP_B_AW159_Armed_BAF","CUP_I_Mi24_D_UN","CUP_I_BMP2_UN","CUP_B_A10_CAS_USA","CUP_B_A10_AT_USA","CUP_B_AH64D_USA","CUP_B_M163_USA","CUP_B_M1A1_Woodland_US_Army",
		"CUP_B_M1A2_TUSK_MG_US_Army","CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M6LineBacker_USA_W","CUP_B_AV8B_Hydra19","CUP_B_AH1Z","CUP_B_UH1Y_GUNSHIP_USMC"]
	};
	case "EAST": {["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Plane_CAS_02_F"]};
};
#endif
#ifdef __CUP_SARA__
d_sm_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_UGV_01_F","I_UGV_01_rcws_F"]};
	case "WEST": {
		["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F",
		"B_UGV_01_F","B_UGV_01_rcws_F","B_MBT_01_TUSK_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F",
		"I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F",
		"CUP_B_AH1_BAF","CUP_B_AH1_AT_BAF","CUP_B_AW159_Armed_BAF","CUP_I_Mi24_D_UN","CUP_I_BMP2_UN","CUP_B_A10_CAS_USA","CUP_B_A10_AT_USA","CUP_B_AH64D_USA","CUP_B_M163_USA","CUP_B_M1A1_Woodland_US_Army",
		"CUP_B_M1A2_TUSK_MG_US_Army","CUP_B_M2Bradley_USA_W","CUP_B_M2A3Bradley_USA_W","CUP_B_M6LineBacker_USA_W","CUP_B_AV8B_Hydra19","CUP_B_AH1Z","CUP_B_UH1Y_GUNSHIP_USMC"]
	};
	case "EAST": {["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_APC_Tracked_02_cannon_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Plane_CAS_02_F"]};
};
#endif
#ifdef __TT__
if (!d_tt_tanoa) then {
	d_sm_bonus_vehicle_array = [
		["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F","B_UGV_01_F","B_UGV_01_rcws_F","B_MBT_01_TUSK_F","B_Plane_CAS_01_F"],
		["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Plane_CAS_02_F"]
	];
} else {
	d_sm_bonus_vehicle_array = [
		["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F","B_UGV_01_F","B_UGV_01_rcws_F","B_MBT_01_TUSK_F","B_Plane_CAS_01_F","B_T_VTOL_01_armed_F"],
		["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Plane_CAS_02_F","O_T_VTOL_02_infantry_F"]
	];
};
#endif
#ifdef __TANOA__
d_sm_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_UGV_01_F","I_UGV_01_rcws_F"]};
	case "WEST": {["B_Heli_Light_01_armed_F","B_Heli_Attack_01_F","B_APC_Wheeled_01_cannon_F","B_APC_Tracked_01_rcws_F","B_MBT_01_cannon_F","B_APC_Tracked_01_AA_F","B_UGV_01_F","B_UGV_01_rcws_F","B_MBT_01_TUSK_F","B_Plane_CAS_01_F","I_Plane_Fighter_03_AA_F","I_Plane_Fighter_03_CAS_F","I_Heli_light_03_F","I_APC_Wheeled_03_cannon_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "B_T_VTOL_01_armed_F"]};
	case "EAST": {["O_Heli_Attack_02_F","O_Heli_Attack_02_black_F","O_APC_Tracked_02_cannon_F","O_APC_Wheeled_02_rcws_F","O_APC_Tracked_02_AA_F","O_MBT_02_cannon_F","O_UGV_01_F","O_UGV_01_rcws_F","O_Plane_CAS_02_F"]};
};
#endif

#ifdef __ALTIS__
d_mt_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]};
	case "WEST": {["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]};
	case "EAST": {["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]};
};
#endif
#ifdef __CUP_CHERNARUS__
d_mt_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]};
	case "WEST": {
		["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F",
		"CUP_B_Jackal2_GMG_GB_W","CUP_B_LR_MG_GB_W","CUP_I_UAZ_AGS30_UN","CUP_I_UAZ_MG_UN","CUP_I_UAZ_SPG9_UN","CUP_I_M113_UN","CUP_I_BRDM2_UN","CUP_B_HMMWV_Avenger_USA","CUP_B_HMMWV_Crows_M2_USA","CUP_B_HMMWV_Crows_M2_USA",
		"CUP_B_HMMWV_M2_GPK_USA","CUP_B_HMMWV_SOV_USA","CUP_B_HMMWV_TOW_USA","CUP_B_M113_USA","CUP_B_AAV_USMC","CUP_B_LAV25_USMC"]
	};
	case "EAST": {["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]};
};
#endif
#ifdef __CUP_TAKISTAN__
d_mt_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]};
	case "WEST": {
		["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F",
		"CUP_B_Jackal2_GMG_GB_W","CUP_B_LR_MG_GB_W","CUP_I_UAZ_AGS30_UN","CUP_I_UAZ_MG_UN","CUP_I_UAZ_SPG9_UN","CUP_I_M113_UN","CUP_I_BRDM2_UN","CUP_B_HMMWV_Avenger_USA","CUP_B_HMMWV_Crows_M2_USA","CUP_B_HMMWV_Crows_M2_USA",
		"CUP_B_HMMWV_M2_GPK_USA","CUP_B_HMMWV_SOV_USA","CUP_B_HMMWV_TOW_USA","CUP_B_M113_USA","CUP_B_AAV_USMC","CUP_B_LAV25_USMC"]
	};
	case "EAST": {["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]};
};
#endif
#ifdef __CUP_SARA__
d_mt_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]};
	case "WEST": {
		["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F",
		"CUP_B_Jackal2_GMG_GB_W","CUP_B_LR_MG_GB_W","CUP_I_UAZ_AGS30_UN","CUP_I_UAZ_MG_UN","CUP_I_UAZ_SPG9_UN","CUP_I_M113_UN","CUP_I_BRDM2_UN","CUP_B_HMMWV_Avenger_USA","CUP_B_HMMWV_Crows_M2_USA","CUP_B_HMMWV_Crows_M2_USA",
		"CUP_B_HMMWV_M2_GPK_USA","CUP_B_HMMWV_SOV_USA","CUP_B_HMMWV_TOW_USA","CUP_B_M113_USA","CUP_B_AAV_USMC","CUP_B_LAV25_USMC"]
	};
	case "EAST": {["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]};
};
#endif
#ifdef __TT__
if (!d_tt_tanoa) then {
	d_mt_bonus_vehicle_array = [
		["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F"],
		["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]
	];
} else {
	d_mt_bonus_vehicle_array = [
		["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","B_T_LSV_01_armed_F"],
		["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F","O_T_LSV_02_armed_F"]
	];
};
#endif
#ifdef __TANOA__
d_mt_bonus_vehicle_array =
switch (d_own_side) do {
	case "GUER": {["I_MRAP_03_hmg_F","I_MRAP_03_gmg_F"]};
	case "WEST": {["B_MRAP_01_hmg_F","B_MRAP_01_gmg_F","I_MRAP_03_hmg_F","I_MRAP_03_gmg_F","B_T_LSV_01_armed_F"]};
	case "EAST": {["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]};
};
#endif

#ifndef __TT__
d_sm_bonus_vehicle_array = d_sm_bonus_vehicle_array apply {toUpper _x};
d_mt_bonus_vehicle_array = d_mt_bonus_vehicle_array apply {toUpper _x};
// these vehicles can be lifted by the wreck lift chopper (previous chopper 4), but only, if they are completely destroyed
d_heli_wreck_lift_types = d_sm_bonus_vehicle_array + d_mt_bonus_vehicle_array;
#else
d_sm_bonus_vehicle_array set [0, (d_sm_bonus_vehicle_array select 0) apply {toUpper _x}];
d_sm_bonus_vehicle_array set [1, (d_sm_bonus_vehicle_array select 1) apply {toUpper _x}];
d_mt_bonus_vehicle_array set [0, (d_mt_bonus_vehicle_array select 0) apply {toUpper _x}];
d_mt_bonus_vehicle_array set [1, (d_mt_bonus_vehicle_array select 1) apply {toUpper _x}];

d_heli_wreck_lift_types = (d_sm_bonus_vehicle_array select 0) + (d_sm_bonus_vehicle_array select 1) + (d_mt_bonus_vehicle_array select 0) + (d_mt_bonus_vehicle_array select 1);
#endif

d_x_drop_array =
#ifdef __OWN_SIDE_INDEPENDENT__
	[[], [localize "STR_DOM_MISSIONSTRING_22","I_MRAP_03_F"], [localize "STR_DOM_MISSIONSTRING_20", "Box_IND_Ammo_F"]];
#endif
#ifdef __OWN_SIDE_BLUFOR__
	[[], [localize "STR_DOM_MISSIONSTRING_22","B_MRAP_01_F"], [localize "STR_DOM_MISSIONSTRING_20", "Box_NATO_Ammo_F"]];
#endif
#ifdef __OWN_SIDE_OPFOR__
	[[], [localize "STR_DOM_MISSIONSTRING_22","O_MRAP_02_F"], [localize "STR_DOM_MISSIONSTRING_20", "Box_East_Ammo_F"]];
#endif
#ifdef __TT__
	[[], [], []];
#endif

// side of the pilot that will fly the drop air vehicle
d_drop_side = d_own_side;

// d_jumpflag_vec = empty ("") means normal jump flags for HALO jump get created
// if you add a vehicle typename to d_jumpflag_vec (d_jumpflag_vec = "B_Quadbike_01_F"; for example) only a vehicle gets created and no HALO jump is available
//d_jumpflag_vec = "B_Quadbike_01_F";
d_jumpflag_vec = "";

// please note, player string names are case sensitive! You have to use exactly the same case as in the editor here!
#ifndef __TT__
d_player_entities = ["d_artop_1","d_artop_2",
	"d_alpha_1","d_alpha_2","d_alpha_3","d_alpha_4","d_alpha_5","d_alpha_6","d_alpha_7","d_alpha_8",
	"d_bravo_1","d_bravo_2","d_bravo_3","d_bravo_4","d_bravo_5","d_bravo_6","d_bravo_7","d_bravo_8",
	"d_charlie_1","d_charlie_2","d_charlie_3","d_charlie_4","d_charlie_5","d_charlie_6","d_charlie_7","d_charlie_8",
	"d_delta_1","d_delta_2","d_delta_3","d_delta_4","d_delta_5","d_delta_6",
	"d_echo_1","d_echo_2","d_echo_3","d_echo_4","d_echo_5","d_echo_6","d_echo_7","d_echo_8"];
#else
d_entities_tt_blufor = ["d_artop_blufor","d_blufor_1","d_blufor_2","d_blufor_3","d_blufor_4","d_blufor_5","d_blufor_6","d_blufor_7",
	"d_blufor_8","d_blufor_9","d_blufor_10","d_blufor_11","d_blufor_12","d_blufor_13","d_blufor_14","d_blufor_15","d_blufor_16",
	"d_blufor_17","d_blufor_18","d_blufor_19","d_blufor_20","d_blufor_21","d_blufor_22","d_blufor_23","d_blufor_24"];
	
d_entities_tt_opfor = ["d_artop_opfor","d_opfor_1","d_opfor_2","d_opfor_3","d_opfor_4","d_opfor_5","d_opfor_6","d_opfor_7",
	"d_opfor_8","d_opfor_9","d_opfor_10","d_opfor_11","d_opfor_12","d_opfor_13","d_opfor_14","d_opfor_15","d_opfor_16","d_opfor_17",
	"d_opfor_18","d_opfor_19","d_opfor_20","d_opfor_21","d_opfor_22","d_opfor_23","d_opfor_24"];
#endif

d_servicepoint_building = "Land_Cargo_House_V2_F";

d_illum_tower = "Land_TTowerBig_2_F";
d_wcamp = "Land_Cargo_Patrol_V1_F";

d_mash = "Land_TentDome_F";
d_mash_flag = "Flag_RedCrystal_F";

d_dropped_box_marker = "mil_marker";

d_strongpointmarker = "mil_objective";

d_flag_str_blufor = "\a3\data_f\flags\flag_blue_co.paa";
d_flag_str_opfor = "\a3\data_f\flags\flag_red_co.paa";
d_flag_str_independent = "\a3\data_f\flags\flag_green_co.paa";

d_SlopeObject = "Logic" createVehicleLocal [0,0,0];

d_cargo_chute =
#ifdef __OWN_SIDE_BLUFOR__
	"B_Parachute_02_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
	"O_Parachute_02_F";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"I_Parachute_02_F";
#endif
#ifdef __TT__
	"I_Parachute_02_F";
#endif

d_flag_pole = "FlagPole_F";

d_vec_camo_net =
#ifdef __OWN_SIDE_OPFOR__
	"CamoNet_OPFOR_big_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"CamoNet_BLUFOR_big_F";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"CamoNet_INDP_big_F";
#endif
#ifdef __TT__
	"CamoNet_INDP_big_F";
#endif

// internal
d_sm_winner = 0;
d_objectID1 = objNull;
d_objectID2 = objNull;

// no farps in A3 so we fake them
// first entry should always be a helipad because the trigger which is needed to make it work is spawned there
// second object is also needed, remove action gets added on the second object
d_farp_classes = ["Land_HelipadSquare_F", "Land_Cargo40_military_green_F"];

// artillery operators
#ifndef __TT__
d_can_use_artillery = ["d_artop_1", "d_artop_2"]; // case has to be the same as in mission.sqm, d_artop_1 D_ARTOP_1 is not the same :)
#else
d_can_use_artillery = ["d_artop_blufor", "d_artop_opfor"];
#endif

// those units can mark artillery targets but can not call in artillery strikes (only d_can_use_artillery can call in artillery strikes and also mark arty targets)
#ifndef __TT__
d_can_mark_artillery = ["d_alpha_1", "d_bravo_1", "d_charlie_1", "d_echo_1"];
#else
d_can_mark_artillery = ["d_blufor_1", "d_blufor_2", "d_blufor_3", "d_opfor_1", "d_opfor_2", "d_opfor_3"];
#endif

#ifndef __TT__
d_can_call_cas = ["d_alpha_1", "d_bravo_1", "d_charlie_1", "d_echo_1"];
#else
d_can_call_cas = ["d_blufor_1", "d_blufor_2", "d_blufor_3", "d_opfor_1", "d_opfor_2", "d_opfor_3"];
#endif

d_arty_m_marker =
#ifdef __OWN_SIDE_OPFOR__
	"o_art";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"b_art";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"n_art";
#endif
#ifdef __TT__
	"n_art";
#endif

d_color_m_marker =
#ifdef __OWN_SIDE_OPFOR__
	"ColorEAST";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"ColorWEST";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"ColorGUER";
#endif
#ifdef __TT__
	"ColorGUER";
#endif

#ifdef __TT__
d_tt_points = [
	30, // points for the main target winner team
	7, // points if draw (main target)
	15, // points for destroying main target radio tower
	5, // points for main target mission
	10, // points for sidemission
	5, // points for capturing a camp (main target)
	10, // points that get subtracted when loosing a mt camp again
	4, // points for destroying a vehicle of the other team
	2 // points for killing a member of the other team
];
#endif

d_cas_available_time = 600; // time till CAS is available again!

d_non_steer_para = "NonSteerable_Parachute_F";

private _isserv_or_hc = isServer || {!isDedicated && {!hasInterface}};

if (_isserv_or_hc) then {
	__TRACE_1("","_isserv_or_hc")
	d_player_store = d_HeliHEmpty createVehicleLocal [0, 0, 0];
	d_placed_objs_store = d_HeliHEmpty createVehicleLocal [0, 0, 0];
	d_placed_objs_store2 = d_HeliHEmpty createVehicleLocal [0, 0, 0];
	d_placed_objs_store3 = d_HeliHEmpty createVehicleLocal [0, 0, 0];
};

if (isServer) then {
	call compile preprocessFileLineNumbers "x_init\x_initcommon.sqf";
};

if (_isserv_or_hc) then {
	if (isServer) then {
		if (d_weather == 0) then {
			0 setOvercast (random 1);
			if (d_enable_fog == 0) then {
				private _fog = if (random 100 > 90) then {
					[random 0.1, 0.1, 20 + (random 40)]
				} else {
					[0,0,0]
				};
				__TRACE_1("","_fog")
				0 setFog _fog;
			} else {
				0 setFog [0, 0, 0];
				0 spawn {
					sleep 100;
					0 setFog [0, 0, 0];
				};
			};
			forceWeatherChange;
		} else {
			0 setFog [0, 0, 0];
			0 spawn {
				while {true} do {
					sleep 100;
					0 setFog [0, 0, 0];
				};
			};
		};
		
		if (d_timemultiplier > 1) then {
			setTimeMultiplier d_timemultiplier;
		};
	};
	// _E = Opfor
	// _W = Blufor
	// _G = Independent
	// this is what gets spawned
	d_allmen_E = [
#ifndef __TANOA__
		["East","OPF_F","Infantry","OIA_InfSquad"] call d_fnc_GetConfigGroup,
		["East","OPF_F","Infantry","OIA_InfSquad_Weapons"] call d_fnc_GetConfigGroup,
		["East","OPF_F","Infantry","OIA_InfTeam"] call d_fnc_GetConfigGroup,
		["East","OPF_F","Infantry","OIA_InfTeam_AT"] call d_fnc_GetConfigGroup,
		["East","OPF_F","Infantry","OI_reconPatrol"] call d_fnc_GetConfigGroup,
		["East","OPF_F","Infantry","OI_reconTeam"] call d_fnc_GetConfigGroup,
	    ["East","OPF_F","UInfantry","OIA_GuardSquad"] call d_fnc_GetConfigGroup,
		["East","OPF_F","UInfantry","OIA_GuardTeam"] call d_fnc_GetConfigGroup,
		["East","OPF_F","Infantry","OIA_InfTeam_AA"] call d_fnc_GetConfigGroup
#else
		["East","OPF_T_F","Infantry","O_T_InfSquad"] call d_fnc_GetConfigGroup,
		["East","OPF_T_F","Infantry","O_T_InfSquad_Weapons"] call d_fnc_GetConfigGroup,
		["East","OPF_T_F","Infantry","O_T_InfTeam"] call d_fnc_GetConfigGroup,
		["East","OPF_T_F","Infantry","O_T_InfTeam_AT"] call d_fnc_GetConfigGroup,
		["East","OPF_T_F","Infantry","O_T_InfTeam_AA"] call d_fnc_GetConfigGroup,
		["East","OPF_T_F","Infantry","O_T_reconPatrol"] call d_fnc_GetConfigGroup,
		["East","OPF_T_F","Infantry","O_T_reconTeam"] call d_fnc_GetConfigGroup
#endif
	];
	d_allmen_W = [
		["West","BLU_F","Infantry","BUS_InfSquad"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_InfSquad_Weapons"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_InfTeam"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_InfTeam_AT"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_InfSentry"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_ReconPatrol"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_ReconSentry"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_ReconTeam"] call d_fnc_GetConfigGroup,
		["West","BLU_F","Infantry","BUS_InfTeam_AA"] call d_fnc_GetConfigGroup
	];
	d_allmen_G = [
		["Indep","IND_F","Infantry","HAF_InfSquad"] call d_fnc_GetConfigGroup,
		["Indep","IND_F","Infantry","HAF_InfSquad"] call d_fnc_GetConfigGroup,
		["Indep","IND_F","Infantry","HAF_InfSquad"] call d_fnc_GetConfigGroup,
		["Indep","IND_F","Infantry","HAF_InfSquad_Weapons"] call d_fnc_GetConfigGroup,
		["Indep","IND_F","Infantry","HAF_InfTeam"] call d_fnc_GetConfigGroup,
		["Indep","IND_F","Infantry","HAF_InfTeam_AT"] call d_fnc_GetConfigGroup,
		["Indep","IND_F","Infantry","HAF_InfTeam_AA"] call d_fnc_GetConfigGroup,
		["Guerilla","FIA","Infantry","IRG_InfSquad"] call d_fnc_GetConfigGroup,
		["Guerilla","FIA","Infantry","IRG_InfSquad_Weapons"] call d_fnc_GetConfigGroup,
		["Guerilla","FIA","Infantry","IRG_InfTeam"] call d_fnc_GetConfigGroup,
		["Guerilla","FIA","Infantry","IRG_InfTeam_AT"] call d_fnc_GetConfigGroup
#ifdef __TANOATT__
		,["Indep","IND_C_F","Infantry","BanditCombatGroup"] call d_fnc_GetConfigGroup,
		["Indep","IND_C_F","Infantry","BanditFireTeam"] call d_fnc_GetConfigGroup,
		["Indep","IND_C_F","Infantry","ParaCombatGroup"] call d_fnc_GetConfigGroup,
		["Indep","IND_C_F","Infantry","ParaShockTeam"] call d_fnc_GetConfigGroup
#endif
	];

	d_specops_E = [
#ifndef __TANOA__
	["East","OPF_F","Infantry","OI_reconTeam"] call d_fnc_GetConfigGroup,
	["East","OPF_F","SpecOps","OI_ViperTeam"] call d_fnc_GetConfigGroup
#else
	["East","OPF_T_F","Infantry","O_T_reconTeam"] call d_fnc_GetConfigGroup,
	["East","OPF_T_F","SpecOps","O_T_ViperTeam"] call d_fnc_GetConfigGroup
#endif
	];
	d_specops_W = [["West","BLU_F","Infantry","BUS_ReconTeam"] call d_fnc_GetConfigGroup];
	d_specops_G = [["I_G_Soldier_exp_F", "I_Soldier_exp_F", "I_G_Soldier_GL_F", "I_G_medic_F"]];

#ifndef __CUP__
	d_veh_a_E =
	[
		if (!d_tanoa) then {["O_MBT_02_cannon_F"]} else {["O_T_MBT_02_cannon_ghex_F"]},
		if (!d_tanoa) then {["O_APC_Tracked_02_cannon_F"]} else {["O_T_APC_Tracked_02_cannon_ghex_F"]},
		if (!d_tanoa) then {["O_APC_Wheeled_02_rcws_F"]} else {["O_T_APC_Wheeled_02_rcws_ghex_F"]},
		if (!d_tanoa) then {["O_APC_Tracked_02_AA_F"]} else {["O_T_APC_Tracked_02_AA_ghex_F"]},
		if (!d_tanoa) then {["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"]} else {["O_T_MRAP_02_gmg_ghex_F","O_T_MRAP_02_hmg_ghex_F"]},
		if (!d_tanoa) then {["O_G_Offroad_01_armed_F"]} else {["O_T_LSV_02_armed_F"]},
		["O_GMG_01_F","O_GMG_01_high_F"], //O_GMG_01_A_F, removed because it creates an invisible gunner (UAV type)
		["O_HMG_01_F","O_HMG_01_high_F","O_static_AA_F","O_static_AT_F"], // O_HMG_01_A_F, removed because it creates an invisible gunner (UAV type)
		["O_Mortar_01_F"],
		if (!d_tanoa) then {["O_Truck_02_fuel_F"]} else {["O_T_Truck_03_fuel_ghex_F"]},
		["O_Truck_02_box_F"],
		if (!d_tanoa) then {["O_Truck_02_Ammo_F"]} else {["O_T_Truck_03_ammo_ghex_F"]}
	];
#else
	d_veh_a_E =
	[
		["O_MBT_02_cannon_F","CUP_O_T72_CHDKZ","CUP_O_T72_RU"],
		["O_APC_Tracked_02_cannon_F","CUP_O_BMP2_CHDKZ","CUP_O_BMP2_RU"],
		["O_APC_Wheeled_02_rcws_F","CUP_O_BRDM2_CHDKZ","CUP_O_BRDM2_ATGM_CHDKZ","CUP_O_BTR90_RU"],
		["O_APC_Tracked_02_AA_F","CUP_O_ZSU23_ChDKZ","CUP_O_Ural_ZU23_RU"],
		["O_MRAP_02_hmg_F","O_MRAP_02_gmg_F"],
		["O_G_Offroad_01_armed_F"],
		["O_GMG_01_F","O_GMG_01_high_F","CUP_B_UAZ_AGS30_CDF","CUP_O_UAZ_AGS30_RU","CUP_O_UAZ_MG_RU","CUP_O_UAZ_METIS_RU","CUP_O_UAZ_SPG9_RU","CUP_O_LR_MG_TKA"], //O_GMG_01_A_F, removed because it creates an invisible gunner (UAV type)
		["O_HMG_01_F","O_HMG_01_high_F","O_static_AA_F","O_static_AT_F"], // O_HMG_01_A_F, removed because it creates an invisible gunner (UAV type)
		["O_Mortar_01_F"],
		["O_Truck_02_fuel_F"],
		["O_Truck_02_box_F"],
		["O_Truck_02_Ammo_F"]
	];
#endif

	d_veh_a_W =
	[
		["B_MBT_01_cannon_F","B_MBT_01_TUSK_F"],
		["B_APC_Tracked_01_rcws_F"],
		["B_APC_Wheeled_01_cannon_F"],
		["B_APC_Tracked_01_AA_F"],
		["B_MRAP_01_gmg_F","B_MRAP_01_hmg_F"],
		["B_G_Offroad_01_armed_F"],
		["B_GMG_01_F","B_GMG_01_high_F"],
		["B_HMG_01_F","B_HMG_01_high_F","B_static_AA_F","B_static_AT_F"], // , "B_HMG_01_A_F"
		["B_Mortar_01_F", "B_G_Mortar_01_F"],
		["B_Truck_01_fuel_F"],
		["B_Truck_01_Repair_F"],
		["B_Truck_01_ammo_F"]
	];
		
	d_veh_a_G =
	[
		["I_MBT_03_cannon_F"],
        ["I_APC_tracked_03_cannon_F"],
        ["I_APC_Wheeled_03_cannon_F"],
        ["I_MRAP_03_hmg_F"],
        ["I_G_Offroad_01_armed_F"],
        ["I_MRAP_03_gmg_F"],
        ["I_HMG_01_F","I_GMG_01_high_F"],
        ["I_GMG_01_F","I_HMG_01_high_F","I_static_AA_F","I_static_AT_F"],
        ["I_Mortar_01_F", "I_G_Mortar_01_F"],
        ["I_Truck_02_fuel_F"],
        ["I_Truck_02_box_F"],
        ["I_Truck_02_ammo_F"]
	];

	d_arti_observer_E = 
#ifndef __TANOA__
		[["O_recon_JTAC_F"]];
#else
		[["O_T_Recon_JTAC_F"]];
#endif
	d_arti_observer_W = [["B_recon_JTAC_F"]];
	d_arti_observer_G = [["I_Soldier_TL_F"]];
	
	d_number_attack_planes = 1;
	d_number_attack_choppers = 1;
	
	// Type of aircraft, that will air drop stuff
	d_drop_aircraft =
#ifdef __OWN_SIDE_INDEPENDENT__
		"I_Heli_Transport_02_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
		"B_Heli_Transport_01_camo_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
		"O_Heli_Light_02_unarmed_F";
#endif
#ifdef __TT__
		"O_Heli_Light_02_unarmed_F";
#endif

	if (isServer && {d_with_ai || {d_with_ai_features == 0}}) then {
		d_taxi_aircraft =
#ifdef __OWN_SIDE_INDEPENDENT__
			"I_Heli_Transport_02_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
			"B_Heli_Transport_01_camo_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
			"O_Heli_Light_02_unarmed_F";
#endif
#ifdef __TT__
			"O_Heli_Light_02_unarmed_F";
#endif
	};
d_cas_plane = 
#ifdef __OWN_SIDE_INDEPENDENT__
			"I_Plane_Fighter_03_CAS_F";
#endif
#ifdef __OWN_SIDE_BLUFOR__
			"B_Plane_CAS_01_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
			"O_Plane_CAS_02_F";
#endif
#ifdef __TT__
			["B_Plane_CAS_01_F", "O_Plane_CAS_02_F"];
#endif

	// max men for main target clear
	d_man_count_for_target_clear = 6;
	// max tanks for main target clear
	d_tank_count_for_target_clear = 1;
	// max cars for main target clear
	d_car_count_for_target_clear = 1;
	
	// time (in sec) between attack planes and choppers over main target will respawn once they were shot down (a random value between 0 and 240 will be added)
	d_airai_respawntime = 1200;

	d_side_missions_random = [];

	// don't remove d_recapture_indices even if you set d_WithRecapture to 1
	d_recapture_indices = [];

	// max number of cities that the enemy will recapture at once
	// if set to -1 no check is done
	d_max_recaptures = 2;
	
	d_time_until_next_sidemission = [
		[10,300], // if player number <= 10, it'll take 300 seconds until the next sidemission
		[20,400], // if player number <= 20, it'll take 400 seconds until the next sidemission
		[30,500], // if player number <= 30, it'll take 500 seconds until the next sidemission
		[40,600] // if player number <= 40, it'll take 600 seconds until the next sidemission
	];

	d_civilians_t = ["C_man_1","C_man_1_1_F","C_man_1_2_F","C_man_1_3_F","C_man_polo_1_F","C_man_polo_2_F","C_man_polo_3_F","C_man_polo_4_F","C_man_polo_5_F","C_man_polo_6_F"];
	
	d_base_aa_vec =
#ifdef __OWN_SIDE_INDEPENDENT__
	"";
#endif
#ifdef __OWN_SIDE_BLUFOR__
	"B_APC_Tracked_01_AA_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
	"O_APC_Tracked_02_AA_F";
#endif
#ifdef __TT__
	"";
#endif
	
	d_wreck_cur_ar = [];
	
	d_sm_fortress = "Land_Cargo_House_V2_F";
	d_functionary = "C_Nikos_aged";
	d_fuel_station = "Land_FuelStation_Build_F";//Land_FuelStation_Shed_F
	d_sm_cargo = switch (d_enemy_side_short) do {
		case "E": {"O_Truck_02_box_F"};
		case "W": {"B_Truck_01_box_F"};
		case "G": {"I_Truck_02_box_F"};
	};
	//d_sm_hangar = "Land_TentHangar_V1_F"; // Land_TentHangar_V1_F creates 3 objects and adding a killed eh makes it useless as the correct object might never get destroyed
	d_sm_hangar = "Land_Hangar_F";
	d_sm_tent = "Land_TentA_F";

	d_sm_land_tankbig = "Land_dp_bigTank_F";
	d_sm_land_transformer = "Land_dp_transformer_F";
	d_sm_barracks = "Land_i_Barracks_V2_F";
	d_sm_land_tanksmall = "Land_dp_smallTank_F";
	d_sm_land_factory = "Land_u_Barracks_V2_F";
	d_sm_small_radar = "Land_Radar_Small_F";
	
	d_soldier_officer = switch (d_enemy_side_short) do {
		case "E": {"O_officer_F"};
		case "W": {"B_officer_F"};
		case "G": {"I_officer_F"};
	};
	d_sniper = switch (d_enemy_side_short) do {
		case "E": {"O_sniper_F"};
		case "W": {"B_sniper_F"};
		case "G": {"I_sniper_F"};
	};
	d_sm_arty = switch (d_enemy_side_short) do {
		case "E": {"O_MBT_02_arty_F"};
		case "W": {"B_MBT_01_arty_F"};
		case "G": {"B_MBT_01_arty_F"}; // no independent arty in Alpha 3
	};
	d_sm_plane = switch (d_enemy_side_short) do {
		case "E": {"O_Plane_CAS_02_F"};
		case "W": {"B_Plane_CAS_01_F"};
		case "G": {"I_Plane_Fighter_03_CAS_F"};
	};
	d_sm_tank = switch (d_enemy_side_short) do {
		case "E": {"O_MBT_02_cannon_F"};
		case "W": {"B_MBT_01_cannon_F"};
		case "G": {"I_MBT_03_cannon_F"};
	};
	d_sm_HunterGMG = switch (d_enemy_side_short) do {
		case "E": {"O_MRAP_02_gmg_F"};
		case "W": {"B_MRAP_01_gmg_F"};
		case "G": {"I_MRAP_03_hmg_F"};
	};
	d_sm_SpeedBoat = switch (d_enemy_side_short) do {
		case "E": {"O_Boat_Armed_01_hmg_F"};
		case "W": {"B_Boat_Armed_01_hmg_F"};
		case "G": {"I_Boat_Armed_01_hmg_F"};
	};
	d_sm_submarine = switch (d_enemy_side_short) do {
		case "E": {"O_SDV_01_F"};
		case "W": {"B_SDV_01_F"};
		case "G": {"I_SDV_01_F"};
	};
	d_sm_AssaultBoat = switch (d_enemy_side_short) do {
		case "E": {"O_Boat_Transport_01_F"};
		case "W": {"B_Boat_Transport_01_F"};
		case "G": {"I_Boat_Transport_01_F"};
	};
	d_sm_chopper = switch (d_enemy_side_short) do {
		case "E": {"O_Heli_Attack_02_black_F"};
		case "W": {"B_Heli_Attack_01_F"};
		case "G": {"I_Heli_light_03_F"};
	};
	d_sm_pilottype = switch (d_enemy_side_short) do {
		case "E": {"B_Helipilot_F"};
		case "W": {"O_helipilot_F"};
		case "G": {"I_helipilot_F"};
	};
	d_sm_wrecktype = switch (d_enemy_side_short) do {
		case "E": {"Land_Wreck_Heli_Attack_01_F"};
		case "W": {"Land_UWreck_Heli_Attack_02_F"};
		case "G": {"Land_Wreck_Heli_Attack_02_F"};
	};
	d_sm_ammotrucktype = switch (d_enemy_side_short) do {
		case "E": {"O_Truck_02_Ammo_F"};
		case "W": {"B_Truck_01_ammo_F"};
		case "G": {"I_Truck_02_ammo_F"};
	};
	
	d_intel_unit = objNull;

	d_ArtyShellsBlufor = [
		"Sh_120mm_HE", // HE
		"Smoke_120mm_AMOS_White", // Smoke
		"G_40mm_HE" // dpicm
	];

	d_ArtyShellsOpfor = [
		"Sh_120mm_HE", // HE
		"Smoke_120mm_AMOS_White", // Smoke
		"G_40mm_HE" // dpicm
	];

	d_all_simulation_stoped = false;

	d_hd_sim_types = ["SHOTPIPEBOMB", "SHOTTIMEBOMB", "SHOTDIRECTIONALBOMB", "SHOTMINE"];
	d_hd_sim_types apply {toUpper _x};

	d_isle_defense_marker = "n_mech_inf";

	d_air_radar = switch (d_enemy_side_short) do {
		case "W": {"Land_Radar_Small_F"};
		case "E": {"Land_Radar_Small_F"};
		case "G": {"Land_Radar_Small_F"};
	};

	d_enemy_hq = switch (d_enemy_side_short) do {
		case "E": {"Land_Cargo_HQ_V1_F"};
		case "W": {"Land_Cargo_HQ_V1_F"};
		case "G": {"Land_Cargo_HQ_V1_F"};
	};

	// type of enemy plane that will fly over the main target
#ifndef __CUP__
	d_airai_attack_plane = switch (d_enemy_side_short) do {
		case "E": {["O_Plane_CAS_02_F"]};
		case "W": {["B_Plane_CAS_01_F"]};
		case "G": {["I_Plane_Fighter_03_CAS_F"]};
	};
#else
	d_airai_attack_plane = switch (d_enemy_side_short) do {
		case "E": {["O_Plane_CAS_02_F","CUP_O_Su25_RU_3","CUP_O_Su25_RU_1","CUP_O_Su25_RU_2"]};
		case "W": {["B_Plane_CAS_01_F"]};
		case "G": {["I_Plane_Fighter_03_CAS_F"]};
	};
#endif

#ifndef __CUP__
	// type of enemy chopper that will fly over the main target
	d_airai_attack_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_Heli_Attack_02_F"]};
		case "W": {["B_Heli_Attack_01_F"]};
		case "G": {["I_Heli_light_03_F"]};
	};
#else
	// type of enemy chopper that will fly over the main target
	d_airai_attack_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_Heli_Attack_02_F","CUP_O_Mi24_P_RU","CUP_O_Mi24_V_RU","CUP_O_Ka50_SLA"]};
		case "W": {["B_Heli_Attack_01_F"]};
		case "G": {["I_Heli_light_03_F"]};
	};
#endif

#ifndef __CUP__
	// enemy parachute troops transport chopper
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_Heli_Light_02_F"]};
		case "W": {["B_Heli_Light_01_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#else
	d_transport_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_Heli_Light_02_F","CUP_O_MI6T_RU"]};
		case "W": {["B_Heli_Light_01_F"]};
		case "G": {["I_Heli_Transport_02_F"]};
	};
#endif

#ifndef __CUP__
	// light attack chopper (for example I_Heli_light_03_F with MG)
	d_light_attack_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_Heli_Attack_02_black_F"]};
		case "W": {["B_Heli_Light_01_armed_F"]};
		case "G": {["I_Heli_light_03_F"]};
	};
#else
	d_light_attack_chopper = switch (d_enemy_side_short) do {
		case "E": {["O_Heli_Attack_02_black_F", "CUP_O_Mi8_RU"]};
		case "W": {["B_Heli_Light_01_F"]};
		case "G": {["I_Heli_light_03_F"]};
	};
#endif
};

if (!isDedicated) then {
	__TRACE("preInit !isDedicated")
	// d_reserved_slot gives you the ability to add a reserved slot for admins
	// if you don't log in when you've chosen the slot, you'll get kicked after ~20 once the intro ended
	// default is no check, example: d_reserved_slot = "d_artop_1";
	d_reserved_slot = "";

	// d_uid_reserved_slots and d_uids_for_reserved_slots gives you the possibility to limit a slot
	// you have to add the var names of the units to d_uid_reserved_slots and in d_uids_for_reserved_slots the UIDs of valid players
	// d_uid_reserved_slots = ["d_alpha_1", "d_bravo_3"];
	// d_uids_for_reserved_slots = ["1234567", "7654321"];
	d_uid_reserved_slots = [];
	d_uids_for_reserved_slots = [];
	
	// this vehicle will be created if you use the "Create XXX" at a mobile respawn (old "Create Motorcycle") or at a jump flag
	// IMPORTANT !!!! for ranked version !!!!
	// if there is more than one vehicle defined in the array the vehicle will be selected by player rank
	// one vehicle only, vehicle is only available when the player is at least lieutenant
	d_create_bike =
#ifdef __OWN_SIDE_INDEPENDENT__
	["I_Quadbike_01_F"];
#endif
#ifdef __OWN_SIDE_BLUFOR__
	["B_Quadbike_01_F"];
#endif
#ifdef __OWN_SIDE_OPFOR__
	["O_Quadbike_01_F"];
#endif
#ifdef __TT__
	["O_Quadbike_01_F"];
#endif
	
#ifdef __OWN_SIDE_BLUFOR__
	d_UAV_Small = "B_UAV_01_F";
	d_UAV_Terminal = "B_UavTerminal";
#endif
#ifdef __OWN_SIDE_OPFOR__
	d_UAV_Small = "O_UAV_01_F";
	d_UAV_Terminal = "O_UavTerminal";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	d_UAV_Small = "I_UAV_01_F";
	d_UAV_Terminal = "I_UavTerminal";
#endif
	
	d_still_in_intro = true;

	d_cur_sm_txt = "";
	d_current_mission_resolved_text = "";

	// ammobox handling (default, loading and dropping boxes) it means the time diff in seconds before a box can be loaded or dropped again in a vehicle
	d_drop_ammobox_time = 10;
	d_current_truck_cargo_array = [];
	// d_check_ammo_load_vecs
	// the only vehicles that can load an ammo box are the transport choppers and MHQs__
	d_check_ammo_load_vecs =
#ifdef __OWN_SIDE_BLUFOR__
	["B_Heli_Light_01_F", "B_MRAP_01_F", "B_APC_Tracked_01_CRV_F", "B_T_APC_Tracked_01_CRV_F"];
#endif
#ifdef __OWN_SIDE_OPFOR__
	["O_MRAP_02_F", "O_Heli_Light_02_unarmed_F"];
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	["I_MRAP_03_F", "I_Heli_light_03_unarmed_F"];
#endif
#ifdef __TT__
	["B_Heli_Light_01_F", "B_APC_Tracked_01_CRV_F", "O_Heli_Light_02_unarmed_F", "B_T_APC_Tracked_01_CRV_F"];
#endif
	
	d_check_ammo_load_vecs = d_check_ammo_load_vecs apply {toUpper _x};

	d_weapon_respawn = true;

	// points needed to get a specific rank
	// gets even used in the unranked versions, though it's just cosmetic there
#ifndef __TT__
	d_points_needed = [
		20, // Corporal
		50, // Sergeant
		90, // Lieutenant
		140, // Captain
		200, // Major
		270 // Colonel
	];
#else
	d_points_needed = [
		100, // Corporal
		400, // Sergeant
		1000, // Lieutenant
		4000, // Captain
		10000, // Major
		20000 // Colonel
	];
#endif

	d_marker_vecs = [];

	// is engineer
#ifndef __TT__
	d_is_engineer = ["d_delta_1","d_delta_2","d_delta_3","d_delta_4","d_delta_5","d_delta_6"];
#else
	d_is_engineer = ["d_blufor_17","d_blufor_18","d_blufor_19","d_opfor_17","d_opfor_18","d_opfor_19"];
#endif

	// can build mash
#ifndef __TT__
	d_is_medic = ["d_alpha_6","d_bravo_6","d_charlie_6","d_echo_6"];
#else
	d_is_medic = ["d_blufor_20","d_blufor_21","d_blufor_22","d_blufor_23","d_blufor_24","d_opfor_20","d_opfor_21","d_opfor_22","d_opfor_23","d_opfor_24"];
#endif

	// can call in air drop
#ifndef __TT__
	d_can_call_drop_ar = ["d_alpha_1","d_charlie_1","d_echo_1"];
#else
	d_can_call_drop_ar = [];
#endif

	d_last_telepoint = 0;
	d_chophud_on = true;

	d_jump_helo =
#ifdef __OWN_SIDE_BLUFOR__
	"B_Heli_Transport_01_F";
#endif
#ifdef __OWN_SIDE_OPFOR__
	"O_Heli_Light_02_unarmed_F";
#endif
#ifdef __OWN_SIDE_INDEPENDENT__
	"I_Heli_light_03_unarmed_F";
#endif
#ifdef __TT__
	"I_Heli_light_03_unarmed_F";
#endif
	
	d_headbug_vehicle = "B_Quadbike_01_F";
	
	d_drop_max_dist = 500;

	// if the array is empty, anybody with a pilot uniform and headgear can fly (if the latter is enabled)
	// if you add the string name of playable units (var name in the editor) only those players get a pilot uniform and headgear
	// makes only sense when only pilots can fly is enabled
	// for example: ["pilot_1","pilot_2"];, case sensitiv
	// PLEASE DO NOT CHANGE THIS FOR THE TT VERSION, IT SHOULD BE AN EMPTY ARRAY!!!!
	d_only_pilots_can_fly = [];
	
	d_the_box = switch (d_own_side) do {
		case "GUER": {"Box_IND_Wps_F"};
		case "EAST": {"Box_East_Wps_F"};
		case "WEST": {"Box_NATO_Wps_F"};
	};
	d_the_base_box = switch (d_own_side) do {
		case "GUER": {"I_supplyCrate_F"};//Box_IND_WpsSpecial_F
		case "EAST": {"O_supplyCrate_F"};//Box_East_WpsSpecial_F
		case "WEST": {"B_supplyCrate_F"};//Box_NATO_WpsSpecial_F
	};
	
	d_rev_respawn_vec_types = [d_the_box, "B_MRAP_01_F", "O_MRAP_02_F", "I_MRAP_03_F", "B_APC_Tracked_01_CRV_F"];

	// internal variables
	d_flag_vec = objNull;
	d_rscspect_on = false;
	d_player_can_call_drop = 0;
	d_player_can_call_arti = 0;
	d_eng_can_repfuel = false;
	d_there_are_enemies_atbase = false;
	d_enemies_near_base = false;
	d_player_is_medic = false;
	d_vec_end_time = -1;
	d_rscCrewTextShownTimeEnd = -1;
	d_commandingMenuIniting = false;
	d_DomCommandingMenuBlocked = false;
	d_playerInMHQ = false;
	d_player_in_vec = false;
	d_clientScriptsAr = [false, true];
	d_areArtyVecsAvailable = false;
	d_ao_arty_vecs = [];
	d_misc_store = d_HeliHEmpty createVehicleLocal [0,0,0];
	
	// If you want to add additional non MHQ respawn points like additional bases for example
	// Usage: Each point array needs a unique name, position or marker name, description and a side (side is only valid for the TT version)
	// Example:
	//d_additional_respawn_points = [
	//	["D_UNIQUE_NAME_1", [1023, 5000, 4000], "My Cool Base", blufor],
	//	["D_UNIQUE_NAME_2", markerPos "myevencoolerbase", "My Even Cooler Base", blufor],
	//	["D_UNIQUE_NAME_3", markerPos "opforbase", "The Opfor Base", opfor],
	//	["D_UNIQUE_NAME_2", "myevencoolerbase", "My Even Cooler Base", blufor]
	//];
	d_additional_respawn_points = [];
	
	d_add_resp_points_uni = [];
	{
		d_add_resp_points_uni pushBack (_x select 0);
	} forEach d_additional_respawn_points;
	
	if (isMultiplayer) then {
		// does work but not in EDEN preinit!!!
		// In 1.60 not working EachFrame in EDEN preinit is fixed.... PreloadFinished still doesn't work...
		d_prl_fin_id = addMissionEventHandler ["PreloadFinished", {
			d_preloaddone = true;
			diag_log [diag_frameno, diag_ticktime, time, "Preload finished"];
			removeMissionEventHandler ["PreloadFinished", d_prl_fin_id];
			d_prl_fin_id = nil;
		}];
	} else {
		d_prl_fin_id = ["DOM_PRL_ID", "onPreloadFinished", {
			d_preloaddone = true;
			diag_log [diag_frameno, diag_ticktime, time, "Preload finished"];
			[d_prl_fin_id, "onPreloadFinished"] call bis_fnc_removeStackedEventHandler;
			d_prl_fin_id = nil;
		}] call bis_fnc_addStackedEventHandler;
	};
	
	d_client_check_init = addMissionEventhandler ["EachFrame", {
		if (!isNull player) then {
			if (isMultiplayer && {isNil "xr_phd_invulnerable"}) then {
				xr_phd_invulnerable = true;
				player setVariable ["d_p_ev_hd_last", time];
			};
			if (!isNil "d_init_processed" && {time > 0} && {!isNil "d_preloaddone"} && {!isNull (findDisplay 46)}) then {
				diag_log [diag_frameno, diag_tickTime, time, "Executing Dom local player pre start"];
				call compile preprocessFileLineNumbers "x_client\x_prestart.sqf";
				removeMissionEventHandler ["EachFrame", d_client_check_init];
				d_client_check_init = nil;
			};
		};
	}];
	
	execVM "tasks.sqf";
};

diag_log [diag_frameno, diag_ticktime, time, "Dom fn_preinit.sqf processed"];