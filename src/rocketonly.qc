enumflags int
{
    ROFL_SEEN_START_MESSAGE,
    ROFL_SPAWNED_INVULNERABILITY,
};


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
	}
}

void() Rocket_PrintWelcomeMessage =
{
	msg_entity = self;

	WriteByte(MSG_ONE,26);

	
	WriteShort(MSG_ONE,1);
	
	WriteChars('W','e','l','c','o','m','e',' ','t','o',' ','R','o','c','k','e');WriteChars('t','-','o','n','l','y',' ','d','e','a','t','h','m','a','t','c');WriteChars('h','\n');
	WriteChars('\n');
	WriteChars('A','n','y',' ','b','u','g','s',' ','a','r','e',' ','p','r','o');WriteChars('b','a','b','l','y',' ','r','e','l','a','t','e','d',' ','t','o');WriteChars(' ','t','h','e',' ','m','o','d','\n');
	WriteChars('H','a','v','e',' ','f','u','n','!');

	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');
	WriteByte(MSG_ONE,'\n');

	WriteChars('G','a','m','e','m','o','d','e',':','\n');

	local float gamemodesLength = 0;
	local float seek = 1;
	while(seek < 4294967296) {
		if(gamemode & seek) {
			gamemodesLength += Rocket_GamemodeName_GetLength(seek);
			Rocket_GamemodeName_PrintName(seek);
			WriteByte(MSG_ONE,' ');
		}

		seek *= 2;
	}
	WriteByte(MSG_ONE,'\n');
	WriteString(MSG_ONE,ftos(gamemode));
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

	if(gamemode & GM_HOMING_ROCKETS) {
		makevectors(self.owner.v_angle);

		// Calculate where the rocket should aim towards
		local vector from = self.owner.origin + self.owner.view_ofs;
		traceline(from,from + (v_forward * 2048),FALSE,self);

		self.velocity = normalize(trace_endpos - self.origin) * Rocket_GetSpeed();
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