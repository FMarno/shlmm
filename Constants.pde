int HEAD_SIZE = 15, CHAR_WIDTH = 40, CHAR_HEIGHT = 25, BULLET_SIZE = 5;
float SPEED = 3, ACC=SPEED/10, BULLET_SPEED = 50;
int SQUARE_SIZE = CHAR_WIDTH;

int FRAME_RATE = 60;

float dt = 1;
boolean W, A, S, D, PAUSE, GAME_OVER;
PVector unit = new PVector(10, 10);


import java.awt.geom.*;
import java.util.Iterator;
import org.json.JSONObject;
import org.json.JSONArray;