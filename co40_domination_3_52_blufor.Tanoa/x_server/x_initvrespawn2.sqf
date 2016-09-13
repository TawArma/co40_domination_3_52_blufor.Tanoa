// by Xeno
//#define __DEBUG__
#define THIS_FILE "x_initvrespawn2.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

d_vrespawn2_ar = [];
{
	__TRACE_1("","_x")
	private _vec = _x select 0;
	if (!isNil "_vec" && {!isNull _vec}) then {
		private _number_v = _x select 1;
		d_vrespawn2_ar pushBack [_vec,_number_v,getPosATL _vec,direction _vec,typeOf _vec];
		
		_vec setVariable ["d_OUT_OF_SPACE", -1];
		_vec setVariable ["d_vec", _number_v, true];
		_vec setAmmoCargo 0;
		_vec setVariable ["d_vec_islocked", (_vec call d_fnc_isVecLocked)];
#ifdef __TT_
		if (_number_v < 1000) then {
			_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_checkveckillblufor}}];
		} else {
			_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_checkveckillopfor}}];
		};
#endif
		if (_number_v < 100 || {(_number_v > 999 && {_number_v < 1100})}) then {
			_vec addMPEventhandler ["MPKilled", {(param [0]) call d_fnc_MHQFunc}];
		};
		_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_fuelCheck}}];
	};
} forEach _this;
_this = nil;

0 spawn d_fnc_vrespawn2
