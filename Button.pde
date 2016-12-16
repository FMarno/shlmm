abstract class Button {
  String word;
  PVector location;
  int w;
  int h;
  int fill;

  abstract void display();

  abstract void action();
  
  boolean contains(PVector l){
   return (location.x - w/2 <= l.x && l.x <= location.x+w/2 && location.y - h/2 <= l.y && l.y <= location.y + h/2);
  }
}