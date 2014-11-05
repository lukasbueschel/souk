Environment environment;
ParticleManager particleManager;
NeedManager needManager;
double temperature = 26f;
PGraphics tintLayer;
PShape mapLayer;
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
  //colorMode(HSB, 255);
  // ---- Boilerplate ----
  //frameRate(60);

  xScale = width / svgWidth;
  yScale = xScale;

  needManager = new NeedManager();
  particleManager = new ParticleManager();
  
  // The tint layer is just black with an alpha channel.
  // At each frame, it is copied to the existing particle trails,
  // which creates the decay as it gradually is forced to black.
  tintLayer = createGraphics(width, height);
  tintLayer.beginDraw();
  tintLayer.background(255,decayRate);
  tintLayer.endDraw();

  path = new Path();

  path.addPoint(333,70);
  path.addPoint(356,153);
  path.addPoint(405.5,221);

  path.addPoint(500.25,211.432);
  path.addPoint(502.75,75.784);
  path.addPoint(500.25,211.432);
  path.addPoint(637.25,209.001);
  path.addPoint(500.25,211.432);
  path.addPoint(497.334,264);

  path.addPoint(405.32,266.667);
  path.addPoint(405.5,221);
  path.addPoint(405.32,266.667);

  path.addPoint(405.025,341.502);
  path.addPoint(230,334.334);
  path.addPoint(405.025,341.502);
  path.addPoint(636,335.473);
  path.addPoint(405.025,341.502);
  path.addPoint(375,363.334);

  path.addPoint(376.5,436);
  path.addPoint(233.75,446.25);
  path.addPoint(376.5,436);
  path.addPoint(396,441.001);
  path.addPoint(640.5,428.5);
  path.addPoint(396,441.001);
  path.addPoint(376.5,436);

  path.addPoint(360,454.001);
  path.addPoint(359.333,523.668);
  
  // setup map
  mapLayer = loadShape("maplayer.svg");
}
 
void draw() {
  image(tintLayer, 0, 0);
  environment.update();
  path.display();
  particleManager.updatePositions();
  
  shape(mapLayer, 0, 0, mapLayer.width*xScale, mapLayer.height*yScale);
}

//// SCREENSHOT
void mouseClicked() {
  save("x_sketch_" + year() + "-" + month() + "-" + day() + "_" + hour() + "-" + minute() + "-" + second() + ".jpg");
}
