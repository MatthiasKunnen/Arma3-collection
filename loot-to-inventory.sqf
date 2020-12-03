_target = cursortarget;
_potential = nearestObjects [player, ["GroundWeaponHolder", "weaponholdersimulated", "Man"], 200];

if (typeOf _target isEqualTo "") then {
    systemChat "No target";
    _potential = [];
};

{
    _items = [];
    _backpacks = [];
    _entity = _x;

    if (_entity isKindOf "Man" && !alive _entity) then {
        _items append magazines _entity;
        _items append items _entity;

        _items append weapons _entity;
        {_entity removeWeapon _x} forEach weapons _entity;
        removeAllWeapons _entity; // To remove magazines, does not remove pistols successfully

        private _backpack = backpack _entity;
        if !(_backpack isEqualTo "") then {
            _backpacks pushBack _backpack;
            removeBackpackGlobal _entity;
        };

        private _uniform = uniform _entity;
        if !(_uniform isEqualTo "") then {
            _items pushBack _uniform;

            removeUniform _entity;
        };

        private _vest = vest _entity;
        if !(_vest isEqualTo "") then {
            _items pushBack _vest;
            removeVest _entity;
        };

        private _headgear = headgear _entity;
        if !(_headgear isEqualTo "") then {
            _items pushBack _headgear;
            removeHeadgear _entity;
        };

        _items append (assignedItems _entity);
        {_entity unlinkItem _x;} forEach assignedItems _entity; // removeAllAssignedItems does not work properly
    };

    if (alive _entity && (_entity isKindOf "GroundWeaponHolder" || _entity isKindOf "weaponholdersimulated")) then {
        _items append magazineCargo _entity;
        _items append weaponCargo _entity;
        _items append itemCargo _entity;
        // Most weapons already have predetermined scopes etc based on name, dunno what to do bout that
        _items append weaponsItemsCargo _entity;
        _backpacks append backpackCargo _entity;
        clearWeaponCargoGlobal _entity;
        clearBackpackCargoGlobal _entity;
        deleteVehicle _entity;
    };

    {
        _target addItemCargoGlobal [_x, 1];
    } forEach _items;

    {
        _target addBackpackCargoGlobal [_x, 1];
    } forEach _backpacks;
} forEach _potential;
