// by Xeno
//#define __DEBUG__
#define THIS_FILE "initPlayerLocal.sqf"
#include "x_setup.sqf"
diag_log [diag_frameno, diag_ticktime, time, "Executing MPF initPlayerLocal.sqf"];
__TRACE_1("","_this")
if (hasInterface) then {
	["InitializePlayer", [player]] call BIS_fnc_dynamicGroups;
};
diag_log [diag_frameno, diag_ticktime, time, "MPF initPlayerLocal.sqf processed"];
[] call SID_FNC_setupEVH;
