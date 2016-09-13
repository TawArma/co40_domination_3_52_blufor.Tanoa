// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_tasks.sqf"
#include "x_setup.sqf"

__TRACE("Before !isNull player")
waitUntil {!isNull player};
waitUntil {!isNil "d_MaxNumAmmoboxes"};
__TRACE("After !isNull player")

#define __BR "<br/>"
#define __BRBR "<br/><br/>"
#define __BRBRBR "<br/><br/><br/>"

private _bar = [
	localize "STR_DOM_MISSIONSTRING_23", __BR,
	"<font face='RobotoCondensed' size=52 color='#ffffff'>Domination! 3</font>", __BRBR,
	localize "STR_DOM_MISSIONSTRING_24", __BR,
	localize "STR_DOM_MISSIONSTRING_25", __BRBRBR,
	localize "STR_DOM_MISSIONSTRING_26", __BRBR,
	localize "STR_DOM_MISSIONSTRING_27", __BRBR,
	localize "STR_DOM_MISSIONSTRING_28", __BRBR,
	localize "STR_DOM_MISSIONSTRING_29", __BR,
	localize "STR_DOM_MISSIONSTRING_30", __BR,
#ifndef __TT__
	format [localize "STR_DOM_MISSIONSTRING_31", d_MaxNumAmmoboxes], __BR,
#else
	format [localize "STR_DOM_MISSIONSTRING_39", d_MaxNumAmmoboxes], __BR,
#endif
	localize "STR_DOM_MISSIONSTRING_32", __BR,
	localize "STR_DOM_MISSIONSTRING_33", __BRBR,
	localize "STR_DOM_MISSIONSTRING_34", __BR,
	localize "STR_DOM_MISSIONSTRING_35", __BR,
	localize "STR_DOM_MISSIONSTRING_36", __BR,
	localize "STR_DOM_MISSIONSTRING_37", __BRBR,
	localize "STR_DOM_MISSIONSTRING_40", __BRBR,
	localize "STR_DOM_MISSIONSTRING_41", __BR,
	localize "STR_DOM_MISSIONSTRING_42", __BRBR,
	localize "STR_DOM_MISSIONSTRING_43", __BRBR,
	localize "STR_DOM_MISSIONSTRING_44", __BR,
	localize "STR_DOM_MISSIONSTRING_46", __BRBR,
	localize "STR_DOM_MISSIONSTRING_47", __BR,
	localize "STR_DOM_MISSIONSTRING_48", __BRBR,
	localize "STR_DOM_MISSIONSTRING_49", __BRBR,
	localize "STR_DOM_MISSIONSTRING_51", __BR,
	localize "STR_DOM_MISSIONSTRING_52", __BR,
	localize "STR_DOM_MISSIONSTRING_54", __BRBR,
	localize "STR_DOM_MISSIONSTRING_55", __BR,
	localize "STR_DOM_MISSIONSTRING_56", __BRBR,
	localize "STR_DOM_MISSIONSTRING_57", __BRBR,
	localize "STR_DOM_MISSIONSTRING_56a", __BRBR,
	localize "STR_DOM_MISSIONSTRING_58", __BRBR,
	localize "STR_DOM_MISSIONSTRING_61"
];

player createDiaryRecord ["Diary", ["Briefing", _bar joinString ""]];

player createDiarySubject ["dLicense","License"];
player createDiaryRecord ["dLicense", ["License", "
Attribution-NonCommercial-NoDerivatives 4.0 International (CC BY-NC-ND 4.0)<br/><br/>
http://creativecommons.org/licenses/by-nc-nd/4.0/<br/><br/>
You are free to:<br/><br/>
Share — copy and redistribute the material in any medium or format<br/><br/>
The licensor cannot revoke these freedoms as long as you follow the license terms.<br/><br/><br/>
Under the following terms:<br/><br/>
Attribution — You must give appropriate credit, provide a link to the license, and indicate if changes were made. You may do so in any reasonable manner,<br/>
but not in any way that suggests the licensor endorses you or your use.<br/><br/>
NonCommercial — You may not use the material for commercial purposes.<br/><br/>
NoDerivatives — If you remix, transform, or build upon the material, you may not distribute the modified material.<br/><br/><br/>
No additional restrictions — You may not apply legal terms or technological measures that legally restrict others from doing anything the license permits.
"]];
player createDiaryRecord ["dLicense", ["License, additional", "
The following is not allowed, read strictly forbidden!<br/><br/>
Uploading Domination to Steam Workshop is not allowed (only by myself)!!!!!<br/><br/>
You are not allowed to monetize videos recorded/streamed while playing Domination in any form!!!!<br/>
(Non-commercial license, that's for you, youtube and twitch heroes. Make your own content if you want to make money and don't use other peoples work!!!)<br/><br/>
Server owners are also not allowed to monetize their servers with perks or anything else when using/playing Domination!<br/>
(Again, non-commercial license!)<br/><br/>
Additionally you are not allowed to use any of the Dom scripts/dialogs/images/whatever outside of the mission!<br/>
This is strictly forbidden! Removing the ingame messages about monetization is also not allowed!!!<br/><br/>
It is also strictly forbidden for server host companys to sell or rent servers with the mission!!<br/>
(Non commercial license, not that hard to understand)<br/><br/>
THIS MISSION IS Arma 3 only! Because no derivates are allowed it also means no port to any other game in the series is allowed!<br/><br/>
PLEASE ALSO TRY TO NOT USE ANY DLC CONTENT WHICH IS RESTRICTED TO DLC OWNERS ONLY. THIS ONLY FRUSTRATS PLAYERS WHO DO NOT OWN THE DLC!!!!<br/><br/>
You are free to edit the mission for your own server but you may not release the mission elsewhere (read the license!).<br/>
Furthermore you may not use servside addons with code from the mission or from your modded version. All code has to be in the mission.pbo!
"]];

waitUntil {!isNil "d_current_target_index"};

private _tstate = if (d_current_target_index == -1) then {
	"Assigned"
} else {
	"Succeeded"
};
[true, "d_obj00", [localize "STR_DOM_MISSIONSTRING_62", localize "STR_DOM_MISSIONSTRING_62", localize "STR_DOM_MISSIONSTRING_62"], getPosWorld player, _tstate, 2, false, "Defend", false] call BIS_fnc_taskCreate;

d_obj00_task = true;