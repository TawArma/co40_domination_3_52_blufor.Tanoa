// by Xeno
#define THIS_FILE "fn_sidesteal.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

sleep 10.213;

params ["_vec"];

private _reached_base = false;
#ifdef __TT__
private _winner = 0;
#endif
private _vma = format ["d_smvecposc_%1", _vec];

private _oldpos = getPosAsl _vec;

[_vma, _oldpos, "ICON", "ColorBlue", [0.5, 0.5], localize "STR_DOM_MISSIONSTRING_1584", 0, "mil_dot"] remoteExecCall ["d_fnc_CreateMarkerGlobal", 2];

while {alive _vec && {!_reached_base}} do {
	call d_fnc_mpcheck;
#ifndef __TT__
	if (_vec distance2D d_FLAG_BASE < 100) exitWith {_reached_base = true};
#else
	if (_vec distance2D d_WFLAG_BASE < 100) exitWith {
		_reached_base = true;
		_winner = 2;
	};
	if (_vec distance2D d_EFLAG_BASE < 100) exitWith {
		_reached_base = true;
		_winner = 1;
	};
#endif
	if (_oldpos distance2D _vec > 10) then {
		_oldpos = getPosAsl _vec;
		_vma setMarkerPos _oldpos;
	};
	sleep 5.2134;
};

if (alive _vec && {_reached_base}) then {
#ifndef __TT__
	d_sm_winner = 2;
#else
	d_sm_winner = _winner;
#endif
} else {
	d_sm_winner = -600;
};

_vma remoteExecCall ["deleteMarker", 2];

d_sm_resolved = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};