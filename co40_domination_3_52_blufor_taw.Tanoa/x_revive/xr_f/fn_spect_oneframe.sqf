// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_spect_oneframe.sqf"
#include "..\..\x_macros.sqf"

#define __dspctrl(ctrlid) (_disp displayCtrl ctrlid)
#define __spectdlg1006e ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1006)

__TRACE("start one frame")
private _p_no_l = (player getVariable "xr_lives") == -1;
xr_mouseDeltaPos set [0, xr_mouseLastX - (xr_MouseCoord select 0)];
xr_mouseDeltaPos set [1, xr_mouseLastY - (xr_MouseCoord select 1)];
xr_mouseLastX = xr_MouseCoord select 0;
xr_mouseLastY = xr_MouseCoord select 1;
if (xr_MouseScroll != 0) then {
	xr_sdistance = xr_sdistance - (xr_MouseScroll * 0.11);
	xr_MouseScroll = xr_MouseScroll * 0.75;
	if (xr_sdistance > xr_maxDistance) then {
		xr_sdistance = xr_maxDistance;
	} else {
		if (xr_sdistance < -xr_maxDistance) then {
			xr_sdistance = -xr_maxDistance;
		};
	};
	if (xr_sdistance < -0.6) then {xr_sdistance = -0.6};
};

if (time > xr_spect_timer) then {
	if (!_p_no_l) then {
		xr_x_pllist = if (xr_x_withresp) then {[xr_strpl]} else {[]};
		xr_x_plnamelist = if (xr_x_withresp) then {[xr_name_player]} else {[]};
	} else {
		xr_x_pllist = [];
		xr_x_plnamelist = [];
	};
	private _helperls = [];
	if (!_p_no_l) then {
		private _vecp = vehicle player;
		{
			private _u = missionNamespace getVariable _x;
			if (!isNil "_u" && {alive _u} && {side (group _u) == xr_side_pl} && {_u != player} && {!(_u getVariable ["xr_pluncon", false])}) then {
				_helperls pushBack [(vehicle _u) distance2D _vecp, name _u, str _u];
			};
		} forEach d_player_entities;
	} else {
		private _sfm = markerPos "xr_playerparkmarker";
		{
			private _u = missionNamespace getVariable _x;
			if (!isNil "_u" && {alive _u} && {side (group _u) == xr_side_pl} && {_u != player}) then {
				private _distup = _u distance2D _sfm;
				if (_distup > 100) then {
					_helperls pushBack [_distup, name _u, str _u];
				};
			};
		} forEach d_player_entities;
	};
	if !(_helperls isEqualTo []) then {
		_helperls sort false;
		{
			xr_x_pllist pushBack (_x select 2);
			xr_x_plnamelist pushBack (_x select 1);
		} forEach _helperls;
	};
	xr_x_updatelb = true;
	xr_spect_timer = time + 10;
	_helperls = nil;
};
//if (xr_x_updatelb && {!isNil {(uiNamespace getVariable "xr_SpectDlg")}} && {ctrlShown ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1000)}) then {
if (xr_x_updatelb && {!isNil {(uiNamespace getVariable "xr_SpectDlg")}}) then {
	__TRACE_1("","xr_x_updatelb")
	xr_x_updatelb = false;
	lbClear ((uiNamespace getVariable "xr_SpectDlg") displayCtrl 1000);
	private _setidx = -1;
	{
		lbSetData [1000, lbAdd [1000, xr_x_plnamelist select _forEachIndex], _x];
		if (xr_spectcamtargetstr == _x) then {_setidx = _forEachIndex};
	} forEach xr_x_pllist;
	if (_setidx != -1) then {lbSetCurSel [1000, _setidx]};
};
// user pressed ESC
private _spectdisp = uiNamespace getVariable "xr_SpectDlg";
if ((isNil "_spectdisp" || {!ctrlShown (_spectdisp displayCtrl 1002)}) && {!xr_stopspect} && {player getVariable "xr_pluncon"}) then {
	__TRACE("ctrl not shown anymore, black out")
	"xr_revtxt" cutText ["","BLACK OUT", 1];
	__TRACE("creating new dialog")
	createDialog "xr_SpectDlg";
	private _disp = uiNamespace getVariable "xr_SpectDlg";
	__dspctrl(1000) ctrlShow false;
	__dspctrl(3000) ctrlShow false;
	if (!xr_x_withresp) then {
		__dspctrl(1020) ctrlShow false;
		__dspctrl(1021) ctrlShow false;
		__dspctrl(1005) ctrlShow false;
		__dspctrl(1006) ctrlShow false;
	} else {
		if (xr_respawn_available) then {
			__spectdlg1006e ctrlSetText xr_x_loc_922;
			__spectdlg1006e ctrlSetTextColor [1,1,0,1];
			__spectdlg1006e ctrlCommit 0;
		};
	};
	if (!_p_no_l) then {
		xr_spectcamtarget = player;
		xr_spectcamtargetstr = xr_strpl;
		xr_spectcam cameraEffect ["INTERNAL", "Back"];
		xr_spectcam camCommit 0;
		__dspctrl(1010) ctrlSetText xr_name_player;
	} else {
		private _sfm = markerPos "xr_playerparkmarker";
		private _visobj = objNull;
		{
			private _u = missionNamespace getVariable _x;
			if (!isNil "_u" && {alive _u} && {side (group _u) == xr_side_pl} && {_u != player} && {_u distance2D _sfm > 100}) exitWith {
					_visobj = _u;
			};
		} forEach d_player_entities;
		if (isNull _visobj) then {_visobj = player};
		/*_vppv = vehicle _visobj;
		_nposvis = if (!surfaceIsWater (getPosWorld _vppv)) then {
			ASLToATL (visiblePositionASL _vppv)
		} else {
			visiblePosition _vppv
		};*/
		private _nposvis = ASLToATL (visiblePositionASL (vehicle _visobj));
		private _campos = [(_nposvis select 0) - 1 + random 2, (_nposvis select 1) - 1 + random 2, 2];
		xr_spectcam = "camera" camCreate _campos;
		xr_spectcamtarget = _visobj;
		xr_spectcamtargetstr = str _visobj;
		xr_spectcam cameraEffect ["INTERNAL", "Back"];
		xr_spectcam camCommit 0;
		__dspctrl(1010) ctrlSetText (name _visobj);
	};
	xr_spect_timer = -1;
	__TRACE("ctrl not shown anymore, black in")
	"xr_revtxt" cutText ["","BLACK IN", 1];
};
if (isNull xr_spectcamtarget) then { // player disconnect !?!
	/*_vppv = vehicle player;
	_nposvis = if (!surfaceIsWater (getPosWorld _vppv)) then {
		ASLToATL (visiblePositionASL _vppv)
	} else {
		visiblePosition _vppv
	};*/
	private _nposvis = ASLToATL (visiblePositionASL (vehicle player));
	private _campos = [(_nposvis select 0) - 1 + random 2, (_nposvis select 1) - 1 + random 2, 2];
	xr_spectcamtarget = player;
	xr_spectcamtargetstr = xr_strpl;
	xr_spectcam cameraEffect ["INTERNAL", "Back"];
	xr_spectcam camCommit 0;
	__dspctrl(1010) ctrlSetText xr_name_player;
};

private _bb = boundingBoxreal vehicle xr_spectcamtarget;
__TRACE_1("","_bb")
private _l = ((_bb select 1) select 1) - ((_bb select 0) select 1);
__TRACE_1("","_l")
private _hstr = 0.15;
__TRACE_1("","_hstr")
if (isNil "xr_hhx") then {xr_hhx = 2};
xr_hhx = ((((_bb select 1) select 2) - ((_bb select 0) select 2)) * _hstr) + (xr_hhx * (1 - _hstr));
__TRACE_1("","xr_hhx")

/*_vppv = vehicle xr_spectcamtarget;
_vpmtw = if (!surfaceIsWater (getPosWorld _vppv)) then {
	ASLToATL (visiblePositionASL _vppv)
} else {
	visiblePosition _vppv
};*/
private _vpmtw = ASLToATL (visiblePositionASL (vehicle xr_spectcamtarget));
__TRACE_1("","_vpmtw")
xr_spectcam camSetTarget [_vpmtw select 0, _vpmtw select 1, (_vpmtw select 2) + (xr_hhx * 0.6)];
xr_spectcam camSetFov xr_szoom;

private _lsdist = _l * (0.3 max xr_sdistance);
private _d = -_lsdist;
private _co = cos xr_fangleY;
xr_spectcam camSetRelPos [(sin xr_fangle * _d) * _co, (cos xr_fangle * _d) * _co, sin xr_fangleY * _lsdist];
xr_spectcam camCommit 0;
//if (!(player getVariable "xr_pluncon") && {!_p_no_l}) exitWith {xr_stopspect = true};
__TRACE("end one frame")