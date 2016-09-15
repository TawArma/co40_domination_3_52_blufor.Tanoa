//#define __DEBUG__
#define THIS_FILE "fn_moduleCAS.sqf"
#include "..\x_setup.sqf"

params ["_lpos", "_caller", "_wtype"];

__TRACE_1("","_this")

#ifndef __TT__
if (!isServer || {!d_cas_available}) exitWith {};
d_cas_available = false;
publicVariable "d_cas_available";
#else
if (!isServer || {!d_cas_available_w && {!d_cas_available_e}}) exitWith {};
#endif

private _callero = missionNamespace getVariable _caller;

private _side = side (group _callero);
#ifndef __TT__
private _planeClass = d_cas_plane;
#else
if (_side == opfor) then {
	d_cas_available_e = false;
	publicVariable "d_cas_available_e";
} else {
	d_cas_available_w = false;
	publicVariable "d_cas_available_w";
};
private _planeClass = d_cas_plane select (_side == opfor);
#endif

private _planeCfg = configfile >> "cfgvehicles" >> _planeClass;
if !(isclass _planeCfg) exitwith {
#ifndef __TT__
	d_cas_available = true;
	publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true;
		publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true;
		publicVariable "d_cas_available_w";
	};
#endif
	false
};

//--- Detect gun
private _weaponTypes = switch _wtype do {
	case 0: {["machinegun"]};
	case 1: {["missilelauncher"]};
	case 2: {["machinegun", "missilelauncher"]};
	default {[]};
};

private _weapons = [];
{
	if (toLower ((_x call bis_fnc_itemType) select 1) in _weaponTypes) then {
		private _modes = getArray (configFile>>"cfgweapons">>_x>>"modes");
		if !(_modes isEqualTo []) then {
			private _mode = _modes select 0;
			if (_mode == "this") then {_mode = _x;};
			_weapons set [count _weapons, [_x, _mode]];
		};
	};
} forEach getArray (_planeCfg >> "weapons");
if (_weapons isEqualTo []) exitwith {
#ifndef __TT__
	d_cas_available = true;
	publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true;
		publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true;
		publicVariable "d_cas_available_w";
	};
#endif
	false
};

remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];

#ifdef __TT__
private _topicside = ["HQ_W", "HQ_E"] select (_side == opfor);
private _logic = [d_hq_logic_blufor2, d_hq_logic_opfor2] select (_side == opfor);
private _logic1 = [d_hq_logic_blufor1, d_hq_logic_opfor1] select  (_side == opfor);
#else
private _topicside = d_kb_topic_side;
private _logic = d_kb_logic2;
private _logic1 = d_kb_logic1;
#endif

private _callero = missionNamespace getVariable _caller;
if (isNil "_callero" || {isNull _callero}) then {_callero = _logic};
_logic1 kbTell [_callero,_topicside,"CASOnTheWay","SIDE"];
sleep 1;
_logic1 kbTell [_logic, _topicside, "CASUnavailable","SIDE"];

private _callerpos = getPos _callero;

private _logico = d_HeliHEmpty createVehicleLocal [0,0,0];
_logico setPos _lpos;
__TRACE_1("","_logico")

private _posATL = getPosAtl _logico;
private _pos = +_posATL;
_pos set [2, (_pos select 2) + getTerrainheightasl _pos];
private _dir = _callerpos getDir _logico;

private _dis = 3000;
private _alt = 1000;
private _pitch = atan (_alt / _dis);
private _speed = 400 / 3.6;
private _duration = ([0,0] distance [_dis, _alt]) / _speed;

//--- Create plane
private _planePos = [_pos, _dis, _dir + 180] call bis_fnc_relpos;
_planePos set [2, (_pos select 2) + _alt];
([_planePos, _dir, _planeClass, (getNumber (_planeCfg>>"side")) call bis_fnc_sideType] call d_fnc_spawnVehicle) params ["_plane"];
_plane setPosasl _planePos;
_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
_plane disableAi "move";
_plane disableAi "target";
_plane disableAi "autotarget";
_plane setCombatMode "blue";

private _vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
private _velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
_plane setVectordir _vectorDir;
[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
private _vectorUp = vectorUp _plane;

//--- Remove all other weapons
private _currentWeapons = weapons _plane;
{
	if !(toLower ((_x call bis_fnc_itemType) select 1) in (_weaponTypes + ["countermeasureslauncher"])) then {
		_plane removeWeapon _x;
	};
} forEach _currentWeapons;

private _enemy_units = [];
private _soldier_type = format ["Soldier%1B", d_enemy_side_short];

//--- Approach
private _fire = [] spawn {waitUntil {false}};
private _fireNull = true;
private _time = time;
private _offset = if ({_x == "missilelauncher"} count _weaponTypes > 0) then {20} else {0};
waituntil {
	private _fireProgress = _plane getVariable ["fireProgress", 0];

	//--- Update plane position when module was moved / rotated
	if ((getPosatl _logico distance _posATL > 0 || {_callerpos getDir _logico != _dir}) && {_fireProgress == 0}) then {
		_posATL = getPosatl _logico;
		_pos = +_posATL;
		_pos set [2,(_pos select 2) + getTerrainheightasl _pos];
		_dir = _callerpos getDir _logico;

		_planePos = [_pos,_dis,_dir + 180] call bis_fnc_relpos;
		_planePos set [2,(_pos select 2) + _alt];
		_vectorDir = [_planePos,_pos] call bis_fnc_vectorFromXtoY;
		_velocity = [_vectorDir,_speed] call bis_fnc_vectorMultiply;
		_plane setVectordir _vectorDir;
		//[_plane,-90 + atan (_dis / _alt),0] call bis_fnc_setpitchbank;
		_vectorUp = vectorUp _plane;

		_plane move ([_pos,_dis,_dir] call bis_fnc_relpos);
	};

	//--- Set the plane approach vector
	_plane setVelocityTransformation [
		_planePos, [_pos select 0, _pos select 1, (_pos select 2) + _offset + _fireProgress * 12],
		_velocity, _velocity,
		_vectorDir, _vectorDir,
		_vectorUp, _vectorUp,
		(time - _time) / _duration
	];
	_plane setVelocity velocity _plane;

	//--- Fire!
	if (_fireNull && {(getPosAsl _plane) distance _pos < 1000}) then {
		_fireNull = false;
		terminate _fire;
		{
			_enemy_units pushBackUnique _x;
		} forEach (_lpos nearEntities [_soldier_type, 40]);
		_fire = [_plane,_weapons] spawn {
			params ["_plane", "_weapons"];
			private _planeDriver = driver _plane;
			private _duration = 3;
			private _time = time + _duration;
			waitUntil {
				{
					//_plane selectweapon (_x select 0);
					_planeDriver forceWeaponfire _x;
				} foreach _weapons;
				_plane setVariable ["fireProgress", (1 - ((_time - time) / _duration)) max 0 min 1];
				sleep 0.1;
				(time > _time || {isnull _plane})
			};
			sleep 1;
		};
	};

	sleep 0.01;
	(scriptDone _fire || {isNull _logico} || {isNull _plane})
};
_plane setVelocity velocity _plane;
_plane flyinHeight _alt;

if !(isNull _logico) then {
	sleep 1;
	deleteVehicle _logico;
	waitUntil {_plane distance _pos > _dis};
};

//--- Delete plane
private _group = group _plane;
private _crew = crew _plane;
deleteVehicle _plane;
{deleteVehicle _x} forEach _crew;
deleteGroup _group;

[_side, _logic1, _logic, _topicside] spawn {
	scriptName "spawn_cas_available";
	params ["_side", "_logic1", "_logic", "_topicside"];
	//sleep d_cas_available_time;
	sleep 5;
#ifndef __TT__
	d_cas_available = true; publicVariable "d_cas_available";
#else
	if (_side == opfor) then {
		d_cas_available_e = true; publicVariable "d_cas_available_e";
	} else {
		d_cas_available_w = true; publicVariable "d_cas_available_w";
	};
#endif
	remoteExecCall ["d_fnc_updatesupportrsc", [0, -2] select isDedicated];
	_logic1 kbTell [_logic, _topicside, "CASAvailable", "SIDE"];
};

sleep 10;
_callero = missionNamespace getVariable _caller;
if (!isNil "_callero" && {!isNull _callero}) then {
	_callero addScore ({!alive _x} count _enemy_units);
#ifdef __TT__
	if (d_cur_tgt_pos distance2D _lpos < 500) then {
		if (_side == opfor) then {
			{
				if (!alive _x) then {
					d_kill_points_opfor = d_kill_points_opfor + 1;
				};
			} forEach _enemy_units;
		} else {
			if (_side == blufor) then {
				{
					if (!alive _x) then {
						d_kill_points_blufor = d_kill_points_blufor + 1;
					};
				} forEach _enemy_units;
			};
		};
	};
#endif
};