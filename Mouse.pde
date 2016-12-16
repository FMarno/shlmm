void mouseClicked() {
  if ((gameMode == Mode.GAME || gameMode == Mode.MAKER) && (PAUSE || GAME_OVER || GAME_WON))
    pauseMenu.press(new PVector(mouseX/scale, mouseY/scale));
  if (gameMode == Mode.MENU)
    menu.press(new PVector(mouseX, mouseY));
}