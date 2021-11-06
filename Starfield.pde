Particle[] ball=new Particle[701];
boolean spaceWarp=false;
boolean setZoom=false;
boolean spooling=false;
float xPan=640;
float yPan=360;
float zoom=0.8;
float temp=40;
int timer=0;
PFont eurostile;

void setup() {
  eurostile=createFont("Eurostile.ttf", 20);
  frameRate(60);
  size(1280, 670);
  ball[0]=new star();
  for (int i=1; i<201; i++) {
    ball[i]=new slowParticle();
  }
  for (int i=200; i<ball.length; i++) {
    ball[i]=new Particle();
  }
}

void draw() {
  background(0);
  translate(width/2, height/2);
  scale(zoom);
  translate(-xPan, -yPan);
  if (timer>1) {
    timer-=1;
  }
  if (timer==1&&zoom==0.8) {
    spaceWarp=true;
  }
  if (zoom>0.8) {
    zoom-=0.01;
  }
  if (spaceWarp==true) {
    translate(random(-7, 7), random(-7, 7));
  }
  //standstill
  for (int i=1; i<ball.length; i++) {
    ball[i].showDot();
    ball[i].mySize=dist((float)ball[i].myX, (float)ball[i].myY, 640, 360)/100;
  }
  //hyperspace
  if (spaceWarp==true) {
    for (int i=1; i<ball.length; i++) {
      ball[i].show();
      ball[i].move();
    }
    ball[0].move();
  }
  ball[0].show();  
  cockpit();
  cockpitDetail();
  if (zoom>0.79) {
    gui();
  }
}

class Particle {
  double myX, myY, mySpeed, myAngle, mySize, angularMomentumX, angularMomentumY, distVar;
  int myColor, myOpacity;
  Particle() {
    //vanity
    myX=640;
    myY=360;
    myColor=255;
    myOpacity=180;
    distVar=50;
    //set movement direction
    mySpeed=Math.random()*5;
    myAngle=Math.random()*2*Math.PI;
    angularMomentumX=Math.cos(myAngle)*mySpeed;
    angularMomentumY=Math.sin(myAngle)*mySpeed;
    //randomly position stars
    for (int i=0; i<Math.random()*1000000; i++)
    {
      move();
    }
  }
  //shows hyperspace lines
  void show() {
    stroke(myColor, myOpacity);
    strokeWeight((float)mySize);
    if (spaceWarp==true && dist((float)myX, (float)myY, 640, 360)>distVar) {
      line((float)myX, (float)myY, (float)myX-(float)angularMomentumX*5, (float)myY-(float)angularMomentumY*5);
      distVar+=0.3;
    }
  }
  //shows stationary stars
  void showDot() {
    if (spaceWarp==false && dist((float)myX, (float)myY, 640, 360)>distVar) {
      fill(myColor, myOpacity);
      noStroke();
      ellipse((float)myX, (float)myY, 2, 2);
    }
  }

  void move() {
    myX+=angularMomentumX;
    myY+=angularMomentumY;
    if (dist((float)myX, (float)myY, 640, 360)>1000) {
      myX=640;
      myY=360;
    }
  }
}

class slowParticle extends Particle {
  slowParticle() {
    myX=640;
    myY=360;
    mySpeed=Math.random()*3;
    myAngle=Math.random()*2*Math.PI;
    myColor=255;
    myOpacity=180;
  }
}

class star extends Particle {
  star() {
    myX=640;
    myY=360;
    myColor=color(255, 187, 0);
    mySize=5;
  }
  void show() {
    if (mySize>=500) {
      temp=20;
      spaceWarp=false;
      mySize=700;
      if (setZoom==false) {
        if (zoom<1) {
          zoom+=0.2;
        } else {
          setZoom=true;
        }
      }
    }
    noStroke();
    fill(myColor);
    ellipse((int)myX, (int)myY, (float)mySize, (float)mySize);
    if (spaceWarp==true) {
      if (zoom>0.69) {
        zoom-=0.03;
        spooling=false;
      }
      mySize+=0.7;
    }
  }
  void move() {
    myX+=random(-1, 1);
    myY+=random(-1, 1);
    if (dist((float)myX, (float)myY, 640, 360)>2) {
      myX=640;
      myY=360;
    }
  }
}

void mousePressed() {
  if (ball[0].mySize<150&&timer==0) {
    timer=360;
    spooling=true;
  }
}

void cockpit() {
  fill(80);
  //top left window bar
  beginShape();
  vertex(-600, -500);
  vertex(-400, -500);
  vertex(530, 500);
  vertex(500, 500);
  endShape(CLOSE);
  //top right window bar
  beginShape();
  vertex(1880, -500);
  vertex(1680, -500);
  vertex(755, 500);
  vertex(780, 500);
  endShape(CLOSE);
  //middle window bars
  beginShape();
  vertex(-500, 730);
  vertex(-500, 620);
  vertex(360, 510);
  vertex(435, 410);
  vertex(485, 485);
  vertex(800, 485);
  vertex(850, 410);
  vertex(920, 510);
  vertex(1780, 620);
  vertex(1780, 730);
  vertex(895, 545);
  vertex(385, 545);
  endShape(CLOSE);
  //main cockpit
  beginShape();
  vertex(-1000, 945);
  vertex(225, 620);
  vertex(390, 540);
  vertex(890, 540);
  vertex(1055, 620);
  vertex(2280, 945);
  endShape(CLOSE);
}

void cockpitDetail() {
  stroke(120);
  strokeWeight(2.5);

  //lines

  //left mid
  line(-600, -500, 420, 427);
  line(-500, 620, 360, 510);
  line(360, 510, 421, 428);
  //right mid
  line(1880, -500, 860, 427);
  line(1780, 620, 920, 510);
  line(920, 510, 860, 427);
  //left bottom
  line(-500, 815, 225, 620);
  line(225, 620, 385, 545);
  line(385, 545, -500, 730);
  //right bottom
  line(1780, 815, 1055, 620);
  line(1055, 620, 895, 545);
  line(895, 545, 1780, 730);

  //3d effect
  fill(95);

  //top
  beginShape();
  vertex(-400, -500);
  vertex(-320, -500);
  vertex(520, 470);
  vertex(760, 470);
  vertex(1600, -500);
  vertex(1680, -500);
  vertex(770, 485);
  vertex(515, 485);
  endShape(CLOSE);
  //mid left
  beginShape();
  vertex(-500, 620);
  vertex(360, 510);
  vertex(421, 428);
  vertex(410, 418);
  vertex(350, 490);
  vertex(-500, 560);
  endShape(CLOSE);
  //mid right
  beginShape();
  vertex(1780, 620);
  vertex(920, 510);
  vertex(859, 428);
  vertex(870, 418);
  vertex(930, 490);
  vertex(1780, 560);
  endShape(CLOSE);
  //bottom left
  beginShape();
  vertex(-500, 815);
  vertex(225, 620);
  vertex(385, 545);
  vertex(340, 555);
  vertex(210, 610);
  vertex(-500, 775);
  endShape(CLOSE);
  //bottom right
  beginShape();
  vertex(1780, 815);
  vertex(1055, 620);
  vertex(895, 545);
  vertex(940, 555);
  vertex(1070, 610);
  vertex(1780, 775);
  endShape(CLOSE);
  //3d effect lines
  strokeWeight(1);
  line(515, 485, 520, 470);
  line(770, 485, 760, 470);
  line(640, 485, 640, 470);
  line(350, 490, 360, 510);
  line(920, 510, 930, 490);
  line(225, 620, 210, 610);
  line(1055, 620, 1070, 610);

  //cockpit background
  fill(120);
  noStroke();
  beginShape();
  vertex(-500, 900);
  vertex(235, 635);
  vertex(445, 535);
  vertex(535, 520);
  vertex(745, 520);
  vertex(835, 535);
  vertex(1045, 635);
  vertex(1780, 900);
  endShape(CLOSE);

  //minor cockpit detailing
  fill(70);
  stroke(120);
  //window detailing
  triangle(435, 435, 490, 487, 387, 500);
  triangle(845, 435, 795, 487, 893, 500);
  //top of dash
  beginShape();
  vertex(535, 520);
  vertex(580, 475);
  vertex(605, 475);
  vertex(630, 508);
  vertex(650, 508);
  vertex(675, 475);
  vertex(700, 475);
  vertex(745, 520);
  vertex(730, 545);
  vertex(700, 555);
  vertex(580, 555);
  vertex(550, 545);
  endShape(CLOSE);
  line(545, 535, 580, 475);
  line(735, 535, 700, 475);
  line(605, 475, 620, 508);
  line(675, 475, 660, 508);
  line(545, 535, 575, 508);
  line(735, 535, 705, 508);
  line(575, 508, 705, 508);
  line(575, 508, 585, 510);
  line(705, 508, 695, 510);
  line(585, 510, 695, 510);
  line(550, 545, 585, 510);
  line(730, 545, 695, 510);
  line(575, 552, 585, 510);
  line(585, 510, 630, 550);
  line(705, 552, 695, 510);
  line(695, 510, 650, 550);

  //misc dash items (bottom to top)
  //black outlines on side
  fill(50);
  beginShape();
  vertex(-500, 900);
  vertex(235, 635);
  vertex(-1000, 1400);
  endShape(CLOSE);
  beginShape();
  vertex(1780, 900);
  vertex(1045, 635);
  vertex(2280, 1400);
  endShape(CLOSE);
  //grey boxes
  fill(80);
  beginShape();
  vertex(-1000, 1300);
  vertex(235, 635);
  vertex(325, 655);
  vertex(-1000, 1800);
  endShape(CLOSE);
  beginShape();
  vertex(2280, 1300);
  vertex(1045, 635);
  vertex(955, 655);
  vertex(2280, 1800);
  endShape(CLOSE);
  //dashboard triangles
  beginShape();
  vertex(240, 630);
  vertex(350, 575);
  vertex(330, 630);
  endShape(CLOSE);
  beginShape();
  vertex(1040, 630);
  vertex(930, 575);
  vertex(950, 630);
  endShape(CLOSE);
  //dashboard triangle 3d
  fill(50);
  beginShape();
  vertex(240, 630);
  vertex(330, 630);
  vertex(350, 575);  
  vertex(351, 585);
  vertex(333, 639);
  vertex(241, 636);
  endShape(CLOSE);
  beginShape();
  vertex(1040, 630);
  vertex(950, 630);
  vertex(930, 575);
  vertex(929, 585);
  vertex(947, 639);
  vertex(1039, 636);
  endShape(CLOSE);
  line(330, 630, 332, 639);
  line(950, 630, 948, 639);
  //hologram projector panels
  fill(40);
  beginShape();
  vertex(-500, 1400);
  vertex(330, 655);
  vertex(355, 580);
  vertex(445, 537);
  vertex(465, 560);
  vertex(515, 564);
  vertex(-500, 1450);
  endShape(CLOSE);
  beginShape();
  vertex(1780, 1400);
  vertex(950, 655);
  vertex(925, 580);
  vertex(835, 537);
  vertex(815, 560);
  vertex(765, 564);
  vertex(1780, 1450);
  endShape(CLOSE);
  //arrowhead 3d effect
  fill(50);
  stroke(120);
  strokeWeight(1);
  beginShape();
  vertex(365, 695);
  vertex(440, 670);
  vertex(522, 675);
  vertex(522.5, 683.5);
  vertex(440, 678);
  vertex(365, 705);
  endShape(CLOSE);
  beginShape();
  vertex(915, 695);
  vertex(840, 670);
  vertex(758, 675);
  vertex(757.5, 683.5);
  vertex(840, 678);
  vertex(915, 705);
  endShape(CLOSE);
  //arrowhead shape decoration
  fill(80);
  stroke(50);
  strokeWeight(2);
  beginShape();
  vertex(367, 695);
  vertex(476, 600);
  vertex(520, 675);
  vertex(440, 670);
  endShape(CLOSE);
  beginShape();
  vertex(913, 695);
  vertex(804, 600);
  vertex(760, 675);
  vertex(840, 670);
  endShape(CLOSE);
  stroke(80);
  line(440, 669, 440, 677);
  line(840, 669, 840, 677);
  //lower deco
  fill(70);
  stroke(60);
  beginShape();
  vertex(513, 645);
  vertex(544, 649);
  vertex(582, 673);
  vertex(589, 690);
  vertex(538, 685);
  endShape(CLOSE);
  beginShape();
  vertex(767, 645);
  vertex(736, 649);
  vertex(698, 673);
  vertex(691, 690);
  vertex(742, 685);
  endShape(CLOSE);
  //upper deco
  beginShape();
  vertex(451, 536);
  vertex(530, 523);
  vertex(537, 537);
  vertex(515, 558);
  vertex(468, 555);
  endShape(CLOSE);
  beginShape();
  vertex(829, 536);
  vertex(750, 523);
  vertex(743, 537);
  vertex(765, 558);
  vertex(812, 555);
  endShape(CLOSE);
  //radar extras
  fill(100);
  stroke(100);
  beginShape();
  vertex(570, 560);
  vertex(540, 550);
  vertex(485, 600);
  vertex(510, 640);
  vertex(545, 645);
  vertex(585, 670);
  vertex(600, 705);
  vertex(680, 705);
  vertex(695, 670);
  vertex(735, 645);
  vertex(770, 640);
  vertex(795, 600);
  vertex(740, 550);
  vertex(710, 560);
  endShape(CLOSE);

  fill(70);
  stroke(70);
  beginShape();
  vertex(570, 560);
  vertex(540, 550);
  vertex(488, 598);
  vertex(512, 635);
  vertex(548, 641);
  vertex(588, 666);
  vertex(595, 680);
  vertex(685, 680);
  vertex(692, 666);
  vertex(732, 641);
  vertex(768, 635);
  vertex(792, 598);
  vertex(740, 550);
  vertex(710, 560);
  endShape(CLOSE);
  //radar
  stroke(80);
  fill(80);
  ellipse(640, 596, 200, 115);
  fill(50);
  ellipse(640, 595, 190, 105);
  noStroke();
  fill(60);
  ellipse(641, 597, 180, 100);

  //dashboard end
  noStroke();
  fill(0);
  beginShape();
  vertex(-500, 900);
  vertex(-500, 830);
  vertex(0, 800);
  vertex(440, 685);
  vertex(580, 695);
  vertex(590, 720);
  vertex(690, 720);
  vertex(700, 695);
  vertex(840, 685);
  vertex(1280, 800);
  vertex(1780, 830);
  vertex(1880, 900);
  endShape(CLOSE);
  fill(60);
  stroke(50);
  beginShape();
  vertex(-500, 830);
  vertex(0, 800);
  vertex(440, 685);
  vertex(580, 695);
  vertex(590, 720);
  vertex(690, 720);
  vertex(700, 695);
  vertex(840, 685);
  vertex(1280, 800);
  vertex(1780, 830);
  vertex(1580, 950);
  vertex(840, 715);
  vertex(700, 725);
  vertex(685, 750);
  vertex(595, 750);
  vertex(580, 725);
  vertex(440, 715);
  vertex(-300, 950);
  endShape(CLOSE);
  line(440, 685, 440, 715);
  line(580, 695, 580, 725);
  line(590, 720, 594, 750);
  line(690, 720, 686, 750);
  line(700, 695, 700, 725);
  line(840, 685, 840, 715);
}

void gui() {
  textSize(20);
  float x=1;
  float y=1;
  float z=30;
  noStroke();
  //radar
  while (x<100) {
    fill(204, 129, 0, z);
    ellipse(641, 597, y, x);
    z-=0.5;
    x+=1;
    y=x*1.8;
  }
  x=y=0;
  z=15;
  stroke(204, 129, 0, 150);
  strokeWeight(2);
  fill(128, 62, 0, 100);
  ellipse(641, 590, 252, 140);
  noFill();
  while (x<140) {
    ellipse(641, 590, y, x);
    x+=45;
    y=x*1.8;
  }
  ellipse(641, 590, 235, 126);
  ellipse(641, 590, 211, 112);
  strokeWeight(8);
  point(641, 590);
  
  //target info
  if(timer!=1){
  strokeWeight(3);
  stroke(204, 129, 0);
  arc(640,360,100,100,radians(5),radians(265));
  fill(204, 129, 0);
  line(690,364,770,364);
  text("Asterope",690,357);
  text("63.9Ly",692,385);
  }
  
  //ui shadow
  rectMode(CENTER);
  x=y=z=1;
  noStroke();
  while (x<110) {
    x+=1;
    y=0.3*x;
    z+=0.05;
    fill(0, 0, 0, z);
    rect(464, 659, x, y);
    rect(816, 659, x, y);
  }
  x=y=z=1;
  while (x<200) {
    x+=1;
    y=0.6*x;
    z+=0.03;
    fill(0, 0, 0, z);
    rect(380, 580, x, y);
    rect(900, 580, x, y);
  }
  
  //left UI panel
  String SysString="Next System:";
  String FSDstatus="Ready";
  String FSDcommand="CLICK TO SPOOL FSD";
  if(timer==1){
   SysString="Current System:"; 
   FSDstatus="Cooldown";
   FSDcommand="FSD COOLDOWN";
  }
  if(timer>1){
   FSDstatus="Charging";
   FSDcommand="CHARGING FSD...";
  }
  strokeWeight(3);
  stroke(204, 129, 0);
  fill(204, 129, 0);
  line(290,526,470,526);
  line(290,548,470,548);
  text(SysString,295,544);
  text("Name: Asterope",295,568);
  text("Faction: AXI",295,588);
  text("Gov: Patronage",295,608);
  text("Economy: AX",295,628);
  
  line(990,526,810,526);
  line(990,548,810,548);
  text("Frame-Shift Drive:",815,544);
  text("Status: "+FSDstatus,815,568);
  textSize(18);
  text(FSDcommand,815,588);
  
  fill(128, 62, 0, 100);
  noStroke();
  rect(900,608,180,25);
  if(spooling==true){
    fill(204, 129, 0);
    rect(900,608,timer/2-180,25);
  }
  
  //speed & heat bars
  strokeWeight(15);
  stroke(128, 62, 0, 110);
  noFill();
  x=0.01;
  arc(641, 595, 300, 155, radians(320), radians(400));
  arc(639, 595, 300, 155, radians(140), radians(220));
  stroke(204, 129, 0);
  arc(641, 595, 300, 155, radians(400-x), radians(400));
  arc(639, 595, 300, 155, radians(140), radians(140+temp));
  if (spooling==true) {
    arc(639, 595, 300, 155, radians(140), radians(140+temp));
    if (temp<53) {
      temp+=0.05;
    }
  }
  
  //speed & heat text
  stroke(204, 129, 0);
  fill(204, 129, 0);
  textSize(20);
  textFont(eurostile);
  text("Heat: "+(int)(temp+20)+"%", 419, 665);
  text("Speed: 0", 777, 665);
}
