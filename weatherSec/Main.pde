import http.requests.*;

PFont myFont;

public void setup() 
{
  size(1200,705);
  fill(128,200,207);
  rect(0,0,width,height);
  smooth();
  noStroke();
  myFont = createFont("標楷體",100);
  textFont(myFont);
  GetRequest get = new GetRequest("http://data.taipei/opendata/datalist/apiAccess?scope=resourceAquire&rid=e6831708-02b4-4ef8-98fa-4b4ce53459d9");
  get.send();
  String startTime="";
  String endTime="";

  //initialize weatherInfo
  weatherInfo[] weatherData = new weatherInfo[22];
  for(int i=0;i<22;i++){
    weatherData[i] = new weatherInfo("city",300,100);
  }
  //there are totol 22 area
  int cityList = 0;
  
  JSONObject response = parseJSONObject(get.getContent());
  JSONArray boxes = response.getJSONObject("result").getJSONArray("results");
  
  //there are sometimes 14 or 15 data per city. I pick up latest 14.
  for(int i=0;i< boxes.size();i++) {
    JSONObject box = boxes.getJSONObject(i);
    if(boxes.size()==330){
      //discard fisrt data
      if((i%15)==1){
        weatherData[cityList].city = box.getString("locationName");  
        if(i==1)
          startTime =  box.getString("startTime").substring(5,10);
      }
      if((i%15)>0){
        if(i==328)
          endTime =  box.getString("endTime").substring(5,10);
        weatherData[cityList].list[(i%15)-1] = Integer.parseInt(box.getString("parameterValue1"));
      }
      if((i%15)==14){
        cityList++;
      }
    }else{
      if((i%14)==0){
        weatherData[cityList].city = box.getString("locationName");
        if(i==0)
          startTime =  box.getString("startTime").substring(5,10);
      }
      if(i==306)
          endTime =  box.getString("endTime").substring(5,10);
      weatherData[cityList].list[(i%14)] = Integer.parseInt(box.getString("parameterValue1"));
      if((i%14)==13){
        cityList++;     
      }
    }
    //println( i+"locationName: " + box.getString("locationName") + " 天氣狀況: " + box.getString("parameterValue1"));
  }
  //total 22 areas in weather report
  weatherS[] city = new weatherS[22];
  for(int i=0;i<22;i++){
    city[i] = new weatherS(weatherData[i].city,weatherData[i].W,weatherData[i].H,weatherData[i].list);
  }
  //first collemn
  pushMatrix();
  for(int i=0;i<7;i++){
    city[i].show();
    translate(0,100);
  }
  popMatrix();
  
  translate(300,0);
  pushMatrix();
  for(int i=7;i<14;i++){
    city[i].show();
    translate(0,100);
  }
  popMatrix();
  
  translate(300,0);
  pushMatrix();
  for(int i=14;i<21;i++){
    city[i].show();
    translate(0,100);
  }
  popMatrix();
  
  translate(300,0);
  city[21].show();
  translate(0,100);
  fill(34,103,110);
  textSize(40);
  text("一週天氣預報",30,50);
  text(startTime,30,100);
  text(endTime,30,150);
}

//weather information class,parameters connect to weatherS
class weatherInfo{
  String city;
  int H;
  int W;
  int[] list;
  weatherInfo(String c, int w,int h){
    city = c;
    H = h;
    W = w;
    list = new int [14];
  }
}


void draw(){

}
