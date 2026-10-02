// =====================================================
// Player.pde
// =====================================================

class Player {

  PVector pos;

  // -------------------------
  // Basic stats
  // -------------------------

  float radius = 24;

  float speed = 4;

  float bulletSpeed = 9;

  int fireCooldown = 12;

  // -------------------------
  // Runtime
  // -------------------------

  int cooldown = 0;


  Player(float x, float y) {
    pos = new PVector(x, y);
  }


  // ===================================================
  // Update
  // ===================================================

  void update() {

    PVector movement = new PVector(0, 0);

    if (up) {
      movement.y -= 1;
    }

    if (down) {
      movement.y += 1;
    }

    if (left) {
      movement.x -= 1;
    }

    if (right) {
      movement.x += 1;
    }


    // Normalize diagonal movement

    if (movement.mag() > 0) {

      movement.normalize();

      movement.mult(speed);

      pos.add(movement);
    }


    // Keep player inside screen

    pos.x = constrain(
      pos.x,
      radius,
      width - radius
    );

    pos.y = constrain(
      pos.y,
      radius,
      height - radius
    );


    // Shooting cooldown

    if (cooldown > 0) {
      cooldown--;
    }


    if (shooting && cooldown <= 0) {

      shoot();

      cooldown = fireCooldown;
    }
  }


  // ===================================================
  // Shooting
  // ===================================================

  void shoot() {

    PVector direction = new PVector(
      mouseX - pos.x,
      mouseY - pos.y
    );

    if (direction.mag() == 0) {
      return;
    }

    direction.normalize();


    PVector bulletPos = PVector.add(
      pos,
      PVector.mult(direction, 30)
    );


    bullets.add(
      new Bullet(
        bulletPos.x,
        bulletPos.y,
        direction
      )
    );
  }


  // ===================================================
  // Display
  // ===================================================

  void display() {

    pushMatrix();

    translate(
      pos.x,
      pos.y
    );


    // -------------------------
    // Barrel
    // -------------------------

    float angle = atan2(
      mouseY - pos.y,
      mouseX - pos.x
    );

    pushMatrix();

    rotate(angle);

    rectMode(CENTER);

    fill(110);

    stroke(70);
    strokeWeight(3);

    rect(
      22,
      0,
      48,
      16
    );

    popMatrix();


    // -------------------------
    // Tank body
    // -------------------------

    fill(80, 170, 220);

    stroke(50);
    strokeWeight(3);

    ellipse(
      0,
      0,
      radius * 2,
      radius * 2
    );


    // Inner circle

    fill(100, 190, 235);

    noStroke();

    ellipse(
      0,
      0,
      radius * 1.25,
      radius * 1.25
    );


    popMatrix();
  }
}
