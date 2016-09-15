// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_buttonclickrespawn.sqf"
#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

private _respawn_pos = [0,0,0];
__TRACE("black out")
"xr_revtxt" cutText [localize "STR_DOM_MISSIONSTRING_917", "BLACK OUT", 0.2];

player setVariable ["xr_hasusedmapclickspawn", true];

__TRACE_1("","d_beam_target")

if (d_beam_target == "") then {d_beam_target = "D_BASE_D"};

if (d_beam_target == "D_BASE_D") then {
	_respawn_pos = markerPos "base_spawn_1";
	_respawn_pos set [2, 0];
	d_player_in_base = true;
} else {
	if (d_beam_target == "D_SQL_D") then {
		private _lead = leader (group player);
		//_respawn_pos = _lead modelToWorldVisual [0, -2, 0];
		_respawn_pos = getPosASL _lead;
		_respawn_pos set [2, _lead distance (getPos _lead)];
#ifndef __TT__
		d_player_in_base = player inArea d_base_array;
#else
		d_player_in_base = player inArea (d_base_array select 0) || {player inArea (d_base_array select 1)};
#endif
	} else {
		private _uidx = d_add_resp_points_uni find d_beam_target;
		if (_uidx != -1) then {
			_respawn_pos = (d_additional_respawn_points select _uidx) select 1;
			d_player_in_base = false;
		} else {
			_respawn_pos = (missionNamespace getVariable [d_beam_target, objNull]) modelToWorldVisual [0,-8,0];
			_respawn_pos set [2, 0];
			d_player_in_base = false;
		};
	};
};

__TRACE_1("","_respawn_pos")

sleep 1;
__TRACE("stopspect = true")
xr_stopspect = true;
player setVariable ["xr_pluncon", false, true];
[player, false] remoteExecCall ["setCaptive"];
sleep 0.5;

private _mhqobj = objNull;
if (d_beam_target != "D_BASE_D" && {d_beam_target != "D_SQL_D"} && {!(d_beam_target in d_add_resp_points_uni)}) then {
	{
		if (_x getVariable ["d_vec_type", ""] == "MHQ") exitWith {
			_mhqobj = _x;
		};
	} forEach (_respawn_pos nearEntities ["All", 25]);
};
[player, 105] remoteExecCall ["xr_fnc_handlenet"];
__TRACE_1("","_mhqobj")
if (!isNull _mhqobj) then {
	private _newppos = _mhqobj modelToWorldVisual [0,-8,0];
	player setDir (getDirVisual _mhqobj);
	player setPosATL [_newppos select 0, _newppos select 1, 0];
	{player reveal _x} forEach (nearestObjects [player, d_rev_respawn_vec_types, 30]);
	call d_fnc_retrieve_layoutgear;
} else {
	if (d_beam_target != "D_SQL_D")	then {
		call d_fnc_retrieve_layoutgear;
	};
	if (surfaceIsWater _respawn_pos) then {
		player setPosASL [markerpos "base_spawn_1" select 0, markerpos "base_spawn_1" select 1, 16.20];
	} else {
		player setPos _respawn_pos;
	};
};
d_last_beam_target = d_beam_target;
player setDamage 0;
__TRACE("MapClickRespawn, black in")
"xr_revtxt" cutText [localize "STR_DOM_MISSIONSTRING_918", "BLACK IN", 6];
if (xr_max_lives != -1) then {
	0 spawn {
		sleep 7;
		hintSilent format [localize "STR_DOM_MISSIONSTRING_933", player getVariable "xr_lives"];
		if (d_with_ai && {alive player} && {!(player getVariable ["xr_pluncon", false])}) then {[] spawn d_fnc_moveai};
	};
};
__TRACE("MapClickRespawn done")