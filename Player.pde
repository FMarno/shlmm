class Player extends Character {

  public Player(Level level, PVector location, PVector direction) {
    super(level, location, direction);
  }

  void update() {
    heading = new PVector(mouseX - location.x, mouseY - location.y).heading();

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
    PVector projection = PVector.add(location, velocity);
    
    if (!inWall(projection))
      location.add(velocity);
    velocity.div(dt);
    velocity.mult(0.93);

    if (gun != null)
      gun.update();
  }
}