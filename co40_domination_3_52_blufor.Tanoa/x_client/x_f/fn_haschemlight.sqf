// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_haschemlight.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

private _chemar = [];
{
	if (getText(configFile>>"CfgMagazines">>_x>>"nameSound") == "Chemlight") then {
		_chemar pushBackUnique _x;
	};
} forEach (magazines player);

_chemar