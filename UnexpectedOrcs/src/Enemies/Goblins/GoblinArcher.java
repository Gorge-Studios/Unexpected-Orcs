package Enemies.Goblins;

import Enemies.Enemy;
import Enemies.RangedEnemy;
import Entities.Drops.ItemBag;
import Entities.Drops.StatOrb;
import Utility.Collision.RectangleObject;
import Utility.Util;

import static Utility.Constants.*;
import static Utility.Colour.*;
import static Sprites.Sprites.*;

public class GoblinArcher extends RangedEnemy implements Enemy, RectangleObject {

    private float w = 0.4f, h = 0.5f;

    public GoblinArcher(float x, float y, int tier) {
        super(x, y, tier, charSprites.get("GOBLIN_ARCHER"));
        stats.speed = 0.7f + 0.2f * tier;
        stats.attack = 5 + 15 * tier;
        stats.defence = 2 + 2 * tier;
        stats.health = 10 + 8 * tier;
        stats.vitality = 1;
        shotWaitTime = 0.9f - game.abs(0.03f * tier * game.randomGaussian());
        shootDistance = 2.6f;
        retreatDistance = 2;
        accuracy = 0.04f;
        projectileSprite = Util.getCombinedSprite(projectileSprites.get("ARROW"), projectileSprites.get("ARROW_TIP"), colour(50,50,50));
    }

    public float getWidth() {
        return w;
    }

    public float getHeight() {
        return h;
    }

    public void onDeath() {
        engine.addDrop(new StatOrb(x, y, tier, "HEALTH"));
        ItemBag itembag = new ItemBag(x, y, tier);
        if(game.random(1) < 0.2) {
            itembag.addItem(itemFactory.createBow(tier));
        }
        engine.addDrop(itembag);
    }

}