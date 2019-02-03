package Enemies.Elementals;

import Enemies.Enemy;
import Entities.Drops.StatOrb;

import static Utility.Constants.*;
import static Sprites.Sprites.*;

public class FireElemental extends Elemental implements Enemy {

    public FireElemental(float x, float y, int tier) {
        super(x, y, tier);
        statusEffect = "SICK";
        sprite = charSprites.get("FIRE_ELEMENTAL");
        sprites[0] = charSprites.get("FIRE_ELEMENTAL");
        sprites[1] = charSprites.get("FIRE_ELEMENTAL_2");
        sprites[2] = charSprites.get("FIRE_ELEMENTAL_3");
        sprites[3] = charSprites.get("FIRE_ELEMENTAL_4");
    }

    public void onDeath() {
        engine.addDrop(new StatOrb(x, y, tier, "VITALITY"));
    }

}