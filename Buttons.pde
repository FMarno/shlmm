void keyPressed() {
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
  }
}

void keyReleased() {
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