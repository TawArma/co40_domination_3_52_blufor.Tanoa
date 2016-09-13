// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checkmthardtarget.sqf"
#include "..\..\x_setup.sqf"

params ["_vec"];
//[_vec] call d_fnc_XRemoveVehiExtra;
[_vec] execFSM "fsms\fn_XRemoveVehiExtra.fsm";
_vec addEventHandler ["killed", {
	d_mt_spotted = false;
	if (d_IS_HC_CLIENT) then {
		[missionNamespace, ["d_mt_spotted", false]] remoteExecCall ["setVariable", 2];
	};
	d_mt_radio_down = true;
	[missionNamespace, ["d_mt_radio_down", true]] remoteExecCall ["setVariable", 2];
	"d_main_target_radiotower" remoteExecCall ["deleteMarker", 2];
#ifndef __TT__
	[37] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
	[38] remoteExecCall ["d_fnc_DoKBMsg", 2];
	private _killer = param [1];
	if (!isNull _killer) then {
		[d_tt_points select 2, _killer] remoteExecCall ["d_fnc_AddPoints", 2];
		private _killedby = switch (side (group _killer)) do {case blufor: {"WEST"}; case opfor: {"EAST"}; default {"N"};};
		if (_killedby != "N") then {
			[39, _killedby] remoteExecCall ["d_fnc_DoKBMsg", 2];
		};
	};
#endif
#ifdef __DOMDB__
	private _killer = param [1];
	if (!isNil "_killer" && {!isNull "_killer"} && {isPlayer _killer}) then {
		[_killer, 1] remoteExecCall ["d_fnc_addpkill", 2];
	};
#endif
	(param [0]) removeAllEventHandlers "killed";
}];
_vec addEventHandler ["handleDamage", {_this call d_fnc_CheckMTShotHD}];