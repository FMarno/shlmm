abstract class Character {
  PVector location;
  PVector direction;
  PVector velocity;
  float heading;
  Level level;
  Gun gun;

  public Character(Level level, PVector location, PVector direction) {
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
      rotate(heading + HALF_PI);
      rect(0, 0, CHAR_WIDTH, CHAR_HEIGHT, CHAR_HEIGHT/2);
    }
    popMatrix();
    PVector.fromAngle(heading, unit);
    unit.mult(2);
    ellipse(location.x + unit.x, location.y + unit.y, HEAD_SIZE, HEAD_SIZE);
  }

  void update() {
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

    if (gun != null)
      gun.update();
  }

  void giveGun(Gun gun) {
    if (this.gun == null) {
      this.gun = gun;
    }
  }

  void fireGun() {
    if (gun != null) gun.fire(heading);
  }

  boolean contains(PVector point) {
    float angle = heading + HALF_PI;
    PVector c = location.copy();
    PVector p = point.copy();

    c.rotate(-angle);
    p.rotate(-angle);

    float w = CHAR_WIDTH;
    float h = CHAR_HEIGHT;
    return (c.x-w/2 < p.x && p.x < c.x + w/2 && c.y-h/2 < p.y && p.y < c.y+h/2);
  }

  boolean intersectedBy(PVector p1, PVector p2) {
    float angle = heading + HALF_PI;
    PVector c = location.copy();
    PVector pi = p1.copy();
    PVector px = p2.copy();

    c.rotate(-angle);
    pi.rotate(-angle);
    px.rotate(-angle);

    float w = CHAR_WIDTH;
    float h = CHAR_HEIGHT;

    Line2D.Float line = new Line2D.Float(pi.x, pi.y, px.x, px.y);

    return line.intersects(c.x - w/2, c.y - h/2, w, h);
  }

  boolean inWall(final PVector location) {
    boolean anyIn = false;
    float x = location.x;
    float y = location.y;
    PVector[] points = {
      new PVector(x -2 + CHAR_WIDTH / 2, y -2 + CHAR_WIDTH / 2), 
      new PVector(x -2 + CHAR_WIDTH / 2, y +2 - CHAR_WIDTH / 2), 
      new PVector(x +2 - CHAR_WIDTH / 2, y -2 + CHAR_WIDTH / 2), 
      new PVector(x +2 - CHAR_WIDTH / 2, y +2 - CHAR_WIDTH / 2), 
    };
    for (PVector p : points) {
      for (Wall w : level.walls) {
        anyIn = anyIn || w.contains(p);
        if (anyIn) return true;
      }
    }
    return false;
  }
}