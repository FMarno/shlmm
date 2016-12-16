void mouseClicked() {
  if ((gameMode == Mode.GAME || gameMode == Mode.MAKER) && (PAUSE || GAME_OVER || GAME_WON)) {
    pauseMenu.press(new PVector(mouseX/scale, mouseY/scale));
    return;
  }
  if (gameMode == Mode.MENU) {
    menu.press(new PVector(mouseX, mouseY));
    return;
  }
  // implementation of maker delete
  if (gameMode == Mode.MAKER && !PAUSE && makerMode == MakerMode.DELETE) {
    PVector point = new PVector(mouseX/scale, mouseY/scale);
    Iterator<Agent> as = level.agents.iterator();
    while (as.hasNext()) {
      Agent smith = as.next();
      if (smith.contains(point)) {
        as.remove();
      }
    }
    Iterator<Wall> ws = level.walls.iterator();
    //dont allow the removal of barrier
    ws.next(); 
    ws.next(); 
    ws.next(); 
    ws.next();
    while (ws.hasNext()) {
      Wall w = ws.next();
      if (w.contains(point)) {
        ws.remove();
      }
    }
    Iterator<Gun> gs = level.guns.iterator();
    while (gs.hasNext()) {
      Gun g = gs.next();
      if (g.contains(point)) {
        gs.remove();
      }
    }

    if (level.player != null && level.player.contains(point)) {
      level.player = null;
    }
  }
}

void mousePressed() {
  if (gameMode == Mode.MAKER && !PAUSE) {
    start = new PVector(mouseX/scale, mouseY/scale);
  }
}

void mouseReleased() {
  if (gameMode == Mode.MAKER && !PAUSE) {
    end = new PVector(mouseX/scale, mouseY/scale); 
    Tuple<Integer, Integer> s = pointToGridCoords(start); 
    Tuple<Integer, Integer> e = pointToGridCoords(end); 
    switch(makerMode) {
    case WALL : 
      {
        level.walls.add(new Wall(s.x, s.y, e.x, e.y));
        break;
      }
    case PLAYER : 
      {
        if (level.player == null) {
          PVector l = gridCoordsToPoint(s.x, s.y);
          l.add(new PVector(SQUARE_SIZE/2, SQUARE_SIZE/2));
          Player p = new Player(level, l, PVector.sub(end, start), #ff00ff);
          p.heading = p.direction.heading();
          level.player = p;
        }
        break;
      }
    case AGENT : 
      {
        PVector l = gridCoordsToPoint(s.x, s.y);
        l.add(new PVector(SQUARE_SIZE/2, SQUARE_SIZE/2));
        Agent a = new Agent(level, l, PVector.sub(end, start), #ff0000);
        a.heading = a.direction.heading();
        level.agents.add(a);
        break;
      }
    case GUN : 
      {
        Gun g = new HandGun(level, end, null);
        level.guns.add(g);
        break;
      }
    case GUNAGENT : 
      {
        PVector l = gridCoordsToPoint(s.x, s.y);
        l.add(new PVector(SQUARE_SIZE/2, SQUARE_SIZE/2));
        Agent a = new Agent(level, l, PVector.sub(end, start), #ff0000);
        a.heading = a.direction.heading();
        level.agents.add(a);
        a.giveGun(new HandGun(level, a.location, a));
        break;
      }
    default : 
      {
        return;
      }
    }
  }
}