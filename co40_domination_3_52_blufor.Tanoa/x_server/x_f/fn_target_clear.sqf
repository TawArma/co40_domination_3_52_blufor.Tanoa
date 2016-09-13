// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_target_clear.sqf"
#include "..\..\x_setup.sqf"
if (!isServer) exitWith{};

sleep 1.123;

if (!isNull d_f_check_trigger) then {deleteVehicle d_f_check_trigger};
#ifdef __TT__
if (!isNull d_f_check_trigger2) then {deleteVehicle d_f_check_trigger2};
#endif
deleteVehicle d_current_trigger;
if (!isNil "d_HC_CLIENT_OBJ_OWNER") then {
	remoteExecCall ["d_fnc_xdelct", d_HC_CLIENT_OBJ_OWNER];
	[missionNamespace, ["d_mt_done", true]] remoteExecCall ["setVariable", d_HC_CLIENT_OBJ_OWNER];
} else {
	d_mt_done = true;
};
sleep 0.01;

if (!d_side_main_done) then {
	if (alive d_fixor_var) then {
		sleep 60 + random 60;
		if (alive d_fixor_var) then {
			d_fixor_var setDamage 1;
		};	
	};
	d_side_main_done = true;
};

private _cur_tgt_name = d_cur_tgt_name;

#ifndef __TT__
d_counterattack = false;
private _start_real = false;
if ((random 100) > 95) then {
	d_counterattack = true;
	_start_real = true;	
	d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "CounterattackEnemy", ["1", "", _cur_tgt_name, []], "SIDE"];
	0 spawn d_fnc_counterattack;
};

while {d_counterattack} do {sleep 3.123};

if (_start_real) then {
	d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "CounterattackDefeated", "SIDE"];
	sleep 2.321;
};
#endif

d_old_target_pos =+ d_cur_tgt_pos;
d_old_radius = d_cur_target_radius;

#ifndef __TT__
d_resolved_targets pushBack d_current_target_index;
publicVariable "d_resolved_targets";
#else
private _addpblufor = 0;
private _addpopfor = 0;
private _pdist = d_old_radius + 200;
{
	if (alive _x && {!(_x getVariable ["xr_pluncon", false])} && {_x distance2D d_old_target_pos < _pdist}) then {
		_x addScore (d_tt_points select 0);
		switch (side (group _x)) do {
			case blufor: {_addpblufor = _addpblufor + (d_tt_points select 0)};
			case opfor: {_addpopfor = _addpopfor + (d_tt_points select 0)};
		};
	};
} forEach allPlayers;

d_kill_points_blufor = d_kill_points_blufor + _addpblufor;
d_kill_points_opfor = d_kill_points_opfor + _addpopfor;

if (d_kill_points_blufor > d_kill_points_opfor) then {
	d_mt_winner = 1;
	d_points_blufor = d_points_blufor + (d_tt_points select 0);
} else {
	if (d_kill_points_opfor > d_kill_points_blufor) then {
		d_mt_winner = 2;
		d_points_opfor = d_points_opfor + (d_tt_points select 0);
	} else {
		if (d_kill_points_opfor == d_kill_points_blufor) then {
			d_mt_winner = 3;
			d_points_blufor = d_points_blufor + (d_tt_points select 1);
			d_points_opfor = d_points_opfor + (d_tt_points select 1);
		};
	};
};
publicVariable "d_mt_winner";
d_points_array = [d_points_blufor, d_points_opfor, d_kill_points_blufor, d_kill_points_opfor]; 
publicVariable "d_points_array";

d_resolved_targets pushBack [d_current_target_index, d_mt_winner];
publicVariable "d_resolved_targets";
sleep 0.5;
d_public_points = false;
#endif

if (!isNil "d_HC_CLIENT_OBJ_OWNER") then {
	remoteExecCall ["d_fnc_dodelintelu", d_HC_CLIENT_OBJ_OWNER];
} else {
	if (!isNull d_intel_unit) then {
		deleteVehicle d_intel_unit;
		d_intel_unit = objNull;
	};
};

sleep 0.5;

if !(d_maintargets_list isEqualTo []) then {
	0 spawn d_fnc_gettargetbonus;
} else {
	d_target_clear = true; publicVariable "d_target_clear";
	//["d_" + _cur_tgt_name + "_dommtm", "ColorGreen"] remoteExecCall ["setMarkerColor", 2];
	("d_" + _cur_tgt_name + "_dommtm") setMarkerColor "ColorGreen";
#ifndef __TT__
	"" remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
#else
	["", ""] remoteExec ["d_fnc_target_clear_client", [0, -2] select isDedicated];
#endif
#ifndef __TT__
	d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "Captured2", ["1", "", _cur_tgt_name, [_cur_tgt_name]],"SIDE"];
#else
	
	d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","Captured2",["1","",_cur_tgt_name,[_cur_tgt_name]],"SIDE"];
	d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","Captured2",["1","",_cur_tgt_name,[_cur_tgt_name]],"SIDE"];
#endif
};

sleep 2.123;

if !(d_maintargets_list isEqualTo []) then {
	if (!isNil "d_HC_CLIENT_OBJ_OWNER") then {
		//d_current_target_index remoteExecCall ["d_fnc_deleteunits", d_HC_CLIENT_OBJ_OWNER];
		[1, d_current_target_index] remoteExecCall ["d_fnc_doexechcf", d_HC_CLIENT_OBJ_OWNER];
	} else {
		//d_current_target_index call d_fnc_DeleteUnits;
		d_current_target_index execFSM "fsms\fn_DeleteUnits.fsm";
	};
};

sleep 4.321;

if (d_WithJumpFlags == 1 && {!(d_maintargets_list isEqualTo [])}) then {0 spawn d_fnc_createjumpflag};

if (!isNil "d_HC_CLIENT_OBJ_OWNER") then {
	remoteExecCall ["d_fnc_dodelrspgrps", d_HC_CLIENT_OBJ_OWNER];
} else {
	if !(d_respawn_ai_groups isEqualTo []) then {
		0 spawn {
			__TRACE_1("","d_respawn_ai_groups")
			{
				if (_x isEqualType []) then {
					_x params ["_rgrp"];
					__TRACE_1("","_rgrp")
					if (!isNil "_rgrp" && {_rgrp isEqualType grpNull} && {!isNull _rgrp}) then {
						{
							private _uni = _x;
							__TRACE_1("","_uni")
							if (!isNil "_uni" && {!isNull _uni}) then {
								private _v = vehicle _uni;
								__TRACE_1("","_v")
								if (_v != _uni && {alive _v}) then {_v setDamage 1};
								if (alive _uni) then {_uni setDamage 1}
							};
						} forEach (units _rgrp);
					};
				};
			} forEach d_respawn_ai_groups;
		};
	};
};

_del_camps_stuff = [];
{
	private _flag = _x getVariable "d_FLAG";
	deleteMarker format ["d_camp%1",_x getVariable "d_INDEX"];
	_del_camps_stuff pushBack _x;
	if (!isNull _flag) then {
		_del_camps_stuff pushBack _flag;
	};
} forEach d_currentcamps;
d_currentcamps = [];
#ifdef __TT__
d_campscaptured_w = 0;
publicVariable "d_campscaptured_w";
d_campscaptured_e = 0;
publicVariable "d_campscaptured_e";
#endif

sleep 0.245;

if (isNil "d_HC_CLIENT_OBJ_OWNER") then {
	//[d_old_target_pos, d_old_radius, _del_camps_stuff] call d_fnc_DeleteEmpty;
	[d_old_target_pos, d_old_radius, _del_camps_stuff] execFSM "fsms\fn_DeleteEmpty.fsm";
} else {
	[d_old_target_pos, d_old_radius, _del_camps_stuff] remoteExecCall ["d_fnc_DeleteEmpty", d_HC_CLIENT_OBJ_OWNER];
};

if !(d_maintargets_list isEqualTo []) then {
	if (d_MHQDisableNearMT != 0) then {
		{
			if (alive _x) then {
				private _fux = _x getVariable "d_vecfuelmhq";
				if (!isNil "_fux") then {
					if (fuel _x < _fux) then {
						[_x, _fux] remoteExecCall ["setFuel", _x];
					};
					_x setVariable ["d_vecfuelmhq", nil, true];
				};
			};
		} forEach vehicles;
	};
	sleep 15;
#ifdef __TT__
	d_kill_points_blufor = 0;
	d_kill_points_opfor = 0;
	d_public_points = true;
#endif
	0 spawn d_fnc_createnexttarget;
} else {
#ifdef __TT__
	d_the_end = true; publicVariable "d_the_end";
	0 spawn d_fnc_DomEnd;
#else
	if (d_WithRecapture == 0) then {
		if (d_recapture_indices isEqualTo []) then {
			d_the_end = true; publicVariable "d_the_end";
			0 spawn d_fnc_DomEnd;
		} else {
			0 spawn {
				scriptName "spawn_x_target_clear_waitforrecap";
				while {!(d_recapture_indices isEqualTo [])} do {
					sleep 2.543;
				};
				d_the_end = true; publicVariable "d_the_end";
				0 spawn d_fnc_DomEnd;
			};
		};
	} else {
		d_the_end = true; publicVariable "d_the_end";
		0 spawn d_fnc_DomEnd;
	};
#endif
};