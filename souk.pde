Environment environment;
ParticleManager particleManager;
PGraphics tintLayer;
float t=540;
int decayRate = 20;    // Trails: 0=last forever, 255=die instantly.

Path path;
float svgWidth = 841.89;
float svgHeight = 595.28;
float xScale, yScale;

boolean sketchFullScreen(){
  return true;
}

void setup() {
  
  size(displayWidth, displayHeight);
  smooth();
  background(255,255,255);
  environment = new Environment();
  // ---- Parameters to tune ----
  
  strokeWeight(0.5);
  stroke(255);
  colorMode(HSB, 255);
  // ---- Boilerplate ----
  //frameRate(60);
  
  particleManager = new ParticleManager();
  
  // The tint layer is just black with an alpha channel.
  // At each frame, it is copied to the existing particle trails,
  // which creates the decay as it gradually is forced to black.
  tintLayer = createGraphics(width, height);
  tintLayer.beginDraw();
  tintLayer.background(255,decayRate);
  tintLayer.endDraw();

  xScale = width / svgWidth;
  yScale = height / svgHeight;

  path = new Path();
  path.addPoint(502.75,75.784);
  path.addPoint(500.25,211.432);
  path.addPoint(637.25,209.001);
}
 
void draw() {
  image(tintLayer, 0, 0);
  environment.update();
  path.display();
  particleManager.updatePositions();

  
}
