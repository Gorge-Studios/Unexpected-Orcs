import java.util.Map;
import java.util.PriorityQueue;
import java.util.Comparator;

// HashMap<String, SoundFile> soundFiles;

final int GUI_WIDTH = 240;

final int TILE_SIZE = 64;
final int SPRITE_SIZE = 16;
final int SCALE = TILE_SIZE/SPRITE_SIZE; 

public int[] keys = {0, 0, 0, 0, 0};
public float miniMapZoom = 1;
public float zoomMax = 5;
public float zoomMin = 1;
public boolean inMenu = false;

public PFont bitcell;

public String STATE;
public String PREV_STATE;

public PGraphics debugScreen;
public boolean drawDebug = false;

public String loadMessage = "Litty";
public String loadedPlayerName = "";
public Player[] loadedPlayers = new Player[0];

public Engine engine;
public GUI gui;
public ItemFactory itemFactory = new ItemFactory();

void setup() {
  size(1080, 720, FX2D);
  noSmooth();
  frameRate(60);

  setState("LOADING");
  thread("loadAssets");
  thread("loadSettings");
  // thread("loadSounds");
  
  bitcell = createFont("./assets/fonts/bitcell.ttf", TILE_SIZE);
  textFont(bitcell);
  textAlign(CENTER, CENTER);
  textSize(TILE_SIZE);
  
  debugScreen = createGraphics(width, height);
  
  engine = new Engine();
  gui = new GUI();
  
  //try {
  //  engine.player = readStats("SUPERSS.txt");
  //} catch (IOException ioe) {
  //  println(ioe);
  //}
}

void draw() {
  switch(STATE) {
  case "LOADING": 
    gui.drawLoading();
    break;
  case "MENU":
    gui.drawMenu();
    break;
  case "OPTIONS":
    gui.drawOptions();
    break;
  case "PLAYING":
    //thread("update");
    engine.update();
    engine.show();
    gui.drawPlay(engine.player);
    if(drawDebug) {
      image(debugScreen, 0, 0);
      debugScreen.beginDraw();
      debugScreen.clear();
      debugScreen.endDraw();
    }
    break;
  case "PAUSED":
    engine.show();
    gui.drawPaused(); 
    break;
  case "DEAD":
    gui.drawDead();
    break;
  case "SAVE":
    gui.drawSave();
    break;
  case "NEWGAME":
    gui.drawNewGame();
    break;
  case "LOAD":
    gui.drawLoad();
    break;
  }
  
    
}

public void update() {
  engine.update();
}

void mouseReleased() {
  gui.handleMouseReleased();
}

void mouseWheel(MouseEvent e) {
  if(STATE == "PLAYING"){
    miniMapZoom -= e.getCount();
    miniMapZoom = constrain(miniMapZoom, zoomMin, zoomMax);
  } else if(STATE == "LOAD") {
    gui.loadScroll.changeScrollPosition(e.getCount());
  }
}


void keyPressed() {
  if (remapNextKey) remapKey(remapAction, keyCode);
  if (keyCode == UP_KEY) keys[up] = 1;
  if (keyCode == LEFT_KEY) keys[left] = 1;
  if (keyCode == DOWN_KEY) keys[down] = 1;
  if (keyCode == RIGHT_KEY) keys[right] = 1;
  if (keyCode == ABILITY_KEY) keys[ability] = 1;
  if(characterNaming) gui.keyPressed(key);
}
void keyReleased() {
  if (keyCode == UP_KEY) keys[up] = 0;
  if (keyCode == LEFT_KEY) keys[left] = 0;
  if (keyCode == DOWN_KEY) keys[down] = 0;
  if (keyCode == RIGHT_KEY) keys[right] = 0;
  if (keyCode == ABILITY_KEY) keys[ability] = 0;
}


void dispose() {
  //runs when the "x" button is pressed
  quitGame();
}

public void quitGame() {
  //do all savey-stuff here
  saveGame();
  exit();
}

public void setState(String state) {
  remapNextKey = false;
  PREV_STATE = STATE;
  STATE = state;
}

public void revertState() {
  STATE = PREV_STATE;
}

public float fastAbs(float v) {
  if (v < 0) return v * -1;
  return v;
}