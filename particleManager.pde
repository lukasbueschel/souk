// generates and holds the particles

class ParticleManager{
  
 
  Particle[] particles;
  // noiseOffset = whatever the Z coordinate passed to noise(...) is
  // to give us a sort-of distinct 2D space of noise
  float noiseOffset;
  //float delta;
  float cx, cy;
  // How far off the screen it can go before being dead
  int borders;
  // Magnitude of the noise
  float magnitude;
  // Effect of passage of time (0 = static field)
  float timeDelta;
  float t;
   
  ParticleManager(int count, float magn) {
    particles = new Particle[count];
    noiseOffset = 5000;
    borders = 50;
    magnitude = magn;
    timeDelta = 0;
    cx = 1;
    cy = 1;
    t = 0;
  }
   
  ParticleManager(ParticleManager toCopy) {
    // Note that we don't copy the particles; it's expected that
    // you'll generate your own.
    particles = new Particle[toCopy.particles.length];
    noiseOffset = toCopy.noiseOffset;
    cx = toCopy.cx;
    cy = toCopy.cy;
    borders = toCopy.borders;
    magnitude = toCopy.magnitude;
    timeDelta = toCopy.timeDelta;
    t = toCopy.t;
  }
   
  void setNoiseSize(float cx, float cy) {
    this.cx = cx;
    this.cy = cy;
  }
   
  void setTimeDelta(float d) {
    timeDelta = d;
  }
   
  void setBorders(int b) {
    borders = b;
  }
   
  // Generate a row of particles, evenly spaced, at the bottom of the view.
  void generateBottom() {
    int count = particles.length;
    for(int i = 0; i < count; ++i) {
      PVector pos = new PVector(width*i/count, height);
      PVector vel = new PVector(0,0);
      particles[i] = new Particle(pos, vel);
    }
  }
   
  void updatePositions() {
    updatePositions(null);
  }
   
  // Pass any extra forces as an argument
  void updatePositions(PVector otherForce) {
    PVector[] forces = new PVector[2];
    forces[1] = otherForce;
    if (otherForce==null) forces[1] = new PVector(0,0);
    for(int i = 0; i < particles.length; ++i) {
      PVector pos = particles[i].position;
      // The force is derived from the Perlin noise, which we
      // generate as a 2D vector by choosing from two regions that
      // are suitably far away.
      // Since noise(...) is in [0,1] it needs some biasing.
      float fx = magnitude*(noise(cx*pos.x, cy*pos.y, t) - 0.47);
      float fy = magnitude*(noise(cx*pos.x, cy*pos.y, t + noiseOffset) - 0.48);
      forces[0] = new PVector(fx, fy);
      particles[i].perturb(forces);
    }
    t += timeDelta;
  }
   
  void drawLines() {
    //surface.beginDraw();
    //surface.background(0);
    for(int i = 0; i < particles.length; ++i) {
      PVector old = particles[i].oldPosition;
      PVector now = particles[i].position;
      stroke(particles[i].h, 127, 255);
      line(old.x, old.y, now.x, now.y);
    }   
    //surface.endDraw();
  }
   
  void resurrectOutliers() {
    int x0 = -borders;
    int y0 = -borders;
    int x1 = width + borders;
    int y1 = height + borders;
    for(int i = 0; i < particles.length; ++i) {
      PVector pos = particles[i].position;
      if (pos.x < x0 || pos.x > x1 || pos.y < y0 || pos.y > y1) {
        PVector vel = new PVector(0,0);
        PVector newPos = new PVector(random(0,width), height);
        particles[i] = new Particle(newPos, vel);
      }
    }
  }
}

