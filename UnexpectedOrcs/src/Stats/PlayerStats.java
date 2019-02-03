package Stats;

import GUI.WrappedText;
import Utility.Util;
import processing.core.PGraphics;
import processing.core.PImage;

import java.io.Serializable;
import java.util.HashMap;

import static Utility.Constants.*;
import static Sprites.Sprites.*;

public class PlayerStats extends Stats implements Serializable {

    //-----KEEP TRACK OF KILLS AND TIERS----
    public HashMap<Integer, Integer> healthKills = new HashMap<Integer, Integer>();
    public HashMap<Integer, Integer> manaKills = new HashMap<Integer, Integer>();
    public HashMap<Integer, Integer> vitalityKills = new HashMap<Integer, Integer>();
    public HashMap<Integer, Integer> attackKills = new HashMap<Integer, Integer>();
    public HashMap<Integer, Integer> wisdomKills = new HashMap<Integer, Integer>();
    public HashMap<Integer, Integer> defenceKills = new HashMap<Integer, Integer>();
    public HashMap<Integer, Integer> speedKills = new HashMap<Integer, Integer>();

    private int baseHealth = 100, baseMana = 100;
    public int baseVitality = 5, baseAttack = 1, baseWisdom = 5, baseDefence = 1;

    private float baseSpeed = 2;

    private int totalKills = 0;

    public PlayerStats() {
        calcAllStats();
        health = baseHealth;
        mana = baseMana;
    }

    public void addKill() {
        totalKills ++;
    }

    public void addOrbStat(String stat, int tier) {
        switch(stat) {
            case("HEALTH"):
                healthKills.put(tier, healthKills.getOrDefault(tier, 0) + 1);
                healthMax = (int)calcStatValue(healthKills, baseHealth, 5, 0.5f);
                break;
            case("MANA"):
                manaKills.put(tier, manaKills.getOrDefault(tier, 0) + 1);
                manaMax = (int)calcStatValue(manaKills, baseMana, 5, 0.2f);
                break;
            case("VITALITY"):
                vitalityKills.put(tier, vitalityKills.getOrDefault(tier, 0) + 1);
                vitality = (int)calcStatValue(vitalityKills, baseVitality, 1, 0.1f);
                break;
            case("ATTACK"):
                attackKills.put(tier, attackKills.getOrDefault(tier, 0) + 1);
                attack = (int)calcStatValue(attackKills, baseAttack, 1, 0.1f);
                break;
            case("WISDOM"):
                wisdomKills.put(tier, wisdomKills.getOrDefault(tier, 0) + 1);
                wisdom = (int)calcStatValue(wisdomKills, baseWisdom, 1, 0.1f);
                break;
            case("DEFENCE"):
                defenceKills.put(tier, defenceKills.getOrDefault(tier, 0) + 1);
                defence = (int)calcStatValue(defenceKills, baseDefence, 1, 0.1f);
                break;
            case("SPEED"):
                speedKills.put(tier, speedKills.getOrDefault(tier, 0) + 1);
                speed = calcStatValue(speedKills, baseSpeed, 1, 0.1f);
                break;
        }
    }

    public void calcAllStats() {
        healthMax = (int)calcStatValue(healthKills, baseHealth, 5, 0.5f);
        manaMax = (int)calcStatValue(manaKills, baseMana, 5, 0.2f);
        vitality = (int)calcStatValue(vitalityKills, baseVitality, 1, 0.1f);
        attack = (int)calcStatValue(attackKills, baseAttack, 1, 0.1f);
        wisdom = (int)calcStatValue(wisdomKills, baseWisdom, 1, 0.1f);
        defence = (int)calcStatValue(defenceKills, baseDefence, 1, 0.1f);
        speed = calcStatValue(speedKills, baseSpeed, 1, 0.1f);
    }

    public float calcStatValue(HashMap<Integer, Integer> stat, float base, int max, float rate) {
        float value = base;
        for(int tier : stat.keySet()) {
            value += calcStatTierValue(max, rate, stat.get(tier)) * (tier + 1);
        }
        return value;
    }

    private float calcStatTierValue(int max, float rate, int num) {
        return (-max * game.exp(-rate * num) + max);
    }

    public int getTotalKills() {
        return totalKills;
    }

    @Override
    public String toString() {
        String text = "";

        text += " Health: " + this.getHealthMax();
        text += " Mana: " + this.getManaMax();
        text += " Attack: " + this.getAttack();
        text += " Defence: " + this.getDefence();
        text += " Vitality: " + this.getVitality();
        text += " Wisdom: " + this.getWisdom();
        text += " Speed: " + (int)(100 * this.getSpeed());


        return text;

    }

    public void show(PGraphics screen, float x, float y) {
        PImage attackSprite = itemSprites.get("ATTACK_ICON");
        PImage defenceSprite = itemSprites.get("DEFENCE_ICON");
        PImage vitalitySprite = itemSprites.get("VITALITY_ICON");
        PImage wisdomSprite = itemSprites.get("WISDOM_ICON");
        PImage speedSprite = itemSprites.get("SPEED_ICON");

        screen.pushMatrix();
        screen.translate(x, y);

        screen.noStroke();


        //Stat progress
        float attackFloat = calcStatValue(attackKills, baseAttack, 1, 0.1f);
        attackFloat = attackFloat % 1;
        screen.fill(150, 150, 150);
        screen.rect(0, 0, SPRITE_SIZE/2, SPRITE_SIZE * 2);
        screen.fill(statColours.get("ATTACK"));
        screen.rect(0, SPRITE_SIZE * 2, SPRITE_SIZE/2, - SPRITE_SIZE * 2 * attackFloat);

        float defenceFloat = calcStatValue(defenceKills, baseDefence, 1, 0.1f);
        defenceFloat = defenceFloat % 1;
        screen.fill(150, 150, 150);
        screen.rect(TILE_SIZE * 3/2, 0, SPRITE_SIZE/2, SPRITE_SIZE * 2);
        screen.fill(statColours.get("DEFENCE"));
        screen.rect(TILE_SIZE * 3/2, SPRITE_SIZE * 2, SPRITE_SIZE/2, -SPRITE_SIZE * 2 * defenceFloat);

        float vitalityFloat = calcStatValue(vitalityKills, baseVitality, 1, 0.1f);
        vitalityFloat = vitalityFloat % 1;
        screen.fill(150, 150, 150);
        screen.rect(0, gui.buff + TILE_SIZE/2, SPRITE_SIZE/2, SPRITE_SIZE * 2);
        screen.fill(statColours.get("VITALITY"));
        screen.rect(0, gui.buff + TILE_SIZE/2 + SPRITE_SIZE * 2, SPRITE_SIZE/2, - SPRITE_SIZE * 2 * vitalityFloat);

        float wisdomFloat = calcStatValue(wisdomKills, baseWisdom, 1, 0.1f);
        wisdomFloat = wisdomFloat % 1;
        screen.fill(150, 150, 150);
        screen.rect(TILE_SIZE * 3/2, gui.buff + TILE_SIZE/2, SPRITE_SIZE/2, SPRITE_SIZE * 2);
        screen.fill(statColours.get("WISDOM"));
        screen.rect(TILE_SIZE * 3/2, gui.buff + TILE_SIZE/2 + SPRITE_SIZE * 2, SPRITE_SIZE/2, - SPRITE_SIZE * 2 * wisdomFloat);

        screen.textAlign(game.LEFT);
        screen.textSize(TILE_SIZE/2);
        screen.fill(30);

        //Draw stat values
        screen.text(attack, TILE_SIZE, SPRITE_SIZE * 3/2);
        screen.text(defence, TILE_SIZE * 5/2, SPRITE_SIZE * 3/2);
        screen.text(vitality, TILE_SIZE, gui.buff + SPRITE_SIZE * 3/2 + TILE_SIZE/2);
        screen.text(wisdom, TILE_SIZE * 5/2, gui.buff + SPRITE_SIZE * 3/2 + TILE_SIZE/2);
        screen.text((int)(speed * 100), TILE_SIZE, 2 * gui.buff + SPRITE_SIZE * 3/2 + TILE_SIZE);

        //Draw stat sprites
        screen.image(attackSprite, TILE_SIZE/2 - gui.buff * 2, 0, attackSprite.width * 2, attackSprite.height * 2);
        screen.image(defenceSprite, TILE_SIZE * 2 - gui.buff * 2, 0, defenceSprite.width * 2, defenceSprite.height * 2);
        screen.image(vitalitySprite, TILE_SIZE/2 - gui.buff * 2, gui.buff + TILE_SIZE / 2, vitalitySprite.width * 2, vitalitySprite.height * 2);
        screen.image(wisdomSprite, TILE_SIZE * 2 - gui.buff * 2, gui.buff + TILE_SIZE / 2, wisdomSprite.width * 2, wisdomSprite.height * 2);
        screen.image(speedSprite, TILE_SIZE/2 - gui.buff * 2, 2 * gui.buff + TILE_SIZE, speedSprite.width * 2, speedSprite.height * 2);
        screen.popMatrix();

        mouseOverStat(x, y);


    }

    private void mouseOverStat(float tx, float ty) {

        int x = game.mouseX;
        int y = game.mouseY;

        String statName = "";
        String type = "";
        String desc = "";

        if (Util.pointInBox(x, y, TILE_SIZE/2 - gui.buff * 2 + tx, ty, TILE_SIZE / 2, TILE_SIZE / 2)) { // attack sprite hover
            statName = "Attack";
            type = String.valueOf(getAttack());
            desc = "Increases Damage dealt by player projectiles";
        } else if (Util.pointInBox(x, y, TILE_SIZE * 2 - gui.buff * 2 + tx, ty, TILE_SIZE / 2, TILE_SIZE / 2)) { // defence sprite hover
            statName = "Defence";
            type = String.valueOf(getDefence());
            desc = "Decreases damage taken from enemies";
        } else if (Util.pointInBox(x, y, TILE_SIZE/2 - gui.buff * 2 + tx, gui.buff + TILE_SIZE / 2 + ty, TILE_SIZE / 2, TILE_SIZE / 2)) { // vitality hover
            statName = "Vitality";
            type = String.valueOf(getVitality());
            desc = "Increases health regeneration rate";
        } else if (Util.pointInBox(x, y, TILE_SIZE * 2 - gui.buff * 2 + tx, gui.buff + TILE_SIZE / 2 + ty, TILE_SIZE / 2, TILE_SIZE / 2)) { // wisdom hover
            statName = "Wisdom";
            type = String.valueOf(getVitality());
            desc = "Increases mana regeneration rate";
        } else if (Util.pointInBox(x, y, TILE_SIZE/2 - gui.buff * 2 + tx, 2 * gui.buff + TILE_SIZE + ty, TILE_SIZE / 2, TILE_SIZE / 2)) { // speed hover
            statName = "Speed";
            type = String.valueOf((int)(speed * 100));
            desc = "Increases player speed";
        }

        if (!statName.equals("")) {

            int mouseOverWidth = 3 * GUI_WIDTH/4;
            WrappedText title = WrappedText.wrapText(statName, mouseOverWidth - gui.buff * 4, TILE_SIZE/2);
            WrappedText subtitle = WrappedText.wrapText(type, mouseOverWidth - gui.buff * 4, TILE_SIZE/3);
            WrappedText description = WrappedText.wrapText(desc, mouseOverWidth - gui.buff * 4, TILE_SIZE/3);

            gui.drawMouseOverText(x, y, title, subtitle, description);
        }
    }


}