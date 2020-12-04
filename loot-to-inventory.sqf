// Look at an object with an inventory and execute this locally (sp) or globally (mp).

_target = cursortarget;
_radius = 50;
_nearObjects = nearestObjects [player, ["GroundWeaponHolder", "WeaponHolderSimulated", "Man"], _radius];

if (getNumber(configFile >> "CfgVehicles" >> typeOf cursorTarget >> "maximumLoad") == 0 && alive _target) then {
    systemChat "No target";
    _nearObjects = [];
};

// Returns the base name of the given _vehicle name.
fnc_get_base_vehicle_name = {
    params ["_vehicle"];
    configname (inheritsfrom (configFile >> "CfgVehicles" >> _vehicle))
};

// Put all weapons and their attachments/magazines into the target
fnc_extract_weapons = {
    params ["_target", "_holder"];

    {
        _target addWeaponWithAttachmentsCargoGlobal [_x, 1];
        _holder removeWeaponGlobal (_x select 0);
    } forEach weaponsItems _holder;

    clearWeaponCargoGlobal _holder;
};

// Returns true if the item supplied is one that would be returned for a weaponItems call. False
// otherwise.
fnc_is_in_weapon_items_list = {
    params ["_item"];

    // Binoculars and NVGs both extend "Binocular" yet only the binocular is part of weaponItems so
    // we have to whitelist the NVG.
    _y = [_item, ["Binocular", "Launcher", "Pistol", "Rifle"]] call fnc_inherits_from_weapon;
    _n = [_item, ["NVGoggles"]] call fnc_inherits_from_weapon;
    diag_log ["fnc_is_in_weapon_items_list", _item, _y, _n, _y && !_n];

    _y && !_n;
};

// Check if a given item inherits from the given list of weapon classes.
fnc_inherits_from_weapon = {
    params ["_item", "_classes"];

    (_classes findIf {_item isKindOf [_x, configFile >> "CfgWeapons"]}) >= 0
};

{
    _items = [];
    _backpacks = [];
    _entity = _x;

    if (_entity isKindOf "Man" && !alive _entity) then {
        [_target, _entity] call fnc_extract_weapons;
        _items append magazines _entity;

        {
            // Weapons in backpacks are not removed by fnc_extract_weapons, we have to prevent
            // duplication.
            if (not ([_x] call fnc_is_in_weapon_items_list)) then {
                _items pushBack _x;
            };
        } forEach items _entity;

        private _backpack = unitBackpack _entity;
        if (not isNull _backpack) then {
            // Get base backpack name. This prevents content duplication
            _backpackName = [typeof _backpack] call fnc_get_base_vehicle_name;
            _backpacks pushBack _backpackName;
            _backpacks append backpackCargo _backpack;
            removeBackpackGlobal _entity;
        };

        private _goggles = goggles _entity;
        if !(_goggles isEqualTo "") then {
            _items pushBack _goggles;
            removeGoggles _entity;
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

    if (alive _entity && (_entity isKindOf "GroundWeaponHolder" || _entity isKindOf "WeaponHolderSimulated")) then {
        [_target, _entity] call fnc_extract_weapons;
        {
            // Handle things in backpacks/uniforms/vests
            _backpackName = [_x select 0] call fnc_get_base_vehicle_name;
            _container = _x select 1;
            [_target, _container] call fnc_extract_weapons;
            _items append magazineCargo _container;
            _items append itemCargo _container;
            _backpacks append backpackCargo _container;
            _backpacks pushBack _backpackName;
        } forEach everyContainer _entity;

        _items append magazineCargo _entity;
        _items append itemCargo _entity;
        deleteVehicle _entity;
    };

    {
        _target addItemCargoGlobal [_x, 1];
    } forEach _items;

    {
        _target addBackpackCargoGlobal [_x, 1];
    } forEach _backpacks;
} forEach _nearObjects;
