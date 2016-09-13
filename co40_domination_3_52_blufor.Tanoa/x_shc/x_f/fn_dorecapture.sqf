// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dorecapture.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

__TRACE_1("","_this")

params ["_target_center", "_radius", "_recap_index", "_helih"];

if (isNil "_target_center") exitWith {};

__TRACE_3("","_target_center","_radius","_recap_index")
__TRACE_1("","_helih")

private _veclist = [];
private _unitslist = [];

{
	private _posran = [_target_center, _radius] call d_fnc_GetRanPointCircleNoSlope;
	__TRACE_1("vec","_posran")
	private _counter = 0;
	while {_posran isEqualTo [] && {_counter < 50}} do {
		_posran = [_target_center, _radius] call d_fnc_GetRanPointCircleNoSlope;
		__TRACE_1("in loop vec","_posran")
		_counter = _counter + 1;
		sleep 0.4;
	};
	if (_posran isEqualTo []) then {
		_posran = [_target_center, _radius] call d_fnc_GetRanPointCircleOld;
	};
	private _reta = [ceil (random 2), _posran, [_x, d_enemy_side_short] call d_fnc_getunitlistv, [d_side_enemy] call d_fnc_creategroup, -1.111] call d_fnc_makevgroup;
	private _vecs = _reta select 0;
	__TRACE_2("","_reta","_vecs")
	{_x lock true} forEach _vecs;
	sleep 0.1;
	_veclist append _vecs;
	_unitslist append (_reta select 1);
	__TRACE_2("","_veclist","_unitslist")
	sleep 0.1;
} forEach ["tank", "tracked_apc"];

__TRACE_2("","_veclist","_unitslist")

sleep 1.23;

for "_i" from 0 to 1 do {
	private _posran = [_target_center, _radius] call d_fnc_GetRanPointCircleNoSlope;
	__TRACE_1("men","_posran")
	private _counter = 0;
	 while {_posran isEqualTo [] && {_counter < 50}} do {
		_posran = [_target_center, _radius] call d_fnc_GetRanPointCircleNoSlope;
		__TRACE_1("in loop men","_posran")
		_counter = _counter + 1;
		sleep 0.4;
	};
	if (_posran isEqualTo []) then {
		_posran = [_target_center, _radius] call d_fnc_GetRanPointCircleOld;
	};
	private _units = [_posran, ["allmen", d_enemy_side_short] call d_fnc_getunitlistm, [d_side_enemy] call d_fnc_creategroup] call d_fnc_makemgroup;
	_unitslist append _units;
	__TRACE_2("","_units","_unitslist")
	sleep 0.1;
};

__TRACE_2("","_units","_unitslist")

sleep 10;

private _completel = _unitslist;
_completel append _veclist;
__TRACE_1("","_completel")
while {{alive _x} count _completel > 5} do {
#ifdef __DEBUG__
	diag_log [{alive _x} count _completel];
#endif
	sleep 10.312
};

sleep 5;

_helih setVariable ["d_recaptured", nil, true];

d_recapture_indices = d_recapture_indices - [_recap_index];

_target_name = (d_target_names select _recap_index) select 1;
[_target_name, "ColorGreen", "Solid"] remoteExecCall ["d_fnc_s_mrecap_g", 2];

[_recap_index, 1] remoteExecCall ["d_fnc_RecapturedUpdate", [0, -2] select isDedicated];

[22, _target_name, _target_name] remoteExecCall ["d_fnc_DoKBMsg", 2];

sleep 300;

{
	if (!isNull _x) then {
		_x call d_fnc_DelVecAndCrew;
	};
} forEach _veclist;

{if (!isNull _x) then {deleteVehicle _x}} forEach _unitslist;
