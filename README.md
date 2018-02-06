# Safezones-1.6.2
Icludes the safezones, script to remove AI and AI vehicles from safezones. Script To remove Damaged vehicles and craters, script to remove zeds and loot from safezones and bases. Include too a script to fix that shit about you need made zoom on traders to get the trader option.Include vehicles with not damage on plot poles. 

(tnks oldmatechoc and nova for all help).

**NOTE:** Currently the safezones are defined for chernarus map. If u are using other map change the coords in main_safezone.sqf here:
```ruby
_infiSZ =
[
    [[6325.6772,7807.7412,0],150,true],//stary
    [[4063.4226,11664.19,0],150,true],//bash
    [[11447.472,11364.504,0],150,true],//klen
    [[1606.6443,7803.5156,0],150,true],//bandit
    [[12944.227,12766.889,0],150,true],//hero
    [[4361.4937,2259.9526,0],50,true],//wholesalerSouth
    [[12060,12640,0],200,true]//air dealear
];
```





INSTALL:

1-Open your init.sqf and at very bottom paste:

```ruby
[] execVM "scripts\safezone\main_safezone.sqf";
[] execVM "scripts\safezone\safezone_ai_remover.sqf";
```
2-Open your custom compiles.sqf

Into: If (!isDedicated) then { paste };

```ruby
player_spawnCheck = compile preprocessFileLineNumbers "scripts\safezone\player_spawnCheck.sqf";//remove loot from safezones
```
Now out of If (!isDedicated) then {}; paste:
```ruby
//Vehicles with godmod in plot zones// 
fnc_veh_handleDam = compile preprocessFileLineNumbers "scripts\safezone\veh_handleDam.sqf";
```
3-Now drop safezone folder in your scripts folder.

4-We gonna need edit WAI and DZAI files to remove his bots from this safezones.. so:

For DZAI open DZAI\init\dzai_functions.sqf  and find those lines:

```
 DZAI_protectObject = {
    private ["_objectMonitor","_object"];
    _object = _this;
    
    _objectMonitor = missionNamespace getVariable [DZAI_serverObjectMonitor,[]];
    _objectMonitor set [count _objectMonitor,_object];
    DZAI_monitoredObjects set [count DZAI_monitoredObjects,_object];
    _object setVariable ["ObjectID",""];
    _object setVariable ["ObjectUID",""];    
    true
}; 
```
Replace by:
```ruby
 DZAI_protectObject = {
    private ["_objectMonitor","_object"];
    _object = _this;
    
    _objectMonitor = missionNamespace getVariable [DZAI_serverObjectMonitor,[]];
    _objectMonitor set [count _objectMonitor,_object];
    DZAI_monitoredObjects set [count DZAI_monitoredObjects,_object];
    _object setVariable ["ObjectID",""];
    _object setVariable ["ObjectUID",""];
    _object setvariable ["aiveh",1,true]; 
    true
}; 
```
For WAI open:wai\compile\vehicle_patrol.sqf  and find those lines:
```
_vehicle = createVehicle [_veh_class, [(_startingpos select 0),(_startingpos select 1), 0], [], 0, "CAN_COLLIDE"];
_vehicle setFuel 1;
_vehicle engineOn true;
_vehicle setVehicleAmmo 1;
_vehicle addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
_vehicle allowCrewInImmobile true; 
_vehicle lock true;
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_vehicle];
```
replace by:
```ruby
_vehicle = createVehicle [_veh_class, [(_startingpos select 0),(_startingpos select 1), 0], [], 0, "CAN_COLLIDE"];
_vehicle setFuel 1;
_vehicle engineOn true;
_vehicle setVehicleAmmo 1;
_vehicle addEventHandler ["GetOut",{(_this select 0) setFuel 0;(_this select 0) setDamage 1;}];
_vehicle allowCrewInImmobile true; 
_vehicle lock true;
_vehicle setvariable ["aiveh",1,true]; 
dayz_serverObjectMonitor set [count dayz_serverObjectMonitor,_vehicle];
```

For DZMS open DZMS\DZMSFunctions.sqf  and find those lines:
```
DZMSProtectObj = {
    private ["_object","_objectID"];
    _object = _this select 0;
    
    _objectID = str(round(random 999999));
    _object setVariable ["ObjectID", _objectID, true];
    _object setVariable ["ObjectUID", _objectID, true];
    _object setVectorUp surfaceNormal position _object;
 ```
 add below: ```_object setvariable ["aiveh",1,true];```
 
 You can do the same with whatever other mission with AI. the tip its just add 
 ```_UNITVARIABLENAME setvariable ["aiveh",1,true];``` for each ai vehicles.

