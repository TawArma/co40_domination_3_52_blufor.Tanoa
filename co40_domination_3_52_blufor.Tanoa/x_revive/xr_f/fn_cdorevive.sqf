// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_revive\xr_f\fn_cdorevive.sqf"
#include "..\..\x_macros.sqf"

if (isDedicated) exitWith {};

player setVariable ["xr_cursorTarget", param [0]];

call xr_fnc_dorevive;