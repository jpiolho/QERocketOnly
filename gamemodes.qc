float GM_NO_AMMO_PACKS            = 1;
float GM_NO_SPAWN_PROTECTION      = 2;
float GM_NO_SELF_DAMAGE           = 4;
float GM_INFINITE_AMMO            = 8;
float GM_HEALTH_BY_KILLING        = 16;

float() GetGameMode = {
    return cvar("saved1");
}