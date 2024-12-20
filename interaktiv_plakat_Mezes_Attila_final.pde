float speed = 100;
float constant = 0.005;
ArrayList<Particle> particles = new ArrayList<>();
PShape bot;
PImage botMask;

void setup()
{
  size(800, 800);
  background(255);
  bot = loadShape("DRAWWITHTHEFLOW.svg");
  shape(bot, 120, 260);
  botMask = createImage(width, height, RGB);
  PGraphics pg = createGraphics(width, height);
  pg.beginDraw();
  pg.background(255);
  pg.shape(bot, 120, 260);
  pg.endDraw();
  botMask = pg.get();
}

void draw()
{
  particles.add(new Particle(mouseX, mouseY));

  for (Particle p : particles)
  {
    p.update();
  }

  if (keyPressed)
  {
    for (int w = 0; w < 10; w++)
    {
      particles.add(new Particle(random(width), random(height)));
    }
  }
}

class Particle
{
  PVector position;
  PVector velocity;

  Particle(float x, float y)
  {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
  }

  void update()
  {
    if (position.x > 0 && position.x < width && position.y > 0 && position.y < height)
    {
      // Check collision with SVG mask
      color maskColor = botMask.get((int)position.x, (int)position.y);
      if (brightness(maskColor) < 128)
      {
        velocity.mult(0);
      }
      else
      {
        velocity = PVector.fromAngle(noise(position.x * constant, position.y * constant) * 2 * PI);
        velocity.setMag(speed);
        position.add(PVector.div(velocity, frameRate));
      }
      display();
    }
  }

  void display()
  {
    fill(0);
    noStroke();
    circle(position.x, position.y, 0.5);
  }
}
