// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_nostreaming.sqf"
#include "..\..\x_setup.sqf"

cutText [localize "STR_DOM_MISSIONSTRING_1456", "BLACK"];
waitUntil {sleep 0.71; !isStreamFriendlyUIEnabled};
cutText ["", "PLAIN"];
["itemAdd", ["dom_nostreaming", {["itemRemove", ["dom_nostreaming"]] call bis_fnc_loop; 0 spawn d_fnc_nostreaming}, 1, "seconds", {isStreamFriendlyUIEnabled}]] call bis_fnc_loop;