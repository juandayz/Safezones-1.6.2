//SAFEZONES UNITS AND VEHICLES REMOVER FROM SAFEZONES BY NOVA AND JUANDAYZ

private ["_traders","_vehicleID","_vehicleUID","_playerpos","_ai_to_be_removed","_Safezone_radio","_all_nearest_veh","_delete","_veh","_classes_list","_classCount","_classes"];


while {true} do {

waitUntil {isInTraderCity};

_playerpos = getPos (vehicle player);
_player = player;
_ai_to_be_removed = _playerpos nearEntities ["Man",350];
_Safezone_radio = 350;
_all_nearest_veh = _playerpos nearEntities [["LandVehicle","Helicopter","Plane","Ship"],_Safezone_radio];
_traders = _playerpos nearEntities ["Man",50];


//TNKS CHOC FOR THIS IDEA
{
if (_x in serverTraders)then{
 player reveal _x;
};

} forEach _traders;



{
if ((_x in allunits) and !(_x in serverTraders) and !(_x in playableunits))then{

_x setdamage 1;
deletevehicle _x;
};

} forEach _ai_to_be_removed;



{
if (vehicle _x getVariable ["aiveh",0] == 1) then {
if (_player == driver _x) then {
_x setVariable ["aiveh",0];
}else{
deletevehicle _x;
//_vehicleID = _x getVariable ["ObjectID", "0"];
//_vehicleUID = _x getVariable ["ObjectUID", "0"];
//[_vehicleID,_vehicleUID] call server_deleteObjDirect;
//PVDZ_obj_Destroy = [_vehicleID,_vehicleUID,_x];
//publicVariableServer "PVDZ_obj_Destroy";
};
};
} forEach _all_nearest_veh;


_delete = 0;
                {
                    _veh = _x;
                    if(!isNull _veh)then
                    {
 if((damage _veh)>=0.99)then {
_delete = _delete + 1;deleteVehicle _veh;
//_vehicleID = _veh getVariable ["ObjectID", "0"];
//_vehicleUID = _veh getVariable ["ObjectUID", "0"];
//[_vehicleID,_vehicleUID] call server_deleteObjDirect;
//PVDZ_obj_Destroy = [_vehicleID,_vehicleUID,player,_obj,dayz_authKey];
//publicVariableServer "PVDZ_obj_Destroy";
                   }; 
                    };
					
                } forEach (vehicles);
				
_classes =
                [
                    "crater","craterlong","PartWoodPile",
                    "SeaGull","Rabbit","WildBoar","Cow","Goat","Sheep","Bird","wire_cat1",
                    "CAAnimalBase"
                ];
                {
                    _classes_list     = allMissionObjects _x;
                    _classCount     = (count _classes_list);
                    {
                        
                            deleteVehicle _x;
                        
                    } forEach (allMissionObjects _x);
                } forEach _classes;					

uiSleep 5;
};


