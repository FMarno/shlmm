class MakerButton extends Button {
  public MakerButton() {
    word = "Level Maker";
    location = new PVector(width/2 + width/4, height/2);
    w = 100;
    h = 100;
    fill = 0;
  }

  void action() {
    startMaker();
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