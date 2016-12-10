class Level {
  Character player;
  ArrayList<Character> characters = new ArrayList<Character>();
  ArrayList<Bullet> bullets = new ArrayList<Bullet>();

  void update() {

    for (Character c : characters) {
      c.update();
    }
    player.update();
    for (int i = 0; i<bullets.size(); i++) {
      bullets.get(i).update();
    }
  }

  void display() {
    for (Character c : characters) {
      c.display(#ff0000);
    }
    player.display(#ff00ff);

    for (Bullet b : bullets) {
      b.display();
    }
  }
}