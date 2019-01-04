package com.bmd.Items;

import com.bmd.Items.Abilities.*;
import com.bmd.Items.Scrolls.DebuffScroll;
import com.bmd.Items.Weapons.GreenRod;

import java.io.Serializable;

public class Inventory implements Serializable {

    private int MAX_SIZE = 12;
    public Item[] active = new Item[4];
    public Item[] inv = new Item[MAX_SIZE];

    public final static int WIDTH = 4;

  /*
         _____________________
  ACTIVE:|Weap|Abil|Arm |Scrl|
         _____________________
  INVENT:|____|____|____|____|
         |____|____|____|____|
         |____|____|____|____|
  */


    public Inventory() {
        active[0] = new GreenRod();
        active[1] = new SwiftBoots();
        active[2] = new Armour("LEATHER_ARMOUR", "Plain Leather Armour", 5);
        active[3] = new DebuffScroll(new String[] {"SLOWED"});

        inv[0] = (Item)ItemFactory.createRandomWeapon(4);
        inv[1] = new FireBomb();
        inv[2] = new SpellBomb();
        inv[3] = new Telescope();
        inv[4] = new Teleport();
    }

    void swapItemsInv(int i, int j) {
        try {
            Item save = inv[i];
            inv[i] = inv[j];
            inv[j] = save;
        } catch(Exception e) {
            //rip
        }
    }

    void swapItemsActive(int act, int in) {
        try {
            if(inv[in] != null) {
                if(act == 0 && inv[in].type != "Weapon") return;
                if(act == 1 && inv[in].type != "Ability") return;
                if(act == 2 && inv[in].type != "Armour") return;
                if(act == 3 && inv[in].type != "Scroll") return;
            }
            Item save = active[act];
            active[act] = inv[in];
            inv[in] = save;
        } catch(Exception e) {
            //rip
        }
    }

    public Item addItemInv(Item item, int pos) {
        Item old = inv[pos];
        inv[pos] = item;
        return old;
    }

    public Item addItemActive(Item item, int pos) {
        if(item != null) {
            if(pos == 0 && item.type != "Weapon") return item;
            if(pos == 1 && item.type != "Ability") return item;
            if(pos == 2 && item.type != "Armour") return item;
            if(pos == 3 && item.type != "Scroll") return item;
        }
        Item old = active[pos];
        active[pos] = item;
        return old;
    }


    public Item[] active() { return active; }
    public Item[] inv() { return inv; }

    public Weapon currentWeapon() { return (Weapon)active[0]; }
    public Ability currentAbility() { return (Ability)active[1]; }
    public Armour currentArmour() { return (Armour)active[2]; }
    public Scroll currentScroll() { return (Scroll)active[3]; }
}