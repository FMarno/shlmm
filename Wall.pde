class Wall {
  int x1, y1;
  int x2, y2;
  PVector start;
  PVector end;
  PVector centre;

  public Wall(int x1, int y1, int x2, int y2) {
    if (x1 >x2){
     int t = x2;
     x2 = x1;
     x1 =t;
    }
    if (y1 >y2){
     int t = y2;
     y2 = y1;
     y1 =t;
    }
    this.x1 = x1;
    this.y1 = y1;
    this.x2 = x2;
    this.y2 = y2;
    start = gridCoordsToPoint(new Tuple(x1, y1));
    end = gridCoordsToPoint(new Tuple(x2, y2));
    end.x += SQUARE_SIZE;
    end.y += SQUARE_SIZE;
    centre = start.copy();
    centre.add((end.x - start.x)/2, (end.y - start.y)/2);
  }


  void display() {
    noStroke();
    fill(#22201A);
    rect(centre.x, centre.y, end.x - start.x, end.y - start.y);
  }

  Tuple<Integer, Integer> pointToGridCoords(PVector location) {
    int wide = width/SQUARE_SIZE;
    int hei = height/SQUARE_SIZE;
    int x = floor(location.x)/wide;
    int y = floor(location.y)/hei;
    return new Tuple(x, y);
  }

  PVector gridCoordsToPoint(Tuple<Integer, Integer> coords) {
    float x = coords.x * SQUARE_SIZE;
    float y = coords.y * SQUARE_SIZE;
    return new PVector(x, y);
  }

  boolean intersectedBy(final PVector pi, final PVector px) {
    Line2D.Float line = new Line2D.Float(pi.x, pi.y, px.x, px.y);

    return line.intersects(start.x, start.y, end.x-start.x, end.y-start.y);
  }
  
  boolean contains(final PVector p){
   return (start.x <= p.x && start.y <= p.y && p.x <= end.x && p.y <= end.y); 
  }
}