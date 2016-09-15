// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_handledisconnect.sqf"
#include "..\..\x_setup.sqf"
if (!isServer) exitWith{};
params ["_unit", "", "_uid"];

__TRACE_2("","_unit","_uid")

// TODO: Read getPlayerScores _unit and save them to an external database
// also write rank, and other information

if (str _pl == "HC_D_UNIT") exitWith {false};

private _pa = d_player_store getVariable _uid;
if (!isNil "_pa") then {
	__TRACE_1("player store before change","_pa")
	_pa set [0, [(_pa select 0) - (time - (_pa select 1)), 0] select ((time - (_pa select 1)) >= (_pa select 0))];
	_pa set [9, time];
	private _mname = (_pa select 4) + "_xr_dead";
	__TRACE_1("","_mname")
	if !(markerPos _mname isEqualTo [0,0,0]) then {
		deleteMarker _mname;
	};
	private _amark = _pa select 10;
	__TRACE_1("","_amark")
	if (_amark != "") then {
		if !(markerPos _amark isEqualTo [0,0,0]) then {
			deleteMarker _amark;
		};
		_pa set [10, ""];
	};
	(_pa select 4) call d_fnc_markercheck;
	__TRACE_1("player store after change","_pa")
};

private _jipid = player getVariable "xr_dml_jip_id";
if (!isNil "_jipid") then {
	remoteExecCall ["", _jipid];
};

_jipid = player getVariable "d_artmark_jip_id";
if (!isNil "_jipid") then {
	remoteExecCall ["", _jipid];
};

#ifdef __DOMDB__
//  [infantry kills, soft vehicle kills, armor kills, air kills, deaths, total score]
private _ps = getPlayerScores _unit;
private _usc = _uid + "_scores";
private _t_ps = d_player_store getVariable [_usc, [0, 0, 0, 0, 0, 0]];
// only add diff to db
private _infkills = (_ps select 0) - (_t_ps select 0);
private _softveckills = (_ps select 1) - (_t_ps select 1);
private _armorkills = (_ps select 2) - (_t_ps select 2);
private _airkills = (_ps select 3) - (_t_ps select 3);
private _deaths = (_ps select 4) - (_t_ps select 4);
private _totalscore = (_ps select 5) - (_t_ps select 5);
d_player_store setVariable [_usc, _ps];
if (!isNil "_pa") then {
	private _playtime = time - (_pa select 1);
};
#endif

_unit spawn {
	sleep 10;
	deleteVehicle _this;
};

removeAllOwnedMines _unit;

false