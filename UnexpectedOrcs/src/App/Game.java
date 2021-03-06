package App;

import Engine.Engine;
import File.GameFile;
import GUI.GUI;
import GUI.Screens.LoadScreen;
import GUI.Screens.LoadingScreen;
import GUI.Screens.NewGameScreen;
import GUI.Screens.OptionsScreen;
import Levels.Dungeons.Cave;
import Levels.Level;
import Settings.Settings;
import Sound.SoundManager;
import Sprites.Sprites;
import Tiles.Tiles;
import Utility.Constants;
import Utility.Util;
import processing.core.PApplet;
import processing.core.PGraphics;
import processing.core.PImage;
import processing.core.PVector;
import processing.event.MouseEvent;
import processing.opengl.PGraphicsOpenGL;
import processing.opengl.PJOGL;

import java.util.Objects;

import static Levels.Generator.getBitMaskValue;
import static Settings.Settings.*;
import static Utility.Constants.*;

public class Game extends PApplet{


    public GameState STATE;
    public GameState PREV_STATE;

    public PImage title;

    public static PGraphics debugScreen;
    public static boolean drawDebug = false;

    public static void main(String[] args) {
        String[] appletArgs = new String[] { "Game" };
        Game game = new Game();
        PApplet.runSketch(appletArgs, game);
    }

    public void settings() {
        size(1280, 720, P2D);
        pixelDensity(displayDensity());
        noSmooth();
        PJOGL.setIcon("/assets/sprites/icon.png");
    }

    public void setup() {
        frameRate(60);

        surface.setTitle("Unexpected Orcs");

        setState(GameState.LOADING);
        thread("load");

        bitcell = createFont("./assets/fonts/bitcell.ttf", TILE_SIZE);

        outlineShader = loadShader("/assets/shaders/outlineFrag.glsl");//, "/assets/shaders/outlineVert.glsl");
        outlineShader.set("scale", SCALE);

        textFont(bitcell);
        textAlign(CENTER, CENTER);
        textSize(TILE_SIZE);
        title = loadImage("/assets/sprites/title.png");

        debugScreen = createGraphics(width, height);
    }

    public void draw() {
        updateMouse();

        if(STATE.equals(GameState.TEST)) {
            for(int i = 0; i < 10; i ++) {
                println("Test " + i);
                Level level = new Cave();
                level.setName("CaveTest" + i);
                level.saveLevel();
            }
        }

        if(STATE.equals(GameState.PLAYING)) {
            engine.update();
            engine.show();
            if(drawDebug) {
                image(debugScreen, 0, 0);
                debugScreen.beginDraw();
                debugScreen.clear();
                debugScreen.endDraw();
            }
        } else if (STATE.equals(GameState.PAUSED)) {
            engine.show();
        }

        if(STATE.equals(GameState.LOADING)) {
            LoadingScreen.show(g);
        } else {
            gui.show();
        }

    }

    public void mouseReleased() {
       if(gui != null) gui.handleMouseReleased();
    }

    public void mouseWheel(MouseEvent e) {
        if(STATE.equals(GameState.PLAYING)){
            miniMapZoom -= e.getCount();
            miniMapZoom = constrain(miniMapZoom, zoomMin, zoomMax);
        } else if(STATE.equals(GameState.LOAD)) {
            LoadScreen.loadScroll.changeScrollPosition(e.getCount() * 20);
        } else if(STATE.equals(GameState.OPTIONS)) {
            OptionsScreen.settingsScroll.changeScrollPosition(e.getCount() * 20);
        }
    }

    public void keyPressed() {
        if (remapNextKey) remapKey(remapAction, keyCode);
        if(gui.keyInput) { gui.handleKeyInput(key); return; }
        if(key == '`') {
            drawDebug = !drawDebug;
            String state = "disabled";
            if(drawDebug) state = "enabled";
            engine.addText("Debug " + state, engine.player.x - 1, engine.player.y, 1f, 255);
            return;
        }
        if (keyCode == UP_KEY) keys[up] = 1;
        if (keyCode == LEFT_KEY) keys[left] = 1;
        if (keyCode == DOWN_KEY) keys[down] = 1;
        if (keyCode == RIGHT_KEY) keys[right] = 1;
        if (keyCode == ABILITY_KEY) keys[ability] = 1;
        if (keyCode == INTERACT_KEY) keys[interact] = 1;
    }

    public void keyReleased() {
        if (keyCode == UP_KEY) keys[up] = 0;
        if (keyCode == LEFT_KEY) keys[left] = 0;
        if (keyCode == DOWN_KEY) keys[down] = 0;
        if (keyCode == RIGHT_KEY) keys[right] = 0;
        if (keyCode == ABILITY_KEY) keys[ability] = 0;
        if (keyCode == INTERACT_KEY) keys[interact] = 0;

        if(STATE.equals(GameState.PLAYING)) {
            if(keyCode == HOT_SWAP_0) {
                engine.player.inv.hotSwap(0);
            } else if(keyCode == HOT_SWAP_1) {
                engine.player.inv.hotSwap(1);
            } else if(keyCode == HOT_SWAP_2) {
                engine.player.inv.hotSwap(2);
            } else if(keyCode == HOT_SWAP_3) {
                engine.player.inv.hotSwap(3);
            }
        }

    }

    public void dispose() {
        //runs when the "x" button is pressed
        quitGame();
    }

    public void quitGame() {
        GameFile.saveGame();
        exit();

        //give the game 1/2 a second to close
        delay(500);
        //force the game to close if it doesn't
        Runtime.getRuntime().halt(0);
    }

    public void setState(GameState state) {
        remapNextKey = false;
        PREV_STATE = STATE;
        STATE = state;
    }

    public void revertState() {
        STATE = PREV_STATE;
    }

    public void load() {
        loadPercentage = 0;
        loadMessage = "Setting up variables";
        Constants.setGame(this);

        loadPercentage = 1/7f;
        loadMessage = "Loading Settings";
        Settings.loadSettings();

        loadPercentage = 2/7f;
        loadMessage = "Loading Assets";
        Sprites.loadAssets();
        Tiles.loadTileJSON("/assets/data/tiles.json");

        loadPercentage = 3/7f;
        loadMessage = "Generating level";
        Constants.setEngine(new Engine());


        loadPercentage = 4/7f;
        loadMessage = "Making the GUI beautiful";
        Constants.setGUI(new GUI());

        loadPercentage = 5/7f;
        loadMessage = "Loading Sounds";
        SoundManager.loadSounds(this);
        SoundManager.playMusic("TEST_MUSIC");

        loadPercentage = 6/7f;
        loadMessage = "Loading Stats";
        loadStats();

        loadPercentage = 1;
        loadMessage = "DONE!";
        setState(GameState.MENU);
    }

    private void updateMouse() {
        if(mousePressed) {
            mouseDownCount ++;
            mouseUpCount = 0;
        } else {
            mouseUpCount ++;
            mouseDownCount = 0;
        }

        mouseReleased = mouseUpCount < mouseCountThreshold && !mousePressed;
        mouseClicked = mouseDownCount < mouseCountThreshold && mousePressed;
    }

    public void loadClosestPortal() {
        loadPercentage = 0;
        loadMessage = "Generating Level";
        engine.currentLevel = engine.getClosestPortal().getLevel();

        loadPercentage = 1/4f;
        loadMessage = "Sweeping the floors";
        engine.initiateDrops();

        loadPercentage = 2/4f;
        loadMessage = "Putting you in the right spot";
        engine.player.x = engine.currentLevel.start.x;
        engine.player.y = engine.currentLevel.start.y;

        loadPercentage = 3/4f;
        loadMessage = "Saving the Game";
        GameFile.saveGame();

        loadPercentage = 1;
        loadMessage = "DONE!";
        setState(GameState.PLAYING);
    }

    public void resize(int w, int h) {
        surface.setSize(w, h);
    }
}
