// by Xeno
#define THIS_FILE "fn_handleattackgroups.sqf"
#include "..\..\x_setup.sqf"

if (!isServer) exitWith {};

params ["_grps"];

private _allunits = [];
{
	_allunits append (units _x);
	sleep 0.011;
} forEach _grps;

sleep 1.2123;

private _numdown = 5;

while {!d_mt_radio_down} do {
	call d_fnc_mpcheck;
	if ({alive _x} count _allunits < _numdown) exitWith {
		d_c_attacking_grps = [];
		d_create_new_paras = true;
	};
	sleep 10.623;
};
