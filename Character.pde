class Character {
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
      //generate hit points
      PVector[] points = {new PVector(0, 0), new PVector(CHAR_WIDTH/2, 0), new PVector(CHAR_WIDTH, 0)};
      for (PVector p : points) {
        p.rotate(heading);
        p.add(location); 
        fill(255);
      }

      Iterator<Agent> as = level.agents.iterator();
      while (as.hasNext()) {
        Agent smith = as.next();
        if (smith == this) {
          continue;
        }
        for (PVector p : points) {
          if (smith.contains(p)) {
            if (this.gun == null && smith.gun != null) {
              giveGun(smith.gun);
            }
            as.remove();
            melee = 0;
            break;
          }
        }
      }

      Iterator<Gun> gs = level.guns.iterator();
      while (gs.hasNext()) {
        Gun g = gs.next();
        for (PVector p : points) {
          if (this.gun == null && g.contains(p)) {
            giveGun(g);
            gs.remove();
            break;
          }
        }
      }

      if (this != level.player) {
        for (PVector p : points) {
          if (level.player.contains(p)) {
            GAME_OVER = true;
          }
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

  void removeGun() {
    gun = null;
  }
}