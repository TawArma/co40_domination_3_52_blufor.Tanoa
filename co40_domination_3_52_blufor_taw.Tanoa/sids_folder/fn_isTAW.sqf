/*
	Author: Sidthesloth

	Description:
	Checks to see if the user is in TAW.

	Parameter(s):
		0 (Optional): NONE

	Returns:
	NONE
*/
private["_uid","_members"];
_uid = getPlayerUID player;
_members = [] call SID_FNC_getTawPlayers;
_isTAW = false;
if(_uid in _members) then {
  _isTAW = true;
};
_isTAW;
