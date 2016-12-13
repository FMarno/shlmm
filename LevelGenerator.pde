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
    
    
    return level;
  }

  boolean writeLevel(String filename) {
    return false;
  }
}