// by Xeno
#define THIS_FILE "fn_handleobservers.sqf"
#include "..\..\x_setup.sqf"

if !(call d_fnc_checkSHC) exitWith {};

private _e_ari_avail = true;
private _nextaritime = 0;

#ifndef __TT__
private _man_type = format ["Soldier%1B", d_enemy_side_short];
#else
private _man_type = ["SoldierWB", "SoldierEB"];
#endif

sleep 10.123;
while {d_nr_observers > 0} do {
	d_ai_artiller_unit_vecs = d_ai_artiller_unit_vecs - [objNull];
	call d_fnc_mpcheck;
	{
		if (alive _x && {_e_ari_avail}) then {
			private _enemy = _x findNearestEnemy _x;
			if (!isNull _enemy && {(_x knowsAbout _enemy >= 1.5)} && {!((vehicle _enemy) isKindOf "Air")} && {_x distance2D _enemy < 500}) then {
				private _pos_nearest = getPosWorld _enemy;
				_pos_nearest set [2, 0];
				if ((_pos_nearest nearEntities [_man_type, 30]) isEqualTo []) then {
					_e_ari_avail = false;
					_nextaritime = time + 120 + (random 120);
					[_pos_nearest, floor (random 2)] spawn d_fnc_shootari;
				} else {
					_e_ari_avail = false;
					_nextaritime = time + 120 + (random 120);
					if (random 100 < 15) then {// 1 to 6 chance for smoke
						[_pos_nearest, 2] spawn d_fnc_shootari;
					};
				};
			};
		};
		sleep 2.321;
	} forEach d_obs_array;
	sleep 5.123;
	if (time > _nextaritime && {!_e_ari_avail}) then {_e_ari_avail = true};
};
