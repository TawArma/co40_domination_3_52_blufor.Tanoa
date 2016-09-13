// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_creategroup.sqf"
#include "..\..\x_setup.sqf"

params ["_side"];
private _side_str = if (_side isEqualType sideUnknown) then {
	_side
} else {
	if (_side isEqualType "") then {
		switch (_side) do {
			case "EAST";
			case "E": {opfor};
			case "WEST";
			case "W": {blufor};
			case "GUER";
			case "G": {independent};
			default {civilian};
		}
	} else {
		if (_side isEqualType objNull) then {
			side _side
		} else {
			_side
		};
	};
};
private _grp = createGroup _side_str;
// d_gstate
// 0 = created
// 1 = filled with units
// 2 = reduced
[_grp, 0] call d_fnc_setGState;
#ifdef __GROUPDEBUG__
if (isNil "d_all_marker_groups") then {
	d_all_marker_groups = [];
	0 spawn d_fnc_map_group_count_marker;
};
[_grp] spawn d_fnc_groupmarker;
#endif
__TRACE_1("creategroup","_grp")
_grp