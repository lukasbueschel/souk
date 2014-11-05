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
   
  ParticleManager() {
    deploymentPoints = new PVector[3];
    deploymentPoints[0] = new PVector((int)(333 * xScale), (int)(70 * yScale));
    deploymentPoints[1] = new PVector((int)(502 * xScale), (int)(75 * yScale));
    deploymentPoints[2] = new PVector((int)(359 * xScale), (int)(523 * yScale));
    
    particles = new ArrayList<Particle>();
    deploy();
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
    println(t);
    // wenn t = 9:00; 12:00, 18:00: HUNGER
    //kurz danach: KLO
    // wenn temperature rises: slower, weniger
    if ((t >= 450f && t <= 510f) || (t >= 750f && t <= 810f) || (t >= 1050f && t <= 1110f)){ 
      for(int i = 0; i < particles.length; ++i) {
        particles[i].changeNeed("hunger"); 
      }
    }   
  }
}
