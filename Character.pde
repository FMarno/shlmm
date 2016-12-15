abstract class Character {
  PVector location;
  PVector direction;
  PVector velocity;
  float heading;
  Level level;
  Gun gun;
  int fill;
  float melee = 0;

  public Character(Level level, PVector location, PVector direction, int fill) {
    this.location = location;
    this.direction = direction;
    velocity = new PVector();
    this.level = level;
    this.fill = fill;
  }

  void attack() {
    if (gun != null) {
      fireGun();
      return;
    }
    meleeAttack();
  }

  void meleeAttack() {
    if (melee <1)
      melee = FRAME_RATE/2;
  }

  void display() {
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

    if (melee>FRAME_RATE/3) {
      stroke(0);
      strokeWeight(1);
      fill(fill);
      pushMatrix();
      PVector offset = PVector.fromAngle(heading +HALF_PI);
      offset.setMag(15);
      {
        translate(location.x + offset.x, location.y + offset.y);
        rotate(heading + HALF_PI - HALF_PI/4);
        rect(0, -CHAR_WIDTH/2, CHAR_WIDTH/3, CHAR_WIDTH);
      }
      popMatrix();
    }

    PVector unit = PVector.fromAngle(heading);
    unit.mult(2);
    ellipse(location.x + unit.x, location.y + unit.y, HEAD_SIZE, HEAD_SIZE);
  }

  void update() {

    if (melee >FRAME_RATE/3) {
      fill(255);
      PVector c1 = new PVector(-CHAR_HEIGHT/2, CHAR_WIDTH/2);
      PVector c2 = new PVector(-CHAR_HEIGHT/2, -CHAR_WIDTH/2);
      c1.rotate(heading);
      c2.rotate(heading);
      PVector offset = PVector.fromAngle(heading);
      offset.setMag(CHAR_HEIGHT);
      c1.add(offset);
      c2.add(offset);
      c1.add(location);
      c2.add(location);
      float angle = atan2(c2.x - c1.x, c2.y - c1.y);

      c1.rotate(angle);

      Iterator<Gun> gs = level.guns.iterator();
      while (gs.hasNext()) {
        Gun gun = gs.next();
        PVector gloc = gun.location.copy();
        gloc.rotate(angle);
        if (c1.x - CHAR_WIDTH*3/2 <= gloc.x && gloc.x <= c1.x && c1.y <= gloc.y && gloc.y <= c1.y + CHAR_WIDTH) {
          if (this.gun == null) {
            giveGun(gun);
            gs.remove();
            break;
          }
        }
      }

      Iterator<Agent> as = level.agents.iterator();
      while (as.hasNext()) {
        Agent smith = as.next();
        PVector sloc = smith.location.copy();
        sloc.rotate(angle);
        if (c1.x - CHAR_WIDTH*3/2 <= sloc.x && sloc.x <= c1.x && c1.y <= sloc.y && sloc.y <= c1.y + CHAR_WIDTH) {
          if (this.gun ==null && smith.gun != null) {
            giveGun(smith.gun);
          }
          as.remove();
        }
      }
    }
    if (gun != null)
      gun.update();


    if (melee > 0)
      melee-=dt;
  }

  void giveGun(Gun gun) {
    if (this.gun == null) {
      this.gun = gun;
      this.gun.location =this.location;
      this.gun.velocity.setMag(0);
      this.gun.time_to_reload = this.gun.reload_time;
      this.gun.owner = this;
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

  void dropGun() {
    if (gun == null)
      return;
    gun.velocity = PVector.fromAngle(heading);
    gun.velocity.setMag(5);
    gun.velocity.add(velocity);
    gun.location = location.copy();
    level.guns.add(gun);
    gun.owner = null;
    gun = null;
  }
}