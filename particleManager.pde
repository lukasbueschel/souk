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
    deploymentPoints[0] = new PVector((int)(333 * xScale), (int)(70 * yScale)); // top left
    deploymentPoints[1] = new PVector((int)(502 * xScale), (int)(75 * yScale)); // top right
    deploymentPoints[2] = new PVector((int)(359 * xScale), (int)(523 * yScale)); // bottom
    
    particles = new ArrayList<Particle>();
    deploy();
  }
      
  void deploy() {
    for(int i = 0; i < deploymentPoints.length; i++) {
      for(int j = 0; j < numParticleSpawn; ++j) {
        float speed = (float)Math.random();
        // fire particles at the bottom upward
        if (i == 2) speed = -speed;
        particles.add(new Particle(deploymentPoints[i], speed, (float)Math.random())); 
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
    
    int val = (int)random(particles.size());
    particles.get(val).changeNeed(needManager.getRandomNeed().getName());
    
    
    // wenn t = 9:00; 12:00, 18:00: HUNGER
    if ((t >= 540f && t <= 600f) || (t >= 750f && t <= 810f) || (t >= 1050f && t <= 1110f)){ 
      for(Particle p : particles){
        if (particles.indexOf(p)%100 == millis()%100)
          p.changeNeed("hunger");
      }
    }   
    
    // wenn t = 9:00; 12:00, 18:00: TOILETTE
    else if ((t >= 490f && t <= 550f) || (t >= 680f && t <= 740f) || (t >= 1090f && t <= 1150f)){ 
      for(Particle p : particles){
        if (particles.indexOf(p)%100 == millis()%100)
          p.changeNeed("toilet");
      }
   }
   else {
     for(Particle p : particles){
        if (particles.indexOf(p)%100 == millis()%100)
          p.changeNeed("shopping");
      }
    }
  }
  
  
}
