// by Xeno
#define THIS_FILE "fn_hcsmexec.sqf"
#include "..\x_setup.sqf"

#ifdef __ALTIS__
execVM format ["x_missions\ma3a\%2%1.sqf", param [0], param [1]];
#endif
#ifdef __CUP_CHERNARUS__
execVM format ["x_missions\m\%2%1.sqf", param [0], param [1]];
#endif
#ifdef __CUP_TAKISTAN__
execVM format ["x_missions\moa\%2%1.sqf", param [0], param [1]];
#endif
#ifdef __CUP_SARA__
execVM format ["x_missions\msara\%2%1.sqf", param [0], param [1]];
#endif
#ifdef __TT__
if (!d_tt_tanoa) then {
	execVM format ["x_missions\ma3a\%2%1.sqf", param [0], param [1]];
} else {
	execVM format ["x_missions\ma3t\%2%1.sqf", param [0], param [1]];
};
#endif
#ifdef __TANOA__
execVM format ["x_missions\ma3t\%2%1.sqf", param [0], param [1]];
#endif
sleep 7.012;
(d_x_sm_pos select 0) remoteExecCall ["d_fnc_savbserv", 2];
[param [0], d_x_sm_pos, d_x_sm_type] remoteExecCall ["d_fnc_s_sm_up", 2];
