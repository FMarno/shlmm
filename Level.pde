class Level {
  Character player;
  ArrayList<Agent> agents = new ArrayList<Agent>();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();
  ArrayList<Wall> walls = new ArrayList<Wall>();
  ArrayList<Gun> guns = new ArrayList<Gun>();


  void update() {

    for (Agent a : agents) {
      a.update();
    }
    player.update();
    for (int i = 0; i<bullets.size(); i++) {
      bullets.get(i).update();
    }
    for (Gun g : guns) {
      g.update();
    }
  }

  void display() {
    for (Wall w : walls) {
      w.display();
    }
    for (Agent a : agents) {
      a.display();
    }

    player.display();
    for (Bullet b : bullets) {
      b.display();
    }
    for (Gun g : guns) {
      g.display();
    }
  }

  boolean outOfBounds(PVector l) {
    return l.x > 0  && l.y > 0 && l.x < width && l.y < height;
  }
}