// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_chopperkilled.sqf"
#include "..\..\x_setup.sqf"

_this call d_fnc_fuelCheck;
private _ropes = (param [0]) getVariable "d_ropes";
if (!isNil "_ropes") then {
	{if (!isNull _x) then {ropeDestroy _x}} forEach _ropes;
	(param [0]) setVariable ["d_ropes", nil];
};
private _dummy = (param [0]) getVariable "d_dummy_lw";
if (!isNil "_dummy") then {
	deleteVehicle _dummy;
	(param [0]) setVariable ["d_dummy_lw", nil];
};
