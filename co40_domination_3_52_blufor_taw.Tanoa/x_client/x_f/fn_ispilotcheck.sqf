// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_ispilot.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

// when does BIS learn... why is there not a simple config entry which says that those items are pilot items, would make checking things like this totally easy
((uniform player in ["U_O_PilotCoveralls", "U_B_HeliPilotCoveralls", "U_I_HeliPilotCoveralls"]) && {headgear player in ["H_PilotHelmetHeli_B", "H_PilotHelmetHeli_O", "H_PilotHelmetHeli_I"]})