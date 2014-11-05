Environment environment;
ParticleManager particleManager;
PGraphics tintLayer;
float mouseStrength;
float t=0;
int decayRate = 20;

boolean sketchFullScreen(){
  return true;
}

void setup() {
  
  size(displayWidth, displayHeight);
  smooth();
  background(255,255,255);
  environment = new Environment();
  // ---- Parameters to tune ----
  

  mouseStrength = 1.0;   // How strongly the mouse pushes/pulls
  int borders = 100;     // How far off-screen a particle can go
  strokeWeight(0.5);
  // ---- Boilerplate ----
  //frameRate(60);
  particleManager = new ParticleManager();
  stroke(255);
  colorMode(HSB, 255);
  // The tint layer is just black with an alpha channel.
  // At each frame, it is copied to the existing particle trails,
  // which creates the decay as it gradually is forced to black.
  
  tintLayer = createGraphics(width, height);
  tintLayer.beginDraw();
  tintLayer.background(255,decayRate);
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
