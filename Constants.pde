int HEAD_SIZE = 15, CHAR_WIDTH = 40, CHAR_HEIGHT = 25, BULLET_SIZE = 5;
float SPEED = 3, ACC=SPEED/10, BULLET_SPEED = 20;
int SQUARE_SIZE = CHAR_WIDTH;

int FRAME_RATE = 60;

float dt;
boolean W, A, S, D, pause;
PVector unit = new PVector(10, 10);

Player player;

ArrayList<Bullet> bullets = new ArrayList<Bullet>();