// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_teleupdate_dlg.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated || {d_x_loop_end}) exitWith {};

disableSerialization;

#define __CTRL(A) (_disp displayCtrl A)

params ["_wone"];

private _disp = [uiNamespace getVariable "xr_SpectDlg", uiNamespace getVariable "d_TeleportDialog"] select (_wone == 0);

private _listctrl = __CTRL(1500);

#define __COLRED [1,0,0,0.7]

for "_i" from 0 to ((lbSize _listctrl) - 1) do {
	private _lbdata = _listctrl lbData _i;
	if (_lbdata != "D_BASE_D") then {
		if (_lbdata != "D_SQL_D") then {
			private _mrs = missionNamespace getVariable [_lbdata, objNull];
			if (!isNull _mrs) then {
				private _mravailable = false;
				private _lbcolor = call {
					if (_mrs getVariable ["d_in_air", false]) exitWith {__COLRED};
					if (speed _mrs > 4) exitWith {__COLRED};
					if (surfaceIsWater (getPosWorld _mrs)) exitWith {__COLRED};
					if (!alive _mrs) exitWith {__COLRED};
					if !(_mrs getVariable ["d_MHQ_Deployed", false]) exitWith {__COLRED};
					if (_mrs getVariable ["d_enemy_near", false]) exitWith {__COLRED};
					_mravailable = true;
					[1,1,1,1.0];
				};
				_listctrl lbSetColor [_i, _lbcolor];
				if (lbCurSel _listctrl == _i) then {
					if (_mravailable) then {
						private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
							format [localize "STR_DOM_MISSIONSTRING_607", _listctrl lbText _i]
						} else {
							format [localize "STR_DOM_MISSIONSTRING_605", _listctrl lbText _i]
						};
						__CTRL(100102) ctrlEnable true;
						__CTRL(100110) ctrlSetText _text;
					} else {
						__CTRL(100102) ctrlEnable false;
						__CTRL(100110) ctrlSetText "";
					};
				};
			};
		} else {
			if (d_respawnatsql == 0 && {_lbdata == "D_SQL_D"} && {!(player getVariable ["xr_isleader", false])}) then {
				private _leader = leader (group player);
				private _lbcolor = if (alive _leader && {!(_leader getVariable ["xr_pluncon", false])} && {isNull objectParent _leader} && {(getPos _leader) select 2 < 10}) then {
					private _text = if (_wone == 1 || {d_tele_dialog == 0}) then {
						format [localize "STR_DOM_MISSIONSTRING_607", localize "STR_DOM_MISSIONSTRING_1705a"]
					} else {
						format [localize "STR_DOM_MISSIONSTRING_605", localize "STR_DOM_MISSIONSTRING_1705a"]
					};
					__CTRL(100102) ctrlEnable true;
					__CTRL(100110) ctrlSetText _text;
					[1,1,1,1.0]
				} else {
					__CTRL(100102) ctrlEnable false;
					__CTRL(100110) ctrlSetText "";
					__COLRED
				};
				_listctrl lbSetColor [_i, _lbcolor];
			};
		};
	};
};

if (_wone == 1 && {xr_respawn_available} && {!ctrlEnabled __CTRL(100102)}) then {
	__CTRL(100102) ctrlEnable true;
};
