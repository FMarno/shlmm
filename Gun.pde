abstract class Gun {
  float reload_time;
  float time_to_reload;
  int ammo;
  PVector location;

  abstract void fire(float heading);

  abstract void update();
}