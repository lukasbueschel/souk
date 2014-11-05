// controls environmental behaviour: heat, wind,..
// controls needs of particles via particlemanager
// Temperaturannahme: 0/24:00 - 24°; 13:00: 32°, gleichmäßige Verteilung

class Environment{
  
  float sundegree = 0;

  Environment(){
    
  }


  void update(){
    //Time running: 60 min --> +=1
    t += 1;
    if (t > 1440){
      t = 0;
    }
    
    updateTemp();
    //checkForDeployment();
    draw();
  }
  
  void draw(){
    //time, temp and degrees on screen
    textSize(32);
    fill(0, 102, 153);
    String ti = (int)(t/60) +":"+(int)(t%60);
    text(ti, 10, 60);
    text("Temp. "+(int)temperature+"°", 10, 120);
    text("Sun. "+ (int)sundegree+"°", 10, 180);
  }
  
  //calculates Temp and Sundegrees, depending on time
  void updateTemp(){
    if (t <= 480 || t>=1080){ 
      sundegree = 0;
    }
    if (t <= 480 || t>=1260 ){
      temperature = 26;
    }
    else{ 
      if (t <= 780){
        temperature = map(t, 480, 780, 26, 32);
        sundegree = map(t, 480, 780, 0, 90);
      }    
      else{ 
        if (t < 1260){
          temperature = map(t, 780, 1260, 32, 26);
        } 
        if (t < 1080){
          sundegree = map(t, 780, 1260, 90, 0);
        }
      }
    }
    temperature = temperature+ random(0.2);
  
  }
  

}
