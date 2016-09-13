// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_player_name_huddo.sqf"
#include "..\..\x_setup.sqf"

disableSerialization;
if (d_show_pname_hud && {!visibleMap} && {isNil "d_is_sat_on"}) then {
	private _eppl = eyePos player;
	{
		private _u = missionNamespace getVariable _x;
		if (!isNil "_u" && {!isNull _u}) then {			
			if (_u != player && {alive player} && {alive _u} && {!(_u getVariable ["xr_pluncon", false])}) then {
				private _distu = (positionCameraToWorld [0,0,0]) distance _u;
				if (_distu <= d_dist_pname_hud) then {
					//if ([player, "VIEW"] checkVisibility [_eppl, eyePos _u] == 0) exitWith {};
					private _vu = vehicle _u;
					private _targetPos = ASLToATL (visiblePositionASL _vu);
					if (!(_targetPos isEqualTo []) && {(_vu == _u || {(_vu != _u && {_u == driver _vu})})}) then {
						private _tex = "";
						private  _scale = 1;
						if (_distu <= 100) then {
							_tex = if (d_show_player_namesx == 1) then {
								[_u] call d_fnc_gethpname
							} else {
								if (d_show_player_namesx == 2) then {
									str(9 - round(9 * damage _u))
								} else {
									d_phud_loc886
								};
							};
							if (isNil "_tex") then {_tex = d_phud_loc886};
							//_scale = [(1.2 - ((_distu / 50) * .65)) max 0.8, 1.2] select (_distu == 0);
						} else {
							_tex = "*";
							//_scale = 0.4;
						};
						private _col = [d_pnhudothercolor, d_pnhudgroupcolor] select (group _u == group player);
						_targetPos set [2 , (_targetPos select 2) + (_distu/40) + 2];
						drawIcon3D ["#(argb,8,8,3)color(0,0,0,0)", _col, _targetPos, 1, 1, 0, _tex, 1, _scale / 35, "RobotoCondensedBold"];
					};
				};
			};
		};
	} forEach d_phud_units;
} else {
	if (!d_show_pname_hud) then {
		removeMissionEventHandler ["Draw3D", d_phudraw3d];
		d_phudraw3d = -1;
	};
};