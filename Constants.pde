final int HEAD_SIZE = 15, CHAR_WIDTH = 40, CHAR_HEIGHT = 25, BULLET_SIZE = 5;
final float SPEED = 3, ACC=SPEED/10, BULLET_SPEED = 15;
final int SQUARE_SIZE = CHAR_WIDTH;

final float ORIENTATION_INCREMENT = PI/32;
float scale = 1;
final float SAT_RADIUS = SQUARE_SIZE*(3/2);


final int FRAME_RATE = 60;

float dt = 1;
boolean W, A, S, D, PAUSE, GAME_OVER, GAME_WON, MUTE;
LevelGenerator lg;
Level level;
Menu menu;
Menu pauseMenu;
String notification;
Mode gameMode = Mode.MENU;
MakerMode makerMode = MakerMode.WALL;
PVector start, end;

import java.awt.geom.*;
import java.util.Iterator;
import java.util.concurrent.ConcurrentSkipListMap;

import org.json.JSONObject;
import org.json.JSONArray;
import ddf.minim.*;
Minim minim;
AudioPlayer gameSong;
AudioPlayer menuSong;


enum Mode {
  GAME, MENU, MAKER
}

public enum MakerMode {
  WALL ("Wall"), PLAYER("Player"), AGENT("Agent"), GUN("Gun"), GUNAGENT("Agent with Gun"), DELETE ("Delete"), SAVE("save");

  final String name;

  private MakerMode(String name) {
    this.name = name;
  }
}