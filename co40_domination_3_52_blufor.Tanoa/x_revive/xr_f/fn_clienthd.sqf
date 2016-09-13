// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_clienthd.sqf"
#include "..\..\x_macros.sqf"

#define __shots ["shotBullet","shotShell","shotRocket","shotMissile","shotTimeBomb","shotMine","shotGrenade","shotSpread","shotSubmunitions","shotDeploy","shotBoundingMine","shotDirectionalBomb"]

if (isDedicated) exitWith {};

params ["_unit", "_part", "_dam", "_injurer", "_ammo", "_idx"];
__TRACE_1("","_this")
if (!alive _unit || {_dam == 0}) exitWith {
	__TRACE_1("exiting, unit dead or healing","_dam")
	_dam
};
if (_unit getVariable ["xr_pluncon", false] || {xr_phd_invulnerable}) exitWith {
	__TRACE_2("exiting, unit uncon or invulnerable","_part")
	0
};
if (d_no_teamkill == 0 && {_dam >= 0.1} && {!isNull _injurer} && {isPlayer _injurer} && {_injurer != _unit} && {isNull objectParent _unit} && {side (group _injurer) == side (group _unit)}) exitWith {
	if (_idx == -1 && {_ammo != ""} && {getText (configFile>>"CfgAmmo">>_ammo>>"simulation") in __shots} && {time > ((player getVariable "d_tk_cutofft") + 3)}) then {
		_unit setVariable ["d_tk_cutofft", time];
		hint format [localize "STR_DOM_MISSIONSTRING_497", name _injurer];
		[_unit, _injurer] remoteExecCall ["d_fnc_TKR", 2];
	};
	0
};
if (_dam >= 0.9 && {time > (_unit getVariable "d_last_gear_save")}) then {
	__TRACE_1("saving respawn gear","_dam")
	_unit setVariable ["d_last_gear_save", time + 2];
	call d_fnc_save_respawngear;
	_unit setVariable ["xr_isleader", leader (group player) == player];
	xr_pl_group = group player;
};
_dam