// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_update_telerespsel.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_cparams", "_wone"];
_cparams params ["_ctrl", "_sel"];

__TRACE_1("","_this")

if (_sel == -1) exitWith {};

disableSerialization;

#define __CTRL(A) (_display displayCtrl A)

private _data = _ctrl lbData _sel;

#define __COLRED [1,0,0,0.7]
private _mravailable = false;
private _leadavailable = false;
private _display = [uiNamespace getVariable "XR_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);

private _uidx = d_add_resp_points_uni find _data;

if (_data != "D_BASE_D" && {_data != "D_SQL_D"} && {_uidx == -1}) then {
	private _logtxt = ctrlText __CTRL(11002);

	private _mrs = missionNamespace getVariable [_data, objNull];
	__TRACE_1("","_mrs")
	if (!isNull _mrs) then {
		private _lbcolor = call {
			if (_mrs getVariable ["d_in_air", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_592",  _ctrl lbText _sel, _logtxt]; __COLRED};
			if (speed _mrs > 4) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_593", _ctrl lbText _sel, _logtxt]; __COLRED};
			if (surfaceIsWater (getPosWorld _mrs)) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_594", _ctrl lbText _sel, _logtxt]; __COLRED};
			if (!alive _mrs) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_595", _ctrl lbText _sel, _logtxt]; __COLRED};
			if !(_mrs getVariable ["d_MHQ_Deployed", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_596", _ctrl lbText _sel, _logtxt]; __COLRED};
			if (_mrs getVariable ["d_enemy_near", false]) exitWith {_logtxt = format [localize "STR_DOM_MISSIONSTRING_597", _ctrl lbText _sel, _logtxt]; __COLRED};
			_mravailable = true;
			[1,1,1,1.0];
		};
		_ctrl lbSetColor [_sel, _lbcolor];
		
		if (_logtxt != "" && {!d_lb_tele_first}) then {
			__CTRL(11002) ctrlSetText _logtxt;
		};
	};
} else {
	if (d_respawnatsql == 0 && {_data == "D_SQL_D"}) then {
		if !(player getVariable ["xr_isleader", false]) then {
			private _leader = leader (group player);
			private _lbcolor = if (alive _leader && {!(_leader getVariable ["xr_pluncon", false])} && {isNull objectParent _leader} && {(getPos _leader) select 2 < 10}) then {
				_leadavailable = true;
				[1,1,1,1.0]
			} else {
				__CTRL(11002) ctrlSetText (localize "STR_DOM_MISSIONSTRING_1706");
				__COLRED
			};
			_ctrl lbSetColor [_sel, _lbcolor];
		};
	};
};

d_lb_tele_first = false;

private _end_pos = if (_data == "D_BASE_D") then {
	getPosATL d_FLAG_BASE;
} else {
	if (_data == "D_SQL_D") then {
		visiblePosition (leader (group player));
	} else {
		if (_uidx != -1) then {
			(d_additional_respawn_points select _uidx) select 1;
		} else {
			visiblePosition (missionNamespace getVariable _data);
		};
	};
};

if (_wone == 1 && {!xr_respawn_available}) then {
	_mravailable = false;
	_data = "";
};

if (_mravailable || {_data == "D_BASE_D"} || {_leadavailable} || {_uidx != -1}) then {
	d_beam_target = _data;
	private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
		format [localize "STR_DOM_MISSIONSTRING_607", _ctrl lbText _sel]
	} else {
		format [localize "STR_DOM_MISSIONSTRING_605", _ctrl lbText _sel]
	};
	__CTRL(100110) ctrlSetText _text;
	__CTRL(100102) ctrlEnable true;
} else {
	d_beam_target = "";
	__CTRL(100110) ctrlSetText "";
	__CTRL(100102) ctrlEnable false;
};

private _ctrlmap = _display displayCtrl 900;
ctrlMapAnimClear _ctrlmap;

_ctrlmap ctrlMapAnimAdd [0, 1, getPosATL player];
_ctrlmap ctrlMapAnimAdd [1.2, 1, _end_pos];
_ctrlmap ctrlMapAnimAdd [0.8, 0.1, _end_pos];
ctrlMapAnimCommit _ctrlmap;