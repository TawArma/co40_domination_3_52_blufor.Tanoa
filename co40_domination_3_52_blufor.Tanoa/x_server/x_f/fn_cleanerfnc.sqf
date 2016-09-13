// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_cleanerfnc.sqf"
#include "..\..\x_setup.sqf"

while {true} do {
	sleep (300 + random 150);
	// TODO How to improve this? Means how to improve cleanup? AllmissionObjects is not the fastest engine command...
	private _allmisobjs = allMissionObjects "groundWeaponHolder";
	sleep 2;
	private _helperx = allMissionObjects "WeaponHolder";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	//_helperx = allMissionObjects "WeaponHolderSimulated";
	_helperx = entities "WeaponHolderSimulated";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	_helperx = allMissionObjects "WeaponHolder_Single_F";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	_helperx = allMissionObjects "Chemlight_green";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	_helperx = allMissionObjects "Chemlight_red";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	_helperx = allMissionObjects "Chemlight_yellow";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	_helperx = allMissionObjects "Chemlight_blue";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	_helperx = allMissionObjects "CraterLong";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	sleep 2;
	_helperx = allMissionObjects "CraterLong_small";
	if !(_helperx isEqualTo []) then {
		_allmisobjs append _helperx;
	};
	if !(_allmisobjs isEqualTo []) then {
		{
			if (!isNull _x) then {
				private _ct = _x getVariable ["d_checktime", -1];
				if (_ct == -1) then {
					_x setVariable ["d_checktime", time];
				} else {
#ifndef __TT__
					if (_x distance2D d_FLAG_BASE < 15) then {
#else
					if (_x distance2D d_WFLAG_BASE < 15 || {_x distance2D d_EFLAG_BASE < 15}) then {
#endif
						deleteVehicle _x;
					} else {
						if ({isPlayer _x} count (_x nearEntities ["CAManBase", 50]) == 0) then {
							deleteVehicle _x;
						};
					};
				};
			};
			sleep 0.212;
		} forEach _allmisobjs;
	};
	_allmisobjs = nil;
};