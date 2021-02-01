boolean debug = true;

Path path;
ArrayList<Vehicle> vehicles;


void setup() {
  size(600, 600);
  
  vehicles = new ArrayList<Vehicle>();
  
  for(int i = 0; i < 120; i++) {
    vehicles.add(new Vehicle(new PVector(random(width), random(height)), random(2, 5), random(0.1, 0.5)));
  }
  
}

void draw() {
  background(245);
  path = new Path(mouseX, mouseY);
  //This calling function may will follow to the path position vector. 
  for(Vehicle v : vehicles) {
    v.follow(path);
    v.run();
    v.borders(path);
  }
  
  path.display();
  //saveFrame("agent1_####.png");
}

public void keypressed() {
  if(key == ' '){
    debug = !debug;
  }
}
