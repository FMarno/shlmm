class HomeButton extends Button {
  public HomeButton(PVector location) {
    word = "home";
    this.location = location;
    w = 100;
    h = 100;
    fill = 0;
  }

  void action() {
    homeMenu();
    PAUSE = false;
    GAME_OVER = false;
    GAME_WON = false;
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