class Bullet {
  PVector location;
  PVector velocity;
  Level level;

  Bullet(Level level, PVector location, float heading) {
    this.level = level;
    this.location = location;
    velocity = PVector.fromAngle(heading);
    velocity.setMag(CHAR_HEIGHT);
    location.add(velocity);
    velocity.setMag(BULLET_SPEED);
  }

  void update() {
    PVector pi = location.copy();

    velocity.mult(dt);
    location.add(velocity);
    velocity.div(dt);

    boolean killed = false;
    PVector p = location.copy();
    Iterator<Character> cs = level.characters.iterator();
    while (cs.hasNext()) {
      Character c = cs.next();
      if (c.intersectedBy(pi, p)) {
        cs.remove();
        killed = true;
      }
    }
    if (level.player.intersectedBy(pi, p)) {
      GAME_OVER = true;
      killed = true;
    }
    if (killed)
      level.bullets.remove(this);
  }

  void display() {
    noStroke();
    ellipse(location.x, location.y, BULLET_SIZE, BULLET_SIZE);
  }
}