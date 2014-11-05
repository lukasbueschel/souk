class Need{
  
  String name;
  color fillColor;
  color strokeColor;
  PVector[] goals;
  float acceleration; 
  
  Need(String n, color fC, color sC, float accel){
    this.name = n;
    this.fillColor = fC;
    this.strokeColor = sC;
    this.acceleration = accel; 
  }
  
  color getFill(){
    return this.fillColor;
  }
  
  color getStroke(){
    return this.strokeColor;
  }
  
  String getName(){
    return this.name;
  }
  
  float getAccel(){
    return this.acceleration;
  }
  
}
