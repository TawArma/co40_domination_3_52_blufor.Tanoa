// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_firearty.sqf"
#include "..\..\..\x_setup.sqf"

if (isDedicated) exitWith {};

#ifndef __TT__
if !(d_ari_available) exitWith {[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_149")};
#else
if (d_player_side == blufor && {!d_ari_available_w} || {d_player_side == opfor && {!d_ari_available_e}}) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_149");
};
#endif

disableSerialization;

private _lbctrl = (uiNamespace getVariable "d_ArtilleryDialog2") displayCtrl 1000;
private _idx = lbCurSel _lbctrl;
if (_idx == -1) exitWith {};

private _arele = d_cur_art_marker_ar select (_lbctrl lbValue _idx);
private _curmar_pos = markerPos (_arele select 0);
__TRACE_2("","_arele","_curmar_pos")

private _no = [];
private _ammoconf = configFile>>"CfgAmmo">>getText(configFile>>"CfgMagazines">>(_arele select 2)>>"ammo");

if (getText(_ammoconf>>"effectFlare") != "CounterMeasureFlare" && {getText(_ammoconf>>"submunitionAmmo") != "SmokeShellArty"}) then {
	private _man_type = switch (d_own_side) do {
		case "WEST": {"SoldierWB"};
		case "EAST": {"SoldierEB"};
		case "GUER": {"SoldierGB"};
	};
	_no = _curmar_pos nearEntities [[_man_type], 20];
};

if !(_no isEqualTo []) exitWith {
	[playerSide, "HQ"] sideChat (localize "STR_DOM_MISSIONSTRING_151");
};

if (d_with_ranked && {d_ranked_a select 2 > 0}) then {[player, (d_ranked_a select 2) * -1] remoteExecCall ["addScore", 2]};
#ifndef __TT__
player kbTell [d_kb_logic1, d_kb_topic_side_arti, "ArtilleryRequest", ["1", "", getText(configFile>>"CfgMagazines">>(_arele select 2)>>"displayname"), []], ["2", "", str (_arele select 3), []], ["3", "", mapGridPosition _curmar_pos, []], "SIDE"];
#else
private _topicside = switch (d_player_side) do {
		case blufor: {"HQ_ART_W"};
		case opfor: {"HQ_ART_E"};
	};
private _logic = switch (d_player_side) do {
	case blufor: {d_hq_logic_blufor1};
	case opfor: {d_hq_logic_opfor1};
};
player kbTell [_logic, _topicside, "ArtilleryRequest", ["1", "", getText(configFile>>"CfgMagazines">>(_arele select 2)>>"displayname"), []], ["2", "", str (_arele select 3), []], ["3", "", mapGridPosition _curmar_pos, []], "SIDE"];
#endif
[_arele select 2, _arele select 3, str player, _arele select 0] remoteExec ["d_fnc_arifire", 2];
d_arti_did_fire = true;
