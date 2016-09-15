// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerServer.sqf"
#include "x_setup.sqf"
//diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerServer.sqf"];
__TRACE_1("","_this")

params ["_pl"];

if (str _pl == "HC_D_UNIT") exitWith {
	d_HC_CLIENT_OBJ_OWNER = owner HC_D_UNIT;
	__TRACE_1("","d_HC_CLIENT_OBJ_OWNER")
};

private _name = name _pl;
private _uid = getPlayerUID _pl;

private _p = d_player_store getVariable _uid;
if (isNil "_p") then {
	//_p = [d_AutoKickTime, time, _uid, 0, str _pl, sideUnknown, _name, 0, if (xr_max_lives != -1) then {xr_max_lives} else {-2}, 0, ""];
	_p = [d_AutoKickTime, time, "", 0, str _pl, sideUnknown, _name, 0, if (xr_max_lives != -1) then {xr_max_lives} else {-2}, 0, ""];
	d_player_store setVariable [_uid, _p];
	__TRACE_3("Player not found","_uid","_name","_p")
	d_scda = _p;
} else {
	__TRACE_1("player store before change","_p")
	if (_name != _p select 6) then {
		[format [localize "STR_DOM_MISSIONSTRING_506", _name, _p select 6], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
		diag_log format [localize "STR_DOM_MISSIONSTRING_942", _name, _p select 6, _uid];
	};
	if (time - (_p select 9) > 600) then {
		_p set [8, xr_max_lives];
	};
	_p set [1, time];
	_p set [4, str _pl];
	_p set [6, _name];
	__TRACE_1("player store after change","_p")
	d_scda = _p;
};
#ifdef __DOMDB__
//[played how often on this server, kills radio tower]
private _rvstr = _uid + "_rvals";
private _t_ps = d_player_store getVariable [_rvstr, [0,0]];
_t_ps set [0, (_t_ps select 0) + 1];
d_player_store setVariable [_rvstr, _t_ps];
#endif

private _opl = owner _pl;
_opl publicVariableClient "d_scda";
__TRACE_2("","_opl","d_scda")

//diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerServer.sqf processed"];