// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_hasnvgoggles.sqf"
#include "..\..\x_setup.sqf"

private _hmd = hmd _this;
(_hmd == "NVGoggles" || {_hmd == "NVGoggles_OPFOR"} || {_hmd == "NVGoggles_INDEP"})
