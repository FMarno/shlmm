final int HEAD_SIZE = 15, CHAR_WIDTH = 40, CHAR_HEIGHT = 25, BULLET_SIZE = 5;
final float SPEED = 3, ACC=SPEED/10, BULLET_SPEED = 15;
final int SQUARE_SIZE = CHAR_WIDTH;

final float ORIENTATION_INCREMENT = PI/32;
float scale;
final float SAT_RADIUS = SQUARE_SIZE*(3/2);


final int FRAME_RATE = 60;

float dt = 1;
boolean W, A, S, D, PAUSE, GAME_OVER;
LevelGenerator lg;
Level level;


import java.awt.geom.*;
import java.util.Iterator;
import java.util.concurrent.ConcurrentSkipListMap;

import org.json.JSONObject;
import org.json.JSONArray;
import ddf.minim.*;
import java.io.FileWriter;
Minim minim;
AudioPlayer gameSong;

enum Mode {
  GAME, MENU, MAKER
}