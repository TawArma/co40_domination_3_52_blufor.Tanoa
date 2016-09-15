// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_checksmshothd.sqf"
#include "..\x_setup.sqf"

__TRACE_1("","_this")

if (!alive (param [0])) exitWith {
	(param [0]) removeAllEventHandlers "handleDamage";
};

if (toUpper(getText(configFile>>"CfgAmmo">>(param [4])>>"simulation")) in d_hd_sim_types) then {
#ifdef __TT__
	private _obj = param [3];
	if (!isNull _obj && {isPlayer _obj}) then {
		if (side (group _obj) == opfor) then {
			d_sm_points_opfor = d_sm_points_opfor + 1;
		} else {
			d_sm_points_blufor = d_sm_points_blufor + 1;
		};
	};
	__TRACE_2("","d_sm_points_blufor","d_sm_points_opfor")
#endif
	param [2]
} else {
	0
}