// generates and holds the particles

class ParticleManager{
  int numParticles = 200;
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
      particles[i] = new Particle(pos, (float)Math.random()+3, (float)Math.random()); 
    }
  }
   

   
  void updatePositions() {
    checkForNeeds();
    for(int i = 0; i < particles.length; ++i) {
      particles[i].follow(path);
      particles[i].run();
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

