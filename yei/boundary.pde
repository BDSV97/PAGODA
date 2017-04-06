class Boundary {

  float x;
  float y;
  float w;
  float h;
  
  Body b;

  Boundary(float x_,float y_, float w_, float h_,float a) {
    x = x_;
    y = y_;
    w = w_;
    h = h_;
    
    
    PolygonShape sd = new PolygonShape();
    // Figure out the box2d coordinates
    float box2dW = box2d.scalarPixelsToWorld(w/2);
    float box2dH = box2d.scalarPixelsToWorld(h/2);
    // We're just a box
    sd.setAsBox(box2dW, box2dH);


    // Create the body
    BodyDef bd = new BodyDef();
    bd.type = BodyType.STATIC;
    bd.angle=a;
    bd.position.set(box2d.coordPixelsToWorld(x,y));
    b = box2d.createBody(bd);
    
    // Attached the shape to the body using a Fixture
    b.createFixture(sd,1);
  }

 
void display() {
      fill(0);
      stroke(0);
      rectMode(CENTER);
  
    float a = b.getAngle();

      pushMatrix();
      translate(x,y);
      rotate(-a);
      rect(0,0,w,h);
      popMatrix();
  }

}