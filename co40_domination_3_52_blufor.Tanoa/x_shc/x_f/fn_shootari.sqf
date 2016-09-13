// by Xeno
#define THIS_FILE "fn_shootari.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params ["_pos_enemy", "_kind"];

private _radius = 30;
_pos_enemy params ["_cent_x", "_cent_y"];

private _type = if (d_enemy_side == "EAST") then {
	switch (_kind) do {
		case 0: {d_ArtyShellsOpfor select 2};
		case 1: {d_ArtyShellsOpfor select 0};
		default {d_ArtyShellsOpfor select 1};
	}
} else {
	switch (_kind) do {
		case 0: {d_ArtyShellsBlufor select 2};
		case 1: {d_ArtyShellsBlufor select 0};
		default {d_ArtyShellsBlufor select 1};
	}
};

private _num_shells = if (_kind in [0,1]) then {
#ifndef __TT__
	if (d_searchintel select 4 == 1) then {
#else
	if (floor random 3 == 0) then {
#endif
		_pos_enemy remoteExecCall ["d_fnc_doarti", [0, -2] select isDedicated];
	};
	3 + (ceil random 3)
} else {
	1
}; 

private _pos_ar = [];
private _height = switch (_kind) do {case 0;case 1: {150}; case 2: {1}};
while {count _pos_ar < _num_shells} do {
	private _angle = floor random 360;
	_pos_ar pushBack [_cent_x - ((random _radius) * sin _angle), _cent_y - ((random _radius) * cos _angle), _height];
	sleep 0.0153;
};
sleep 9.25 + (random 8);
for "_i" from 0 to (_num_shells - 1) do {
	private _shell = createVehicle [_type, _pos_ar select _i, [], 0, "NONE"];
	_shell setVelocity [0,0,-150];
	 sleep 0.923 + ((ceil random 10) / 10);
};
