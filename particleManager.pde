// generates and holds the particles

class ParticleManager{
  int numParticles = 4000;
  float magnitude = 3;       // How strong the Perlin vector field is
  float noiseSize = 0.01; // Higher value -> faster spatial change
  float timeDelta = 0.01; // Higher value -> faster temporal change  
  // noiseOffset = whatever the Z coordinate passed to noise(...) is
  // to give us a sort-of distinct 2D space of noise
  float noiseOffset = 5000;  
  // How far off the screen it can go before being dead
  int borders= 50;
  Particle[] particles;

  //float delta;
  float cx = 1, cy=1;
  // Effect of passage of time (0 = static field)
  float t = 0;
   
  ParticleManager() {
    particles = new Particle[numParticles];
    setNoiseSize(noiseSize, noiseSize);
    generateDeploymentPoint();
    t = 0;
  }
   
   
  void setNoiseSize(float cx, float cy) {
    this.cx = cx;
    this.cy = cy;
  }
   

   
  // Generate a row of particles, evenly spaced, at the bottom of the view.
  void generateDeploymentPoint() {
    int count = particles.length;
    println(count);
    for(int i = 0; i < count; ++i) {
      PVector pos = new PVector(width/2, height/2);//new PVector(width*i/count, height);
      PVector vel = new PVector(width/2,i/count);
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
        PVector newPos = new PVector(random(0,width), height);// new PVector(width/2, height/2);//
        particles[i] = new Particle(newPos, vel);
      }
    }
  }
}

