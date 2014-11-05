class Need{
  
  String name;
  color fillColor;
  color strokeColor;
  
  Need(String n, color fC, color sC){
    this.name = n;
    this.fillColor = fC;
    this.strokeColor = sC;
  }
  
  color getFill(){
    return this.fillColor;
  }
  
  color getStroke(){
    return this.strokeColor;
  }
  
}
