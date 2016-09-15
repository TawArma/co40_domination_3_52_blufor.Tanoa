// by Xeno
#define THIS_FILE "fn_clean_craters.sqf"
#include "..\..\x_setup.sqf"

private _craters = allMissionObjects "CraterLong" + allMissionObjects "CraterLong_small";
{
	deleteVehicle _x;
	sleep 0.212;
} forEach _craters;
_craters = nil;

["itemAdd", ["dom_clean_craters", {["itemRemove", ["dom_clean_craters"]] call bis_fnc_loop; 0 spawn d_fnc_clean_craters}, 240 + random 240]] call bis_fnc_loop;
