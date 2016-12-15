class PositionNode {
  PVector location;
  Level level;
  ArrayList<PositionNode> neighbours = new ArrayList<PositionNode>();

  PositionNode(PVector location, Level level) {
    this.location = location;
    this.level = level;
  }

  void display() {
    fill(0);
    stroke(255);
    rect(location.x, location.y, 1, 1);
    for (PositionNode n : neighbours) {
      line(location.x, location.y, n.location.x, n.location.y);
    }
  }

  void findNeighbours() {
    for (PositionNode n : level.nodes) {
      if (n != this && location.dist(n.location) <= SQUARE_SIZE) { //*sqrt(2)) {
        neighbours.add(n);
      }
    }
  }

  //a* search to player
  //returns the next node to travel to
  PositionNode pathToPlayer() {
    ArrayList < PositionNode > searched = new ArrayList < PositionNode > ();
    ConcurrentSkipListMap < Float, PositionNode > toSearch = new ConcurrentSkipListMap();
    ConcurrentSkipListMap < Float, PositionNode > fScore = new ConcurrentSkipListMap(); // fscore, node
    HashMap < PositionNode, Float > gScore = new HashMap(); // gScore, node
    HashMap < PositionNode, PositionNode > cameFrom = new HashMap();
    gScore.put(this, 0f);
    fScore.put(estWeight(), this);
    toSearch.put(estWeight(), this);

    while (!toSearch.isEmpty()) {
      Float k = toSearch.firstKey();
      PositionNode current = toSearch.get(k);
      if (current.location.dist(level.player.location) < 15) {
        return cameFrom(current, cameFrom);
      }

      toSearch.remove(k, current);
      searched.add(current);
      float currentGScore = gScore.get(current);
      for (PositionNode neighbour : current.neighbours) {
        if (searched.contains(neighbour)) continue;
        float tentative_gScore = currentGScore + current.location.dist(neighbour.location);
        if (!toSearch.containsValue(neighbour)) {
          toSearch.put(tentative_gScore + neighbour.estWeight(), neighbour);
        } else if (tentative_gScore >= gScore.get(neighbour)) {
          continue;
        }
        //this is the new best path
        cameFrom.put(neighbour, current);
        gScore.put(neighbour, tentative_gScore);
      }
    }
    return null;
  }

  PositionNode cameFrom(PositionNode end, HashMap < PositionNode, PositionNode > cameFrom) {
    PositionNode current = end, previous = cameFrom.get(end);
    while (cameFrom.containsKey(previous)) {
      current = previous;
      previous = cameFrom.get(current);
    }
    return current;
  }

  float estWeight() {
    return location.dist(level.player.location);
  }
}