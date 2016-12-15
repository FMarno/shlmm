abstract class Gun {
  Level level;
  float reload_time;
  float time_to_reload;
  int ammo;
  PVector location;
  PVector velocity;
  Character owner;

  public Gun(Level level, PVector location, Character owner) {
    this.level = level;
    this.location = location;
    this.owner = owner;
    velocity = new PVector(0, 0);
  }

  abstract void fire(float heading);

  void update() {
    location.add(velocity);
    velocity.mult(0.9);
    if (time_to_reload > 0) {
      time_to_reload -= dt;
      if (time_to_reload < 0 && owner == level.player) {
        stroke(#0000ff);
        strokeWeight(5);
        noFill();
        rect(width/2, height/2, 1040, 640);
      }
    }
  }

  void display() {
    fill(0);
    noStroke();
    rect(location.x, location.y, 10, 4);
  }
}