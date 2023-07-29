/*
 Assessment 1
 made with a hint of love (i was too lazy to spice it up)
 */
int[] ufoAnchor = { 35, 35 }; //0 is x, 1 is y
int[] obstacleOne = new int[4]; //the four points for the obstacle generation
int[] obstacleTwo = new int[4]; //the same as above but the other.
boolean gameLost = false;

void obstacleGeneration() {
  for (int i =- 0; i < 2; i++ ) {
    obstacleOne[i] = (int)random(1, 5);
    obstacleTwo[i] = (int)random(1, 5);
    obstacleOne[i+2] = obstacleOne[i];
    obstacleOne[i+2] += (int)random(1, 8);
    obstacleTwo[i+2] = obstacleTwo[i];
    obstacleTwo[i+2] += (int)random(1, 8);
  }
  for (int i =- 0; i < 4; i++ ) {
    obstacleOne[i] *= 70;
    obstacleTwo[i] *= 70;
  }
  /* //for debug
   println(obstacleOne);
   println(obstacleTwo);
   */
}

void setup() {
  size(700, 700);
  obstacleGeneration();
  noStroke();
  rectMode(CORNERS);
  textSize(75);
  textAlign(CENTER);
}

void keyPressed() {
  switch(keyCode) {
  case UP :
    ufoAnchor[1] -= 70;
    break;

  case LEFT :
    ufoAnchor[0] -= 70;
    break;

  case DOWN :
    ufoAnchor[1] += 70;
    break;

  case RIGHT :
    ufoAnchor[0] += 70;
    break;
  }
}

void lildude() {
  fill(#000000);
  line(ufoAnchor[0], 0, ufoAnchor[0], ufoAnchor[1]); //that line
  fill(#00e000);
  triangle(ufoAnchor[0] + 14, ufoAnchor[1] + 5, ufoAnchor[0] + 28, ufoAnchor[1] + 35, ufoAnchor[0] - 2, ufoAnchor[1] + 35); //right triangle
  triangle(ufoAnchor[0] - 14, ufoAnchor[1] + 5, ufoAnchor[0] + 2, ufoAnchor[1] + 35, ufoAnchor[0] - 28, ufoAnchor[1] + 35); //left triangle
  fill(#555555);
  ellipse(ufoAnchor[0], ufoAnchor[1] - 10, 56, 42); //main oval
  fill(#7777ff);
  ellipse(ufoAnchor[0], ufoAnchor[1] - 5, 70, 14); //front oval
  fill(#dc987b);
  for (int decorOffset =- 24; decorOffset < 28; decorOffset += 8 ) {
    circle(ufoAnchor[0] + decorOffset, ufoAnchor[1] - 5, 3); //lil dots
  }
}

void oobDetect() { //out of bounds detect
  if (ufoAnchor[0] + 30 <= 0) {
    ufoAnchor[0] += 700;
  }
  if (ufoAnchor[0] -30 >= 700) {
    ufoAnchor[0] -= 700;
  }

  if (ufoAnchor[1] + 30 <= 0) {
    ufoAnchor[1] += 700;
  }
  if (ufoAnchor[1] - 30 >= 700) {
    ufoAnchor[1] -= 700;
  }
}

void gameOverScreen() {
  gameLost = true;
  background(#ff0000);
  fill(#00ffff);
  text("you killed lil dude rip", width/2, height/2);
}

void draw() {
  if (gameLost == true) {
    gameOverScreen();
  } else {
    oobDetect();
    background(#ffffff);
    noStroke();
    fill(#ff0000);
    rect(obstacleOne[0], obstacleOne[1], obstacleOne[2], obstacleOne[3]);
    rect(obstacleTwo[0], obstacleTwo[1], obstacleTwo[2], obstacleTwo[3]);
    // collision detection (processing really doesnt like escape chars
    // please dont count these as errors, i just wanted to make it neat
    if (obstacleOne[0] < ufoAnchor[0] && ufoAnchor[0] < obstacleOne[2] && \
obstacleOne[1] < ufoAnchor[1] && ufoAnchor[1] < obstacleOne[3] || \
obstacleTwo[0] < ufoAnchor[0] && ufoAnchor[0] < obstacleTwo[2] && \
obstacleTwo[1] < ufoAnchor[1] && ufoAnchor[1] < obstacleTwo[3]) {
      gameOverScreen();
    }
    stroke(1);
    lildude(); //lil dude is a UFO if it wasnt obvious enough
    /*   //debug to show the size of the UFO, its just a bit under 70, 70. itll do.

     line(00, 140, 1000, 140);
     line(140, 00, 140, 1000);
     line(00, 70, 1000, 70);
     line(70, 00, 70, 1000);
     */
  }
}
