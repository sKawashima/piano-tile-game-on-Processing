/**
 * author sKawashima
 * not complete yet
 **/

void setup() {
  size(600, 800);
  pTiles = new boolean[4][725 / blockSize + 1];
  for (int i = 0; i < 725 / blockSize + 1; i++) {
    int t = int(random(0, 4));
    for (int j = 0; j < 4; j++) {
      if (j == t) {
        pTiles[j][i] = true;
      } else {
        pTiles[j][i] = false;
      }
    }
  }
}

int blockSize = 125;
boolean[][] pTiles;

int score = 0;
int highScore = 0;
boolean record = false;
float time = 20;
float startTime = 0;

float penalty = 0;


int status = 0;//0=not start 1=start 2=over

void draw() {
  background(255);
  fill(255);
  rect(100, 725, 100, 25);
  rect(200, 725, 100, 25);
  rect(300, 725, 100, 25);
  rect(400, 725, 100, 25);
  textAlign(CENTER);
  textSize(14);
  fill(0);
  text("D", 150, 743);
  text("F", 250, 743);
  text("J", 350, 743);
  text("K", 450, 743);

  line(100, 0, 100, 725);
  line(200, 0, 200, 725);
  line(300, 0, 300, 725);
  line(400, 0, 400, 725);
  line(500, 0, 500, 725);

  for (int i = 0; i < 4; i++) {
    for (int j = 0; j < 725/blockSize+1; j++) {
      if (pTiles[i][j]) {
        fill(128);
      } else {
        noFill();
      }
      rect(i *100 + 100, 725 - blockSize - j*blockSize, 100, blockSize);
    }
  }

  fill(0);

  textSize(18);
  text(score, 550, 750);
  if(record){
    fill(255,0,0);
  }else{
    fill(128);
  }
  text(highScore,550,725);

    //text("-10", 50, 750);
  fill(0);
  

  if(status == 0){
    text(time,50,750);
    rect(30,50,40,675);
  }else if(status == 1){
    text((startTime + time * 1000 -millis())/1000,50,750);
    rect(30,50 + 675 - 675 * ((startTime + time * 1000 -millis())/1000) / time,40,675 * ((startTime + time * 1000 -millis())/1000) / time);
    if(startTime + time * 1000 -millis() <= 0){
      status = 2;
      if(highScore < score){
        record = true;
        highScore = score;
      }
    }
  }else if(status == 2){
    text("over",50,750);
    text("please press Space Key to Reset",width / 2, height - 19);
  }
}

void keyPressed() {
  fill(0, 50);
  if (status != 2) {
    if (key == 'd') {
      rect(100, 725, 100, 25);
      pushTile(0);
    }
    if (key == 'f') {
      rect(200, 725, 100, 25);
      pushTile(1);
    }
    if (key == 'j') {
      rect(300, 725, 100, 25);
      pushTile(2);
    }
    if (key == 'k') {
      rect(400, 725, 100, 25);
      pushTile(3);
    }
  }
  if (key == ' ') {
    reset();
  }
}

void pushTile(int n) {
  if (status == 0) {
    status = 1;
    startTime = millis();
  }
  if (pTiles[n][0]) {
    step();
    score++;
  } else {
    background(255, 0, 0);
    score -= 10;
    penalty = millis() + 2000;
  }
}

void step() {
  for (int i = 1; i < 725 / blockSize + 1; i++) {
    for (int j = 0; j < 4; j++) {
      pTiles[j][i-1] = pTiles[j][i];
    }
  }
  int t = int(random(0, 4));
  for (int j = 0; j < 4; j++) {
    if (j == t) {
      pTiles[j][725 / blockSize] = true;
    } else {
      pTiles[j][725 / blockSize] = false;
    }
  }
}

void reset() {
  score = 0;
  status = 0;
  record = false;
  for (int i = 0; i < 725 / blockSize + 1; i++) {
    int t = int(random(0, 4));
    for (int j = 0; j < 4; j++) {
      if (j == t) {
        pTiles[j][i] = true;
      } else {
        pTiles[j][i] = false;
      }
    }
  }
}