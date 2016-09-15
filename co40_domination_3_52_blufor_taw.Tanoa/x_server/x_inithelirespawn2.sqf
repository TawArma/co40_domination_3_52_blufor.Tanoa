// by Xeno
#define THIS_FILE "x_inithelirespawn2.sqf"
#include "..\x_setup.sqf"

if (!isServer) exitWith{};

d_helirespawn2_ar = [];
{
	private _vec_a = _x;
	private _vec = _vec_a select 0;
	if (!isNil "_vec" && {!isNull _vec}) then {
		private _number_v = _vec_a select 1;
		private _ifdamage = _vec_a select 2;
		_vposp = getPosATL _vec;
		_vposp set [2, (_vposp select 2) + 0.1];
		d_helirespawn2_ar pushBack [_vec, _number_v, _ifdamage, -1, _vposp, direction _vec, typeOf _vec, if (_ifdamage) then {-1} else {_vec_a select 3}];
		
		_vec setVariable ["d_OUT_OF_SPACE", -1];
		_vec setVariable ["d_vec", _number_v, true];
		_vec setVariable ["d_vec_islocked", _vec call d_fnc_isVecLocked];
		
		_vec setPos _vposp;
		_vec setDamage 0;
		
		_vec addEventhandler ["local", {_this call d_fnc_heli_local_check}];
		
#ifdef __TT__
		if (_number_v < 4000) then {
			_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_checkveckillblufor}}];
		} else {
			_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_checkveckillopfor}}];
		};
#endif
		
		_vec addMPEventhandler ["MPKilled", {if (isServer) then {_this call d_fnc_chopperkilled}}];
	};
} forEach _this;
_this = nil;

0 spawn d_fnc_helirespawn2
