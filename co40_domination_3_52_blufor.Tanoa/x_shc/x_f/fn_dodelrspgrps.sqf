// by Xeno
#define THIS_FILE "fn_dodelrspgrps.sqf"
#include "..\..\x_setup.sqf"

if !(d_respawn_ai_groups isEqualTo []) then {
	0 spawn {
		scriptName "spawn_respawn_ai_groups";
		__TRACE_1("","d_respawn_ai_groups")
		{
			if (_x isEqualType []) then {
				_x params ["_rgrp"];
				__TRACE_1("","_rgrp")
				if (!isNil "_rgrp" && {_rgrp isEqualType grpNull} && {!isNull _rgrp}) then {
					{
						private _uni = _x;
						__TRACE_1("","_uni")
						if (!isNil "_uni" && {!isNull _uni}) then {
							private _v = vehicle _uni;
							__TRACE_1("","_v")
							if (_v != _uni && {alive _v}) then {_v setDamage 1};
							if (alive _uni) then {_uni setDamage 1}
						};
					} forEach (units _rgrp);
				};
			};
		} forEach d_respawn_ai_groups;
	};
};