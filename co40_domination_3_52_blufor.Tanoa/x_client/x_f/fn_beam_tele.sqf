// by Xeno
#define THIS_FILE "fn_beam_tele.sqf"
#include "..\..\x_setup.sqf"
#define __CTRL2(A) (_display displayCtrl A)

if (isDedicated || {d_beam_target == ""} || {d_x_loop_end}) exitWith {};

d_x_loop_end = true;

if (!isNull objectParent player) then {unassignVehicle player};

params ["_wone"];

disableSerialization;
private _display = [uiNamespace getVariable "xr_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);
if (_wone == 0) then {
	__CTRL2(100102) ctrlEnable false;
	__CTRL2(100107) ctrlEnable false;
	__CTRL2(100108) ctrlEnable false;
	__CTRL2(100109) ctrlEnable false;
} else {
	__CTRL2(3000) ctrlShow false;
};

d_last_telepoint = d_beam_target;

private _global_pos = [];
private _global_dir = 180;
private _typepos = 0;

if (d_beam_target == "D_BASE_D") then {
#ifndef __TT__
	_global_pos = markerPos "base_spawn_1";
#else
	_global_pos = [markerPos "base_spawn_2", markerPos "base_spawn_1"] select (d_player_side == blufor);
#endif
	d_player_in_base = true;
} else {
	if (d_beam_target == "D_SQL_D") then {
		private _lead = leader (group player);
		_global_pos = getPosASL _lead;
		_global_pos set [2, _lead distance (getPos _lead)];
		_global_dir = getDirVisual _lead;
		_typepos = 1;
#ifndef __TT__
		d_player_in_base = player inArea d_base_array;
#else
		d_player_in_base = player inArea (d_base_array select 0) || {player inArea (d_base_array select 1)};
#endif
	} else {
		private _uidx = d_add_resp_points_uni find d_beam_target;
		if (_uidx != -1) then {
			_global_pos = (d_additional_respawn_points select _uidx) select 1;
			_global_dir = 0;
			d_player_in_base = false;
		} else {
			private _mrs = missionNamespace getVariable [d_beam_target, objNull];
			_global_pos = _mrs modelToWorldVisual [0, -8, 0];
			_global_pos set [2,0];
			_global_dir = getDirVisual _mrs;
			_typepos = 1;
			d_player_in_base = false;
		};
	};
};

d_beam_target = "";

if (_typepos == 1) then {
	player setDir _global_dir;
	player setPosATL [_global_pos select 0, _global_pos select 1, 0];
} else {
	player setDir _global_dir;
	player setPos _global_pos;
};
_wone spawn {
	sleep 2;
	if (_this == 0) then {
		if (d_teleport_dialog_open) then {closeDialog 0};
		titleText ["", "BLACK IN"];
	};

	{player reveal _x} forEach (nearestObjects [player, d_rev_respawn_vec_types, 30]);

	if (d_with_ai && {alive player} && {!(player getVariable ["xr_pluncon", false])}) then {[] spawn d_fnc_moveai};
};