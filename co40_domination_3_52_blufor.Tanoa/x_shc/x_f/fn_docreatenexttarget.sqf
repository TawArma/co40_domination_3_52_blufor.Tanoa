// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_docreatenexttarget.sqf"
#include "..\..\x_setup.sqf"

__TRACE("docreatenexttarget start")

if (isServer && {!isNil "d_HC_CLIENT_OBJ_OWNER"}) exitWith {
	__TRACE("found HC moving")
	remoteExec ["d_fnc_docreatenexttarget", d_HC_CLIENT_OBJ_OWNER];
};

d_delvecsmt = [];
d_delinfsm = [];
d_respawn_ai_groups = [];
d_mt_done = false;
if (isNil "d_sum_camps") then {d_sum_camps = -91};

#ifndef __TT__
d_enemyai_respawn_pos = [getPosASL d_FLAG_BASE, d_cur_tgt_pos] call d_fnc_posbehind2; // startpoint for random camp location (if needed) plus direction
if (surfaceIsWater (d_enemyai_respawn_pos select 0)) then {
	__TRACE("Position is in water")
	private _counter = 0;
	private _tmppos = d_enemyai_respawn_pos select 0;
	__TRACE_1("","d_enemyai_respawn_pos")
	private _dist = d_enemyai_respawn_pos select 2;
	private _dirn = d_enemyai_respawn_pos select 1;
	if (_dirn < 0) then {_dirn = _dirn + 180};
	private _incdir = if (_dirn <= 90 || {_dirn >= 270}) then {
		-15
	} else {
		15
	};
	__TRACE_3("","_dist","_dirn","_incdir")
	private _foundpos = false;
	while {_counter < 2} do {
		for "_i" from 1 to 8 do {
			private _ndir = _dirn + (_incdir * _i);
			private _x1 = (d_cur_tgt_pos select 0) - (_dist * sin _ndir);
			private _y1 = (d_cur_tgt_pos select 1) - (_dist * cos _ndir);
			if (!surfaceIsWater [_x1, _y1]) exitWith {
				_tmppos = [_x1, _y1, 0];
				_foundpos = true;
			};
		};
		if (_foundpos) exitWith {
			__TRACE_1("","_tmppos")
		};
		_counter = _counter + 1;
		_incdir = _incdir * -1;
	};
	
	if (surfaceIsWater _tmppos) then {
		_tmppos = d_cur_tgt_pos;
	};
	
	d_enemyai_respawn_pos set [0, _tmppos];
	_dirn = d_cur_tgt_pos getDir _tmppos;
	_dirn = _dirn + 180;
	d_enemyai_respawn_pos set [2, _dirn];
};

d_enemyai_mt_camp_pos = [d_enemyai_respawn_pos select 0, 600, 400, d_enemyai_respawn_pos select 1] call d_fnc_GetRanPointSquare;
if (d_enemyai_mt_camp_pos isEqualTo []) then {
	private _al = 800;
	private _bl = 600;
	while {true} do {
		d_enemyai_mt_camp_pos = [d_enemyai_respawn_pos select 0, _al, _bl, d_enemyai_respawn_pos select 1] call d_fnc_GetRanPointSquare;
		if !(d_enemyai_mt_camp_pos isEqualTo []) exitWith {};
		_al = _al + 200;
		_bl = _bl + 200;
		sleep 0.2;
	};
};
#endif
#ifdef __GROUPDEBUG__
if (!d_tt_ver) then {
	if (markerType "enemyai_mt_camp_pos" != "") then {deleteMarkerLocal "enemyai_mt_camp_pos"};
	["enemyai_mt_camp_pos", d_enemyai_mt_camp_pos, "ICON", "ColorBlack", [1,1], "enemy camp pos", 0, "mil_dot"] call d_fnc_CreateMarkerLocal;
};
#endif

[d_cur_tgt_pos, d_cur_target_radius] spawn d_fnc_createmaintarget;