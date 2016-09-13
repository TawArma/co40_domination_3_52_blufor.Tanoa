// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sfunc.sqf"
#include "..\..\x_setup.sqf"

if (alive player && {!(player getVariable ["xr_pluncon", false])} && {isNull objectParent player}) then {
	d_objectID2 = cursorObject;
	if (!(d_objectID2 isKindOf "LandVehicle") && {!(d_objectID2 isKindOf "Air")}) exitWith {false};
	if (!alive d_objectID2) exitWith {false};	
	(damage d_objectID2 > 0.05 || {fuel d_objectID2 < 1})
} else {
	false
}
