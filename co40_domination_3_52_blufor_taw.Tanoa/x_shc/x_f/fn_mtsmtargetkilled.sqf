// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_mtsmtargetkilled.sqf"
#include "..\..\x_setup.sqf"

d_side_main_done = true;
if (d_IS_HC_CLIENT) then {
	[missionNamespace, ["d_side_main_done", true]] remoteExecCall ["setVariable", 2];
};
private _type = param [count _this - 1];
#ifdef __TT__
private _killer = param [1];
private _si = side (group _killer);
_type = if !(_si in [blufor, opfor]) then {"sec_over"};
private _s = _type call d_fnc_GetSMTargetMessage;
private ["_bluformsg", "_opformsg"];
if (_type != "sec_over") then {
	_bluformsg = if (_si == blufor) then {_s} else {localize "STR_DOM_MISSIONSTRING_962"};
	_opformsg = if (_si == opfor) then {_s} else {localize "STR_DOM_MISSIONSTRING_962"};
} else {
	_bluformsg = _s;
	_opformsg = _s;
};
[40, _bluformsg, _opformsg] remoteExecCall ["d_fnc_DoKBMsg", 2];
if (!isNull _killer) then {
	[d_tt_points select 3, _killer] remoteExecCall ["d_fnc_addpoints", 2];
	private _killedby2 = switch (_si) do {case blufor: {"WEST"}; case opfor: {"EAST"}; default {"N"};};
	if (_killedby2 != "N") then {
		[41, _killedby2] remoteExecCall ["d_fnc_DoKBMsg", 2];
	};
};
#else
[42, (["sec_over", _type] select (side (group (param [1])) == d_side_player)) call d_fnc_GetSMTargetMessage] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
d_sec_kind = 0; publicVariable "d_sec_kind";