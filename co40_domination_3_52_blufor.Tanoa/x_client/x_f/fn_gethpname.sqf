// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_gethpname.sqf"
#include "..\..\x_setup.sqf"

params ["_u"];
private _n = _u getVariable "d_phname";
if (isNil "_n") then {
	_n = (name _u) + (["", d_phud_loc884] select (getNumber (configFile>>"CfgVehicles">>typeOf _u>>"attendant") == 1));
	_u setVariable ["d_phname", _n];
};
_n
