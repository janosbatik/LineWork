class Attractor {

  // The Mover tracks location, velocity, and acceleration 
  PVector location;
  PVector velocity;
  // The Attractor's maximum speed
  float topspeed;

  boolean USE_FIXED_ACCELERATION = true;
  float fixedAccelMag = 0.2;

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

  void AttractToPoint(PVector point) 
  {
    PVector acceleration = PVector.sub(point, location);
    Accelerate(acceleration);
  }

  void RepelFromMouse() 
  {
    PVector mouse = new PVector(mouseX, mouseY);
    RepelFromPoint(mouse);
  }

  void RepelFromPoint(PVector point) 
  {
    PVector acceleration = PVector.sub(location, point);
    Accelerate(acceleration);
  }

  void Accelerate(PVector acceleration)
  {
    if (USE_FIXED_ACCELERATION)
      acceleration.setMag(fixedAccelMag);
    else {
      float mag = acceleration.mag() == 0 ? 0 : 1/float(ceil(acceleration.y));
      float mapMag = map(acceleration.y, -height, height, 0.2, 0.5);
      acceleration.setMag(mapMag);
    }

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
