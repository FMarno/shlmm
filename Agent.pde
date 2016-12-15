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
    if (gun != null && !covered)
      shootPlayer();
    else if (gun == null && level.player.location.dist(location) < SAT_RADIUS)
      punchPlayer();
    else
      move(covered);

    super.update();
  }

  void shootPlayer() {
    PVector target = PVector.sub(level.player.location, location);    
    float orr = atan2(target.y, target.x);

    // Will take a frame extra at the PI boundary
    if (abs(orr - heading) <= ORIENTATION_INCREMENT) {
      heading = orr ;
      if (gun != null)
        attack();
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

  void punchPlayer() {
    PVector target = PVector.sub(level.player.location, location);    
    float orr = atan2(target.y, target.x);

    // Will take a frame extra at the PI boundary
    if (abs(orr - heading) <= ORIENTATION_INCREMENT) {
      heading = orr ;
      attack();
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

  void move(boolean covered) {
    if (!covered) {
      direction = PVector.sub(level.player.location, location);
    }
    float distance = direction.mag();


    if (covered) {
      PositionNode start = findNearestNode();

      if (start != null) {
        PositionNode next = start.pathToPlayer();
        if (next != null) {
          direction = next.location.copy().sub(location);
          distance = direction.mag();
        }
      }
    }
    if (distance < SAT_RADIUS) return;


    PVector acceleration = direction.copy();
    acceleration.setMag(ACC);
    velocity.add(acceleration);

    if (velocity.mag() > SPEED) {
      velocity.setMag(SPEED);
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
  }

  PositionNode findNearestNode() {
    ArrayList < PositionNode > nodes = level.nodes;
    if (nodes.isEmpty()) {
      return null;
    }
    PositionNode closest = nodes.get(0);
    float distance = location.dist(closest.location);
    for (PositionNode n : nodes) {
      float d = location.dist(n.location);
      if (d < distance) {
        distance = d;
        closest = n;
      }
    }

    return closest;
  }
}