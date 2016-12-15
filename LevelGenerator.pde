class LevelGenerator {

  Level parseLevel(String filename) {
    Level level = new Level();
    //read level
    String lines[] = loadStrings(filename);
    String all = String.join("\n", lines);
    JSONObject json = new JSONObject(all);
    //walls
    int w = json.getInt("width");
    level.w = w;
    int h = json.getInt("height");
    level.h = h;
    boolean[][] filledSquares = new boolean[h][w]; 
    JSONArray walls = json.getJSONArray("walls");
    for (int i = 0; i < walls.length(); i++) {
      JSONArray wall = (JSONArray) walls.get(i);
      JSONArray start = (JSONArray) wall.get(0);
      JSONArray end = (JSONArray) wall.get(1);
      int x1 = (Integer)start.get(0);
      int y1 = (Integer)start.get(1);
      int x2 = (Integer)end.get(0);
      int y2 = (Integer)end.get(1);
      if (x1 >x2) {
        int t = x2;
        x2 = x1;
        x1 =t;
      }
      if (y1 >y2) {
        int t = y2;
        y2 = y1;
        y1 =t;
      }
      level.walls.add(new Wall(x1, y1, x2, y2));
      for (int b = y1; b<=y2; b++) {
        for (int a = x1; a<=x2; a++) {
          filledSquares[b][a] = true;
        }
      }
    }
    //border
    level.walls.add(new Wall(0, 0, 0, h-1));
    for (int i = 0; i<h; i++) {
      filledSquares[i][0] = true;
    }
    level.walls.add(new Wall(w-1, 0, w-1, h-1));
    for (int i = 0; i<h; i++) {
      filledSquares[i][w-1] = true;
    }
    level.walls.add(new Wall(1, 0, w-2, 0));
    for (int i = 1; i<w; i++) {
      filledSquares[0][i] = true;
    }
    level.walls.add(new Wall(1, h-1, w-2, h-1));
    for (int i = 1; i<w; i++) {
      filledSquares[h-1][i] = true;
    }

    for (int i = 0; i<filledSquares.length; i++) {
      for (int j = 0; j<filledSquares[0].length; j++) {
        if (!filledSquares[i][j]) {
          PositionNode node = new PositionNode(gridCoordsToPoint(j, i), level);
          node.location.x += SQUARE_SIZE/2;
          node.location.y += SQUARE_SIZE/2;
          level.nodes.add(node);
        }
      }
    }
    
    for (PositionNode n : level.nodes){
     n.findNeighbours(); 
    }

    //AI nodes
    //player
    JSONObject player = (JSONObject) json.get("player");
    JSONArray playerLocation = (JSONArray) player.get("location");
    Player p = new Player(level, gridCoordsToPoint((Integer)playerLocation.get(0), (Integer)playerLocation.get(1)), new PVector(0, 0), #ff00ff);
    p.location.x += SQUARE_SIZE/2;
    p.location.y += SQUARE_SIZE/2;
    level.player = p;
    String gun = player.optString("gun");
    switch(gun) {
    case "hand" : 
      p.giveGun(new HandGun(level, p.location, p)); 
      break;
    default:
      break;
    }
    //agents
    JSONArray agents = (JSONArray) json.get("agents");
    for (int i = 0; i<agents.length(); i++) {
      JSONObject agent = (JSONObject) agents.get(i);
      JSONArray agentL = (JSONArray) agent.get("location");
      gun = agent.optString("gun");
      Agent a = new Agent(level, gridCoordsToPoint((Integer)agentL.get(0), (Integer)agentL.get(1)), new PVector(0, 0), #ff0000);
      a.location.x += SQUARE_SIZE/2;
      a.location.y += SQUARE_SIZE/2;
      a.heading = -PI/2;
      switch(gun) {
      case "hand" : 
        a.giveGun(new HandGun(level, a.location, a)); 
        break;
      default:
        break;
      }
      level.agents.add(a);
    }
    //guns
    JSONArray guns = (JSONArray) json.get("guns");
    for (int i = 0; i<guns.length(); i++) {
      JSONObject g = (JSONObject) guns.get(i);
      JSONArray gloc = (JSONArray) g.get("location");
      PVector loc = gridCoordsToPoint((Integer)gloc.get(0), (Integer)gloc.get(1));
      loc.x += SQUARE_SIZE/2;
      loc.y += SQUARE_SIZE/2;
      String type = g.optString("type");
      Gun theGun;
      switch(type) {
      default :
        theGun = new HandGun(level, loc, null);
      }
      level.guns.add(theGun);
    }

    return level;
  }

  boolean writeLevel(String filename) {
    return false;
  }

  PVector gridCoordsToPoint(int i, int j) {
    float x = i * SQUARE_SIZE;
    float y = j * SQUARE_SIZE;
    return new PVector(x, y);
  }
}