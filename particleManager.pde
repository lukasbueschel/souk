// generates and holds the particles

class ParticleManager{
  int numParticleSpawn = 100;
  float magnitude = 3;    // How strong the Perlin vector field is
  float timeDelta = 0.01; // Higher value -> faster temporal change  
  // noiseOffset = whatever the Z coordinate passed to noise(...) is
  // How far off the screen it can go before being dead
  ArrayList<Particle> particles;
  PVector[] deploymentPoints;

  //float delta;
  float cx = 1, cy=1;
  // Effect of passage of time (0 = static field)
  float t = 0;
   
  ParticleManager() {
    deploymentPoints = new PVector[3];
    deploymentPoints[0] = new PVector((int)(333 * xScale), (int)(70 * yScale));
    deploymentPoints[1] = new PVector((int)(502 * xScale), (int)(75 * yScale));
    deploymentPoints[2] = new PVector((int)(359 * xScale), (int)(523 * yScale));
    
    particles = new ArrayList<Particle>();
    deploy();
    t = 0;
  }
      
  void deploy() {
    for(PVector dPoint : deploymentPoints) {
      for(int i = 0; i < numParticleSpawn; ++i) {
        //PVector vel = new PVector((int)(Math.random()*100-50),(int)(Math.random()*100-50));
        particles.add(new Particle(dPoint, (float)Math.random()+3, (float)Math.random())); 
      }
    }
  }

  void updatePositions() {
    checkForNeeds();
    for(Particle p : particles) {
      p.follow(path);
      p.run();
    }
  }
   
  //checks for Possible Needs depending on time
  void checkForNeeds(){
    // wenn t = 9:00; 12:00, 18:00: HUNGER
    //kurz danach: KLO
    // wenn temperature rises: slower, weniger
    if ((t >= 450 && t <= 510) || (t >= 750 && t <= 810) || (t >= 1050 && t <= 1110)){ 
      //Hunger
    }   
  }
}
