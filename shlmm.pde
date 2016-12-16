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
      for (Agent a : level.agents) {
        if (a.gun != null) {
          fill(255);
          text("G", a.location.x, a.location.y);
        }
      }

      if (mousePressed) {
        displayPotential();
      }
      PVector m = new PVector(mouseX/scale, mouseY/scale);
      noFill();
      stroke(0);
      strokeWeight(1);
      Tuple mloc = pointToGridCoords(m);
      PVector square = gridCoordsToPoint((int)mloc.x, (int)mloc.y);
      square.x += SQUARE_SIZE/2;
      square.y += SQUARE_SIZE/2;
      rect(square.x, square.y, SQUARE_SIZE, SQUARE_SIZE);
      // display mode
      scale(1/scale, 1/scale);
      fill(#ff0000);
      String mode = makerMode.name;
      text("mode: " + mode, width/2, 50);

      if (notification != null) {
        fill(255);
        rect(width/2, 200, 400, 100);
        fill(0);
        text(notification, width/2, 200);
        nCounter--;
        if (nCounter == 0) {
          notification = null;
        }
      }

      if (makerMode == MakerMode.SAVE && level.player != null) {
        fill(255);
        rect(width/2, 200, 400, 300);
        fill(0);
        text("Enter level name NB duplicate names will overwrite", width/2, 100);
        text(levelName, width/2, 200);
        text("enter to continue, esp to cancel", width/2, 300);
      }
    }
  }
}

PVector gridCoordsToPoint(int i, int j) {
  float x = i * SQUARE_SIZE;
  float y = j * SQUARE_SIZE;
  return new PVector(x, y);
}

Tuple<Integer, Integer> pointToGridCoords(PVector location) {

  int x = floor(location.x/(SQUARE_SIZE));
  int y = floor(location.y/(SQUARE_SIZE));
  return new Tuple(x, y);
}

void startMaker() {
  level = new Level();
  level.w = (width/SQUARE_SIZE);
  level.h = (height/SQUARE_SIZE);

  scale = 1;
  gameMode = Mode.MAKER;
  int w = level.w;
  int h = level.h;
  level.walls.add(0, new Wall(0, 0, 0, h-1));
  level.walls.add(1, new Wall(w-1, 0, w-1, h-1));
  level.walls.add(2, new Wall(1, 0, w-2, 0));
  level.walls.add(3, new Wall(1, h-1, w-2, h-1));
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

  File dir = new File(dataPath("levels"));
  File[] flist = dir.listFiles();
  Menu levels = new Menu();
  for (int i = 0; i<flist.length; i++) {
    File f = flist[i];
    levels.buttons.add(new LevelButton(f.getName(), new PVector(150 * ((i+1) %6) + 150, height/6 * (((i+1) / 6)+1))));
  }
  levels.buttons.add( new HomeButton(new PVector(150, height/6)));
  menu = levels;
}


void restart() {
  level = lg.parseLevel(playing);
  GAME_OVER = false;
}

void resizeLevel() {
  float xscale = (width/SQUARE_SIZE)/(float)level.w;
  float yscale = (height/SQUARE_SIZE)/(float)level.h;
  scale = xscale < yscale ? xscale : yscale;
  println(scale);
  int w = level.w;
  int h = level.h;
  level.walls.set(0, new Wall(0, 0, 0, h-1));
  level.walls.set(1, new Wall(w-1, 0, w-1, h-1));
  level.walls.set(2, new Wall(1, 0, w-2, 0));
  level.walls.set(3, new Wall(1, h-1, w-2, h-1));
}

void displayPotential() {
  PVector current = new PVector(mouseX/scale, mouseY/scale);
  Tuple<Integer, Integer> s = pointToGridCoords(start);
  Tuple<Integer, Integer> e = pointToGridCoords(current);
  switch(makerMode) {
  case WALL : 
    {
      Wall w = new Wall(s.x, s.y, e.x, e.y);
      w.display();
      break;
    }
  case PLAYER :
    {
      PVector l = gridCoordsToPoint(s.x, s.y);
      l.add(new PVector(SQUARE_SIZE/2, SQUARE_SIZE/2));
      Player p = new Player(level, l, PVector.sub(current, start), #ff00ff);
      p.heading = p.direction.heading();
      p.display();
      break;
    }
  case AGENT : 
    {
      PVector l = gridCoordsToPoint(s.x, s.y);
      l.add(new PVector(SQUARE_SIZE/2, SQUARE_SIZE/2));
      Agent a = new Agent(level, l, PVector.sub(current, start), #ff0000);
      a.heading = a.direction.heading();
      a.display();
      break;
    }
  case GUN : 
    {
      Gun g = new HandGun(level, current, null);
      g.display();
      break;
    }
  case GUNAGENT : 
    {
      PVector l = gridCoordsToPoint(s.x, s.y);
      l.add(new PVector(SQUARE_SIZE/2, SQUARE_SIZE/2));
      Agent a = new Agent(level, l, PVector.sub(current, start), #ff0000);
      a.heading = a.direction.heading();
      a.display();
      fill(255);
      text("G", a.location.x, a.location.y);
      break;
    }
  default :
    {
      return;
    }
  }
}