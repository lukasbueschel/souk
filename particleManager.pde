// generates and holds the particles
int numParticleMax = 300;

class ParticleManager{
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
    // we need at least one particle
    spawn();
  }
      
  void spawn() {
    if (particles.size() < numParticleMax) {
      float speed = (float)Math.random();
      int deploymentPointNumber = floor(map((float)(Math.random()), 0.0, 1.0, 0.0, 2.4));
      // fire particles at the bottom upward
      if (deploymentPointNumber == 2) speed = -speed;
      particles.add(new Particle(deploymentPoints[deploymentPointNumber], speed, (float)Math.random())); 
    }
  }

  void kill(boolean all) {
    Particle killMe = null;

    float xMin = 240 * xScale;
    float xMax = 630 * xScale;
    float yMin = 60 * yScale;
    float yMax = 525 * yScale;

    // get candidate for removal
    if ((all) && (particles.size() > 1)) {
      killMe = particles.get((int)(Math.random() * particles.size()));
    }
    else {
      for (Particle p : particles) {
        PVector pLoc = p.location;
        if ((pLoc.x < xMin) || (pLoc.x > xMax) || (pLoc.y < yMin) || (pLoc.y > yMax)) {
          killMe = p;
          break;
        }
      }
    }
    if (killMe != null) particles.remove(killMe);
  }

  void updatePositions() {
    if(particles.size()>1){
      checkForNeeds();
      for(Particle p : particles) {
        p.follow(path);
        p.run();
      }
    }
  }
   
  //checks for Possible Needs depending on time
  void checkForNeeds(){
    
    //random needs
    int val = (int)random(particles.size());
    particles.get(val).changeNeed(needManager.getRandomNeed().getName());
    
        
    // dependent needs    
    // Temperaturabhängiges Verhalten
    if (temperature >= 31){ 
      for(Particle p : particles){
        if (particles.indexOf(p)%100 == millis()%100)
          p.changeNeed("heat");
      }
   }
    
    // wenn t = 9:00; 12:00, 18:00: HUNGER
    else if ((t >= 540f && t <= 600f) || (t >= 750f && t <= 810f) || (t >= 1050f && t <= 1110f)){ 
      for(Particle p : particles){
        if (particles.indexOf(p)%100 == millis()%100)
          p.changeNeed("hunger");
      }
    }   
    
    // wenn t = 9:00; 12:00, 18:00: TOILETTE
    else if ((t >= 650f && t <= 700f) || (t >= 830f && t <= 900f) || (t >= 1090f && t <= 1150f)){ 
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
