/*
	Author: Sidthesloth

	Description:
	Handles the GetInMan and SeatSwitchedMan events. Forces certain locations with a vehicle to be TAW only

	Parameter(s):
		0 (Optional): NONE

	Returns:
	NONE
*/
private ["_position","_vehicle"];

_position = (assignedVehicleRole player) select 0;
_path=[];
if(count (assignedVehicleRole player) > 1) then {
  _path = (assignedVehicleRole player) select 1;
};
_vehicle = typeOf (vehicle player);
_uid = getPlayerUID player;
//hint format ["Hello %1 \nPOS: %2 \nVEH:%3 \nUID:%4 \nPATH:%5",name player,_position,_vehicle,_uid,_path];
/*
PATH:
Heli's: 0:copiolet 1-2 are gunners
vehicles's: 0:gunner 1 commander
*/


_vehicleSettings = [/*DRIVER,TURRET,CARGO*/];

switch (_vehicle) do {
    case "B_Heli_Light_01_armed_F": { _vehicleSettings=[true,false,false]};
    case "B_Plane_CAS_01_F": { _vehicleSettings=[true,false,false]};
    case "B_Heli_Attack_01_F": { _vehicleSettings=[true,false,false]};
    default { };
};

switch (_position) do {
    case "driver": {
      _forceTAW= _vehicleSettings select 0;
      if(_forceTAW) then {
          _taw_member = [] call SID_FNC_isTAW;
        if(!_taw_member) then {
            nul = [parseText("<t color='#ff0000'>You must be a member of TAW(TAW.net) to use this vehicle</t>")] spawn BIS_fnc_dynamicText;
            player action ["GetOut",vehicle player];
        }else{
          nul = [parseText format["<t color='#00cc00'>Welcome </t>%1<t color='#00cc00'> this vehicle is for TAW members only</t>", name player]] spawn BIS_fnc_dynamicText;
        };

      };
    };
    case "Turret": {
      _forceTAW= _vehicleSettings select 1;
      if(_forceTAW) then {
          _taw_member = [] call SID_FNC_isTAW;
        if(!_taw_member) then {
          nul = [parseText("<t color='#ff0000'>You must be a member of TAW(TAW.net) to use this vehicle</t>")] spawn BIS_fnc_dynamicText;
            player action ["GetOut",vehicle player];
        }else{
          nul = [parseText format["<t color='#00cc00'>Welcome </t>%1<t color='#00cc00'> this vehicle is for TAW members only</t>", name player]] spawn BIS_fnc_dynamicText;
        };

      };
    };
    case "cargo": {
      _forceTAW= _vehicleSettings select 2;
      if(_forceTAW) then {
          _taw_member = [] call SID_FNC_isTAW;
        if(!_taw_member) then {
          nul = [parseText("<t color='#ff0000'>You must be a member of TAW(TAW.net) to use this vehicle</t>")] spawn BIS_fnc_dynamicText;
            player action ["GetOut",vehicle player];
        }else{
          nul = [parseText format["<t color='#00cc00'>Welcome </t>%1<t color='#00cc00'> this vehicle is for TAW members only</t>", name player]] spawn BIS_fnc_dynamicText;
        };

      };
    };
    default { hint "error" };
};
