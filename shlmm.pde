void setup() {
  size(1024, 632);
  rectMode(CENTER);
  player = new Player(new PVector(200, 200), new PVector(0, 0), null);
  dt =1;
  player.giveGun(new HandGun(player.location));
}

void draw() {
  if (pause) return;
  background(255);
  player.heading = new PVector(mouseX - player.location.x, mouseY - player.location.y).heading();
  player.display(#ff00ff);
  player.update();
  text(dt, 50, 20);
  text(player.gun.time_to_reload, 100, 20);

  for (Bullet b : bullets) {
    b.update();
    b.display();
  }

  if (mousePressed) player.fireGun();
}