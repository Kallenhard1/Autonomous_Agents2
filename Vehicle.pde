class Vehicle {
  PVector Acc;
  PVector Vel;
  PVector Pos;
  float r;
  float maxspeed;
  float maxforce;
  
  Vehicle(PVector l, float ms, float mf) {
    Pos = l.get();
    r = 3.0;
    maxspeed = ms;
    maxforce = mf;
    Acc = new PVector(0, 0);
    Vel = new PVector(maxspeed, 0);
  }
  
  public void run() {
    update();
    display();
    
  }
  // Vai mudar bastante coisa nessa classe
    void follow(Path p) {
      
      //Predizer onde estara o Vehicle mais adiante
      PVector predict = Vel.get();
      predict.normalize();
      predict.mult(50);
      PVector predictPos = PVector.add(Pos, predict);
      
      //Achar o ponto normal, que está um pouco mais a frente.
      PVector a = p.start;
      PVector b = p.end;
      //Esta função(getNrmalPoint) ainda não existe, eu preciso cria-la mais abaixo.
      PVector normalPoint = getNormalPoint(predictPos, a, b);
      
      //Criar um vetor dir que de a direção de a até b e um vetor target baseado no normalPoint e dir.
      PVector dir = PVector.sub(b, a);
      dir.normalize();
      dir.mult(maxspeed);
      PVector target = PVector.add(normalPoint, dir);
      
      //O quão longe estamos de path?
      float distance = PVector.dist(predictPos, target);
      
      if (distance > p.radius) {
      //seek também é uma função que ainda não existe.
      seek(target);
      }
      
      if (debug) {
        if (distance > p.radius){fill(200, 0, 0);}
        else {fill(0);}
        stroke(0);
        line(Pos.x, Pos.y, predictPos.x, predictPos.y);
        ellipse(predictPos.x, predictPos.y, 4, 4);
        //Draw normal position
        fill(0);
        stroke(0);
        line(predictPos.x, predictPos.y, normalPoint.x, normalPoint.y);
        ellipse(normalPoint.x, normalPoint.y, 4, 4);
        
        if (distance > p.radius)fill(0, 200);
        noStroke();
        ellipse(target.x+dir.x, target.y+dir.y, 8, 8);
      }
  }
  
  //função que cria um vetor normal a partir de um ponto p, até um segmento (b - a) ou vetor ab.
  PVector getNormalPoint(PVector p, PVector a, PVector b) {
    //Vetor do ponto a até o ponto p.
    PVector ap = PVector.sub(p, a);
    //Vetor do ponto a ao b.
    PVector ab = PVector.sub(b, a);
    //normalizando o vetor ab.
    ab.normalize();
    //Projeção do vetor ap em ab.
    ab.mult(ap.dot(ab));
    //Vetor do ponto normal(vetor ab - a).
    PVector normalPoint = PVector.add(a, ab);
    
    return normalPoint;
  }
  
  void update() {
    Vel.add(Acc);
    Vel.limit(maxspeed);
    Pos.add(Vel);
    Acc.mult(0);
  }
  
  void applyForce(PVector force) {
    Acc.add(force);
  }
  
  void seek(PVector target) {
    PVector desired = PVector.sub(target, Pos);
    
    
    desired.normalize();
    desired.mult(maxspeed);
    
    PVector steer = PVector.sub(desired, Vel);
    steer.limit(maxforce);
    
    applyForce(steer);
  }
  
  void display() {
    float theta = Vel.heading2D() + PI/2;
    fill(175);
    stroke(0);
    strokeWeight(1);
    pushMatrix();
    translate(Pos.x, Pos.y);
    rotate(theta);
    beginShape(TRIANGLES);
    vertex(0, -r*2);
    vertex(-r, r*2);
    vertex(r, r*2);
    endShape();
    popMatrix();
  }
  
  void borders(Path p) {
    if (Pos.x > p.end.x + r) {
      Pos.x = p.start.x - r;
      Pos.y = p.start.y + (Pos.y - p.end.y);
    }
  }
  
}
