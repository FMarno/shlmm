class Agent extends Character {

  public Agent(Level level, PVector location, PVector direction, int fill) {
    super(level, location, direction, fill);
  }


  void update() {
    boolean covered = false;
    for (Wall w : level.walls) {
      covered = covered || w.intersectedBy(location, level.player.location);
      if (covered) break;
    }
    if (!covered)
      shootPlayer();


    super.update();
  }

  void shootPlayer() {
    PVector target = PVector.sub(level.player.location, location);    
    float orr = atan2(target.y, target.x);

    // Will take a frame extra at the PI boundary
    if (abs(orr - heading) <= ORIENTATION_INCREMENT) {
      heading = orr ;
      if (gun != null)
        gun.fire(heading);
      return ;
    }

    // if it's less than me, then how much if up to PI less, decrease otherwise increase
    if (orr < heading) {
      if (heading - orr < PI) heading -= ORIENTATION_INCREMENT ;
      else heading += ORIENTATION_INCREMENT ;
    } else {
      if (orr - heading < PI) heading += ORIENTATION_INCREMENT ;
      else heading -= ORIENTATION_INCREMENT ;
    }

    // Keep in bounds
    if (heading > PI) heading -= 2*PI ;
    else if (heading < -PI) heading += 2*PI ;
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