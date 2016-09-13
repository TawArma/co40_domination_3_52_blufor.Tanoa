// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_revive\xr_f\fn_drag.sqf"
#include "..\..\x_macros.sqf"

#include "\A3\ui_f\hpp\defineDIKCodes.inc"

if (isDedicated) exitWith {};

private _dragee = player getVariable "xr_cursorTarget";

if (player getVariable ["xr_is_dragging", false]) exitWith {};

if (isNull _dragee|| {!alive player}) exitWith {};

player setVariable ["xr_pisinaction", true];
player setVariable ["xr_is_dragging", true];

if (stance player == "PRONE") exitWith {
	[_dragee] spawn xr_fnc_dragprone;
};

private _unit = player;
private _name_dragee = localize "STR_DOM_MISSIONSTRING_906";
if (alive _dragee && {name _dragee != _name_dragee}) then {_name_dragee = name _dragee};

xr_drag_keys_ar = [DIK_C] + (actionKeys "NetworkStats") + (actionKeys "Crouch") + (actionKeys "Stand");
xr_drag_keyDownEHId = (findDisplay 46) displayAddEventHandler ["KeyDown", {_this call xr_fnc_dragkeydown}];
_dragee setVariable ["xr_dragged", true, true];

_unit playMoveNow "acinpknlmstpsraswrfldnon";
sleep 2;

[_dragee, "AinjPpneMstpSnonWrflDnon"] remoteExecCall ["switchMove"];
_dragee attachto [_unit,[0.1, 1.01, 0]];

sleep 0.02;
[_dragee, 180] remoteExecCall ["setDir"];

xr_drag = true;
sleep 0.02;


if (xr_dropAction != -3333) then {player removeAction xr_dropAction;xr_dropAction = -3333};
xr_dropAction = player addAction [format["<t color='#FF0000'>Drop %1</t>",_name_dragee], {_this call xr_fnc_drop_body}, [_dragee, 0], 0, false, true];
xr_carryAction = player addAction [format["<t color='#FF0000'>Carry %1</t>",_name_dragee], {_this spawn xr_fnc_carry}, _dragee, 0, false, true];
sleep 1;

private _found_anim = false;

private _animsd = ["acinpknlmstpsraswrfldnon","acinpknlmwlksraswrfldb"];

while {xr_drag} do {
	if (!_found_anim && {animationState player in _animsd}) then {
		_found_anim = true;
	};
	if (!alive _dragee || {!(_dragee getVariable ["xr_pluncon", false])}) exitWith {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		if (xr_carryAction != -3333) then {
			player removeAction xr_carryAction;
			xr_carryAction = -3333;
		};
		detach _dragee;
		sleep 0.5;
		if ((alive _dragee && {_dragee getVariable ["xr_pluncon", false]}) || {!alive _dragee}) then {
			[_dragee, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[_dragee, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
		[_unit, ""] remoteExecCall ["switchMove"];
		sleep 1;
		xr_drag = false;
	};
	
	if (_found_anim && {!((animationState _unit) in _animsd)}) exitWith {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		if (xr_carryAction != -3333) then {
			player removeAction xr_carryAction;
			xr_carryAction = -3333;
		};
		detach _dragee;
		sleep 0.5;
		if ((alive _dragee && {_dragee getVariable ["xr_pluncon", false]}) || {!alive _dragee}) then {
			[_dragee, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[_dragee, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
		[_unit, ""] remoteExecCall ["switchMove"];
		sleep 1;
		xr_drag = false;
	};

	if (!alive _unit) exitWith {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		if (xr_carryAction != -3333) then {
			player removeAction xr_carryAction;
			xr_carryAction = -3333;
		};
		detach _unit;
		if ((alive _dragee && {_dragee getVariable ["xr_pluncon", false]}) || {!alive _dragee}) then {
			[_dragee, 101] remoteExecCall ["xr_fnc_handlenet"];
		} else {
			[_dragee, 102] remoteExecCall ["xr_fnc_handlenet"];
		};
		[_unit, ""] remoteExecCall ["switchMove"];
		sleep 1;
		xr_drag = false;
	};
	
	if (isNull _dragee) then {
		player removeAction xr_dropAction;
		xr_dropAction = -3333;
		if (xr_carryAction != -3333) then {
			player removeAction xr_carryAction;
			xr_carryAction = -3333;
		};
		detach _unit;
		[_unit, ""] remoteExecCall ["switchMove"];
		sleep 1;
		xr_drag = false;
	};
	sleep 0.1;
};

player setVariable ["xr_pisinaction", false];
player setVariable ["xr_is_dragging", false];
_dragee setVariable ["xr_dragged", false, true];

(findDisplay 46) displayRemoveEventHandler ["KeyDown", xr_drag_keyDownEHId];

if (xr_carryAction != -3333) then {
	player removeAction xr_carryAction;
	xr_carryAction = -3333;
};