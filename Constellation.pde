float[] pointsX,pointsY,pointsXOrigin,pointsYOrigin,radius,angle,angleSpeed,angleSpeedChanger,diameter,diameterChanger;
int points;
float distance,shade,weight,screenAngle;
boolean mouseLines;
PImage stars;

void setup(){
  frameRate(1000);
  size(displayWidth,displayHeight);
  screenAngle=0;
  points = 200;    //Number of points in window
  pointsX = new float[points];    //Number of floats within arrays
  pointsY = new float[points];
  pointsXOrigin = new float[points];   
  pointsYOrigin = new float[points];
  radius = new float[points];
  angle = new float[points];
  diameter = new float[points];
  diameterChanger = new float[points];
  angleSpeed = new float[points];
  angleSpeedChanger = new float[points];
  for (int x=0;x<points;x=x+1){   
    diameter[x] = random(10,15);    //Sets diameter of circles
    if (x <= points/2){
      diameterChanger[x] = 1;    //Causes circle diameter to initially increase
      angleSpeedChanger[x] = 1;    //Causes circlular motion to be clockwise
    }
    if (x > points/2){
      diameterChanger[x] = -1;    //Causes circle diameter to initially decrease
      angleSpeedChanger[x] = -1;    //Causes circlular motion to be counter-clockwise
    }
    radius[x] = random(50,150);    //Sets radius of circle motion
    pointsX[x] = random(0,width);    //Sets center of circle motion within x range of window
    pointsY[x] = random(0,height);    //Sets center of circle motion within y range of window
    pointsXOrigin[x] = pointsX[x];    //Keeps a list of the original x coordinate of center of circular motion to always refer to
    pointsYOrigin[x] = pointsY[x];    //Keeps a list of the original y coordinate of center of circular motion to always refer to
    angle[x] = random(0,360);    //Sets circle at random angle in circular motion
    angleSpeed[x] = random(2,3);    //Sets circle at random speed of traveling circular motion
  }
  stars = loadImage("stars.jpg");
}

void draw(){
  background(0);
  image(stars,0,0);
  Lines();
  if (mousePressed==true){
    MouseLines();
    MouseCircle();
  }
  Circles();
  NewPointLocation();
}

void Lines(){
  for (int x=0;x<points;x=x+1){
    for (int y=0;y<points;y=y+1){
      distance = sqrt(sq(pointsX[y]-pointsX[x])+sq(pointsY[y]-pointsY[x]));    //Finds distance between point[x] and point[y]
      if (distance>150){    //If distance is greater that 150 in length, then set alpha to 0(invisible)
        shade = 0;
      }
      else {
        shade = 20000/distance-50;    //Determines alpha of lines drawn
      }
      if (shade>0){    //Draws lines only if they are supposed to be visible     
        if (shade>200){    //Sets limit to alpha of lines drawn to 200
          shade=200;
        }
        weight = 300/distance;    //Determines stroke weight based on distance
        if (weight>8){    //Sets limit to stroke weight to 8
          weight = 8;
        }
        strokeWeight(weight);
        stroke(random(255),random(255),random(255),shade);
        line(pointsX[y],pointsY[y],pointsX[x],pointsY[x]);    //Draws line between point[x] and point[y]
      }
    }
  }
}

void Circles(){
  noStroke();
  for (int x=0;x<points;x=x+1){
    diameter[x] = diameter[x]+0.1*diameterChanger[x];    //Changes diameter of point
    if (diameter[x]>=15){    //Sets limit to diameter to 15 and sets diameter to decrease
      diameterChanger[x]=-1;
    }
    if (diameter[x]<=5){    //Sets limit to diameter to 5 and sets diameter to increase
      diameterChanger[x]=1;
    }
    fill(diameter[x]*6+165);
    ellipse(pointsX[x],pointsY[x],diameter[x],diameter[x]);    //Draws point 
  }
}

void MouseLines(){
  for (int x=0;x<points;x=x+1){
    distance = sqrt(sq(mouseX-pointsX[x])+sq(mouseY-pointsY[x]));    //Finds distance between mouse and point[x]
    if (distance>150){    //If distance is greater that 150 in length, then set alpha to 0(invisible)
      shade = 0;
    }
    else {
      shade = 20000/distance-50;    //Determines alpha of lines drawn
    }
    if (shade>0){    //Draws lines only if they are supposed to be visible
      if (shade>200){    //Sets limit to alpha of lines drawn to 200
        shade=200;
      }
      weight = 300/distance;    //Determines stroke weight based on distance
      if (weight>8){    //Sets limit to stroke weight to 8
        weight = 8;
      }
      strokeWeight(weight);
      stroke(random(255),random(255),random(255),shade);
      line(mouseX,mouseY,pointsX[x],pointsY[x]);    //Draws line between mouse and point[x]
    }
  }
}

void MouseCircle(){
  noStroke();
  fill(255);
  ellipse(mouseX,mouseY,10,10);    //Draws mousePoint where mouse is located
}

void NewPointLocation(){
  for (int x=0;x<points;x=x+1){
    angle[x] = angle[x]+angleSpeed[x]*angleSpeedChanger[x];    //Increases angle of the circular motion of point[x]
    pointsX[x]=pointsXOrigin[x] + cos(radians(angle[x]))*radius[x];    //Finds new X location of point based on current angle of specified point
    pointsY[x]=pointsYOrigin[x] + sin(radians(angle[x]))*radius[x];    //Finds new Y location of point based on current angle of specified point
  }
}