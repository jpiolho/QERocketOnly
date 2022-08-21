/* Based on observ from quake_ctf */

.float observer;

void(entity player) BecomeObserver =
{
  player.health           = 999;
  player.takedamage       = DAMAGE_NO;
  player.solid            = SOLID_NOT;
  player.movetype         = MOVETYPE_FLY;
  player.deadflag         = DEAD_NO;

  setmodel (player, string_null);

  player.weaponmodel      = "";
  player.weaponframe      = 0;
  player.weapon           = 0;

  setsize(player, '-12 -12 -12', '12 12 12');
  player.view_ofs = '0 0 10';

  player.observer = 1;
};

