void keyPressed() {
  if (key == 'm') {
    if (MUTE) {
      if (gameMode == Mode.GAME) {
        gameSong.loop();
      } else {
        menuSong.loop();
      }
      MUTE = false;
    } else {
      gameSong.pause();
      menuSong.pause();
      MUTE = true;
    }
  }
  if (gameMode == Mode.MENU) {
    return;
  } else if (gameMode == Mode.GAME) {
    switch (key) {
    case 'w':
      W = true;
      level.player.direction.y = -SPEED;
      break;
    case 'a':
      A = true;
      level.player.direction.x = -SPEED;
      break;
    case 's':
      S = true;
      level.player.direction.y = SPEED;
      break;
    case 'd':
      D = true;
      level.player.direction.x = SPEED;
      break;
    case 'r':
      //if (GAME_OVER)
      restart(); 
      break;
    case ' ':
      level.player.dropGun();
      break;
    }
  } else if (gameMode == Mode.MAKER) {
    switch (key) {
    case 'w': 
      {
        makerMode = MakerMode.WALL;
        break;
      }
    case 'q' : 
      {
        makerMode = MakerMode.PLAYER;
        break;
      }
    case 'e' : 
      {
        makerMode = MakerMode.AGENT;
        break;
      }
    case 'r': 
      {
        makerMode = MakerMode.GUN;
        break;
      }
    case 't':
      {
        makerMode = MakerMode.GUNAGENT;
        break;
      }
    case 'd' :
      {
        makerMode = MakerMode.DELETE;
        break;
      }
    case 's': 
      {
        if (level.player != null) {
          makerMode = MakerMode.SAVE;
        } else {
          notification = "A level requires a player!";
        }
        break;
      }
    case CODED: 
      {
        switch (keyCode) {
        case UP: 
          {
            if (level.h > height/SQUARE_SIZE) {
              level.h--;
              resizeLevel();
            }
            break;
          }
        case DOWN:
          { 
            if (level.h <33) {
              level.h++;
              resizeLevel();
            }
            break;
          }
        case LEFT:
          {
            if (level.w > width/SQUARE_SIZE) {
              level.w--;
              resizeLevel();
            }
            break;
          }
        case RIGHT:
          { 
            if (level.w <41) {
              level.w++;
              resizeLevel();
            }
            break;
          }
        }
      }
    }
  }
}

void keyReleased() {
  if (gameMode == Mode.MAKER) {
    if (key == 'p') {
      PAUSE = ! PAUSE;
    }
  }
  if (gameMode != Mode.GAME) return;
  switch (key) {
  case 'w':
    W = false;
    if (S) {
      level.player.direction.y = SPEED;
    } else {
      level.player.direction.y = 0;
    }
    break;
  case 'a':
    A = false;
    if (D) {
      level.player.direction.x = SPEED;
    } else {
      level.player.direction.x = 0;
    }
    break;
  case 's':
    S = false;
    if (W) {
      level.player.direction.y = -SPEED;
    } else {
      level.player.direction.y = 0;
    }
    break;
  case 'd':
    D = false;
    if (A) {
      level.player.direction.x = -SPEED;
    } else {
      level.player.direction.x = 0;
    }
    break;
  case 'p':
    {
      PAUSE = ! PAUSE;
    }
  }
}