/*
	Author: Sidthesloth

	Description:
	Setup events for use in TAW only vehicles

	Parameter(s):
		0 (Optional): NONE

	Returns:
	NONE
*/
player addEventHandler ["GetInMan",{[] call SID_FNC_handleVehicleLocation}];
player addEventHandler ["SeatSwitchedMan",{[] call SID_FNC_handleVehicleLocation}];
