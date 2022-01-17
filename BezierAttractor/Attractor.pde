class Attractor {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  PVector acceleration;
  // The Attractor's maximum speed
  float topspeed;

  Attractor(float x, float y) {
    location = new PVector(x, y);
    velocity = new PVector(0, 0);
    topspeed = 5;
  }

  void AttractToMouse() 
  {
    PVector mouse = new PVector(mouseX, mouseY);
    AttractToPoint(mouse);
  }

  void AttractToPoint(PVector point) {

    PVector acceleration = PVector.sub(point, location);
    acceleration.setMag(0.2);

    velocity.add(acceleration);
    velocity.limit(topspeed);
    location.add(velocity);
  }

  void Stop()
  {
    velocity = new PVector(0, 0);
  }
  void Display() {
    stroke(255);
    strokeWeight(2);
    fill(127);
    ellipse(location.x, location.y, 15, 15);
  }
}
