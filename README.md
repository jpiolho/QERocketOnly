# QERocketOnly
Quake Enhanced Rocket-only deathmatch multiplayer mod

## What is it?
This is a multiplayer deathmatch mod for Quake Enhanced that dynamically makes any Quake (id1) deathmatch map rocket-only. 
There are a few gamemode options you can choose from but here's the default features:
* You will immediately start with a rocket launcher and an axe. You also receive a 3s protection pentagram.
* All ammo pickups are replaced with rockets. No weapons are placed in the map.
* Armor and powerups are unaffected.

## How to install
1. Go to your 'Saved games' quake folder, NOT THE STEAM FOLDER. You can go to it by pressing Windows+R and typing: %userprofile%\Saved Games\Nightdive Studios\Quake\Id1
2. Create a folder called 'id1'
3. Create another folder and call it 'mpmod'. If you already have this folder, skip this step.
4. Extract zip into the 'id1' folder you created on step 2. If you already have an 'id1' folder, it's likely from another mod. Unfortunately, you'll have to replace it.

## How to run the mod
1. Open console and type 'game mpmod'
2. Start a multiplayer game

### Technical explanation
When you change to mpmod, it sets the root folder to be Saved Games, so next time the game goes into id1 it will use the files from Saved Games and override.

## How to set gamemodes
1. Open console and set the variable 'saved1' to the value you want.
2. Restart map

## Game modes
You can activate multiple gamemodes by adding the values together. (eg: 1+2 = 3)

### 1: No ammo packs
   There will be no ammo pickups in the map. All ammo will be derived from backpacks that players drop.

### 2: No spawn protection
   Players will not receive pentagram of protection when they spawn.

### 4: No self damage
   Player own rockets will not damage their health. Armor is still affected.

### 8: Infinite ammo
   No ammo packs and no backpacks will be dropped since everyone will always have infinite rockets.

### 16: Health by killing
   There will be no health pickups in the map, except mega health. Whenever a player kills another player, their health will be instantly restored.
   An incoming rocket from the player that was killed can still damage you.

## Credits
JPiolho: Author

Dan the man: For help in testing some things
