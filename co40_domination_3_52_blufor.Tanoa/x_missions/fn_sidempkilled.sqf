// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_sidempkilled.sqf"
#include "..\x_setup.sqf"

params ["_vec"];

d_allunits_add pushBack _vec;

_vec removeAllMPEventHandlers "MPKilled";
