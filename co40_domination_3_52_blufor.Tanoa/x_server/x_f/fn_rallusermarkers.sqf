// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_rallusermarkers.sqf"
#include "..\..\x_setup.sqf"

{
	if (_x select [0, 15] == "_USER_DEFINED #") then {deleteMarker _x};
} forEach allMapMarkers;