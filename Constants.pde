final int HEAD_SIZE = 15, CHAR_WIDTH = 40, CHAR_HEIGHT = 25, BULLET_SIZE = 5;
final float SPEED = 3, ACC=SPEED/10, BULLET_SPEED = 20;
final int SQUARE_SIZE = CHAR_WIDTH;

final float ORIENTATION_INCREMENT = PI/32;

final int FRAME_RATE = 60;

float dt = 1;
boolean W, A, S, D, PAUSE, GAME_OVER;
PVector unit = new PVector(1, 1);
LevelGenerator lg;


import java.awt.geom.*;
import java.util.Iterator;
import org.json.JSONObject;
import org.json.JSONArray;
import ddf.minim.*;
Minim minim;
AudioPlayer song;