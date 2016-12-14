class Level {
  Character player;
  ArrayList<Agent> agents = new ArrayList<Agent>();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<Wall> walls = new ArrayList<Wall>();


  void update() {

    for (Agent a : agents) {
      a.update();
    }
    player.update();
    for (int i = 0; i<bullets.size(); i++) {
      bullets.get(i).update();
    }
  }

  void display() {
    for (Wall w : walls){
     w.display(); 
    }
    for (Agent a : agents) {
      a.display(#ff0000);
    }

    player.display(#ff00ff);
    for (Bullet b : bullets) {
      b.display();
    }

  }

  boolean outOfBounds(PVector l) {
    return l.x > 0  && l.y > 0 && l.x < width && l.y < height;
  }

}