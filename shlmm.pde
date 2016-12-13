PVector point;
Level level;
void setup() {
  size(1040, 640);
  frameRate(FRAME_RATE);
  rectMode(CENTER);
  LevelGenerator lg = new LevelGenerator();
  
  level = lg.parseLevel("levels/level1.json");
  
  /*Player player = new Player(level, new PVector(200, 200), new PVector(0, 0));
  level.player = player;*/
  
  /*level.bullets.add(new Bullet(level, new PVector(900, 200), PI));
  level.walls.add(new Wall(0,0, 0, 12));
  level.walls.add(new Wall(0,12, 15,12));
  player.giveGun(new HandGun(level, player.location));*/
}

void draw() {
  if (PAUSE) return;
  if (GAME_OVER){
   //background(0);
   fill(#ff0000);
   text("Game Over", width/2, height/2);
   return;
  }
  background(255);
  level.update();
  level.display();
  text(dt, 50, 20);

  //if (mousePressed) level.player.fireGun();
}