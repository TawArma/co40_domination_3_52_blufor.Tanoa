// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_setgstate.sqf"
#include "..\..\x_setup.sqf"

params ["_grp", "_gstate"];
__TRACE_2("","_grp","_gstate")
_grp setVariable ["d_gstate", _gstate];
if (d_IS_HC_CLIENT) then {
	[_grp, ["d_fromHC", true]] remoteExecCall ["setVariable", 2];
};