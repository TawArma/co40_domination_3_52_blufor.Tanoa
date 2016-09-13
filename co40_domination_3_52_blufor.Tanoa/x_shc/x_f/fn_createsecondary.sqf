// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_createsecondary.sqf"
#include "..\..\x_setup.sqf"

#define __getPos \
private _poss = [_posarx, _mtradius] call d_fnc_GetRanPointCircleBig;\
if (!(_poss isEqualTo []) && {isOnRoad _poss}) then {_poss = []};\
while {_poss isEqualTo []} do {\
	_poss = [_posarx, _mtradius] call d_fnc_GetRanPointCircleBig;\
	if (!(_poss isEqualTo []) && {isOnRoad _poss}) then {_poss = []};\
}

if !(call d_fnc_checkSHC) exitWith {};

params ["_wp_array", "_mtradius", "_trg_center"];

sleep 3.120;

private _mtmhandle = _wp_array execVM "x_shc\x_getmtmission.sqf";

waitUntil {sleep 0.321; scriptDone _mtmhandle};

sleep 5.0123;

private _posarx = _trg_center;
__getPos;
private _vec = createVehicle [d_illum_tower, _poss, [], 0, "NONE"];
_vec setPos _poss;
_vec setVectorUp [0,0,1];
[_vec] call d_fnc_CheckMTHardTarget;
d_mt_radio_down = false;
[missionNamespace, ["d_mt_radio_down", false]] remoteExecCall ["setVariable", 2];
["d_main_target_radiotower", _poss,"ICON","ColorBlack",[0.5,0.5],localize "STR_DOM_MISSIONSTRING_521",0,"mil_dot"] remoteExecCall ["d_fnc_CreateMarkerGlobal", 2];

#ifndef __TT__
[9] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
[10] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif
sleep 1.0112;

private _newgroup = [d_side_enemy] call d_fnc_creategroup;
[_poss, ["specops", d_enemy_side_short] call d_fnc_getunitlistm, _newgroup] spawn d_fnc_makemgroup;
sleep 1.0112;
_newgroup allowFleeing 0;
_newgroup setVariable ["d_defend", true];
[_newgroup, _poss] spawn d_fnc_taskDefend;
[_newgroup, 1] call d_fnc_setGState;

sleep 5.234;
d_mt_spotted = false;
d_create_new_paras = false;
#ifndef __TT__
d_f_check_trigger = [d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], [d_own_side, d_enemy_side + " D", false], ["this", "0 = 0 spawn {if (!d_create_new_paras) then {d_create_new_paras = true;0 execFSM 'fsms\fn_Parahandler.fsm'};d_mt_spotted = true;[12] remoteExecCall ['d_fnc_DoKBMsg', 2];sleep 5;deleteVehicle d_f_check_trigger}", ""]] call d_fnc_createtriggerlocal;
#else
d_f_check_trigger = [d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["WEST", "WEST D", false], ["this", "0 = 0 spawn {if (!d_create_new_paras) then {d_create_new_paras = true;0 execFSM 'fsms\fn_Parahandler.fsm'};d_mt_spotted = true;[13] remoteExecCall ['d_fnc_DoKBMsg', 2];sleep 5;deleteVehicle d_f_check_trigger;if (!isNull d_f_check_trigger2) then {deleteVehicle d_f_check_trigger2}}", ""]] call d_fnc_createtriggerlocal;
d_f_check_trigger2 = [d_cur_tgt_pos, [d_cur_target_radius + 300, d_cur_target_radius + 300, 0, false], ["EAST", "EAST D", false], ["this", "0 = 0 spawn {if (!d_create_new_paras) then {d_create_new_paras = true;0 execFSM 'fsms\fn_Parahandler.fsm'};d_mt_spotted = true;[14] remoteExecCall ['d_fnc_DoKBMsg', 2];sleep 5;deleteVehicle d_f_check_trigger2;if (!isNull d_f_check_trigger) then {deleteVehicle d_f_check_trigger}}", ""]] call d_fnc_createtriggerlocal;
#endif

sleep 5.234;
private _d_currentcamps = [];
#ifndef __TT__
private _nrcamps = (ceil random 5) max 3;
#else
private _nrcamps = (ceil random 6) max 4;
#endif
private _ctype = d_wcamp;

d_sum_camps = _nrcamps;
if (!isServer) then {
	[missionNamespace, ["d_sum_camps", _nrcamps]] remoteExecCall ["setVariable", 2];
};
//_posarx = _trg_center;
for "_i" from 1 to _nrcamps do {
	__getPos;
	private _wf = createVehicle [_ctype, _poss, [], 0, "NONE"];
	_wf setDir floor random 360;
	private _svec = sizeOf _ctype;
	__TRACE_1("","_svec")
	_xcountx = 0;
	_isFlat = [];
	while {_xcountx < 99} do {
		_isFlat = (getPosATL _wf) isFlatEmpty [_svec / 4, -1, 0.7, _svec / 2, 0, false, _wf]; // 100
		if !(_isFlat isEqualTo []) then {
			_isFlat set [2, 0];
			if (!isOnRoad _isFlat) then {
				_poss = _isFlat;
			} else {
				_isFlat = [];
			};
			if (!(_isFlat isEqualTo []) && {!(_d_currentcamps isEqualTo [])}) then {
				{
					if (_wf distance2D _x < 70) exitWith {
						_isFlat = [];
					};
				} forEach _d_currentcamps;
			};
		};
		if !(_isFlat isEqualTo []) exitWith {};
		_xcountx = _xcountx + 1;
	};
	_poss set [2, 0];
	_wf setPos _poss;
	_d_currentcamps pushBack _wf;
	_wf setVariable ["d_SIDE", d_enemy_side, true];
	_wf setVariable ["d_INDEX", _i, true];
	_wf setVariable ["d_CAPTIME", 40 + (floor random 10), true];
	_wf setVariable ["d_CURCAPTIME", 0, true];
#ifndef __TT__
	_wf setVariable ["d_CURCAPTURER", d_own_side];
#else
	_wf setVariable ["d_CURCAPTURER", ""];
#endif
	_wf setVariable ["d_STALL", false, true];
	_wf setVariable ["d_TARGET_MID_POS", _trg_center];
	_fwfpos = getPosATL _wf;
	_fwfpos set [2, 4.3];
	private _flagPole = createVehicle [d_flag_pole, _fwfpos, [], 0, "NONE"];
	_flagPole setPos _fwfpos;
	_wf setVariable ["d_FLAG", _flagPole, true];
	_maname = format["d_camp%1",_i];
	[_maname, _poss,"ICON","ColorBlack",[0.5,0.5],"",0,d_strongpointmarker] remoteExecCall ["d_fnc_CreateMarkerGlobal", 2];
	_flagPole setFlagTexture (call d_fnc_getenemyflagtex);
	
	_wf addEventHandler ["HandleDamage", {0}];
	//[_wf, _flagPole] call d_fnc_HandleCamps2;
#ifndef __TT__
	[_wf, _flagPole] execFSM "fsms\fn_HandleCamps2.fsm";
#else
	[_wf, _flagPole] execFSM "fsms\fn_HandleCampsTT2.fsm";
#endif
	sleep 0.5;
	
	private _newgroup = [d_side_enemy] call d_fnc_creategroup;
	[_poss, ["specops", d_enemy_side_short] call d_fnc_getunitlistm, _newgroup] spawn d_fnc_makemgroup;
	sleep 1.0112;
	_newgroup allowFleeing 0;
	_newgroup setVariable ["d_defend", true];
	[_newgroup, _poss] spawn d_fnc_taskDefend;
	[_newgroup, 1] call d_fnc_setGState;
};

[missionNamespace, ["d_currentcamps", _d_currentcamps]] remoteExecCall ["setVariable", 2];
d_numcamps = count _d_currentcamps; publicVariable "d_numcamps";
d_campscaptured = 0; publicVariable "d_campscaptured";

#ifndef __TT__
[15, _nrcamps] remoteExecCall ["d_fnc_DoKBMsg", 2];
#else
[16, _nrcamps] remoteExecCall ["d_fnc_DoKBMsg", 2];
#endif

if (random 100 > 70) then {
	[_mtradius, _trg_center] call d_fnc_minefield;
};

sleep 5.213;
d_main_target_ready = true;
if (!isServer) then {
	[missionNamespace, ["d_main_target_ready", true]] remoteExecCall ["setVariable", 2];
};
