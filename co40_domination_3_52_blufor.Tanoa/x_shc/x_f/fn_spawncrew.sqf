// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spawncrew.sqf"
#include "..\..\x_setup.sqf"

params ["_vec", "_grp"];

createVehicleCrew _vec;
private _crew = crew _vec;
if (count _crew > 0) then {
	private _grp_old = group (_crew select 0);
	_crew joinSilent _grp;
	deleteGroup _grp_old;
	private _subskill = if (diag_fps > 29) then {
		(0.1 + (random 0.2))
	} else {
		(0.12 + (random 0.04))
	};
	{
		_x call d_fnc_removenvgoggles_fak;
#ifdef __TT__
		_x addEventHandler ["Killed", {[[15, 3, 2, 1], _this select 1, _this select 0] remoteExecCall ["d_fnc_AddKills", 2]}];
#endif
		if (d_with_ai && {d_with_ranked}) then {
			_x addEventHandler ["Killed", {
				[1, param [1]] remoteExecCall ["d_fnc_addkillsai", 2];
				(param [0]) removeAllEventHandlers "Killed";
			}];
		};
		_x setUnitAbility ((d_skill_array select 0) + (random (d_skill_array select 1)));
		_x setSkill ["aimingAccuracy", _subskill];
		_x setSkill ["spotTime", _subskill];
	} forEach _crew;
	if !(isNull (driver _vec)) then {(driver _vec) setRank "LIEUTENANT"};
	if !(isNull (gunner _vec)) then {(gunner _vec) setRank "SERGEANT"};
	if !(isNull (effectiveCommander _vec)) then {(effectiveCommander _vec) setRank "CORPORAL"};
};

__TRACE_1("","_crew")

[_grp, 1] call d_fnc_setGState;

_crew
