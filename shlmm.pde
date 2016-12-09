Character player;

void setup() {
  size(1024, 632);
  rectMode(CENTER);
  player = new Character(new PVector(200, 200), new PVector(0, 0), null);
  dt =1;
}

void draw() {
  if (pause) return;
  background(255);
  player.heading = atan2(mouseX - player.location.x, mouseY - player.location.y);
  player.display(#ff00ff);
  player.update();
  text(dt, 50, 20);
}