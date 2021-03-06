package GUI.Screens;

import App.GameState;
import Enemies.Enemy;
import Enemies.StandardEnemy;
import Entities.Drops.Portal;
import GUI.Bars.DisplayBar;
import GUI.WrappedText;
import Items.Inventory;
import Stats.StatusEffectType;
import Utility.Util;
import GUI.Button;
import processing.core.PGraphics;
import processing.core.PImage;

import static Sprites.Sprites.guiSprites;
import static Sprites.Sprites.playerStatusSprites;
import static Utility.Colour.*;
import static Utility.Constants.*;

public class PlayScreen extends GUIScreen {

    private static final int invBuff = 5, invScale = 2, itemOffset = 1, invSize = SPRITE_SIZE * invScale + 2 * itemOffset;
    public static final int invX = (GUI_WIDTH - ((invSize * Inventory.WIDTH) + (invBuff * Inventory.WIDTH + itemOffset)))/2, invY = 7 * TILE_SIZE/2;

    private static Button pause = new Button(game.width - 1.5f * TILE_SIZE, 0.5f * TILE_SIZE, "PAUSE");
    private static Button enterPortal = new Button(GUI_WIDTH/2 - TILE_SIZE, 14 * TILE_SIZE/2, "BLANK_2x1");

    private static DisplayBar healthBar = new DisplayBar(GUI_WIDTH/2 - TILE_SIZE * 1.5f + 4, TILE_SIZE/2 - invBuff, colour(230, 100, 100));
    private static DisplayBar manaBar = new DisplayBar(GUI_WIDTH/2 - TILE_SIZE * 1.5f + 4, 2 * TILE_SIZE/2, colour(153, 217, 234));

    private static DisplayBar bossBar = new DisplayBar(game.width/2 - TILE_SIZE * 4, game.height - TILE_SIZE * 1.5f, colour(230, 100, 100), "BOSS_BAR");


    private static boolean showingPortal = false;

    private static PImage map, over;
    private static float pZoomLevel;

    public static void show(PGraphics screen) {
        //Draws the GUI during gameplay

        healthBar.updateBar(engine.player.stats.health, engine.player.stats.healthMax);
        manaBar.updateBar(engine.player.stats.mana, engine.player.stats.manaMax);

        screen.beginDraw();
        clearScreen(screen);
        screen.fill(217);
        screen.rect(0, 0, GUI_WIDTH, game.height);

        pause.show(screen);
        screen.textAlign(game.CENTER);
        screen.fill(50, 50, 50);
        screen.textSize(TILE_SIZE / 2);
        screen.text(loadedPlayerName, GUI_WIDTH / 2, 20);
        healthBar.show(screen);
        manaBar.show(screen);
        showStatusEffects(screen);
        drawQuest(screen);
        renderMiniMap(screen);
        drawPortal(screen);

        engine.player.inv.show(screen, invX, invY);
        engine.player.inv.drawCooldown(screen, invX, invY);

        engine.player.stats.show(screen, GUI_WIDTH * 2 / 5 - TILE_SIZE * 9 / 8, 73 + TILE_SIZE / 2);

        screen.endDraw();
        game.image(screen, 0, 0);

        if (Util.pointInBox(game.mouseX, game.mouseY, 0, 0, GUI_WIDTH, game.height) || Util.pointInBox(game.mouseX, game.mouseY, pause.x, pause.y, pause.w, pause.h)) {
            inMenu = true;
        } else {
            inMenu = false;
        }
    }

    public static void handleMouseReleased() {
        if(showingPortal && enterPortal.pressed()) {
            engine.enterClosestPortal();
        } else if(pause.pressed()) {
            game.setState(GameState.PAUSED);
        }
    }

    private static void drawPortal(PGraphics screen) {
        Portal portal = engine.getClosestPortal();
        if (portal == null) {
            showingPortal = false;
            return;
        }
        showingPortal = true;
        enterPortal.show(screen);
        screen.fill(255);
        screen.textAlign(game.CENTER, game.CENTER);
        screen.text("Enter " + portal.name, enterPortal.x, enterPortal.y, enterPortal.w, enterPortal.h);
    }

    private static void renderMiniMap(PGraphics screen) {


        float vw = GUI_WIDTH - (2 * invBuff); //game.width of the view
        float vh = vw * 0.8f;

        int scale = (int) game.map(miniMapZoom, zoomMin, zoomMax, 4, 20);

        int sx = (int) ((engine.player.x * scale) - vw / 2); //get the x-cord to start
        int sy = (int) ((engine.player.y * scale) - vh / 2); //get the y-cord to start

        map = Util.scaleImage(engine.currentLevel.getMiniMap().get(), (int) scale);
        over = Util.scaleImage(engine.currentLevel.getOverlay().get(), (int) scale);
        pZoomLevel = miniMapZoom;

        screen.fill(150);
        screen.rect(0, game.height - vh - invBuff * 2, vw + invBuff * 2, vh + invBuff * 2);
        screen.fill(0);
        screen.rect(invBuff, game.height - vh - invBuff, vw, vh);
        screen.image(map.get(sx, sy, (int)vw, (int)vh), invBuff, game.height - vh - invBuff, vw, vh);
        screen.image(over.get(sx, sy, (int)vw, (int)vh), invBuff, game.height - vh - invBuff, vw, vh);
    }

    private static void showStatusEffects(PGraphics screen) {
        int i = 0;
        StatusEffectType mouseOverEffect = null;
        for (StatusEffectType effect : engine.player.stats.statusEffects.keySet()) {
            i++;
            screen.image(playerStatusSprites.get(effect), screen.width - i * TILE_SIZE, screen.height - TILE_SIZE, TILE_SIZE, TILE_SIZE);
            if (Util.pointInBox(game.mouseX, game.mouseY, screen.width - i * TILE_SIZE, screen.height - TILE_SIZE, TILE_SIZE, TILE_SIZE)) {
                mouseOverEffect = effect;
            }
        }

        if (mouseOverEffect != null) {
            int mouseOverWidth = 3 * GUI_WIDTH/4;
            WrappedText title = WrappedText.wrapText(mouseOverEffect.name(), mouseOverWidth - gui.buff * 4, TILE_SIZE/2);
            WrappedText subtitle = WrappedText.wrapText(Util.roundTo(engine.player.stats.statusEffects.get(mouseOverEffect), 10) + "s remaining", mouseOverWidth - gui.buff * 4, TILE_SIZE/2);
            WrappedText description = WrappedText.wrapText("", mouseOverWidth - gui.buff * 4, 0);
            gui.drawMouseOverText(game.mouseX, game.mouseY, title, subtitle, description);
        }
    }

    private static void drawQuest(PGraphics screen) {
        float x = (game.width - GUI_WIDTH)/2 + GUI_WIDTH;
        float y = game.height/2;
        PImage sprite = null;
        for (Enemy boss : engine.currentLevel.bosses) {
            if(((StandardEnemy) boss).stats.health <= 0) continue;
            float bx = ((StandardEnemy)boss).x;
            float by = ((StandardEnemy)boss).y;
            if(engine.currentLevel.visited((int)bx, (int)by) && game.dist(bx, by, engine.player.x, engine.player.y) < game.min(x, y)/TILE_SIZE + 1) {
                bossBar.updateBar(((StandardEnemy) boss).stats.health, ((StandardEnemy) boss).stats.healthMax);
                bossBar.show(screen);
            } else if(game.dist(bx, by, engine.player.x, engine.player.y) > game.min(x, y)/TILE_SIZE) {
                float ang = game.atan2(by - engine.player.y, bx - engine.player.x);

                float absCos = game.abs(game.cos(ang));
                float absSin = game.abs(game.sin(ang));

                float d = y/absSin;

                if((x - GUI_WIDTH) * absSin < y * absCos) {
                    d = (x - GUI_WIDTH)/absCos;
                }

                d -= TILE_SIZE/2;

                float dx = x + game.cos(ang) * d;
                float dy = y + game.sin(ang) * d;
                screen.pushMatrix();
                screen.translate(dx, dy);
                screen.rotate(ang);
                screen.image(guiSprites.get("QUEST"), -TILE_SIZE / 4, -TILE_SIZE / 4, TILE_SIZE / 2, TILE_SIZE / 2);
                screen.popMatrix();
                if (game.dist(game.mouseX, game.mouseY, dx, dy) < TILE_SIZE / 2) {
                    sprite = ((StandardEnemy) boss).sprite;
                }
            }
        }
        if (sprite != null) {
            gui.drawMouseOverSprite(game.mouseX, game.mouseY, sprite);
        }
    }

    public static void refresh() {
        int invBuff = 5, invScale = 2, itemOffset = 1, invSize = SPRITE_SIZE * invScale + 2 * itemOffset;
        int invX = (GUI_WIDTH - ((invSize * Inventory.WIDTH) + (invBuff * Inventory.WIDTH + itemOffset)))/2, invY = 7 * TILE_SIZE/2;

        pause = new Button(game.width - 1.5f * TILE_SIZE, 0.5f * TILE_SIZE, "PAUSE");
        enterPortal = new Button(GUI_WIDTH/2 - TILE_SIZE, 14 * TILE_SIZE/2, "BLANK_2x1");

        healthBar = new DisplayBar(GUI_WIDTH/2 - TILE_SIZE * 1.5f + 4, TILE_SIZE/2 - invBuff, colour(230, 100, 100));
        manaBar = new DisplayBar(GUI_WIDTH/2 - TILE_SIZE * 1.5f + 4, 2 * TILE_SIZE/2, colour(153, 217, 234));

        bossBar = new DisplayBar(game.width/2 - TILE_SIZE * 4, game.height - TILE_SIZE * 1.5f, colour(230, 100, 100), "BOSS_BAR");

        showingPortal = false;
    }

}
