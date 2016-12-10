class Player extends Character {

  public Player(PVector location, PVector direction, Level level) {
    super(location, direction, level);
  }

  void update() {
    PVector acceleration = direction.copy();
    acceleration.setMag(ACC);
    velocity.add(acceleration);
    if (velocity.mag() > SPEED) {
      velocity.setMag(SPEED);
    }
    dt = velocity.mag()/SPEED;
    if (dt > -0.01 && dt < 0.01) {
      dt = 0.01;
    }
    velocity.mult(dt);
    location.add(velocity);
    velocity.div(dt);
    velocity.mult(0.93);
    if (gun != null)
      gun.update();
  }
}