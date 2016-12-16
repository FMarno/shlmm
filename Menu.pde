class Menu {
  ArrayList<Button> buttons = new ArrayList<Button>();

  void display() {
    for (Button b : buttons) {
      b.display();
    }
  }
  
  void press(PVector location){
   for (Button b : buttons){
    if (b.contains(location)){
     b.action(); 
    }
   }
  }
}