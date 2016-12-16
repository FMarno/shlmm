class Player extends Character {

  public Player(Level level, PVector location, PVector direction, int fill) {
    super(level, location, direction, fill);
  }



  void update() {
    heading = new PVector(mouseX/scale - location.x, mouseY/scale  - location.y).heading();

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

    boolean moved = false;

    if (!inWall(projection)) {
      location.add(velocity);
      moved = true;
    }

    if (!moved) {
      projection.x -= velocity.x;
      if (!inWall(projection)) {
        location.y += velocity.y;
        moved = true;
      }
    }

    if (!moved) {
      projection.x += velocity.x;
      projection.y -= velocity.y;
      if (!inWall(projection)) {
        location.x += velocity.x;
        moved = true;
      }
    }


    velocity.div(dt);
    velocity.mult(0.93);

    super.update();
  }

  void display() {
    if (gun != null && gun.ammo ==0) {
      stroke(#ff0000);
      strokeWeight(5);
      noFill();
      rect(width/2*(1/scale), height/2*(1/scale), 1040*(1/scale), 640*(1/scale));
    }
    super.display();
  }

  void giveGun(Gun gun) {
    if (this.gun == null) {
      this.gun = gun;
      this.gun.location =this.location;
      this.gun.velocity.setMag(0);
      this.gun.time_to_reload = 1;
      this.gun.owner = this;
    }
  }
}