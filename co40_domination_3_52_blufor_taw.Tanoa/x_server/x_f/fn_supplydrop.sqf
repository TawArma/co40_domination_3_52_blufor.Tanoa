// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_supplydrop.sqf"
#include "..\..\x_setup.sqf"

params ["_vec", "_chute", "_is_ammo", "_drop_pos", "_mname"];

private "_helper_pos";

if (!isNull _vec) then {
	waitUntil {(ASLtoATL getPosASL _chute) select 2 <= 5 || {!alive _vec}};
	_helper_pos = getPosASL _vec;
} else {
	waitUntil {(ASLtoATL getPosASL _chute) select 2 <= 5};
	_drop_pos = getPosWorld _chute;
};

if (!isNull _vec) then {
	detach _chute;
	_chute disableCollisionWith _vec;
	if (alive _vec) then {
		if ((getPosATL _vec) select 2 <= -1) then {
			private _pos_vec = getPosATL _vec;
			private _vector = vectorUp _vec;
			_vec setVectorUp [_vector select 0, _vector select 1, 1];
			_vec setPos [_pos_vec select 0, _pos_vec select 1, 0.2];
		};
		_vec setDamage 0;
	};
	_mname setMarkerPos _helper_pos;
} else {
	if (_is_ammo) then {
		_drop_pos set [2, 0];
		_drop_pos remoteExecCall ["d_fnc_air_box", [0, -2] select isDedicated];
		_mname setMarkerPos _drop_pos;
	};
};

sleep 5;

deleteVehicle _chute;
