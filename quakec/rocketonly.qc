enumflags
{
    ROFL_SEEN_START_MESSAGE,
    ROFL_SPAWNED_INVULNERABILITY,
};

entity host;

.float menu_gamemode;

void respawn();

float(float gm) Rocket_GamemodeName_GetLength =
{
	switch(gm)
	{
		case GM_COLLIDE_ROCKETS: return 2;
		case GM_FAST_ROCKETS: return 2;
		case GM_HEALTH_BY_KILLING: return 3;
		case GM_HOMING_ROCKETS: return 2;
		case GM_INFINITE_AMMO: return 2;
		case GM_NO_AMMO_PACKS: return 3;
		case GM_NO_QUAD: return 2;
		case GM_NO_SELF_DAMAGE: return 3;
		case GM_NO_SPAWN_PROTECTION: return 3;
		case GM_RANDOM_QUAD_RESPAWN: return 3;
		case GM_SLOW_BUILDUP: return 2;
		case GM_SLOW_ROCKETS: return 2;
		case GM_SPAWN_WITH_QUAD: return 3;
		case GM_SUDDEN_DEATH: return 2;
		case GM_NO_ARMOR: return 2;
		case GM_DARKNESS: return 4;
		default: return 0;
	}
}

void(float gm) Rocket_GamemodeName_PrintName =
{
	switch(gm) 
	{
		case GM_COLLIDE_ROCKETS: 
			WriteByte(MSG_ONE,'C');
			WriteByte(MSG_ONE,'R');
			break;
		case GM_FAST_ROCKETS:
			WriteByte(MSG_ONE,'F');
			WriteByte(MSG_ONE,'R');
			break;
		case GM_HEALTH_BY_KILLING:
			WriteByte(MSG_ONE,'H');
			WriteByte(MSG_ONE,'B');
			WriteByte(MSG_ONE,'K');
			break;
		case GM_HOMING_ROCKETS: 
			WriteByte(MSG_ONE,'H');
			WriteByte(MSG_ONE,'R');
			break;
		case GM_INFINITE_AMMO:
			WriteByte(MSG_ONE,'I');
			WriteByte(MSG_ONE,'A');
			break;
		case GM_NO_AMMO_PACKS:
			WriteByte(MSG_ONE,'N');
			WriteByte(MSG_ONE,'A');
			WriteByte(MSG_ONE,'P');
			break;
		case GM_NO_QUAD:
			WriteByte(MSG_ONE,'N');
			WriteByte(MSG_ONE,'Q');
			break;
		case GM_NO_SELF_DAMAGE: 
			WriteByte(MSG_ONE,'N');
			WriteByte(MSG_ONE,'S');
			WriteByte(MSG_ONE,'D');
			break;
		case GM_RANDOM_QUAD_RESPAWN:
			WriteByte(MSG_ONE,'R');
			WriteByte(MSG_ONE,'Q');
			WriteByte(MSG_ONE,'R');
			break;
		case GM_SLOW_BUILDUP:
			WriteByte(MSG_ONE,'S');
			WriteByte(MSG_ONE,'B');
			break;
		case GM_SLOW_ROCKETS:
			WriteByte(MSG_ONE,'S');
			WriteByte(MSG_ONE,'R');
			break;
		case GM_SPAWN_WITH_QUAD:
			WriteByte(MSG_ONE,'S');
			WriteByte(MSG_ONE,'W');
			WriteByte(MSG_ONE,'Q');
			break;
		case GM_NO_SPAWN_PROTECTION: 
			WriteByte(MSG_ONE,'N');
			WriteByte(MSG_ONE,'S');
			WriteByte(MSG_ONE,'P');
			break;
		case GM_SUDDEN_DEATH:
			WriteByte(MSG_ONE,'S');
			WriteByte(MSG_ONE,'D');
			break;
		case GM_NO_ARMOR:
			WriteByte(MSG_ONE,'N');
			WriteByte(MSG_ONE,'A');
			break;
		case GM_DARKNESS:
			WriteByte(MSG_ONE,'D');
			WriteByte(MSG_ONE,'A');
			WriteByte(MSG_ONE,'R');
			WriteByte(MSG_ONE,'K');
			break;
	}
}


void(entity t) Rocket_PrintGamemodeSelectMenu;
void(float currentGamemode) Rocket_PrintNextGamemodeInfo;
void() Rocket_PrintWelcomeMessage;

void(float menu) Menu_GamemodeInfo =
{
	if(menu == 0) {
		Rocket_PrintWelcomeMessage();
	}
	else if(menu == 1)
		Rocket_PrintNextGamemodeInfo(self.menu_gamemode);
}

void(float currentGamemode) Rocket_PrintNextGamemodeInfo =
{
	while(currentGamemode < GM__END__) {
		if(currentGamemode >= 1)
			currentGamemode *= 2;
		else
			currentGamemode = 1;		

		if(gamemode & currentGamemode) {
			
			switch(currentGamemode) {
				case GM_NO_AMMO_PACKS: MenuSystem::Create("[Gamemode Info]\nNo ammo packs\n\nThere are no ammo packs in the map"); break;
				case GM_NO_SPAWN_PROTECTION: MenuSystem::Create("[Gamemode Info]\nNo spawn protection\n\nYou don't get invulnerability when you spawn"); break;
				case GM_NO_SELF_DAMAGE: MenuSystem::Create("[Gamemode Info]\nNo self damage\n\nYou can't damage yourself"); break;
				case GM_INFINITE_AMMO: MenuSystem::Create("[Gamemode Info]\nInfinite ammo\n\nYou get infinite rockets"); break;
				case GM_HEALTH_BY_KILLING: MenuSystem::Create("[Gamemode Info]\nHealth by killing\n\nYou only get health by killing other players"); break;
				case GM_NO_QUAD: MenuSystem::Create("[Gamemode Info]\nNo quad\n\nThere is no quad damage in the map"); break;
				case GM_RANDOM_QUAD_RESPAWN: MenuSystem::Create("[Gamemode Info]\nRandom quad respawn\n\nQuad damage respawn time is random"); break;
				case GM_SPAWN_WITH_QUAD: MenuSystem::Create("[Gamemode Info]\nSpawn with quads\n\nYou spawn with quad damage"); break;
				case GM_HOMING_ROCKETS: MenuSystem::Create("[Gamemode Info]\nHoming rockets\n\nRockets will steer towards where you're aiming"); break;
				case GM_SLOW_ROCKETS: MenuSystem::Create("[Gamemode Info]\nSlow rockets\n\nRockets are slower than normal"); break;
				case GM_FAST_ROCKETS: MenuSystem::Create("[Gamemode Info]\nFast rockets\n\nRockets are faster than normal"); break;
				case GM_COLLIDE_ROCKETS: MenuSystem::Create("[Gamemode Info]\nCollide rockets\n\nRockets can collide in mid-air"); break;
				case GM_SLOW_BUILDUP: MenuSystem::Create("[Gamemode Info]\nSlow buildup\n\nRockets take sometime to get up to speed"); break;
				case GM_SUDDEN_DEATH: MenuSystem::Create("[Gamemode Info]\nSudden death\n\nYou only have 1hp. Armor will give you extra hits\n100a (Green): 1 hit\n150a (Yellow): 2 hits\n200a (Red): 3 hits"); break;
				case GM_NO_ARMOR: MenuSystem::Create("[Gamemode Info]\nNo armor\n\nThere is no armor in the map"); break;
				case GM_DARKNESS: MenuSystem::Create("[Gamemode Info]\nDarkness\n\nThe map is in complete darkness for the most part"); break;
			}

			MenuSystem::AddChoice("Exit");
			MenuSystem::AddChoice("Next");
			MenuSystem::Send(self,Menu_GamemodeInfo);

			self.menu_gamemode = currentGamemode;

			return;
		}
	}

	Rocket_PrintWelcomeMessage();

}

void(float menu) Menu_Credits =
{
	Rocket_PrintWelcomeMessage();
}


void(float menu) Menu_MOTD =
{
	if(menu == 0) {
		self.observer = FALSE;
		respawn();
	}
	else if(menu == 1) {
		self.menu_gamemode = 0;
		Rocket_PrintNextGamemodeInfo(0);
	} else if(menu == 2) {
		MenuSystem::Create("QERockets\n\nMod by JPiolho\nThanks to QE Community Discord\nThanks to everyone that has played and tested",
			"Back",
			"Back",
			"Back"
		);
		MenuSystem::Send(self,Menu_Credits);
	}
}

void(float menu) Menu_RestartMap =
{
	if(menu == 1)
	{
		localcmd("changelevel ");
		localcmd(mapname);
		localcmd("\n");
	}
}

void(float menu) Menu_SelectGamemode =
{
	float saved1 = cvar("saved1");
	float leave = FALSE;

	if(menu == 0) leave = TRUE;
	else if(menu == 1) saved1 ^= GM_NO_AMMO_PACKS;
	else if(menu == 2) saved1 ^= GM_NO_SPAWN_PROTECTION;
	else if(menu == 3) saved1 ^= GM_NO_SELF_DAMAGE;
	else if(menu == 4) saved1 ^= GM_INFINITE_AMMO;
	else if(menu == 5) saved1 ^= GM_HEALTH_BY_KILLING;
	else if(menu == 6) saved1 ^= GM_NO_QUAD;
	else if(menu == 7) saved1 ^= GM_RANDOM_QUAD_RESPAWN;
	else if(menu == 8) saved1 ^= GM_SPAWN_WITH_QUAD;
	else if(menu == 9) saved1 ^= GM_HOMING_ROCKETS;
	else if(menu == 10) saved1 ^= GM_SLOW_ROCKETS;
	else if(menu == 11) saved1 ^= GM_FAST_ROCKETS;
	else if(menu == 12) saved1 ^= GM_COLLIDE_ROCKETS;
	else if(menu == 13) saved1 ^= GM_SLOW_BUILDUP;
	else if(menu == 14) saved1 ^= GM_SUDDEN_DEATH;
	else if(menu == 15) saved1 ^= GM_NO_ARMOR;
	else if(menu == 16) saved1 ^= GM_DARKNESS;

	cvar_set("saved1",ftos(saved1));

	if(leave) {
		if(saved1 != gamemode) {
			MenuSystem::Create("[HOST MENU]\n\nThe gamemode has changed.\nDo you want to restart the current map to apply the new gamemode?",
				"No",
				"Yes"
			);
			MenuSystem::Send(self,Menu_RestartMap);
		}
		return;
	}

	Rocket_PrintGamemodeSelectMenu(self);
}

void(entity t) Rocket_PrintGamemodeSelectMenu =
{
	float saved1 = cvar("saved1");

	MenuSystem::Create("[HOST MENU]\nSelect gamemodes");
	
	MenuSystem::AddChoice("Exit");
	MenuSystem::AddChoice(saved1 & GM_NO_AMMO_PACKS ? "No ammo packs (ON)" : "No ammo packs (OFF)");
	MenuSystem::AddChoice(saved1 & GM_NO_SPAWN_PROTECTION ? "No spawn protection (ON)" : "No spawn protection (OFF)");
	MenuSystem::AddChoice(saved1 & GM_NO_SELF_DAMAGE ? "No self damage (ON)" : "No self damage (OFF)");
	MenuSystem::AddChoice(saved1 & GM_INFINITE_AMMO ? "Infinite ammo (ON)" : "Infinite ammo (OFF)");
	MenuSystem::AddChoice(saved1 & GM_HEALTH_BY_KILLING ? "Health by killing (ON)" : "Health by killing (OFF)");
	MenuSystem::AddChoice(saved1 & GM_NO_QUAD ? "No quad (ON)" : "No quad (OFF)");
	MenuSystem::AddChoice(saved1 & GM_RANDOM_QUAD_RESPAWN ? "Random quad respawn (ON)" : "Random quad respawn (OFF)");
	MenuSystem::AddChoice(saved1 & GM_SPAWN_WITH_QUAD ? "Spawn with quad (ON)" : "Spawn with quad (OFF)");
	MenuSystem::AddChoice(saved1 & GM_HOMING_ROCKETS ? "Homing rockets (ON)" : "Homing rockets (OFF)");
	MenuSystem::AddChoice(saved1 & GM_SLOW_ROCKETS ? "Slow rockets (ON)" : "Slow rockets (OFF)");
	MenuSystem::AddChoice(saved1 & GM_FAST_ROCKETS ? "Fast rockets (ON)" : "Fast rockets (OFF)");
	MenuSystem::AddChoice(saved1 & GM_COLLIDE_ROCKETS ? "Collide rockets (ON)" : "Collide rockets (OFF)");
	MenuSystem::AddChoice(saved1 & GM_SLOW_BUILDUP ? "Slow buildup (ON)" : "Slow buildup (OFF)");
	MenuSystem::AddChoice(saved1 & GM_SUDDEN_DEATH ? "Sudden death (ON)" : "Sudden death (OFF)");
	MenuSystem::AddChoice(saved1 & GM_NO_ARMOR ? "No armor (ON)" : "No armor (OFF)");
	MenuSystem::AddChoice(saved1 & GM_DARKNESS ? "Darkness (ON)" : "Darkness (OFF)");

	MenuSystem::Send(t,Menu_SelectGamemode);
}


void() Rocket_PrintWelcomeMessage =
{
	msg_entity = self;

	/*	
	prompt(self,"Hello there",1);
	promptchoice(self,"Option 1",100);
	promptchoice(self,"Option 2",101);
	*/

	WriteByte(MSG_ONE,SVC_PROMPT);
	WriteByte(MSG_ONE,3);
	WriteChars('W','e','l','c','o','m','e',' ','t','o',' ','R','o','c','k','e');WriteChars('t','-','o','n','l','y',' ','d','e','a','t','h','m','a','t','c');WriteChars('h','\n');
	WriteChars('\n');
	WriteChars('A','n','y',' ','b','u','g','s',' ','a','r','e',' ','p','r','o');WriteChars('b','a','b','l','y',' ','r','e','l','a','t','e','d',' ','t','o');WriteChars(' ','t','h','e',' ','m','o','d','\n');
	WriteChars('H','a','v','e',' ','f','u','n','!');
	WriteByte(MSG_ONE,'\n');
	WriteChars('T','h','i','s',' ','m','o','d',' ','i','s',' ','r','u','n','n');WriteChars('i','n','g',' ','a','n','t','i','-','l','a','g');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');

	// Check if we should print gamemodes
	if(cvar("saved2") != 1) {
		WriteChars('G','a','m','e','m','o','d','e',':','\n');

		local float gamemodesLength = 0;
		local float seek = 1;
		while(seek <= GM__END__) {
			if(gamemode & seek) {
				gamemodesLength += Rocket_GamemodeName_GetLength(seek);
				Rocket_GamemodeName_PrintName(seek);
				WriteByte(MSG_ONE,' ');
			}

			seek *= 2;
		}
		WriteString(MSG_ONE,ftos(gamemode));
	}


	promptchoice(self,"OK",200);
	promptchoice(self,"Gamemodes",201);
	promptchoice(self,"Credits",202);
	MenuSystem::OverrideCallback(self,Menu_MOTD);
	
	//centerprint(self,"Welcome to Rocket-only deathmatch\n\nAny bugs are probably related to the mod\nGamemode: ",ftos(gamemode),"\n\nHave fun!");
}


float() Rocket_GetSpeed =
{
	local float mySpeed = 1000;

	if(gamemode & GM_SLOW_ROCKETS)
		mySpeed = 500;
	else if(gamemode & GM_FAST_ROCKETS)
		mySpeed = 1500;
	else
		mySpeed = 1000;

	if(gamemode & GM_SLOW_BUILDUP)
	{
		local float timeDelta = time - self.waitmin;
		if(timeDelta > 1.0) timeDelta = 1.0;

		local float min = mySpeed - 1000;
		if(min < 300) min = 300;
		mySpeed = lerp(min,mySpeed,timeDelta);
	}

	return mySpeed;
}


void() T_MissileTouch;
void() Rocket_Think =
{
	
	// Remove rocket if it expired
	if(time >= self.waitmax) {
		remove(self);
		return;
	}

	if(gamemode & GM_HOMING_ROCKETS && self.owner.deadflag == DEAD_NO) {
		makevectors(self.owner.v_angle);

		// Calculate where the rocket should aim towards
		local vector from = self.owner.origin + self.owner.view_ofs;
		traceline(from,from + (v_forward * 2048),FALSE,self);

		local vector dir = normalize(trace_endpos - self.origin);
		local vector desired  = dir * 96;

		self.velocity += desired;
		self.velocity = normalize(self.velocity) * Rocket_GetSpeed();
		self.angles = vectoangles(self.velocity);
	}

	if(gamemode & GM_COLLIDE_ROCKETS)
	{
		local entity p = findradius(self.origin,64);

		while(p)
		{
			if(p != self && p.classname == "missile")
			{
				if(vlen(self.origin - p.origin) <= 32)
				{
					T_MissileTouch();

					local entity oself = self;
					self = p;
					T_MissileTouch();
					self = oself;

					break;
				}
			}

			p = p.chain;
		}
	}
	
	// Update speed
	if(gamemode & GM_SLOW_BUILDUP)
	{
		self.velocity = normalize(self.velocity) * Rocket_GetSpeed();
	}

	self.nextthink = time;
}




void() HandleRocketOnlyImpulses = 
{
	if(host == self) {
		if(self.impulse == 200) {
			Rocket_PrintGamemodeSelectMenu(self);
		}
	}
}