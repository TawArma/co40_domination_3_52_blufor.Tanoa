// by Xeno
#define THIS_FILE "fn_sidetrains.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params ["_pos", "_trains"];

sleep 2.333;
["specops", 2, "allmen", 2, _pos, 200, true] spawn d_fnc_CreateInf;
sleep 2.333;
["aa", 1, "tracked_apc", 1, "tank", 1, _pos, 2, 300, true] spawn d_fnc_CreateArmor;

sleep 15.321;

#ifdef __TT__
d_sm_points_blufor = 0;
d_sm_points_opfor = 0;
{
	_x addEventHandler ["handleDamage", {_this call d_fnc_AddSMPoints}];
} forEach _trains;
#endif

while {{alive _x} count _trains > 0} do {sleep 5.321};

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