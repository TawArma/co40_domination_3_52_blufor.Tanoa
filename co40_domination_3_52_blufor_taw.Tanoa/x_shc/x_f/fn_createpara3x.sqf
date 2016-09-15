// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createpara3x.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

params ["_startpoint", "_attackpoint", "_heliendpoint", "_number_vehicles"];
__TRACE_3("","_startpoint","_attackpoint","_heliendpoint")
__TRACE_1("","_number_vehicles")

d_should_be_there = _number_vehicles;

d_c_attacking_grps = [];

private _delveccrew = {
	scriptName "spawn_x_createpara3_delveccrew";
	params ["_crew_vec", "_vec", "_time"];
	sleep _time;
	{if (!isNull _x) then {_x setDamage 1}} forEach _crew_vec;
	sleep 1;
	if (!isNull _vec && {({isPlayer _x} count (crew _vec)) == 0}) then {_vec setDamage 1};
};

private _make_jump = {
	scriptName "spawn_x_createpara3_make_jump";
	params ["_vgrp", "_vec", "_attackpoint", "_heliendpoint", "_delveccrew"];
	
	__TRACE("_make_jump")
	
	private _startpos = getPosATL _vec;
	private _driver_vec = driver _vec;
	private _crew_vec = crew _vec;
	
	private _wp = _vgrp addWaypoint [_attackpoint, 0];
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointtype "MOVE";
	_wp setWaypointFormation "VEE";
	_wp setWaypointForceBehaviour true;
	_wp = _vgrp addWaypoint [_heliendpoint, 0];
	_wp setWaypointBehaviour "CARELESS";
	_wp setWaypointSpeed "NORMAL";
	_wp setWaypointtype "MOVE";
	_wp setWaypointFormation "VEE";
	_wp setWaypointForceBehaviour true;
	
	_vec flyInHeight 100;
	
	sleep 10.0231;
	
	private _stop_me = false;
	private _checktime = time + 300;
	while {[_attackpoint select 0, _attackpoint select 1, 0] distance2D [getPosWorld (leader _vgrp) select 0, getPosWorld (leader _vgrp) select 1, 0] > 300} do {
		if (isNull _vec || {!alive _vec} || {!alive _driver_vec} || {!canMove _vec}) exitWith {d_should_be_there = d_should_be_there - 1};
		sleep 0.01;
		if (d_mt_radio_down && {_attackpoint distance2D (leader _vgrp) > 1300}) exitWith {
			[_crew_vec, _vec, 1 + random 1] spawn _delveccrew;
			_stop_me = true;
		};
		sleep 0.01;
		if (time > _checktime) then {
			if (_startpos distance2D _vec < 500) then {
				d_should_be_there = d_should_be_there - 1;
				[_crew_vec, _vec, 1 + random 1] spawn _delveccrew;
				_stop_me = true;
			} else {
				_checktime = time + 9999999;
			};
		};
		if (_stop_me) exitWith {};
		sleep 2.023;
	};
	if (_stop_me) exitWith {};
	
	sleep 0.534;
	
	if (alive _vec && {alive _driver_vec} && {canMove _vec}) then {
		if (!d_mt_radio_down && {_vec distance2D d_cur_tgt_pos < 500}) then {
			private _paragrp = [d_side_enemy] call d_fnc_creategroup;
			private _real_units = ["allmen", d_enemy_side_short] call d_fnc_getunitlistm;
			sleep 0.1;
			private _subskill = if (diag_fps > 29) then {
				(0.1 + (random 0.2))
			} else {
				(0.12 + (random 0.04))
			};
			{
				private _pposcx = getPosATL _vec;
				private _one_unit = _paragrp createUnit [_x, [_pposcx select 0, _pposcx select 1, 0], [], 0,"NONE"];
				__TRACE_1("","_one_unit")
				private _para = createVehicle [d_non_steer_para, _pposcx, [], 20, 'NONE'];
				_one_unit moveInDriver _para;
				_para setDir random 360;
				_pposcx = getPosATL _vec;
				_para setPos [_pposcx select 0, _pposcx select 1, (_pposcx select 2) - 10];
				_one_unit call d_fnc_removenvgoggles_fak;
#ifdef __TT__
				_one_unit addEventHandler ["killed", {[[15, 3, 2, 1], _this select 1, _this select 0] remoteExecCall ["d_fnc_AddKills", 2]}];
#endif
				if (d_with_ai && {d_with_ranked}) then {
					_one_unit addEventHandler ["Killed", {
						[1, param [1]] remoteExecCall ["d_fnc_addkillsai", 2];
						(param [0]) removeAllEventHandlers "Killed";
					}];
				};
				_one_unit setUnitAbility ((d_skill_array select 0) + (random (d_skill_array select 1)));
				_one_unit setSkill ["aimingAccuracy", _subskill];
				_one_unit setSkill ["spotTime", _subskill];
				sleep 0.551;
			} forEach _real_units;
			__TRACE_1("","_real_units")
			_paragrp allowFleeing 0;
			_paragrp setCombatMode "YELLOW";
			_paragrp setBehaviour "AWARE";
			 [_paragrp, 1] call d_fnc_setGState;
			
			[_paragrp, d_cur_tgt_pos, d_cur_target_radius] spawn {
				scriptName "spawn_x_createpara3_usegroup";
				params ["_grp", "_pos"];
				sleep 30;
				if ((_grp call d_fnc_GetAliveUnitsGrp) > 0) then {
					[_grp, _pos, [_pos, param [2]], [10, 20, 50], "", 0] spawn d_fnc_MakePatrolWPX;
					_grp setVariable ["d_PATR",true];
				};
			};
			
			d_c_attacking_grps pushBack _paragrp;
			
			sleep 0.112;
			d_should_be_there = d_should_be_there - 1;
			
			while {_heliendpoint distance2D (leader _vgrp) > 300} do {
				if (isNull _vec || {!alive _vec} || {!alive _driver_vec} || {!canMove _vec}) exitWith {};
				sleep 5.123;
			};
			
			if (!isNull _vec && {_heliendpoint distance2D _vec > 300}) then {
				[_crew_vec, _vec, 240 + random 100] spawn _delveccrew;
			} else {
				_vec call d_fnc_DelVecAndCrew;
			};
			if (!isNull _driver_vec) then {_driver_vec setDamage 1.1};
		};
	} else {
		[_crew_vec, _vec, 240 + random 100] spawn _delveccrew;
	};
};

private _cur_tgt_pos =+ d_cur_tgt_pos;
private _stop_it = false;

if (d_searchintel select 0 == 1) then {
	[43] remoteExecCall ["d_fnc_DoKBMsg", 2];
};

for "_i" from 1 to _number_vehicles do {
	if (d_mt_radio_down) exitWith {_stop_it = true};
	if (d_cur_tgt_pos distance2D _cur_tgt_pos > 500) exitWith {_stop_it = true};
	private _vgrp = [d_side_enemy] call d_fnc_creategroup;
	private _heli_type = selectRandom d_transport_chopper;
	private _spos = [_startpoint select 0, _startpoint select 1, 300];
	private _vec = ([_spos, _spos getDir _attackpoint, _heli_type, _vgrp] call d_fnc_spawnVehicle) select 0;
	if !((toUpper _heli_type) in d_heli_wreck_lift_types) then {
		d_allunits_add pushBack _vec;
	};
	_vec remoteExec ["d_fnc_airmarkermove", 2];

	if (d_LockAir == 0) then {_vec lock true};

	sleep 5.012;
	
	_vec flyInHeight 100;

	if (d_mt_radio_down) exitWith {
		_stop_it = true;
		{_vec deleteVehicleCrew _x} forEach (crew _vec);
		deleteVehicle _vec;
	};
	
	[_vgrp, _vec, _attackpoint, _heliendpoint, _delveccrew] spawn _make_jump;
	
	sleep 30 + random 30;
};

if (_stop_it) exitWith {};

while {d_should_be_there > 0 && {!d_mt_radio_down}} do {sleep 1.021};

if (!d_mt_radio_down) then {
	sleep 20.0123;
	if !(d_c_attacking_grps isEqualTo []) then {
		[d_c_attacking_grps] spawn d_fnc_handleattackgroups;
	} else {
		d_c_attacking_grps = [];
		d_create_new_paras = true;
	};
};