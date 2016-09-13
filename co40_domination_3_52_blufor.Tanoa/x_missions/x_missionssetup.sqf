// by Xeno
#define THIS_FILE "x_missionsetup.sqf"
#include "..\x_setup.sqf"

// I'm using x_mXX.sqf for the mission filename where XX (index number) has to be added to d_sm_array
d_sm_fname = "x_m";

// d_sm_array contains the indices of the sidemissions (it gets shuffled later)
// to remove a specific side mission just remove the index from d_sm_array
#ifdef __ALTIS__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
	41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
	61,62,63,64,65,66,67,68,69,70,71,72,73,74,100,101,102,103,104,105,106];
#endif
#ifdef __CUP_CHERNARUS__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,31,32,33,34,36,37,38,39,40,
	41,42,44,45,46,47,48,49,50,51,52];
#endif
#ifdef __CUP_TAKISTAN__
d_sm_array =
	[0,1,2,3,4,5,6,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,31,32,33,36,
	40,41,42,44,46,47,49,50,51,52];
#endif
#ifdef __CUP_SARA__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
	20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
	40,41,42,44,45,46,47,48,49,50,51,52];
#endif
#ifdef __TT__
d_sm_array =
	if (!d_tt_tanoa) then {
		[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,
		20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,
		41,42,43,44,45,46,47,48,49,50,51,52,53,54,55,56,57,58,59,60,
		61,62,63,64,65,66,67,68,69,70,71,72,73,74]}
	else {
		[0,1,2,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,
		20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
		40,41,42,44,47,48,49,50,51,52,53,64];
	};
#endif
#ifdef __TANOA__
d_sm_array =
	[0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,19,
	20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,
	40,41,42,44,47,48,49,50,51,52,53,64,100,101,102,103,104,105,106];
#endif

d_number_side_missions = count d_sm_array;

if (call d_fnc_checkSHC) then {		
	// these vehicles get spawned in a convoy sidemission. Be aware that it is the best to use a wheeled vehicle first as leader.
	// at least wheeled AI vehicles try to stay on the road somehow
#ifdef __ALTIS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_gmg_F","O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F", "O_Truck_02_box_F", "O_Truck_02_fuel_F", "O_Truck_02_Ammo_F", "O_APC_Tracked_02_AA_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __CUP_CHERNARUS__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_gmg_F","O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F", "O_Truck_02_box_F", "O_Truck_02_fuel_F", "O_Truck_02_Ammo_F", "O_APC_Tracked_02_AA_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __CUP_TAKISTAN__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_gmg_F","O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F", "O_Truck_02_box_F", "O_Truck_02_fuel_F", "O_Truck_02_Ammo_F", "O_APC_Tracked_02_AA_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __CUP_SARA__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_MRAP_02_gmg_F","O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F", "O_Truck_02_box_F", "O_Truck_02_fuel_F", "O_Truck_02_Ammo_F", "O_APC_Tracked_02_AA_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
#ifdef __TT__
	if (!d_tt_tanoa) then {
		d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
			case "E": {["O_MRAP_02_gmg_F","O_APC_Tracked_02_cannon_F", "O_MBT_02_cannon_F", "O_Truck_02_box_F", "O_Truck_02_fuel_F", "O_Truck_02_Ammo_F", "O_APC_Tracked_02_AA_F"]};
			case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
			case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
		};
	} else {
		d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
			case "E": {["O_T_MRAP_02_gmg_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F", "O_T_MBT_02_cannon_ghex_F", "O_T_Truck_03_covered_ghex_F", "O_T_Truck_03_fuel_ghex_F", "O_T_Truck_03_ammo_ghex_F", "O_T_APC_Tracked_02_AA_ghex_F"]};
			case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
			case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
		};
	};
#endif
#ifdef __TANOA__
	d_sm_convoy_vehicles = switch (d_enemy_side_short) do {
		case "E": {["O_T_MRAP_02_gmg_ghex_F","O_T_APC_Tracked_02_cannon_ghex_F", "O_T_MBT_02_cannon_ghex_F", "O_T_Truck_03_covered_ghex_F", "O_T_Truck_03_fuel_ghex_F", "O_T_Truck_03_ammo_ghex_F", "O_T_APC_Tracked_02_AA_ghex_F"]};
		case "W": {["B_MRAP_01_gmg_F","B_APC_Tracked_01_rcws_F", "B_MBT_01_cannon_F", "B_Truck_01_Repair_F", "B_Truck_01_fuel_F", "B_Truck_01_ammo_F", "B_APC_Tracked_01_AA_F"]};
		case "G": {["I_MRAP_03_gmg_F","I_APC_tracked_03_cannon_F", "I_MBT_03_cannon_F", "I_Truck_02_box_F", "I_Truck_02_fuel_F", "I_Truck_02_ammo_F", "I_APC_tracked_03_cannon_F"]};
	};
#endif
};

// Instead of a random vehicle chosen for winning a side mission you can setup it in the mission yourself now
// Add d_current_sm_bonus_vec to the beginning of a sidemission script with a vehicle class string and that vehicle gets chosen instead of a random one.
// Examples:
// d_current_sm_bonus_vec = "B_MBT_01_cannon_F";
// DON'T CHANGE IT HERE IN X_MISSIONSETUP.SQF!!!!!!!!!!!!!!!!!!!!!!!!!
if (call d_fnc_checkSHC) then {
#ifndef __TT__
	d_current_sm_bonus_vec = "";
#else
	d_current_sm_bonus_vec = ["", ""];
#endif
};
