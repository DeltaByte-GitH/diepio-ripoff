// =====================================================
// Diepio.pde
// =====================================================

ArrayList<Bullet> bullets = new ArrayList<Bullet>();

Player player;

boolean up, down, left, right;
boolean shooting = false;

void setup() {
  size(1000, 700);

  player = new Player(width / 2, height / 2);
}

void draw() {
  background(235);

  drawGrid();

  // -------------------------
  // Player
  // -------------------------

  player.update();
  player.display();

  // -------------------------
  // Bullets
  // -------------------------

  for (int i = bullets.size() - 1; i >= 0; i--) {
    Bullet b = bullets.get(i);

    b.update();
    b.display();

    if (b.dead()) {
      bullets.remove(i);
    }
  }

  drawUI();
}


// =====================================================
// Background
// =====================================================

void drawGrid() {
  stroke(215);
  strokeWeight(1);

  int gridSize = 40;

  for (int x = 0; x < width; x += gridSize) {
    line(x, 0, x, height);
  }

  for (int y = 0; y < height; y += gridSize) {
    line(0, y, width, y);
  }
}


// =====================================================
// UI
// =====================================================

void drawUI() {
  fill(40);

  textAlign(LEFT, TOP);
  textSize(18);

  fill(70);

  textSize(13);

  text(
    "WASD: Move   Mouse: Aim   Left Click: Shoot",
    15,
    height - 25
  );
}


// =====================================================
// Input
// =====================================================

void keyPressed() {
  if (key == 'w' || key == 'W') up = true;
  if (key == 's' || key == 'S') down = true;
  if (key == 'a' || key == 'A') left = true;
  if (key == 'd' || key == 'D') right = true;
}

void keyReleased() {
  if (key == 'w' || key == 'W') up = false;
  if (key == 's' || key == 'S') down = false;
  if (key == 'a' || key == 'A') left = false;
  if (key == 'd' || key == 'D') right = false;
}

void mousePressed() {
  if (mouseButton == LEFT) {
    shooting = true;
  }
}

void mouseReleased() {
  if (mouseButton == LEFT) {
    shooting = false;
  }
}


// =====================================================
// Bullet
// =====================================================

class Bullet {
  PVector pos;
  PVector velocity;

  float speed = 9;
  float radius = 7;

  int lifetime = 90;

  Bullet(float x, float y, PVector direction) {
    pos = new PVector(x, y);

    velocity = direction.copy();
    velocity.mult(speed);
  }

  void update() {
    pos.add(velocity);
    lifetime--;
  }

  void display() {
    fill(90);
    stroke(50);
    strokeWeight(2);

    ellipse(
      pos.x,
      pos.y,
      radius * 2,
      radius * 2
    );
  }

  boolean dead() {
    return (
      lifetime <= 0 ||
      pos.x < -20 ||
      pos.x > width + 20 ||
      pos.y < -20 ||
      pos.y > height + 20
    );
  }
}
