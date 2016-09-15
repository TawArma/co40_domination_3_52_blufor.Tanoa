// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_getunitlistm.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

params ["_grptype", "_side"];

private _side_char = [switch (_side) do {case opfor: {"E"};case blufor: {"W"};case independent: {"G"};case civilian: {"W"};}, _side] select (_side isEqualType "");

selectRandom (missionNamespace getVariable format ["d_%1_%2", _grptype, _side_char])
