// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_m13.sqf"
#include "..\..\x_setup.sqf"

d_x_sm_pos = "d_sm_13" call d_fnc_smmapos; // index: 13,   Prime Minister, Kirona
d_x_sm_type = "normal"; // "convoy"

if (!isDedicated && {!d_IS_HC_CLIENT}) then {
	d_cur_sm_txt = localize "STR_DOM_MISSIONSTRING_1662";
	d_current_mission_resolved_text = localize "STR_DOM_MISSIONSTRING_737";
};

if (call d_fnc_checkSHC) then {
	private _poss = d_x_sm_pos select 0;
	["aa", 1, "tracked_apc", 1, "tank", 1, d_x_sm_pos select 1, 1, 0] spawn d_fnc_CreateArmor;
	sleep 2.123;
	["specops", 2, "allmen", 1, _poss, 200, true] spawn d_fnc_CreateInf;
	sleep 2.111;
	private _fortress = createVehicle [d_sm_fortress, _poss, [], 0, "NONE"];
	_fortress setDir (markerDir "d_sm_13");
	_fortress setPos _poss;
	d_x_sm_vec_rem_ar pushBack _fortress;
	sleep 2.123;
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	_sm_vec = _newgroup createUnit [d_functionary, _poss, [], 0, "FORM"];
	_sm_vec call d_fnc_removenvgoggles_fak;
	_sm_vec call d_fnc_addkillednormal;
	private _bpos = getPosATL _fortress;
	_bpos set [2, 1];
	_sm_vec setFormDir ((direction _fortress) + 90);
	_sm_vec setPos _bpos;
	d_x_sm_rem_ar pushBack _sm_vec;
	[_newgroup, 1] call d_fnc_setGState;
	sleep 2.123;
	private _leader = leader _newgroup;
	_leader setRank "COLONEL";
	_newgroup allowFleeing 0;
	_newgroup setbehaviour "AWARE";
	_leader disableAI "MOVE";
};