# Using Zeus in Single Player missions/campaign [Arma 3]

Whether you just like to add some more action, fix a broken scenario, view the enemy's position, or give yourself some needed ammo, it is handy to be able to fall back on Zeus. Here is how you can unlock Zeus in the Arma 3 single player missions including the campaign.

1. Subscribe to the [Simple Single Player Cheat Menu mod (SSPCM)](https://steamcommunity.com/sharedfiles/filedetails/?id=410206202)
2. Load the mod and start the game
3. Start the mission
4. Open the map and enable SSPCM as described in the mod's description
5. Open the SSPCM menu  
   If the cheats button does not appear, when playing Old Man for example, follow the workaround described here <https://steamcommunity.com/workshop/filedetails/discussion/410206202/4086396624008566953/>. In short:  
   - Press ESC key to get debug console.
   - In the _Execute_ box write this:

	     createDialog "RscDialogCheatMenu";

   - Press _LOCAL EXEC_
   - Press _ESC_ key to close debug console.


6. Select Zeus in the cheats menu
7. Click on `Enabled`
8. Enter Zeus with the shortcut, default `Y`

## Enemy AI not showing up in Zeus list
If the enemy AI does not appear in the Zeus list, press _ESC_ to open the menu and enter the following into the execute field

```
_objects = allUnits + vehicles; 
{ 
	_x addCuratorEditableObjects [_objects,true]; 
} foreach allCurators;
```

Now press _LOCAL EXEC_.
