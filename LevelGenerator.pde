class LevelGenerator {

  Level parseLevel(String filename) {
    Level level = new Level();
    //read level
    String lines[] = loadStrings(filename);
    String all = String.join("\n", lines);
    JSONObject json = new JSONObject(all);
    //walls
    JSONArray walls = json.getJSONArray("walls");
    for (int i = 0; i < walls.length(); i++) {
      JSONArray wall = (JSONArray) walls.get(i);
      JSONArray start = (JSONArray) wall.get(0);
      JSONArray end = (JSONArray) wall.get(1);
      level.walls.add(new Wall((Integer)start.get(0), (Integer)start.get(1), (Integer)end.get(0), (Integer)end.get(1)));
    }
    //border
    int w = json.getInt("width");
    int h = json.getInt("height");
    level.walls.add(new Wall(-1, -1, -1, h));
    level.walls.add(new Wall(w, -1, w, h));
    level.walls.add(new Wall(0, -1, w-1, -1));
    level.walls.add(new Wall(0, h, w-1, h));
    //player
    JSONObject player = (JSONObject) json.get("player");
    JSONArray playerLocation = (JSONArray) player.get("location");
    Player p = new Player(level, gridCoordsToPoint(new Tuple((Integer)playerLocation.get(0), (Integer)playerLocation.get(1))), new PVector(0, 0), #ff00ff);
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
      Agent a = new Agent(level, gridCoordsToPoint(new Tuple((Integer)agentL.get(0), (Integer)agentL.get(1))), new PVector(0, 0), #ff0000);
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
      PVector loc = gridCoordsToPoint(new Tuple((Integer)gloc.get(0), (Integer)gloc.get(1)));
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

  PVector gridCoordsToPoint(Tuple<Integer, Integer> coords) {
    float x = coords.x * SQUARE_SIZE;
    float y = coords.y * SQUARE_SIZE;
    return new PVector(x, y);
  }
}