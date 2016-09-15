// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_player_stuff.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

__TRACE_1("","_this")
d_player_autokick_time = param [0];

if (d_WithRevive == 0 && {(param [8]) == -1} && {xr_max_lives != -1}) exitWith {
	0 spawn {
		scriptName "spawn_playerstuffparking";
		waitUntil {!d_still_in_intro};
		__TRACE("player_stuff, calling park_player")
		[false] spawn xr_fnc_park_player;
	};
};

#ifdef __TT__
private _prev_side = param [5];
if (_prev_side != sideUnknown && {d_player_side != _prev_side}) then {
	[format [localize "STR_DOM_MISSIONSTRING_641", d_name_pl, _prev_side, d_player_side], "GLOBAL"] remoteExecCall ["d_fnc_HintChatMsg", [0, -2] select isDedicated];
};
#endif