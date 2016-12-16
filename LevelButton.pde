class LevelButton extends Button {
  public LevelButton(String name, PVector location) {
    word = name;
    this.location = location;
    w = 100;
    h = 100;
    fill = 0;
  }

  void action() {
    startLevel("levels/" + word);
  }

  void display() {
    stroke(0);
    strokeWeight(1);
    fill(fill);
    rect(location.x, location.y, w, h);
    fill(255);
    text(word, location.x, location.y);
  }
}