// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_sidetrafo.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params ["_poss"];

private _objs = nearestObjects [_poss, ["Land_trafostanica_velka"], 40];

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
{_x addEventHandler ["handleDamage", {_this call d_fnc_AddSMPoints}]} forEach _objs;
#endif

sleep 2.123;
["specops", 2, "allmen", 1, _poss, 200, true] spawn d_fnc_CreateInf;
sleep 2.221;
["aa", 1, "tracked_apc", 1, "tank", 1, _poss, 1, 300, true] spawn d_fnc_CreateArmor;

while {{alive _x} count _objs > 0} do {sleep 5.326};

#ifndef __TT__
d_sm_winner = 2;
#else
if (d_sm_points_blufor > d_sm_points_opfor) then {
	d_sm_winner = 2;
} else {
	if (d_sm_points_opfor > d_sm_points_blufor) then {
		d_sm_winner = 1;
	} else {
		if (d_sm_points_opfor == d_sm_points_blufor) then {
			d_sm_winner = 123;
		};
	};
};
#endif
d_side_mission_resolved = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};