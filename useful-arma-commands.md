# Useful Arma 3 commands

Get the inventory size of the vehicle that they player resides in.  
`getNumber (configfile >> "CfgVehicles" >> typeof vehicle player >> "maximumLoad")`

Get the inventory size of the vehicle that the player is pointing at.  
`getNumber (configfile >> "CfgVehicles" >> typeof cursorTarget >> "maximumLoad")`

# Copy container inventory to another
**Get container contents**  
`(getMagazineCargo cursorTarget) + (getItemCargo cursorTarget) + (getWeaponCargo cursorTarget) + (getBackpackCargo cursortarget);`

**Paste container contents**  
Turn the `getMagazineCargo` response into commands:
```js
function getItemCargoAddCommands(inventory) {
    const commands = [];

    function addItem(command, items, amounts) {
        for (let i = 0; i < items.length; i++) {
            commands.push(`cursortarget ${command} ["${items[i]}", ${amounts[i]}];`);
        }
    }


    for (let inventoryIndex = 0; inventoryIndex < 6; inventoryIndex +=2) {
        addItem('addItemCargo', inventory[inventoryIndex], inventory[inventoryIndex + 1]);
    }

    addItem('addBackpackCargo', inventory[6], inventory[7]);

    return commands
}


console.log(getItemCargoAddCommands(use getMagazineCargo response here).join('\n'));

// e.g
console.log(getItemCargoAddCommands([["ACE_HandFlare_White","30Rnd_65x39_caseless_green","30Rnd_65x39_caseless_green_mag_Tracer","30Rnd_556x45_Stanag","30Rnd_556x45_Stanag_Tracer_Yellow","1Rnd_SmokeYellow_Grenade_shell","1Rnd_HE_Grenade_shell","1Rnd_Smoke_Grenade_shell","1Rnd_SmokeRed_Grenade_shell","1Rnd_SmokeOrange_Grenade_shell","1Rnd_SmokeGreen_Grenade_shell","1Rnd_SmokePurple_Grenade_shell","10Rnd_762x54_Mag","20Rnd_762x51_Mag","5Rnd_127x108_Mag","5Rnd_127x108_APDS_Mag","RPG32_F","RPG32_HE_F","Titan_AT","Titan_AA","150Rnd_762x54_Box","200Rnd_65x39_cased_Box","150Rnd_93x64_Mag","30Rnd_556x45_Stanag_Sand","10Rnd_127x54_Mag","HandGrenade","SmokeShell","SmokeShellRed","SmokeShellOrange","SmokeShellYellow","Chemlight_red","SmokeShellGreen","SmokeShellPurple","Chemlight_green","MiniGrenade","SmokeShellBlue","DemoCharge_Remote_Mag","APERSMine_Range_Mag","SatchelCharge_Remote_Mag","vin_build_res_0"],[300,408,50,381,46,49,86,92,49,87,44,44,35,31,21,11,16,16,24,10,31,31,31,28,5,6,6,6,6,6,6,6,6,6,6,6,7,7,7,80],["bipod_02_F_hex","bipod_02_F_tan","tf_rf7800str","tf_anprc152","ACE_UAVBattery","ACE_wirecutter","ACE_MapTools","ACE_microDAGR","ACE_Altimeter","ACE_Sandbag_empty","ACE_SpottingScope","ACE_EntrenchingTool","ACE_Tripod","ACE_DAGR","ACE_Clacker","ACE_M26_Clacker","ACE_DefusalKit","ACE_EarPlugs","ACE_Kestrel4500","ACE_ATragMX","ACE_RangeCard","ACE_key_lockpick","ACE_Banana","acc_pointer_IR","optic_Arco_blk_F","optic_MRCO","optic_ACO_grn","optic_DMS","bipod_02_F_blk","bipod_03_F_blk","optic_LRPS","optic_Arco","ACE_muzzle_mzls_93mmg","acc_flashlight","optic_ERCO_khk_F","muzzle_snds_m_khk_F","ACE_acc_pointer_green","muzzle_snds_H","bipod_03_F_oli","H_HelmetLeaderO_ocamo","H_HelmetIA","H_Beret_ocamo","H_MilCap_dgtl","H_HelmetIA_net","H_HelmetO_ocamo","H_MilCap_ocamo","H_HelmetIA_camo","H_HelmetCrew_O","H_HelmetCrew_I","H_CrewHelmetHeli_O","H_CrewHelmetHeli_I","H_PilotHelmetFighter_O","H_PilotHelmetFighter_I","H_PilotHelmetHeli_O","H_PilotHelmetHeli_I","H_Bandanna_khk","H_HelmetSpecO_ocamo","H_Watchcap_khk","H_HelmetB_light_black","H_HelmetSpecO_blk","H_Booniehat_dgtl","H_Cap_blk_Raven","V_TacVest_khk","V_PlateCarrierIA2_dgtl","V_HarnessOGL_brn","V_PlateCarrierIAGL_dgtl","V_BandollierB_khk","V_BandollierB_oli","V_HarnessO_brn","V_PlateCarrierIA1_dgtl","V_Chestrig_oli","V_Chestrig_khk","V_TacVest_oli","V_SmershVest_01_radio_F","V_SmershVest_01_F","ItemMap","ItemCompass","ItemWatch","ItemRadio","ItemGPS","FirstAidKit","MineDetector","optic_tws_mg","muzzle_snds_93mmg","Medikit","ToolKit","NVGoggles_OPFOR","NVGoggles_INDEP"],[54,32,50,100,10,10,100,10,10,100,10,100,10,30,40,20,50,100,20,20,30,300,200,80,6,9,62,4,4,28,2,2,2,2,2,3,3,23,3,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,4,12,12,12,12,12,12,12,12,12,12,12,12,12,20,20,20,20,20,320,20,20,20,20,20,50,50],["ACE_Vector","arifle_Katiba_F","arifle_Mk20_F","arifle_Katiba_GL_F","arifle_Mk20_GL_F","arifle_Katiba_C_F","arifle_Mk20C_F","srifle_DMR_01_F","srifle_EBR_F","srifle_GM6_camo_F","srifle_GM6_F","launch_RPG32_F","launch_NLAW_F","launch_O_Titan_short_F","launch_I_Titan_short_F","launch_O_Titan_F","launch_I_Titan_F","LMG_Zafir_F","LMG_Mk200_F","MMG_01_hex_F","MMG_01_tan_F","arifle_SPAR_01_snd_F","Binocular","Rangefinder","Laserdesignator_02","Laserdesignator_03"],[30,29,27,4,4,8,7,4,3,1,1,4,3,3,3,1,1,3,3,2,2,2,20,20,20,20],["tf_rt1523g","tf_rt1523g_fabric","B_Carryall_ocamo","B_Carryall_oli","B_Carryall_cbr","B_TacticalPack_oli","B_FieldPack_ocamo","B_AssaultPack_dgtl","B_FieldPack_cbr","B_FieldPack_oli","B_AssaultPack_rgr","ACE_NonSteerableParachute","B_FieldPack_green_F","B_RadioBag_01_digi_F"],[20,20,3,3,3,3,3,3,3,3,3,3,3,3]]).join('\n'))
```
