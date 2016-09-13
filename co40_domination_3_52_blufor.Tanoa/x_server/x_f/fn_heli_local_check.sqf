// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_heli_local_check.sqf"
#include "..\..\x_setup.sqf"

params ["_chopper", "_local"];

__TRACE_1("","_local")

if (!_local) exitWith {};

__TRACE_1("","_chopper")

private _lon = _chopper getVariable "d_mhq_lift_obj";
__TRACE_1("","_lon")
if (!isNil "_lon") then {
	private _lobj = _lon param [0];
	if (!isNil "_lobj" && {alive _lobj}) then {
		_lobj setVariable ["d_in_air", false, true];
		d_kb_logic1 kbTell [d_kb_logic2, d_kb_topic_side, "Dmr_available", ["1", "", _lon param [1], []], "SIDE"];
	};
	if (alive _chopper) then {
		_chopper setVariable ["d_mhq_lift_obj", nil, true];
	};
};

private _ropes = _chopper getVariable "d_ropes";
__TRACE_1("","_ropes")
if (!isNil "_ropes") then {
	{if (!isNull _x) then {ropeDestroy _x}} forEach _ropes;
};

private _dummy = _chopper getVariable "d_dummy_lw";
__TRACE_1("","_dummy")
if (!isNil "_dummy") then {
	deleteVehicle _dummy;
	_chopper setVariable ["d_dummy_lw", nil, true];
};

if (alive _chopper) then {
	_chopper setVariable ["d_ropes", nil, true];
};

private _lobm = _chopper getVariable "d_lobm";
__TRACE_1("","_lobm")
if (!isNil "_lobm") then {
	_lobm remoteExecCall ["setMass"];
	if (alive _chopper) then {
		_chopper setVariable ["d_lobm", nil, true];
	};
};
