// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_baseenemies.sqf"
#include "..\..\x_setup.sqf"

if (isDedicated) exitWith {};

switch (param [0]) do {
	case 0: {
		hint composeText[
			parseText("<t color='#f0ff0000' size='2'>" + (localize "STR_DOM_MISSIONSTRING_676") + "</t>"), lineBreak,
			parseText("<t size='1'>" + (localize "STR_DOM_MISSIONSTRING_677") + "</t>")
		];
	};
	case 1: {
		hint composeText[
			parseText("<t color='#f00000ff' size='2'>" + (localize "STR_DOM_MISSIONSTRING_678") + "</t>"), lineBreak,
			parseText("<t size='1'>" + (localize "STR_DOM_MISSIONSTRING_679") + "</t>")
		];
	};
};