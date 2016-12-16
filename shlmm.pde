PVector mouse;
void setup() {
  //processing setup
  size(1040, 640);
  frameRate(FRAME_RATE);
  rectMode(CENTER);
  minim = new Minim(this);
  gameSong = minim.loadFile("game.mp3");
  //song.loop();// TODO put this back


  //level setup
  lg = new LevelGenerator();
  level = lg.parseLevel("levels/level1.json");

  float xscale = (width/(SQUARE_SIZE))/(float)level.w;
  float yscale = (height/SQUARE_SIZE)/(float)level.h;
  scale = xscale < yscale ? xscale : yscale;
  lg.writeLevel(level, "levels/test.json");
}

void draw() {

  scale(scale, scale);

  if (PAUSE) return;
  if (GAME_OVER) {
    fill(#ff0000);
    text("Game Over", width/2, height/2);
    return;
  }
  background(#A99E81);
  level.update();
  level.display();
  text(dt, 50, 20);

  if (mousePressed)
    level.player.attack();
}

void restart() {
  level = lg.parseLevel("levels/level1.json");
  GAME_OVER = false;
}

PVector gridCoordsToPoint(int i, int j) {
  float x = i * SQUARE_SIZE;
  float y = j * SQUARE_SIZE;
  return new PVector(x, y);
}
Tuple<Integer, Integer> pointToGridCoords(PVector location) { //TODO broken

  int x = floor(location.x/(SQUARE_SIZE/scale));
  int y = floor(location.y/(SQUARE_SIZE/scale));
  return new Tuple(x, y);
}