float s = 1, ds = -0.1;
float t = 0, dt = -10;
float x, y, dx = 2, dy = 2;

void drawVisuals()
{
  reLight();
  lines();
  translate(width/2, height/2);
  reScale();
  face();
}
 //<>//
void lines()
{
  x+=dx;
  y+=dy;
  if (x > width || x < 0) dx = -dx;
  if (y > height || y < 0) dy = -dy;

  stroke(255, t);
  line(x, 0, width, y);
  line(x, 0, 0, height-y);
  line(width-x, height, width, y);
  line(width-x, height, 0, height-y);

  line(width-x, 0, width, height-y);
  line(width-x, 0, 0, y);
  line(x, height, width, height-y);
  line(x, height, 0, y);
}

void flash()
{
  t = 255;
}

void reLight()
{
  t+=dt;
  t = constrain(t, 0, 255);
}

void face()
{
  noFill();
  stroke(255);
  ellipse(0, 0, width/4, height/4);
  bezier(-15, -5, -10, -15, -10, -15, -5, -5);
  bezier(5, -5, 10, -15, 10, -15, 15, -5);
  arc(0, 10, 10, 10, 0, PI);
}

void bounce()
{
  s = 2;
}

void reScale()
{
  s+=ds;
  s = constrain(s, 1, 2);
  scale(s);
}