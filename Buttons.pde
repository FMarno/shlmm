void keyPressed() {
  switch (key) {
  case 'w':
    W = true;
    player.direction.y = -SPEED;
    break;
  case 'a':
    A = true;
    player.direction.x = -SPEED;
    break;
  case 's':
    S = true;
    player.direction.y = SPEED;
    break;
  case 'd':
    D = true;
    player.direction.x = SPEED;
    break;
  }
}

void keyReleased() {
  switch (key) {
  case 'w':
    W = false;
    if (S) {
      player.direction.y = SPEED;
    } else {
      player.direction.y = 0;
    }
    break;
  case 'a':
    A = false;
    if (D) {
      player.direction.x = SPEED;
    } else {
      player.direction.x = 0;
    }
    break;
  case 's':
    S = false;
    if (W) {
      player.direction.y = -SPEED;
    } else {
      player.direction.y = 0;
    }
    break;
  case 'd':
    D = false;
    if (A) {
      player.direction.x = -SPEED;
    } else {
      player.direction.x = 0;
    }
    break;
  case 'p':
    {
      pause = ! pause;
    }
  }
}