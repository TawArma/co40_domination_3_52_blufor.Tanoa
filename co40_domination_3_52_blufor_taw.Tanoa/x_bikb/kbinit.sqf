// by Xeno
#define THIS_FILE "kbinit.sqf"
#include "..\x_setup.sqf"

if (isServer) then {
	if (d_tt_ver || {d_own_side == "WEST"}) then {
		private _grpen = [blufor] call d_fnc_creategroup;
		d_hq_logic_blufor1 = _grpen createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_blufor1] joinSilent _grpen;
		d_hq_logic_blufor1 enableSimulationGlobal false;
		publicVariable "d_hq_logic_blufor1";
		d_hq_logic_blufor1 setVariable ["d_hq_logic_name", "d_hq_logic_blufor1"];
		d_hq_logic_blufor1 setVariable ["d_hq_logic_side", blufor];
		d_hq_logic_blufor1 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
		
		d_hq_logic_blufor2 = _grpen createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_blufor2] joinSilent _grpen;
		d_hq_logic_blufor2 addEventHandler ["handleDamage",{0}];
		d_hq_logic_blufor2 enableSimulationGlobal false;
		publicVariable "d_hq_logic_blufor2";
		d_hq_logic_blufor2 setVariable ["d_hq_logic_name", "d_hq_logic_blufor2"];
		d_hq_logic_blufor2 setVariable ["d_hq_logic_side", blufor];
		d_hq_logic_blufor2 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
	};
	if (d_tt_ver || {d_own_side == "EAST"}) then {
		private _grpru = [opfor] call d_fnc_creategroup;
		d_hq_logic_opfor1 = _grpru createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_opfor1] joinSilent _grpru;
		d_hq_logic_opfor1 enableSimulationGlobal false;
		d_hq_logic_opfor1 addEventHandler ["handleDamage",{0}];
		publicVariable "d_hq_logic_opfor1";
		d_hq_logic_opfor1 setVariable ["d_hq_logic_name", "d_hq_logic_opfor1"];
		d_hq_logic_opfor1 setVariable ["d_hq_logic_side", opfor];
		d_hq_logic_opfor1 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
		
		d_hq_logic_opfor2 = _grpru createUnit ["Logic",[0,0,0],[],0,"NONE"];
		[d_hq_logic_opfor2] joinSilent _grpru;
		d_hq_logic_opfor2 enableSimulationGlobal false;
		d_hq_logic_opfor2 addEventHandler ["handleDamage",{0}];
		publicVariable "d_hq_logic_opfor2";
		d_hq_logic_opfor2 setVariable ["d_hq_logic_name", "d_hq_logic_opfor2"];
		d_hq_logic_opfor2 setVariable ["d_hq_logic_side", opfor];
		d_hq_logic_opfor2 addEventHandler ["killed",{_this call d_fnc_kEHflogic}];
	};
};

private _kbscript = "x_bikb\domkba3.bikb";

if (d_tt_ver || {d_own_side == "EAST"}) then {
	d_hq_logic_opfor1 kbAddTopic["HQ_E",_kbscript];
	d_hq_logic_opfor1 kbAddTopic["HQ_ART_E",_kbscript];
	d_hq_logic_opfor1 setIdentity "DHQ_OP1";
	d_hq_logic_opfor1 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_opfor1 setGroupIdGlobal ["HQ"];
	};
	d_hq_logic_opfor1 setVariable ["d_kddata", [["HQ_E", "HQ_ART_E"], "DHQ_OP1","HQ"]];

	d_hq_logic_opfor2 kbAddTopic["HQ_E",_kbscript];
	d_hq_logic_opfor2 setIdentity "DHQ_OP2";
	d_hq_logic_opfor2 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_opfor2 setGroupIdGlobal ["HQ1"];
	};
	d_hq_logic_opfor2 setVariable ["d_kddata", [["HQ_E"], "DHQ_OP2","HQ1"]];
};

if (d_tt_ver || {d_own_side == "WEST"}) then {
	d_hq_logic_blufor1 kbAddTopic["HQ_W",_kbscript];
	d_hq_logic_blufor1 kbAddTopic["HQ_ART_W",_kbscript];
	d_hq_logic_blufor1 setIdentity "DHQ_BF1";
	d_hq_logic_blufor1 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_blufor1 setGroupIdGlobal ["Crossroad"];
	};
	d_hq_logic_blufor1 setVariable ["d_kddata", [["HQ_W", "HQ_ART_W"], "DHQ_BF1", "Crossroad"]];

	d_hq_logic_blufor2 kbAddTopic["HQ_W",_kbscript];
	d_hq_logic_blufor2 setIdentity "DHQ_BF2";
	d_hq_logic_blufor2 setRank "COLONEL";
	if (isServer) then {
		d_hq_logic_blufor2 setGroupIdGlobal ["Crossroad1"];
	};
	d_hq_logic_blufor2 setVariable ["d_kddata", [["HQ_W"], "DHQ_BF2", "Crossroad1"]];
};

#ifndef __TT__
d_kb_logic1 = switch (d_enemy_side_short) do {
	case "E": {d_hq_logic_blufor1};
	case "W": {d_hq_logic_opfor1};
};
d_kb_logic2 = switch (d_enemy_side_short) do {
	case "E": {d_hq_logic_blufor2};
	case "W": {d_hq_logic_opfor2};
};
d_kb_topic_side = switch (d_enemy_side_short) do {
	case "E": {"HQ_W"};
	case "W": {"HQ_E"};
};
d_kb_topic_side_arti = switch (d_enemy_side_short) do {
	case "E": {"HQ_ART_W"};
	case "W": {"HQ_ART_E"};
};
#endif

if (!isDedicated) then {
	sleep 1;
	if (isMultiplayer) then {
		waitUntil {sleep 0.220;!isNil "d_still_in_intro"};
		waitUntil {sleep 0.220;!d_still_in_intro};
	};
	private _pside = side (group player);
	switch (_pside) do {
		case blufor: {player kbAddTopic["HQ_W", _kbscript]};
		case opfor: {player kbAddTopic["HQ_E", _kbscript]};
	};
	_strp = str player;
	player kbAddTopic["PL" + _strp, _kbscript];
#ifndef __TT__
	d_kb_logic1 kbAddTopic["PL" + _strp, _kbscript];
#else
	private _ll = if (_pside == opfor) then {d_hq_logic_opfor1} else {d_hq_logic_blufor1};
	_ll kbAddTopic["PL" + _strp, _kbscript];
#endif
	if (!d_with_ai && {d_with_ai_features != 0}) then {
		if (_strp in d_can_use_artillery || {_strp in d_can_mark_artillery}) then {
			switch (_pside) do {
				case blufor: {player kbAddTopic["HQ_ART_W", _kbscript]};
				case opfor: {player kbAddTopic["HQ_ART_E", _kbscript]};
			};
		};
	} else {
		switch (_pside) do {
			case blufor: {player kbAddTopic["HQ_ART_W", _kbscript]};
			case opfor: {player kbAddTopic["HQ_ART_E", _kbscript]};
		};
	};
};

