abstract class Gun {
  Level level;
  float reload_time;
  float time_to_reload;
  int ammo;
  PVector location;
  
  public Gun(Level level, PVector location, Character owner); 

  abstract void fire(float heading);

  abstract void update();
}