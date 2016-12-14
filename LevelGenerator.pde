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
    //player
    JSONObject player = (JSONObject) json.get("player");
    JSONArray playerLocation = (JSONArray) player.get("location");
    Player p = new Player(level, gridCoordsToPoint(new Tuple((Integer)playerLocation.get(0), (Integer)playerLocation.get(1))), new PVector(0, 0));
    p.location.x += SQUARE_SIZE/2;
    p.location.y += SQUARE_SIZE/2;
    level.player = p;
    String gun = player.optString("gun");
    switch(gun) {
    case "hand" : 
      p.giveGun(new HandGun(level, p.location)); 
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
      Character a = new Character(level, gridCoordsToPoint(new Tuple((Integer)agentL.get(0), (Integer)agentL.get(1))), new PVector(0, 0));
      switch(gun) {
      case "hand" : 
        a.giveGun(new HandGun(level, a.location)); 
        break;
      default:
        break;
      }
      level.characters.add(a);
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