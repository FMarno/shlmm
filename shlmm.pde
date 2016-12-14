

PVector point;
Level level;
void setup() {
  //processing setup
  size(1040, 640);
  frameRate(FRAME_RATE);
  rectMode(CENTER);
  minim = new Minim(this);
  song = minim.loadFile("game.mp3");
  //song.loop(); TODO put this back

  //level setup
  lg = new LevelGenerator();
  level = lg.parseLevel("levels/level1.json");
}

void draw() {
  if (PAUSE) return;
  if (GAME_OVER) {
    //background(0);
    fill(#ff0000);
    text("Game Over", width/2, height/2);
    return;
  }
  background(#A99E81);
  level.update();
  level.display();
  text(dt, 50, 20);

  if (mousePressed) level.player.fireGun();
}

void restart() {
  level = lg.parseLevel("levels/level1.json");
  GAME_OVER = false;
}