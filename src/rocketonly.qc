enumflags int
{
    ROFL_SEEN_START_MESSAGE,
    ROFL_SPAWNED_INVULNERABILITY,
};

float	modelindex_eyes, modelindex_player;


void() RO_ShowPlayer = 
{
    setmodel (self, "progs/player.mdl");
    setsize (self, VEC_HULL_MIN, VEC_HULL_MAX);
}

void() RO_SendAlphaPlayers =
{
    local float firstBits;
    local float secondBits;
    local float thirdBits;
    
    local entity p;

    local float pNumber = 0;
    while((p = find(p,classname,"player")))
    {       
        pNumber++;

        // Ignore self 
        if(p == self)
            continue;

        if(!(p.cnt & ROFL_SPAWNED_INVULNERABILITY))
            continue;

        // Do a rudimentary check to see if the player is in line of sight
        traceline(self.origin + self.view_ofs,p.origin,TRUE, self);
        if(trace_fraction < 1.0)
            continue;

        firstBits |= 1; // More bytes

		firstBits |= 1 << 1; // Origin 1
		firstBits |= 1 << 2; // Origin 2
		firstBits |= 1 << 3; // Origin 3
		firstBits |= 1 << 4; // Angle 2
		firstBits |= 1 << 6; // Frame

		secondBits |= (1 << 8) >> 8; // Angle 1
		secondBits |= (1 << 9) >> 8; // Angle 3
		secondBits |= (1 << 10) >> 8; // Model Index
		secondBits |= (1 << 11) >> 8; // Colormap
		secondBits |= (1 << 12) >> 8; // Skin
		secondBits |= (1 << 13) >> 8; // Effects
        secondBits |= (1 << 14) >> 8; // Long Entity
		secondBits |= (1 << 15) >> 8; // More bytes

		thirdBits |= (1 << 16) >> 16; // Alpha
		thirdBits |= (1 << 22) >> 16; // Solid

		msg_entity = self;
		WriteByte(MSG_ONE,firstBits | 128); // Packet Type

        // Send all the values
		if(firstBits & 1)
			WriteByte(MSG_ONE,secondBits);
		if(secondBits & 128)
			WriteByte(MSG_ONE,thirdBits);
	
		WriteShort(MSG_ONE,1500 + pNumber); // Entity ID

		WriteByte(MSG_ONE,modelindex_player);
		WriteByte(MSG_ONE,p.frame); 
		WriteByte(MSG_ONE,p.colormap);
		WriteByte(MSG_ONE,p.skin);
		WriteByte(MSG_ONE,p.effects);
		WriteCoord(MSG_ONE,p.origin_x);
		WriteAngle(MSG_ONE,p.angles_x);
		WriteCoord(MSG_ONE,p.origin_y);
		WriteAngle(MSG_ONE,p.angles_y);
		WriteCoord(MSG_ONE,p.origin_z);
		WriteAngle(MSG_ONE,p.angles_z);
		WriteByte(MSG_ONE,120);
		WriteByte(MSG_ONE,MOVETYPE_WALK);
    }
}