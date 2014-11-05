Environment environment;
ParticleManager particleManager;
PGraphics tintLayer;
float mouseStrength;
float t=0;

boolean sketchFullScreen(){
  return true;
}

void setup() {
  
  size(displayWidth, displayHeight, P2D);
  smooth();
  background(0,0,0);
  environment = new Environment();
  // ---- Parameters to tune ----
  
  int numParticles = 4000;
  float speed = 3;       // How strong the Perlin vector field is
  int decayRate = 20;    // Trails: 0=last forever, 255=die instantly.
  float noiseSize = 0.01; // Higher value -> faster spatial change
  float timeDelta = 0.01; // Higher value -> faster temporal change
  mouseStrength = 1.0;   // How strongly the mouse pushes/pulls
  int borders = 100;     // How far off-screen a particle can go
  strokeWeight(0.5);
  // ---- Boilerplate ----
  //frameRate(60);
  particleManager = new ParticleManager(numParticles, speed);
  particleManager.setNoiseSize(noiseSize, noiseSize);
  particleManager.setTimeDelta(timeDelta);
  particleManager.setBorders(borders);
  particleManager.generateBottom();
  stroke(255);
  colorMode(HSB, 255);
  // The tint layer is just black with an alpha channel.
  // At each frame, it is copied to the existing particle trails,
  // which creates the decay as it gradually is forced to black.
  tintLayer = createGraphics(width, height, P2D);
  tintLayer.beginDraw();
  tintLayer.background(0,decayRate);
  tintLayer.endDraw();
}
 
void draw() {
  PVector mouseForce = null;
  // If mouse is pressed, exert a constant force.
  if(mousePressed) {
    if (mouseButton == LEFT) {
      float mx = ((float)mouseX / width - 0.5);
      float my = ((float)mouseY / height - 0.5);
      mouseForce = new PVector(mouseStrength*mx, mouseStrength*my);
    }
  }
  particleManager.updatePositions(mouseForce);
  // Dim the old display by a certain amount (tintLayer has an
  // alpha channel that influences this)
  image(tintLayer, 0, 0);
  // Draw new lines on top of this.
  particleManager.drawLines();
  particleManager.resurrectOutliers();
  t += 0.05;
}
