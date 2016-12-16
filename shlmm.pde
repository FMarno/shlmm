void setup() {
  //processing setup
  size(1040, 640);
  frameRate(FRAME_RATE);
  rectMode(CENTER);
  textAlign(CENTER);
  minim = new Minim(this);
  gameSong = minim.loadFile("game.mp3");
  menuSong = minim.loadFile("menu.mp3");

  pauseMenu = new Menu();
  pauseMenu.buttons.add(new HomeButton(new PVector(width/2, height/2 - 100)));

  MUTE=true;

  //level setup
  lg = new LevelGenerator();

  homeMenu();
}

void draw() {

  scale(scale, scale);

  switch(gameMode) {
  case GAME: 
    {
      if (PAUSE) {
        pauseMenu.display();
        return;
      }
      if (GAME_OVER) {
        fill(#ff0000);
        text("Game Over", width/2, height/2);
        pauseMenu.display();
        return;
      }

      background(#A99E81);
      level.update();
      level.display();
      text(dt, 50, 20);

      if (mousePressed)
        level.player.attack();

      if (GAME_WON) {
        fill(#00ff00);
        text("Success", width/2, height/2);
        pauseMenu.display();
      }

      return;
    }
  case MENU:
    {
      background(#A99E81);
      menu.display();
      return;
    }
  case MAKER :
    {
      if (PAUSE) {
        pauseMenu.display();
        return;
      }
      background(#A99E81);
      level.display();

      noFill();
      stroke(0);
      strokeWeight(1);
      Tuple mloc = pointToGridCoords(new PVector(mouseX, mouseY));
      PVector square = gridCoordsToPoint((int)mloc.x, (int)mloc.y);
      square.x += SQUARE_SIZE/2;
      square.y += SQUARE_SIZE/2;
      rect(square.x, square.y, SQUARE_SIZE, SQUARE_SIZE);
      return;
    }
  }
}

void startMaker() {
  level = new Level();
  level.w = (width/SQUARE_SIZE);
  level.h = (width/SQUARE_SIZE);
  scale = 1;
  gameMode = Mode.MAKER;
}

void startLevel(String filePath) {
  level = lg.parseLevel(filePath);

  float xscale = (width/SQUARE_SIZE)/(float)level.w;
  float yscale = (height/SQUARE_SIZE)/(float)level.h;
  scale = xscale < yscale ? xscale : yscale;
  gameMode = Mode.GAME;
  menuSong.pause();
  if (!MUTE) {
    gameSong.loop();
  }
}

void homeMenu() {
  gameSong.pause();
  gameMode = Mode.MENU;
  if (!MUTE) {
    menuSong.loop();
  }
  scale = 1;

  menu = new Menu();
  menu.buttons.add(new PlayButton());
  menu.buttons.add(new MakerButton());
}

void levelMenu() {
  gameSong.pause();
  gameMode = Mode.MENU;
  if (!MUTE) {
    menuSong.loop();
  }
  scale = 1;

  File dir = new File("../sketchbook/shlmm/levels"); //TODO
  File[] flist = dir.listFiles();
  Menu levels = new Menu();
  for (int i = 0; i<flist.length; i++) {
    File f = flist[i];
    levels.buttons.add(new LevelButton(f.getName(), new PVector(150 * ((i+1) %6) + 150, height/6 * (((i+1) / 6)+1))));
  }
  levels.buttons.add( new HomeButton(new PVector(150, height/6)));
  menu = levels;
  //TODO find levels
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
Tuple<Integer, Integer> pointToGridCoords(PVector location) {

  int x = floor(location.x/(SQUARE_SIZE/scale));
  int y = floor(location.y/(SQUARE_SIZE/scale));
  return new Tuple(x, y);
}