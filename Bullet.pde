class Bullet {
  PVector location;
  PVector velocity;

  Bullet(PVector location, float heading) {
    this.location = location;
    velocity = PVector.fromAngle(heading);
    velocity.mult(BULLET_SPEED);
  }

  void update() {
    velocity.mult(dt);
    location.add(velocity);
    velocity.div(dt);
  }

  void display() {
    ellipse(location.x, location.y, BULLET_SIZE, BULLET_SIZE);
  }
}