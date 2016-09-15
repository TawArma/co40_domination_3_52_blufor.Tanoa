// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_teleportdialoginit.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

disableSerialization;

#define __CTRL(A) (_display displayCtrl A)

params ["_display", "_dtype"];

if (_dtype == 0) then {
	if (d_tele_dialog > 0) then {
		__CTRL(100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_586");
		__CTRL(100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_533");
	} else {
		__CTRL(100111) ctrlSetText (localize "STR_DOM_MISSIONSTRING_299");
		__CTRL(100102) ctrlSetText (localize "STR_DOM_MISSIONSTRING_298");
	};
} else {
	if (!xr_respawn_available) then {
		__CTRL(100102) ctrlEnable false;
	};
	if (!xr_spectating) then {
		__CTRL(1212) ctrlEnable false;
		__CTRL(1212) ctrlShow false;
		__CTRL(1003) ctrlEnable false;
		__CTRL(1003) ctrlShow false;
		__CTRL(1000) ctrlEnable false;
		__CTRL(1000) ctrlShow false;
	};
};

private _addbase = true;
if (d_WithTeleToBase == 1 && {d_tele_dialog > 0} && {_dtype == 0}) then {
	_addbase = false;
};

private _listctrl = __CTRL(1500);
lbClear _listctrl;

private _cidx = -1;
private _selidx = 0;

if (_addbase) then {
	_cidx = _listctrl lbAdd (localize "STR_DOM_MISSIONSTRING_1251");
	_listctrl lbSetData [_cidx, "D_BASE_D"];
	if (d_last_beam_target == "D_BASE_D") then {
		_selidx = _cidx;
	};
};

__TRACE_1("","d_mob_respawns")

#define __COLRED [1,0,0,0.7]
private _logtxt = "";

{
	private _mrs = missionNamespace getVariable [_x select 0, objNull];
	__TRACE_2("","_mrs","_x")
	if (!isNull _mrs) then {
		private _lbcolor = call {
			if (_mrs getVariable ["d_in_air", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_592", _x select 1, _logtxt]; __COLRED};
			if (speed _mrs > 4) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_593", _x select 1] + _logtxt + "\n"; __COLRED};
			if (surfaceIsWater (getPosWorld _mrs)) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_594", _x select 1, _logtxt]; __COLRED};
			if (!alive _mrs) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_595", _x select 1, _logtxt]; __COLRED};
			if !(_mrs getVariable ["d_MHQ_Deployed", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_596", _x select 1, _logtxt]; __COLRED};
			if (_mrs getVariable ["d_enemy_near", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_597", _x select 1, _logtxt]; __COLRED};
			[1,1,1,1.0];
		};
		_cidx = _listctrl lbAdd (_x select 1);
		_listctrl lbSetData [_cidx, _x select 0];
		_listctrl lbSetColor [_cidx, _lbcolor];
		if (d_last_beam_target == _x select 0 && {_lbcolor isEqualTo [1,1,1,1.0]}) then {
			_selidx = _cidx;
		};
	};
} forEach d_mob_respawns;

{
#ifdef __TT__
	if (d_player_side == _x select 3) then {
#endif
	_cidx = _listctrl lbAdd (_x select 2);
	_listctrl lbSetData [_cidx, _x select 0];
	_listctrl lbSetColor [_cidx, [1,1,1,1.0]];
	if (d_last_beam_target == _x select 0) then {
		_selidx = _cidx;
	};
#ifdef __TT__
	};
#endif
} forEach d_additional_respawn_points;

if (_dtype != 0 && {d_respawnatsql == 0} && {!(player getVariable ["xr_isleader", false])}) then {
	_cidx = _listctrl lbAdd (localize "STR_DOM_MISSIONSTRING_1705a");
	_listctrl lbSetData [_cidx, "D_SQL_D"];
	private _leader = leader (group player);
	private _lbcolor = if (alive _leader && {!(_leader getVariable ["xr_pluncon", false])} && {isNull objectParent _leader} && {(getPos _leader) select 2 < 10}) then {
		[1,1,1,1.0]
	} else {
		_logtxt = localize "STR_DOM_MISSIONSTRING_1706";
		__COLRED
	};
	_listctrl lbSetColor [_cidx, _lbcolor];
	if (d_last_beam_target == "D_SQL_D" && {_lbcolor isEqualTo [1,1,1,1.0]}) then {
		_selidx = _cidx;
	};
};

__TRACE_1("","_logtxt")

if (_logtxt != "") then {
	__CTRL(11002) ctrlSetText _logtxt;
};

d_lb_tele_first = true;

if (_cidx > -1) then {
	_listctrl lbSetCurSel _selidx;
};
