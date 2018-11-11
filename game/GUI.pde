class GUI {
  /**
  This class is used for drawing and handeling all UI related screens and elements  
  **/
   
  private Button play, back, options, menu, exit, pause;
  private PImage title = loadImage("/assets/sprites/title.png");
  private PGraphics screen;
  private color c = 100;
  
  GUI() {
    //need to set buttons and whatnot here
    play = new Button (width/2 - TILE_SIZE, height/2 - TILE_SIZE * 2, "PLAY");
    options = new Button (width/2 - TILE_SIZE, height/2 + TILE_SIZE * 0, "OPTIONS");
    menu = new Button (width/2 - TILE_SIZE, height/2 + TILE_SIZE * 1, "MENU");
    back = new Button (width/2 - TILE_SIZE, height/2 + TILE_SIZE * 2, "BACK");
    exit = new Button(width/2 - TILE_SIZE,  height/2 + TILE_SIZE * 1, "EXIT");
    pause = new Button(width - 2 * TILE_SIZE, TILE_SIZE, "PAUSE");
    screen = createGraphics(width, height);
  }
  
  public void clearScreen() {
    screen.background(0, 0);
  }
  
  public void drawMenu() {
    //Draws the main menu
    screen.beginDraw();
    screen.background(title);
    screen.background(c);
    play.show(screen);
    options.show(screen);
    exit.show(screen);
    screen.endDraw();
    image(screen, 0, 0);
  }
  
  public void drawOptions() {
    //Draws the options menu
    screen.beginDraw();
    screen.background(c);
    back.show(screen);
    screen.endDraw();
    image(screen, 0, 0);
  }
  
  public void drawPaused() {
    //Draws the paused overlay
    screen.beginDraw();
    clearScreen();
    screen.fill(0, 100);
    screen.rect(-TILE_SIZE, -TILE_SIZE, width + TILE_SIZE, height + TILE_SIZE);
    menu.show(screen);
    options.show(screen);
    play.show(screen);
    screen.endDraw();
    image(screen, 0, 0);
  }
  
  public void drawPause() {
    //Draws the pause button during gameplay
    screen.beginDraw();
    clearScreen();
    pause.show(screen);
    screen.endDraw();
    image(screen, 0, 0);
  }
  
  public void handleMouseReleased() {
    //used for checking input
    if(play.pressed(mouseX, mouseY) && (STATE == "MENU" || STATE == "PAUSED")) {
      setState("PLAYING");
    }else if(options.pressed(mouseX, mouseY) && (STATE == "MENU" || STATE == "PAUSED")) {
      setState("OPTIONS");
    }else if(menu.pressed(mouseX, mouseY) && STATE == "PAUSED") {
      setState("MENU");
    }else if(pause.pressed(mouseX, mouseY) && STATE == "PLAYING") {
      setState("PAUSED");    
    }else if(exit.pressed(mouseX, mouseY) && STATE == "MENU") {
      quitGame();
    } else if(back.pressed(mouseX, mouseY) && (STATE == "OPTIONS")) {
      revertState();
    }
  }
  
}

class Button {
  
  private float x, y, w, h;
  private String spriteName;
  
  Button(float x, float y, String spriteName) {
    this.x = x;
    this.y = y;
    this.w = guiSprites.get(spriteName).width * SCALE;
    this.h = guiSprites.get(spriteName).height * SCALE;
    this.spriteName = spriteName;
  }
  
  public boolean pressed(float mX, float mY) {
    return pointInBox(mX, mY, x, y, w, h);
  }
  
  public void show(PGraphics screen) {
    PImage sprite = guiSprites.get(spriteName);
    screen.image(sprite, x, y, sprite.width * SCALE, sprite.height * SCALE);
  }
  
}
