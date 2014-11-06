// controls environmental behaviour: heat, wind,..
// controls needs of particles via particlemanager
// Temperaturannahme: 0/24:00 - 24°; 13:00: 32°, gleichmäßige Verteilung

class Environment{
  
  float sundegree = 0;

  Environment(){
    
  }


  void update(){
    //Time running: 60 min --> +=1
    t += 0.11;
    if (t > 1440){
      t = 0;
    }
    
    updateTemp();
    //checkForDeployment();
    draw();
  }
  
  void draw(){
    
    //white background
    fill (255);
    rect(width-200,480,250,250);
    
    //time, temp and degrees on screen
    textSize(24);
    fill(50);
    String ti = nf((int)(t/60),2)+":"+nf((int)(t%60),2);

    text(ti, width-130, 500);
   
   
    text((int)temperature+"°", width-60, 500);
    //stroke(0);
    //fill(255, 255, 255, 130);
    //rect(10,80,30,60);
    //float tmap = map((float)((int)(temperature*10))/10, 25, 33, 140, 80);
    //println(tmap); 
    //line(10,tmap,40,tmap);
    //fill(130,130,130);
    //rect(10,tmap,30,60-tmap);  
    
  }
  
  //calculates Temp and Sundegrees, depending on time
  void updateTemp(){
    // zwischen 18:00 und 08:00
    if (t <= 480 || t>=1080){ 
      sundegree = 0;
      numParticleMax = 0;
      killRate = 1;
    }
    if (t <= 480 || t>=1350 ){
      temperature = 26;
      t = t + 0.5;
    }
    else{ 
      if (t <= 780){
        temperature = map(t, 480, 780, 26, 32);
        sundegree = map(t, 480, 780, 0, 90);
        numParticleMax = 300;
        killRate = 30;
      }    
      else{ 
        if (t>1080 && t < 1350){
          temperature = map(t, 1080, 1350, 32, 26);
          numParticleMax = 300;
          killRate = 30;
        } 
        else if(t>780 && t<1080){
          temperature = 32;
          numParticleMax = 100;
          killRate = 2;
        }
        if (t < 1080){
          sundegree = map(t, 780, 1350, 90, 0);
        }
      }
    }
    //temperature = temperature+ random(0.2);
  
  }
  

}
