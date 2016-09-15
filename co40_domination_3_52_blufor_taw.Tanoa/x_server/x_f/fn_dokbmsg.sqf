// by Xeno
//#define __DEBUG__
#define THIS_FILE "fn_dokbmsg.sqf"
#include "..\..\x_setup.sqf"

__TRACE_1("","_this")

switch (param [0]) do {
	case 0: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellAirSUAttack","SIDE"]};
	case 1: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellAirAttackChopperAttack","SIDE"]};
	case 2: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellAirLightAttackChopperAttack","SIDE"]};
	case 3: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"AllObserversDown","SIDE"]};
#ifdef __TT__
	case 4: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","AllObserversDown","SIDE"]; d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","AllObserversDown","SIDE"]};
#endif
	case 6: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellNrObservers",["1","",str(param [1]),[]],"SIDE"]};
#ifdef __TT__
	case 7: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","TellNrObservers",["1","",str(param [1]),[]],"SIDE"]; d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","TellNrObservers",["1","",str(param [1]),[]],"SIDE"]};
#endif
	case 9: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTRadioTower","SIDE"]};
#ifdef __TT__
	case 10: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MTRadioTower","SIDE"]; d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MTRadioTower","SIDE"]};
#endif
	case 12: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,'MTSightedByEnemy',"SIDE"]};
#ifdef __TT__
	case 13: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,'HQ_W','MTSightedByEnemy',"SIDE"]; d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,'HQ_E','MTSightedByEnemy',"SIDE"]};
	case 14: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,'HQ_W','MTSightedByEnemy',"SIDE"]; d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,'HQ_E','MTSightedByEnemy',"SIDE"]};
#endif
	case 15: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"CampAnnounce",["1","",str(param [1]),[]],"SIDE"]};
#ifdef __TT__
	case 16: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","CampAnnounce",["1","",str(param [1]),[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","CampAnnounce",["1","",str(param [1]),[]],"SIDE"]};
#endif
	case 17: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Dummy",["1","",param [1],[]],"SIDE"]};
	case 18: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellSecondaryMTM",["1","",param [1],[]],"SIDE"]};
#ifdef __TT__
	case 19: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","TellSecondaryMTM",["1","",param [1],[]],"SIDE"]; d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","TellSecondaryMTM",["1","",param [1],[]],"SIDE"]};
#endif
	case 20: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"CounterattackStarts","SIDE"]};
	case 22: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Captured3",["1","",param [1],[param [2]]],"SIDE"]};
	case 23: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","10",[]],"SIDE"]};
#ifdef __TT__
	case 24: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"TimeLimitSM",["1","","10",[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"TimeLimitSM",["1","","10",[]],"SIDE"]};
#endif
	case 25: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","5",[]],"SIDE"]};
#ifdef __TT__
	case 26: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"TimeLimitSM",["1","","5",[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"TimeLimitSM",["1","","5",[]],"SIDE"]};
#endif
	case 27: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSMTwoM","SIDE"]};
#ifdef __TT__
	case 28: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"TimeLimitSMTwoM","SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"TimeLimitSMTwoM","SIDE"]};
#endif
	case 29: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","10",[]],"SIDE"]};
#ifdef __TT__
	case 30: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"TimeLimitSM",["1","","10",[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"TimeLimitSM",["1","","10",[]],"SIDE"]};
#endif
	case 31: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSM",["1","","5",[]],"SIDE"]};
#ifdef __TT__
	case 32: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"TimeLimitSM",["1","","5",[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"TimeLimitSM",["1","","5",[]],"SIDE"]};
#endif
	case 33: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TimeLimitSMTwoM","SIDE"]};
#ifdef __TT__
	case 34: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"TimeLimitSMTwoM","SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"TimeLimitSMTwoM","SIDE"]};
#endif
	case 35: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MissionFailure","SIDE"]};
#ifdef __TT__
	case 36: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MissionFailure","SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MissionFailure","SIDE"]};
#endif
	case 37: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"MTRadioTowerDown","SIDE"]};
#ifdef __TT__
	case 38: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MTRadioTowerDown","SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MTRadioTowerDown","SIDE"]};
	case 39: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MTRadioAnnounce",["1","",param [1],[]],["2","",str(d_tt_points select 2),[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MTRadioAnnounce",["1","",param [1],[]],["2","",str(d_tt_points select 2),[]],"SIDE"]};
	case 40: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","Dummy",["1","",param [1],[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","Dummy",["1","",_this select 2,[]],"SIDE"]};
	case 41: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W","MTSMAnnounce",["1","",param [1],[]],["2","",str(d_tt_points select 3),[]],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E","MTSMAnnounce",["1","",param [1],[]],["2","",str(d_tt_points select 3),[]],"SIDE"]};
#endif
	case 42: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Dummy",["1","",param [1],[]],"SIDE"]};
	case 43: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"TellAirDropAttack","SIDE"]};
	case 44: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,param [1],"SIDE"]};
#ifdef __TT__
	case 45: {d_hq_logic_blufor1 kbTell [d_hq_logic_blufor2,"HQ_W",param [1],"SIDE"];d_hq_logic_opfor1 kbTell [d_hq_logic_opfor2,"HQ_E",param [1],"SIDE"]};
#endif
	case 46: {d_kb_logic1 kbTell [d_kb_logic2,d_kb_topic_side,"Lost",["1","",param [1],[param [2]]],"SIDE"]};
};