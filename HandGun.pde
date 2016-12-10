class HandGun extends Gun {

  public HandGun(PVector location) {
    this.location = location;
    reload_time = 0.5 * FRAME_RATE;
  }

  void fire(float heading) {
    if (time_to_reload > 0) return;
    bullets.add(new Bullet(location.copy(), heading));
    time_to_reload = reload_time;
  }

  void update() {
    if (time_to_reload > 0) {
      time_to_reload -= dt;
      if (time_to_reload < 0) {
        stroke(#0000ff);
        strokeWeight(10);
        noFill();
        rect(width/2, height/2, 1024, 632);
      }
    }
  }
}