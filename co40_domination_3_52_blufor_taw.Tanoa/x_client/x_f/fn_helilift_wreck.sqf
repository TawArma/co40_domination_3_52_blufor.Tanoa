// by Xeno
#define THIS_FILE "fn_helilift_wreck.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

params ["_chopper"];

private _menu_lift_shown = false;
private _liftobj = objNull;
private _id = -1212;
private _release_id = -1212;

_chopper setVariable ["d_vec_attached", false];
_chopper setVariable ["d_vec_released", false];
_chopper setVariable ["d_Attached_Vec", objNull];

_possible_types = _chopper getVariable ["d_lift_types", []];

sleep 10.123;

while {(alive _chopper) && (alive player) && (player in _chopper)} do {
	if ((driver _chopper) == player) then {
		private _pos = getPosATLVisual _chopper;
		
		if (!(_chopper getVariable ["d_vec_attached", false]) && {(_pos select 2 > 2.5)} && {(_pos select 2 < 50)}) then {
			_liftobj = objNull;
			private _nobjects = nearestObjects [_chopper, ["LandVehicle","Air"], 70];
			if !(_nobjects isEqualTo []) then {
				private _dummy = _nobjects select 0;
				if (_dummy == _chopper) then {
					if (count _nobjects > 1) then {_liftobj = _nobjects select 1};
				} else {
					_liftobj = _dummy;
				};
			};
			if (!isNull _liftobj) then {
				if (_liftobj isKindOf "CAManBase") then {
					_liftobj = objNull;
				} else {
					if ((damage _liftobj < 1) || {!((toUpper(typeof _liftobj)) in _possible_types)}) then {_liftobj = objNull};
				};
			};
			sleep 0.1;
			if ((_liftobj getVariable ["d_WreckMaxRepair", d_WreckMaxRepair]) > 0 && {!isNull _liftobj} && {_liftobj != _chopper getVariable "d_Attached_Vec"}) then {
				_liftobj_pos = getPosATLVisual _liftobj;
				private _nx = _liftobj_pos select 0;private _ny = _liftobj_pos select 1;private _px = _pos select 0;private _py = _pos select 1;
				if ((_px <= _nx + 10 && {_px >= _nx - 10}) && {(_py <= _ny + 10 && {_py >= _ny - 10})}) then {
					if (!_menu_lift_shown) then {
						_id = _chopper addAction [format ["<t color='#AAD9EF'>%1</t>", localize "STR_DOM_MISSIONSTRING_254"], {_this call d_fnc_heli_action},-1,100000];
						_menu_lift_shown = true;
					};
				} else {
					_liftobj = objNull;
					if (_menu_lift_shown) then {
						_chopper removeAction _id;
						_id = -1212;
						_menu_lift_shown = false;
					};
				};
			};
		} else {
			if (_menu_lift_shown) then {
				_chopper removeAction _id;
				_id = -1212;
				_menu_lift_shown = false;
			};
			
			sleep 0.1;
			
			if (isNull _liftobj) then {
				_chopper setVariable ["d_vec_attached", false];
				_chopper setVariable ["d_vec_released", false];
			} else {
				if (_chopper getVariable "d_vec_attached") then {
					_release_id = _chopper addAction [format ["<t color='#FF0000'>%1</t>", localize "STR_DOM_MISSIONSTRING_255"], {_this call d_fnc_heli_release}, -1, 100000];
					_chopper vehicleChat (localize "STR_DOM_MISSIONSTRING_252");
					_chopper setVariable ["d_Attached_Vec", _liftobj];
					
					
					// create normal non destroyed object where the wreck gets attached to.
					_poslo = ASLtoATL getPosASL _liftobj;
					private _dummyobj = createVehicle ["RoadCone_F", _poslo, [], 0, "CAN_COLLIDE"];
					_dummyobj addEventhandler ["handleDamage", {0}];
					_dummyobj setDir (getDir _liftobj);
					_dummyobj setPos _poslo;
					_liftobj attachTo [_dummyobj, [0,0,-0.5]];
					_chopper setVariable ["d_dummy_lw", _dummyobj, true];
					
					
					// hopefully this removes the fire if a wreck is still burning!
					// there is no command to turn off the fire
					//[_liftobj, 0] remoteExecCall ["setFuel", _liftobj];
					
					private _maxload = getNumber(configFile>>"CfgVehicles">>(typeOf _chopper)>>"maximumLoad");
					private _slipos = if !(_chopper selectionPosition "slingload0" isEqualTo [0,0,0]) then {_chopper selectionPosition "slingload0"} else {[0,0,1]};
					
					private "_ropes";
					//_slcmp = getArray(configFile>>"CfgVehicles">>(typeOf _liftobj)>>"slingLoadCargoMemoryPoints");
					//if (_slcmp isEqualTo []) then {
						_ropes = [ropeCreate [_chopper, _slipos, _dummyobj, [0, 0, ((boundingBoxReal _dummyobj) select 1) select 2], 25]];
					//} else {
						//_ropes = [];
						//{
							//_ropes pushBack (ropeCreate [_chopper, _slipos, _dummyobj, _liftobj selectionPosition _x, 25]);
						//} forEach _slcmp;
					//};
					
					private _oldmass = getMass _liftobj;
					if (_oldmass > _maxload) then {
						[_dummyobj, (_maxload - 500) max 100] remoteExecCall ["setMass"];
					} else {
						[_dummyobj, _oldmass] remoteExecCall ["setMass"];
					};
					
					_chopper setVariable ["d_ropes", _ropes, true];

					while {alive _chopper && {(player in _chopper)} && {!isNull _liftobj} && {{alive _x} count _ropes > 0} && {alive player} && {!(_chopper getVariable "d_vec_released")}} do {
						sleep 0.312;
					};
					
					if (!isNull _dummyobj) then {
						deleteVehicle _dummyobj;
						_chopper setVariable ["d_dummy_lw", nil, true];
					};
					
					{
						if (!isNull _x) then {
							ropeDestroy _x;
						};
					} forEach _ropes;
					
					if (!isNull _liftobj) then {
						detach _liftobj;
						[_liftobj, [0,0,0]] remoteExecCall ["setVelocity", _liftobj];
					};
					
					_chopper setVariable ["d_ropes", nil, true];
					
					_chopper setVariable ["d_vec_attached", false];
					_chopper setVariable ["d_vec_released", false];
					
					_chopper setVariable ["d_Attached_Vec", objNull];
					
					if (!alive _liftobj || {!alive _chopper}) then {
						_chopper removeAction _release_id;
						_release_id = -1212;
					} else {
						if (alive _chopper && {alive player}) then {_chopper vehicleChat (localize "STR_DOM_MISSIONSTRING_253")};
					};
					
					if (!(_liftobj isKindOf "StaticWeapon") && {(getPosATLVisual _liftobj) select 2 < 200}) then {
						waitUntil {sleep 0.222;(getPosATLVisual _liftobj) select 2 < 10};
					} else {
						private _npos = getPosATLVisual _liftobj;
						_liftobj setPos [_npos select 0, _npos select 1, 0];
					};
					
					[_liftobj, [0,0,0]] remoteExecCall ["setVelocity", _liftobj];
					
					sleep 1.012;
				};
			};
		};
	};
	sleep 0.51;
};

if (alive _chopper) then {
	if (_id != -1212) then {_chopper removeAction _id};
	if (_release_id != -1212) then {_chopper removeAction _release_id};
};