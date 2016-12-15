class HandGun extends Gun {

  public HandGun(Level level, PVector location, Character owner) {
    super(level, location, owner);
    reload_time = 0.5 * FRAME_RATE;
    ammo = 6;
  }

  void fire(float heading) {
    if (time_to_reload > 0 || ammo < 1) return;
    level.bullets.add(new Bullet(level, location.copy(), heading));
    time_to_reload = reload_time;
    if (owner == level.player)
      ammo--;
  }
}