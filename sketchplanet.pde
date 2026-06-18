Planet[] planets;
boolean paused = false;
boolean reverse = false;

void setup() {
  size(800, 800);
    planets = new Planet[8];
    planets[0] = new Planet("Mercury", 50, 6, 0.045, color(180),88);
    planets[1] = new Planet("Venus",   80, 12, 0.035, color(255, 180, 100), 225);
    planets[2] = new Planet("Earth",  110, 13, 0.030, color(100, 150, 255),365);
    planets[3] = new Planet("Mars",   140, 9, 0.025, color(255, 100, 100),687);
    planets[4] = new Planet("Jupiter",180, 26, 0.015, color(255, 200, 150), 4333);
    planets[5] = new Planet("Saturn", 230, 22, 0.012, color(255, 220, 150), 10759);
    planets[6] = new Planet("Uranus", 280, 18,  0.010, color(150, 255, 255), 30687);
    planets[7] = new Planet("Neptune",330, 18, 0.008, color(100, 100, 255), 60190);
    System.out.println(closestPlanetEarth());
}

void draw() {
  background(0);
  translate(width / 2, height / 2);

  // draw Sun
  fill(255, 204, 0);
  noStroke();
  ellipse(0, 0, 60, 60);

  for (Planet p : planets) {
    p.displayOrbit();
    if (!paused) {
      p.update();
    }
    if(reverse)
    {
      p.rupdate();
    }
     p.display();
  }

}

void keyPressed() {
  if (key == ' ') {
    paused = !paused;
  }
  if(key == 'r')
  {
    reverse = true;
  }
  if(key == 'e')
  {
    if(reverse)
    {  
      reverse = false;
    }
  }
}

public Planet closestPlanetEarth()
  {
    Planet Closest = null;
    double closestDistance = Double.MAX_VALUE;
    for(int day = 0; day<=365; day++)
    {
     float x1 = planets[2].PosX();
     float y1 = planets[2].PosY();
     for(Planet p : planets) {
       if(p == planets[2]) continue;
          float x2 = p.PosX();
          float y2 = p.PosY();
          double dist = Math.sqrt(Math.pow((x1-x2), 2) +Math.pow((y1-y2), 2));
       if(dist < closestDistance)
       {
         closestDistance = dist;
         Closest = p;
       }   
     }
    }
    for(Planet p: planets)
    {
      p.update();
    }
    return Closest;
  }

class Planet {
  private String name;
  private float distanceFromSun;
  private float size;
  private float angle;
  private float speed;
  private color planetColor;

  public Planet(String n, float d, float s, float sp, color c, int daysofrev) {
    name = n;
    distanceFromSun = d;
    size = s;
    angle = (float)((daysofrev/360)*(Math.PI/180));
    speed = sp;
    planetColor = c;
  }

  public void update() {
    angle += speed;
  }
  
   public void rupdate() {
    angle -= speed;
  }
  
  public void displayOrbit() {
    noFill();
    stroke(80);
    ellipse(0, 0, distanceFromSun * 2, distanceFromSun * 2);
  }
  public float PosX() {
    float x = cos(angle) * distanceFromSun;
    return x;
  }
  public float PosY() {
    float y = sin(angle) * distanceFromSun;
    return y;
  }
  
   public String getName() {
    return name;
  }

  public void display() {
    float x = cos(angle) * distanceFromSun;
    float y = sin(angle) * distanceFromSun;

    noStroke();
    fill(planetColor);
    ellipse(x, y, size, size);
  }
  
  public String toString()
  {
    return "Planet:" + name;
  }
}
