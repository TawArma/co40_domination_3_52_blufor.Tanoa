// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_posbehind2.sqf"
#include "..\..\x_setup.sqf"

params ["_p1", "_p2"];
private _dist = (random 1300) max 900;
[(_p2 vectorDiff _p1) vectorMultiply (1 + (_dist / 1000)), (_p1 getDir _p2) + 180, _dist]