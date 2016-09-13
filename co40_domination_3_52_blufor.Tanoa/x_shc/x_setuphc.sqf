// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_setuphc.sqf"
#include "..\x_setup.sqf"

__TRACE("Running HC setup")

player removeAllEventHandlers "handleDamage";
player removeAllEventHandlers "respawn";
player addEventHandler ["handleDamage", {0}];
player setPos [-10000,10000,0.3];
[player, false] remoteExecCall ["enableSimulationGlobal", 2];
player remoteExecCall ["hideObjectGlobal", 2];
enableEnvironment false;
player addEventHandler ["respawn", {
	player setPos [-10000,10000,0.3];
	player removeAllEventHandlers "handleDamage";
	player addEventHandler ["handleDamage", {0}];
	player allowDamage false;
	player remoteExecCall ["hideObjectGlobal", 2];
	[player, false] remoteExecCall ["enableSimulationGlobal", 2];
}];

call compile preprocessFileLineNumbers "x_shc\x_shcinit.sqf";

_confmapsize = getNumber(configFile>>"CfgWorlds">>worldName>>"mapSize");
d_island_center = [_confmapsize / 2, _confmapsize / 2, 300];

d_island_x_max = _confmapsize;
d_island_y_max = _confmapsize;

[missionNamespace, ["d_HC_CLIENT_READY", true]] remoteExecCall ["setVariable", 2];

__TRACE("HC setup done")