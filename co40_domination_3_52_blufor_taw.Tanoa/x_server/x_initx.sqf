// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_initx.sqf"
#include "..\x_setup.sqf"
if (!isServer) exitWith{};

call compile preprocessFileLineNumbers "x_shc\x_shcinit.sqf";

#ifndef __TT__
0 spawn {
	scriptName "spawn_x_initx_createbase";
	waitUntil {time > 0};
	sleep 2;

	private _mmm = markerPos "d_base_sb_ammoload";
	__TRACE_1("","_mmm")
	
	if !(_mmm isEqualTo [0,0,0]) then {
		private _ammop = createVehicle [d_servicepoint_building, _mmm, [], 0, "NONE"];
		_ammop setDir (markerDir "d_base_sb_ammoload");
		_ammop setPos _mmm;
		_ammop addEventHandler ["handleDamage", {0}];
	};

	if (d_base_aa_vec == "") exitWith {};
	
	if (isNil "d_HC_CLIENT_OBJ_OWNER") then {
		[d_own_side, d_base_aa_vec] call d_fnc_cgraa;
	} else {
		[d_own_side, d_base_aa_vec] remoteExecCall ["d_fnc_cgraa", d_HC_CLIENT_OBJ_OWNER];
	};
};
#endif