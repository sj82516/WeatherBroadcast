class weatherS{
  PImage dayImg;
  PImage nightImg;
  PImage weatherImg;
  int weatherH;
  int weatherD;
  int [] weather;
  String city;
  float cityW;
  float cityH;
  int lineW=5;
  int weatherFont;
  weatherS(String c, int D, int H, int[] w){
    city = c;
    weatherH = H;
    weatherD = D;
    weather = w;
    weatherFont = H/5;
  }
  void show(){
    dayImg = loadImage("day.png");
    nightImg = loadImage("night.png");

    fill(0);
    rect(0,0,weatherD,lineW);
    rect(weatherD/5,weatherH/2,weatherD*4/5,lineW);
    rect(0,weatherH,weatherD,lineW);
  
    //inner splitting frame
    rect(0,0,lineW,weatherH);
    rect(weatherD/5,0,lineW,weatherH);
    pushMatrix();
    translate(weatherD/5,0);
    for(int i=0;i<8;i++){
      translate(weatherD/10,0);
      rect(0,0,lineW,weatherH+lineW);
    }
    popMatrix();
  
    //City name & day night ican
    fill(0,0,0);
    textSize(weatherFont);
    cityW = textWidth(city);
    while(cityW > weatherH/3){
      weatherFont --;
      textSize(weatherFont);
      cityW = textWidth(city);
    }
    cityH = textAscent()-textDescent();

    //day and night picture
    text(city,(weatherD/5-cityW)/2,weatherH/2+cityH/2);
    image(dayImg,weatherD/50+weatherD/5,weatherH/10+weatherH/24,weatherD/12,weatherD/12);
    image(nightImg,weatherD/50+weatherD/5,weatherH*6/10+weatherH/24,weatherD/12,weatherD/12);
  
    //14 weather icons
    pushMatrix();
    translate(weatherD/65+weatherD/5,weatherH/10+weatherH/24);
    for(int i=0;i<14;){
      //day and night weather pic are different 
      translate(weatherD/10,0);
      weatherImg = loadImage(weather[i]+".png");
      image(weatherImg,0,0,weatherD/12,weatherD/12);
      i++;
      weatherImg = loadImage(weather[i]+"_night.png");
      image(weatherImg,0,weatherH/2,weatherD/12,weatherD/12);
      i++;
    }
    popMatrix();
    
    //popMatrix();
  }
}

