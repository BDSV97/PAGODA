float x;
float y;

int fondo;
int contador = 1500;

PImage inicio;
PImage juego;
PImage over;

PFont f;
PFont titulo;

import processing.sound.*;
SoundFile musica;

import shiffman.box2d.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;

// A reference to our box2d world
Box2DProcessing box2d;


ArrayList<Boundary> boundaries;
ArrayList<Box> boxes;

void setup() {
      size(960,560);
      smooth();
  
     inicio = loadImage("inicio.jpg");
     juego  = loadImage("juego.jpg");
     over  = loadImage("over.jpg");
  
     titulo = createFont ("titulo.ttf",200);
     f = createFont ("f.ttf",200);
  
      musica = new SoundFile(this, "musica.mp3");
      musica.play();
      musica.amp(0.4);

  
      box2d = new Box2DProcessing(this);
      box2d.createWorld();
      box2d.setGravity(0, -10);

     boxes = new ArrayList<Box>();
     boundaries = new ArrayList<Boundary>();

  // Add a bunch of fixed boundaries
 
   boundaries.add(new Boundary(450,200,8,100,0.2));
   boundaries.add(new Boundary(500,200,8,100,-0.2));
   boundaries.add(new Boundary(420,160,8,50,5));
   boundaries.add(new Boundary(470,245,8,35,8));
  
   boundaries.add(new Boundary(440,275,8,55,0.6));
   boundaries.add(new Boundary(500,275,8,55,-0.5));
   boundaries.add(new Boundary(415,250,8,30,5));
   boundaries.add(new Boundary(525,250,8,30,5));
   boundaries.add(new Boundary(470,300,8,34,8));
  
   boundaries.add(new Boundary(150,365,8,143,-8));
   boundaries.add(new Boundary(800,350,8,315,-8));
   boundaries.add(new Boundary(690,445,8,250,-8));
   boundaries.add(new Boundary(955,355,8,40,0));
}

void draw() {
     switch(fondo){
   
     case 0: 
           
            background(#5a3563);
            fill(255);
            textFont(titulo);
            textSize(200);
            text("Let´s Play",160,250);
            
            textFont(f);
            textSize(50);
            text("~key pressed~",330,450);
          
            image(inicio,0,0, 960, 560);
            intro();
            
       break;  
       
       
     case 1:
             background(255);
             image(juego,0,0, 960, 560);
             juego();
             
       break;     
   }
  
        if (fondo == 1){
               contador --;
               println(contador);
               fill(255);
               textFont(f);
               textSize(30);
               text("Tiempo restante:",650,70);
               text(contador/25 , 860,70);

           if(contador <=0){
                   image(over,0,0,960,560);
                   
                    if (keyPressed){
                        if(key == 'g'){  
                           fondo = 0;
  
                         }
                     }      
            }
         }
 }  
 
void intro(){
    
           if (keyPressed){
               fondo = 1;
            }
 }
 
 
void juego(){ 
 
 
        stroke(255);
        line(50,290,70,320);
        line(90,290,70,320);
        line(70,320,70,350);
            
            
       if(mousePressed){
               fill(255);
               line(50,290,mouseX,mouseY);
               line(90,290,mouseX,mouseY);
        }       
  
      x = 70 - mouseX;
      x = x/2;
      y = 290 - mouseY;
      y = y/2; 
  
  // We must always step through time!
  box2d.step();

 

 
 // Display all the boxes
    for (Box b: boxes) {
          b.display();
      }
      
  // Boxes that leave the screen, we delete them
    for (int i = boxes.size()-1; i >= 0; i--) {
          Box b = boxes.get(i);
      
        if (b.done()) {
              boxes.remove(i);
         }
      }
 }

void mouseReleased() {
  
       Box p = new Box(mouseX,mouseY);
           boxes.add(p);
  
 }