// generates and holds the particles

class ParticleManager{
  int numParticles = 1000;
  float magnitude = 3;    // How strong the Perlin vector field is
  float timeDelta = 0.01; // Higher value -> faster temporal change  
  // noiseOffset = whatever the Z coordinate passed to noise(...) is
  // How far off the screen it can go before being dead
  Particle[] particles;
  PVector deploymentPoint;

  //float delta;
  float cx = 1, cy=1;
  // Effect of passage of time (0 = static field)
  float t = 0;
   
  ParticleManager() {
    deploymentPoint = new PVector((int)(width/2), (int)(height/2));
    particles = new Particle[numParticles];
    deploy();
    t = 0;
  }
      
  void deploy() {
    int count = particles.length;
    println(count);
    for(int i = 0; i < count; ++i) {
      PVector pos = new PVector(width/2, height/2);//new PVector(width*i/count, height);
      //PVector vel = new PVector((int)(Math.random()*100-50),(int)(Math.random()*100-50));
      particles[i] = new Particle(pos, Math.random(), Math.random()); 
    }
  }
   

   
  // Pass any extra forces as an argument
  void updatePositions() {
    for(int i = 0; i < particles.length; ++i) {
      PVector[] forces = new PVector[2];
      forces[0] = new PVector((int)Math.random(), (int)Math.random()*100);
      forces[1] = new PVector((int)Math.random(), (int)Math.random());
      particles[i].perturb(forces);
    }
    
    t += timeDelta;
  }
   
  void drawLines() {
    for(int i = 0; i < particles.length; ++i) {
      PVector old = particles[i].oldPosition;
      PVector now = particles[i].position;
      stroke(particles[i].h, 127, 255);
      line(old.x, old.y, now.x, now.y);
    }   
  }
   

}

