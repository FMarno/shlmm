class Character {
  PVector location;
  PVector direction;
  PVector velocity;
  float heading;
  Level level;

  public Character(PVector location, PVector direction, Level level) {
    this.location = location;
    this.direction = direction;
    velocity = new PVector();
    this.level = level;
  }

  void display(int fill) {
    stroke(0);
    strokeWeight(1);
    fill(fill);
    pushMatrix();
    {
      translate(location.x, location.y);
      rotate(-heading);
      rect(0, 0, CHAR_WIDTH, CHAR_HEIGHT, CHAR_HEIGHT/2);
    }
    popMatrix();
    PVector.fromAngle(-heading + PI/2, unit);
    unit.mult(2);
    ellipse(location.x + unit.x, location.y + unit.y, HEAD_SIZE, HEAD_SIZE);
  }

  void update() {
    PVector acceleration = direction.copy();
    acceleration.setMag(ACC);
    velocity.add(acceleration);
    if (velocity.mag() > SPEED){
     velocity.setMag(SPEED); 
    }
    dt = velocity.mag()/SPEED;
    if (dt > -0.1 && dt < 0.1) {
      dt = 0.1;
    }
    velocity.mult(dt);
    location.add(velocity);
    velocity.div(dt);
    velocity.mult(0.93);
  }
}