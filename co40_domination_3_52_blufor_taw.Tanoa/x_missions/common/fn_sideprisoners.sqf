// by Xeno
#define THIS_FILE "fn_sideprisoners.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

private _pos = (param [0]) select 0;

if (d_with_ranked) then {d_sm_p_pos = nil};

sleep 2;

#ifndef __TT__
private _newgroup = [d_own_side] call d_fnc_creategroup;
#else
private _newgroup = [civilian] call d_fnc_creategroup;
#endif
[_pos, call d_fnc_getunitlistc, _newgroup] call d_fnc_makemgroup;
private _leader = leader _newgroup;
_leader setSkill 1;
sleep 2.0112;
_newgroup allowFleeing 0;
[_newgroup, 1] call d_fnc_setGState;
private _units = units _newgroup;
{
	removeAllWeapons _x;
	_x setCaptive true;
	_x disableAI "MOVE";
} forEach _units;

sleep 2.333;
["specops", 2, "allmen", 2, _pos, 100, true] spawn d_fnc_CreateInf;
sleep 2.333;
["aa", 1, "tracked_apc", 1, "tank", 1, _pos, 1, 140, true] spawn d_fnc_CreateArmor;

sleep 32.123;

private _hostages_reached_dest = false;
private _all_dead = false;
private _rescued = false;
private _mforceendtime = time + 2400;

private _aiver_check_fnc = {
	if (!d_with_ai) then {
		(str _this) in d_can_use_artillery
	} else {
		true
	}
};

private _rescuer = objNull;
#ifdef __TT__
private _winner = 0;
#endif
while {!_hostages_reached_dest && {!_all_dead}} do {
	call d_fnc_mpcheck;
	if ({alive _x} count _units == 0) exitWith {
		_all_dead = true;
	};
	if (!_rescued) then {
		_leader = leader _newgroup;
		private _nobjs = (getPosATL _leader) nearEntities ["CAManBase", 20];
		if !(_nobjs isEqualTo []) then {
			{
				if (alive _x && {isPlayer _x} && {!(_x getVariable ["xr_pluncon", false])} && {_x call _aiver_check_fnc}) exitWith {
					_rescued = true;
					_rescuer = _x;
					{
						if (alive _x) then {
							_x setCaptive false;
							_x enableAI "MOVE";
						};
					} forEach _units;
					_units join _rescuer;
#ifdef __TT__
					_winner = switch (side (group _rescuer)) do {case blufor: {2}; case opfor: {1};default {0}}; 
#endif
				};
				sleep 0.01;
			} forEach _nobjs;
		};
	} else {
		if (_winner == 2) then {
			_hostages_reached_dest = {alive _x && {(vehicle _x) distance2D d_EFLAG_BASE < 50}} count _units > 0;
		} else {
			_hostages_reached_dest = {alive _x && {(vehicle _x) distance2D d_WFLAG_BASE < 50}} count _units > 0;
		};
#ifndef __TT__
		private _tmp_flag = d_FLAG_BASE;
#else
		private _tmp_flag = if (_winner == 1) then {d_EFLAG_BASE} else {d_WFLAG_BASE};
#endif
		_hostages_reached_dest = {alive _x && {(vehicle _x) distance2D _tmp_flag < 50}} count _units > 0;
		
		if (!_hostages_reached_dest) then {
			{
				if (alive _x) exitWith {
					_newgroup = group _x;
				};
			} forEach _units;
			if (!isPlayer (leader _newgroup)) then {
				_rescued = false;
#ifdef __TT__
				_winner = 0;
#endif
				[_newgroup, 1] call d_fnc_setGState;
			};
		};
	};
	if (d_with_ranked && {_hostages_reached_dest}) then {
#ifndef __TT__
		private _tmp_flag = d_FLAG_BASE;
#else
		private _tmp_flag = if (_winner == 1) then {d_EFLAG_BASE} else {d_WFLAG_BASE};
#endif
		[missionNamespace, ["d_sm_p_pos", getPosATL _tmp_flag]] remoteExecCall ["setVariable", [0, -2] select isDedicated];
	};
	if (time > _mforceendtime) then {
		{
			_x setDamage 1;
		} forEach _units;
		_all_dead = true;
	};
	sleep 5.123;
};

if (_all_dead) then {
	d_sm_winner = -400;
} else {
	if ({alive _x} count _units > 7) then {
#ifndef __TT__
		d_sm_winner = 2;
#else
		d_sm_winner = _winner;
#endif
	} else {
		d_sm_winner = -400;
	};
};

d_sm_resolved = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_sm_winner", d_sm_winner]] remoteExecCall ["setVariable", 2];
	[missionNamespace, ["d_sm_resolved", true]] remoteExecCall ["setVariable", 2];
};

sleep 5.123;

{
	if (!isNull _x) then {
		if (!isNull objectParent _x) then {
			(vehicle _x) deleteVehicleCrew _x;
		} else {
			deleteVehicle _x;
		};
	};
} forEach _units;
sleep 0.5321;
if (!isNull _newgroup) then {deleteGroup _newgroup};
