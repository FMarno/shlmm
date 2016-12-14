class Agent extends Character {

  public Agent(Level level, PVector location, PVector direction) {
    super(level, location, direction);
  }


  void update() {
    boolean covered = false;
    for (Wall w : level.walls) {
      covered = covered || w.intersectedBy(location, level.player.location);
      ellipse(w.start.x, w.start.y, 10, 10);
      ellipse(w.end.x, w.end.y, 10, 10);
      if (covered) break;
    }
    if (!covered)
      shootPlayer();


    if (gun != null)
      gun.update();
  }

  void shootPlayer() {
    float target = PVector.sub(level.player.location, location).heading();    
    float diff = target - heading;
    if (diff < ORIENTATION_INCREMENT*dt) {
      heading = target;
      gun.fire(heading);
      return;
    }
    if (diff < 0) {
      heading -= ORIENTATION_INCREMENT*dt;
    } else {
      heading += ORIENTATION_INCREMENT*dt;
    }
  }

  void move() {
    PVector acceleration = direction.copy();
    acceleration.setMag(ACC);
    velocity.add(acceleration);

    if (velocity.mag() > SPEED) {
      velocity.setMag(SPEED);
    }

    velocity.mult(dt);
    location.add(velocity);
    velocity.div(dt);
    velocity.mult(0.93);
  }
}