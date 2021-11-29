enumflags int
{
    ROFL_SEEN_START_MESSAGE,
    ROFL_SPAWNED_INVULNERABILITY,
};




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