class Path {
  PVector start;
  PVector end;
  float radius;
  Path(float x, float y) {
    radius = 20;
    start = new PVector(0, y);
    end = new PVector(x, y);
  }
  
  void display() {
  strokeWeight(radius*2);
  stroke(0, 100);
  line(start.x, start.y, end.x, end.y);
  
  strokeWeight(1);
  stroke(0);
  line(start.x, start.y, end.x, end.y);
  }
}
