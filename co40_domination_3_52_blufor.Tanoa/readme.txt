!!!!!!!!!BESIDE THE NORMAL license.txt FILE READ ALSO THE license_additional.txt FILE!!!!!!!!!!!!

While some things may basically be and look the same, all scripts were touched and a lot of code has changed.
Also all code regarding custom made third party content was removed (for example ACRE).

#############################################################################################################

Changelogs

3.52
ATTENTION: Tanoa version mission.sqm file has changed!
ATTENTION: Tanoa TT version mission.sqm file has changed!
ATTENTION: Chernarus version mission.sqm file has changed!

- Changed: Better random positions especially on Tanoa (for example spawn and waypoint positions for infantry units in forrests/jungle)
- Changed: Main target clear now happens also when there is still one enemy AI car or tank left
- Fixed: Arty operator did not receive arty messages from already firing arty anymore when he/she died
- Fixed: Fog was coming even if it was completely disabled (seems to be a bug in A3)
- Fixed: Removed not working CfgGroups from preinit
- Fixed: For whatever reason the CH-53 chopper suddenly was half in the ground in the Chernarus CUP version (in the editor already)
- Fixed: Added missing Opfor vehicles for heli lift in the TT version
- Changed: Replaced all base vehicles, player units and CSAT AI units and vehicles with Apex T versions in the normal and TT version
- Fixed: Some choppers at base were placed above the ground in the normal Tanoa version
- Added: Complete Spanish translation by Brigada_ESP
- Changed: Removed loiter waypoints for airai introduced in 3.43 again (air AI units did not attack anymore)
- Fixed: Convoy sidemission in TT version was broken (did not end)
- Fixed: In the TT version the wrong bonus vehicles got spawned (opfor vehicles for blufor and vice versa)
- Fixed: Blufor helilift types were added to opfor choppers in the TT version
- Fixed: In the ranked TT version blufor players where getting the same gear as the opfor players (player object not initialized while checking for player side)
- Changed: Servicing a drone on chopper service/vehicle service now also writes a message on the screen
- Fixed: Virtual Aresenal 3D text was visible for para jumpers even when they were far away (distance2D check instead just distance)
- Fixed: In the Tanoa AI version recruited AI did not wear tropical uniforms
- Changed: Replaced all TahomaB fonts with RobotoCondensed
- Fixed: Wrong KBTell message in the TT version for main target missions
- Fixed: Opposite team got the message that a MHQ is too close to the main target too (TT version)
- Fixed: The team which did not resolve the sidemission got the "sidemission resolved" hint in the TT version
- Added: Missing localization for sidemission resolved
- Changed: Disabling radio already in respawn eh (revive) and disabling sound till uncon script runs at respawn
- Changed: Increased AI skill
- Fixed: Missing kbTell for the TT version in fn_sm_up (announcing side mission in chat)
- Fixed: fn_checkmthardtarget and fn_mtmtargetkilled were using the unit instead of the side of the unit in the TT version
- Fixed: Typo in fn_preinit.sqf (it's ParaCombatGroup not ParaConbatGroup)
- Fixed: TT version medics were missing in x revive init when only medics can revive was enabled
- Fixed: Script error in fn_target_clear_client.sqf (undefined variable)
- Fixed: Missing distance check for second wreck repair point in the TT version (fn_wreckmarker2.sqf)
- Added: Close air support (CAS), available for Squad Leaders (works like artillery target marking with LD, but the CAS is available immediately, 10 minutes between two CAS strikes, rockets only).
- Fixed: Removed XMIT from bikb config, was causing RPT entries
- Fixed: Sometimes the flag spawned inside a building in the capture the flag side mission 31 on Tanoa
- Changed: In the TT version MT killpoints are now also added for artillery and CAS strikes
- Changed: Player UID gets stored only once now in the player store on the server
- Changed: Default AI skill settings are now "Normal" and not "Low"
- Fixed: Possible nil variable error in gear handling
- Changed: Reduced chance to get fog from 30 to 10 percent
- Optimized: 3D text over player heads (removed visibility check)
- Fixed: No check if player was at delivery point in the deliver side missions if ranked was enabled
- Added: Adding additional static respawn points is now available via d_additional_respawn_points variable in x_init\fn_preinit.sqf
- Fixed: Outdated stringtable entries
- Fixed: Time multiplier reduced to max 120 (the engine doesn't allow more anyway)
- Fixed: Wrong number of maintargets got created by create random main targets function
- More optimizations

3.51
Internal developement version, see 3.52 changelog

3.50
ATTENTION: Tanoa TT version mission.sqm file has changed!

- Addded: Parameter to disable fog when the internal weather system is on
- Fixed: Some blufor markers did not get deleted for the opfor side in the Tanoa TT version (wrong marker names in mission.sqm file)
- Fixed: Headless Client was not working anymore. Somehow remoteExec lost the ability to use a HC as target
- Changed: Respawning at base or at a MHQ gives you the complete Arsenal chosen weapons and magazine layout back
- Changed: Renamed SQL in revive respawn dialog to Squad Leader
- Fixed: Dropping an ammo box from a vehicle did create the Virtual Arsenal 3D text for the oponent team too in the TT version
- Changed: Different progress icon for revive hold action
- Fixed: In the Tanoa TT version the respawn marker for the opfor side had a wrong name thus the ofpor players were teleported into the sea

3.49
- Fixed: Marked artillery targets were visible for the opponent team in the TT version
- Fixed: Ofpor arty operator did not see artillery messages in the TT version
- Fixed: Oponent team in the TT version did see specific artillery messages of the other team (like artillery available again in a few minutes)
- Fixed: Opening the artillery dialog as a blufor player blocked opening the artillery dialog for opfor players too
- Fixed: When the independent AI enemy side in the TT version took a camp from blufor again the flag turned red instead of green (a little bit confusing that was)
- Changed: Enabled parajump flags at main targets in the TT version
- Fixed: Some kbTell messages were broadcasted globally instead of just for one side in the TT version
- Changed: Added an enemy specops group to each camp at the main target to defend them (similar to radio tower at main target)

3.48
- Added: Tanoa TT version
- Fixed: Added missing getflatarea function

3.47
- Fixed: Item STR_DOM_MISSIONSTRING_1705 listed twice
- Fixed: Typo in Tanoa version (Lihnhaven instead of Lijnhaven)
- Fixed: Dropping a box a second time from a vehicle resulted in 3D text over box not being drawn
- Fixed: Loaded boxes were not removed from the 3D draw array (memory leak)

3.46
ATTENTION: Altis TT version mission.sqm file has changed!

- Fixed: Wrong points for Captain in the TT version (were the same as for Seargeant). Resulted in an endless loop between getting promoted to Seargent and Captain
- Changed: Simulation is no longer disabled for dead AI units so one can pick up ammo and weapons from dead AI units again!
- Fixed: It was possible to respawn at squad leader when the squad leader was uncon or dead or even in a vehicle
- Fixed: Vehicles created at MHQ stay longer again
- Fixed: Yet another fix for the Tanoa time problem. Default mission start on Tanoa is now 7 am and not 5 am (was still pitch black night at 5)
- Changed: Reduced wait time to drop or load an ammbox from/to a MHQ to 20 second
- Added: Check in the TT version so that the Parajump dialog does not accept the enemy base area as jump target

3.45
- Added: Respawn at squad leader (only available when revive is used, not available for teleport from base)
- Changed: Medics can now revive faster than normal units
- Fixed: Player received two revive messages when he revived another player
- Fixed: Uncon 3D draw eventhandler for marking uncon units were drawing the player name on the ground instead above the player when the player died in the first floor for example
- Fixed: In the TT version uncon map markers got deleted for blufor side for own units (probably the same on the opfor side)
- Fixed: Markers of uncon units of the opposing side were not removed for JIP players in the TT version
- Fixed: Chopper (lift) hud script was broken in the TT version (wrong variable for accessing the object to lift)
- Changed: Reduced time to spawn a vehicle at MHQ from 5 minutes to 1 minute
- Fixed: Wrong start time for Tanoa version (mission.sqm file time was set to 12 noon instead 12 midnight)

3.44
- Fixed: Revive drag action menu was missing (whoever removed it, I'll find you!)
- Fixed: Nasty respawn in the air bug at Tanoa base (I know who introduced it and I know where your house lives)
- Changed: Reduced mass of heavy vehicles for chopper lifting even more
- Changed: Parajump wait time at base removed from 30 minutes to 0 (time between two jumps from base)

3.43
ATTENTION: Altis version mission.sqm file has changed!

- Added: Tanoa Blufor version
- Added: Altis Opfor version
- Fixed: Wrong isEqualTo scalar check for array in fn_target_clear.sqf
- Changed: Air AI script uses loiter waypoint now which seems to be finally working in combination with flyinheight
- Fixed: Next target on client could be created before d_current_seize was initialized (script error) depending on join time
- Fixed: When TI mode was used in SAT view (MHQ) it stayed on even in revive camera
- Fixed: Side mission tasks get now removed once a side mission is done
- Fixed: Using pushBack with remoteExec does not work very well
- Fixed: Player was not moved back into revive uncon animation after waterfix was running (prevents uncon players from lying on the ground of the sea, moves him to the shore)
- Fixed: Revive waterfix (see above) removed the black screen (should stay till waterfix is done)
- Fixed: Artillery targets can now be marked with any Laserdesignator not just the default vanilla one
- Fixed: Typo in fn_killedsmtargetnormal.sqf
- Changed: Made handling who killed a target of a side mission more robust for the TT version
- Added: New deliver and mines sidemissions by Lelik (only available in the Altis non TT version)
- Changed: Domination revive uses new APEX action menu now!
- Changed: If a lifted vehicle dropped into the sea it did not respawn
- Added: Even more naked women
- And of course more optimizations

3.42
- Hotfix for the hotfix for the hotfix: nearestTerrainObjects sort parameter does not yet exist in 1.60... 

3.41
- Workaround: CUP versions were broken due to an addon problem. The headless client entity gets created even though there is no hc connected. Disabled for CUP versions to make them work again.
- Changed: Moved outer air respawn point a little bit more away from the map sides
- Fixed: Script for adding player score on the server was accidentally using a client side variable (only valid for the ranked version)
- Fixed: Admin lock was broken, missing server lock function in CfgFunctions
- Fixed: A player was still bleeding when healing at a mash
- Fixed: RespawnGroups FSM ended when radio tower was killed and not when the main target was done
- More optimizations

3.40
- Added: Support for hosted environment (might still be a little bit buggy, please report)
- Added: Task for side missions
- Fixed: Arrest side missions were broken due to a logic error (between my ears)
- Changed: Better check which team won a radio tower sidemission in the TT version
- Fixed: Added player ASL position instead of default positioin to playSound3D parameters in revive
- More optimizations

3.39
- Changed: Use setWaypointForceBehaviour for specific AI groups
- Fixed: Wrong topic side and logic for kbTell in server artillery script
- Fixed: Vehicle creation should not result in vehicles falling over anymore
- Fixed: Arrest side missions did not work at all in the TT version
- Added: Missing weapons, mags and backpack in i_weapons.sqf for the ranked TT version (currently both contain the same weapons, mags and backpacks, at least it works now)
- Changed: If a bonus vehicle gets killed over water/over the sea, it'll now be moved to the next beach so that it can still be picked up by a wreck chopper
- Fixed: Stupid typo in x_server\x_f\fn_airtaxiserver.sqf (underline got lost)
- More optimizations

3.38
- Fixed: Blufor players were kicked out of blufor vehicles, did only affect blufor players in the TT version, not used in the normal non TT version

3.37
- Tweaked: Player name hud color (if enabled)
- Changed: Only arty ops and squad leaders can draw lines on the map
- Fixed: In the CUP Chernarus version the bag fences at the jet reload point where positioned in the air
- Fixed: In the CUP Sahrani version the bag fences at the jet reload point where positioned 90 degree in the wrong direction
- Changed: Make use of the height parameter for triggers where possible
- Changed: Air drop marker gets now created for every player which calls a drop (gets removed automatically after about 900 seconds)
- Fixed: Make UAV at MHQ did not work in the TT version (for both sides)
- Changed: Turn MHQ engine off before deploying it
- Fixed: Drop answers when an air drop was executed was not working anymore
- Fixed: Missing localization string STR_DOM_MISSIONSTRING_641 in TT version
- Changed: If virtual arsenal box at base gets destroyed a new one reappears immediately
- Fixed: Replaced d_player_entities with allPlayers in fn_helirespawn2.sqf, variable d_player_entities does not exist on the server in the TT version
- Fixed: Engineers were kicked from engineer trucks in the TT version
- Fixed: Map marker line drawing for AI group waypoint debugging (only for debugging purposes, not available in MP)
- Changed: Progress bar for capping camps turns yellow now if capping is stalled beacuse of nearby enemies
- Fixed: Side mission 39 in the CUP Chernarus version, side mission did not end at all because of missing killed eventhandler
- More optimizations

3.36
- Fixed: Draw3D eventhandler drawing was only drawing when the player was near enough to an object and not the camera
- Updated: Spanish translation (thanks to Brigada_ESP)
- Added: The Two Teams (TT) PvPvE version is back... Yeah, Domi with PvP again!
- Added: Tons of new bugs (due to the quite severe TT version changes)
- Optimized: Replaced saving gear with 5 billion scripting commands with newly available getUnitLoadout and setUnitLoadout scripting commands
- Added: (Lobby) param to disable NVG equipment (disableNVGEquipment)
- Fixed: Stupid _d_pos script error in revive respawn eh script
- Fixed: Another stupid script error in fnc_ampoi which adds points to the player who places a mash when someone heals at a mash in the ranked version
- Fixed: When a player placed an object like a Mash and the object was killed the script was trying to access getVariable space with the player object instead of the player string name
- Optimized: Player firing in base area check (no longer checks if player is in base area every shot)
- Optimized: Non sidemission related buildings are now also restored if they get destroyed while solving a sidemission
- Changed: disableRemoteSensors true on clients in ai version too (for testing purposes)
- Fixed: NVG check for players was broken
- Changed: Disabling TI (for vecs) and disabling NVG will now also remove infantry weapon optics which have these modes (after arsenal gets closed, easiest way and needs no unncessary script loop running)
- Fixed: Retake camps was completely broken in the normal and TT version because of "OPFOR", "EAST", "BLUFOR", "INDEPENDENT", "GUER" inconsistencies
- Fixed: Got rid of the short standing animation before a dead player moves into unconscious animation state (xr revive), was visible only for other players now gone
- Added: Naked women
- Many optimizations

3.35
- Fixed: Wrong references to engineer trucks in fn_repengineer.sqf
- Fixed: Side mission 31 in CUP Takistan version was completely broken
- Fixed: Non existent variable d_heli_taxi_available did break airtaxi script in AI version
- Fixed: Side mission 23 (Special forces boats in a bay near Pacamac) in the CUP Sahrani version bailed out because of a script error
- Fixed: Side mission 9 (Helicopter Prototype at Krasnostav Airfield) in the CUP Chernarus version (a non existent macro broke the mission)

3.34
- Fixed: CUP_O_Mi8_RU accidentally made it into the normal vanilla version
- Changed: New main target index selection. Hopefully fixes the nilified index variable problem (I was still not able to reproduce it)
- Fixed: If player left the server remoteExec dropanswer resulted in sending the message to a nil object
- Fixed: When a player died in a building he was placed on the ground instead in the floor he died (xr_revive)

3.33
- Fixed: Some stringtable names were used twice
- Fixed: Tasks should now work correctly (I think I now know how it works :P...)
- Changed: d_can_mark_artillery units now get the same artillery messages as artillery operators
- Changed: Air drop marker position is adjusted to the position of the dropped object once it is on the ground
- Changed: Added some debug output to find an issue where the target center is missing when calling getranpointcircleold (and one possible fix added)

3.32
- Fixed: Counter attack was using wrong function to find enemy start positions
- Changed: Counter attack starts earlier now (45-90 seconds instead of 120-240 seconds after main target is clear), check trigger for end condition gets also created a lot earlier now
- Changed: Decreased minimal distance check in script which searches for random positions for bigger objects in a circle

3.31
- Fixed: Since 1.58 nore FSMs do not worked when added via CfgFunctions, switched to old execFSM way

3.30
- Changed: Parajump is now also possible with backpack
- Fixed: Script error in map draw script (affected AI version)

3.29
- Added: Spanish translation (thx to Brigada_ESP)
- Changed: Height check in client artillery script changed from getPosATL back to getPos
- Fixed: Wrong variable was used to check if a player is engineer. Resulted in broken engineer functionality sometimes
- Fixed: Automatic NVG in Virtual Arsenal dialog was not disabled when Virtual Arsenal was closed
- Optimized: Replaced some triggers with new inArea command
- Changed: New method to draw player and vehicle markers on map (does not use the game marker system anymore but draws directly on maps)
- Fixed: Another try to make Ammoload working again if a player dies in a vehicle
- Optimized: Using new string based engine layer system for resources (cutRsc, etc.)
- Fixed: BIS_fnc_EGSpectator changes viewdistance. When BIS_fnc_EGSpectator exits viewdistance is set to the one before BIS_fnc_EGSpectator was started (BIS_fnc_EGSpectator is admin only)
- Optimized: Using getInMan (and getOutMan) eventhandler now for vehicle scripts instead of the typical waituntil {vehicle player != player} script construct
- Changed: Increased timeout in evac sidemissions from 30 minutes to 60 minutes
- Changed: "Created" task state switched to "Assigned" to fix a problem with BI tasks overhaul
- Added: North, east, south, west, full ordered routes for Altis, Chernarus and Takistan versions (means ordered main targets instead of random main targets)
- Added: Message to deploy a MHQ when it gets dropped after a air lift or when a player drives a MHQ
- Fixed: Sidemission 36 building got indestructible after game update
- Fixed: In the ranked version (and AI enabled) AI counter was incremented even though no AI was created

3.28
- Fixed: If you want to change an element of an array use set and not setVariable (error in fn_p_o_ar, me dumb)
- Changed, reset player in vehicle variable after respawn. Possible fix for ammoload problem (stops working after respawn if player is in a vehicle when he dies)
- Fixed, player markers are now also shown when a player is in a non standard vehicle like a quad (new marker system is on the way anyway)
- Added one missing drag prone animation
- Changed, vehicles get now airlifted with four ropes instead of one (thanks to the get corners function by duda123), currently only available for normal non wreck lifting

3.27
- Fixed, wrong use of allowCrewInImmobile in armor creation script for side missions
- Fixed script error in BIS_fnc_establishingShot
- Fixed script errors when player created a UAV at MHQ (array instead the UAV object itself was send to server)
- Fixed, UAVs created with MHQ menu now get correctly deleted and UAV terminals removed

3.26
- Fixed, retrieving respawn and layoutgear was broken as it was using the same container object for uniform, vest and backpack
- Fixed, at respawn backpack content was doubled
- Added: Cleanup routine for player assembled objects

3.25
- Fixed, drivers of the artillery vehicles in base did not get deleted thus they were driving around
- Base artillery vehicle crews are now captive so they won't attack anything nor will they get attacked
- Fixed an error in spectating which completely broke it
- Fixed, wrong layer in spectating script caused black in to early before spectating started
- Fixed some more sidemission related erros

3.24
- Fixed free prisoners sidemissions in AI version
- Fixed artillery base sidemissions
- Added first experimental Community Upgrade Project (CUP) Chernarus version

3.23
- Mission now works with 3DEN
- mission.sqm file is now in 3DEN format (not binarized)
- Fixed respawn (was completely broken)

3.22
- Fixed CreateTriggerLocal, instead of creating local triggers it created global triggers :(
- 3D text "Virtual Arsenal" is now added above Virtual Arsenal ammo boxes

3.21
- Fixed chopper and vehicle respawn (note to myself: NEVER EVER USE BI SYSTEMS, THEY WILL FAIL LIKE THEY ALWAYS DO!!! This time it was BIS_fnc_loop which suddenly stopped working without a warning)
- Changed CfgRemoteExec mode to 2-turned on, however, ignoring whitelists (default because of backward compatibility) There was a bis_fnc_execVM warning in RPT although Dom is not using bis_fnc_execVM
- Vehicle overlay alignment corrected
- Switched to enhanced BI task system
- Fixed UI serialisation
- Fixed various small bugs
- Some optimizations

3.20
(only important changes)
- Rewrote many scripts using improved A3 scripting commands (also the ones included in 1.56)
- Many optimizations in virtually all scripts
- Removed many unnecessary scripts
- Replaced Dom network system with remoteExec/remoteExecCall from A3
- Replaced Spectating with the new A3 Spectating
- Replaced Domination Group Management System with Dynamic Groups System from A3
- Fixed various side missions
- Removed old Dom backpack system
- Millions of bug fixes
- And many many more things...