public void loadAssets() {
  
  tileSprites = new HashMap<Integer, PImage>();
  itemSprites = new HashMap<String, PImage>();
  guiSprites = new HashMap<String, PImage>();
  charSprites = new HashMap<String, PImage>();
  projectileSprites = new HashMap<String, PImage>();
  dropSprites = new HashMap<String, PImage>();
  
  //-----TILE SPRITES-----
  PImage tilesheet = loadImage("/assets/sprites/tilesheet.png");
  
  tileSprites.put(WALL, getSprite(tilesheet, 0, 0, 1, 1, SPRITE_SIZE));
  tileSprites.put(FLOOR, getSprite(tilesheet, 1, 0, 1, 1, SPRITE_SIZE));
  
  //--TEST--
  tileSprites.put(TEST_00, getSprite(tilesheet, 0, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_01, getSprite(tilesheet, 1, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_02, getSprite(tilesheet, 2, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_03, getSprite(tilesheet, 3, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_04, getSprite(tilesheet, 4, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_05, getSprite(tilesheet, 5, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_06, getSprite(tilesheet, 6, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_07, getSprite(tilesheet, 7, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_08, getSprite(tilesheet, 8, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_09, getSprite(tilesheet, 9, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_10, getSprite(tilesheet, 10, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_11, getSprite(tilesheet, 11, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_12, getSprite(tilesheet, 12, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_13, getSprite(tilesheet, 13, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_14, getSprite(tilesheet, 14, 31, 1, 1, SPRITE_SIZE));
  tileSprites.put(TEST_15, getSprite(tilesheet, 15, 31, 1, 1, SPRITE_SIZE));
  
  //--STONE BRICK--
  tileSprites.put(STONE_BRICK_00, getSprite(tilesheet, 0, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_01, getSprite(tilesheet, 1, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_02, getSprite(tilesheet, 2, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_03, getSprite(tilesheet, 3, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_04, getSprite(tilesheet, 4, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_05, getSprite(tilesheet, 5, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_06, getSprite(tilesheet, 6, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_07, getSprite(tilesheet, 7, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_08, getSprite(tilesheet, 8, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_09, getSprite(tilesheet, 9, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_10, getSprite(tilesheet, 10, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_11, getSprite(tilesheet, 11, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_12, getSprite(tilesheet, 12, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_13, getSprite(tilesheet, 13, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_14, getSprite(tilesheet, 14, 30, 1, 1, SPRITE_SIZE));
  tileSprites.put(STONE_BRICK_15, getSprite(tilesheet, 15, 30, 1, 1, SPRITE_SIZE));
  
  //--ROCK--
  tileSprites.put(ROCK_00, getSprite(tilesheet, 0, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_01, getSprite(tilesheet, 1, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_02, getSprite(tilesheet, 2, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_03, getSprite(tilesheet, 3, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_04, getSprite(tilesheet, 4, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_05, getSprite(tilesheet, 5, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_06, getSprite(tilesheet, 6, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_07, getSprite(tilesheet, 7, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_08, getSprite(tilesheet, 8, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_09, getSprite(tilesheet, 9, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_10, getSprite(tilesheet, 10, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_11, getSprite(tilesheet, 11, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_12, getSprite(tilesheet, 12, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_13, getSprite(tilesheet, 13, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_14, getSprite(tilesheet, 14, 29, 1, 1, SPRITE_SIZE));
  tileSprites.put(ROCK_15, getSprite(tilesheet, 15, 29, 1, 1, SPRITE_SIZE));
  
  //--HEDGE--
  tileSprites.put(HEDGE_00, getSprite(tilesheet, 0, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_01, getSprite(tilesheet, 1, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_02, getSprite(tilesheet, 2, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_03, getSprite(tilesheet, 3, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_04, getSprite(tilesheet, 4, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_05, getSprite(tilesheet, 5, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_06, getSprite(tilesheet, 6, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_07, getSprite(tilesheet, 7, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_08, getSprite(tilesheet, 8, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_09, getSprite(tilesheet, 9, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_10, getSprite(tilesheet, 10, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_11, getSprite(tilesheet, 11, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_12, getSprite(tilesheet, 12, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_13, getSprite(tilesheet, 13, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_14, getSprite(tilesheet, 14, 28, 1, 1, SPRITE_SIZE));
  tileSprites.put(HEDGE_15, getSprite(tilesheet, 15, 28, 1, 1, SPRITE_SIZE));

  //--Floor--
  tileSprites.put(WOOD, getSprite(tilesheet, 0, 1, 1, 1, SPRITE_SIZE));
  tileSprites.put(STAR_WOOD, getSprite(tilesheet, 1, 1, 1, 1, SPRITE_SIZE));
  tileSprites.put(BROKEN_WOOD,  getSprite(tilesheet, 2, 1, 1, 1, SPRITE_SIZE));
  tileSprites.put(LONG_WOOD, getSprite(tilesheet, 3, 1, 1, 1, SPRITE_SIZE));
  
  tileSprites.put(STONE, getSprite(tilesheet, 0, 2, 1, 1, SPRITE_SIZE));
  tileSprites.put(X_STONE, getSprite(tilesheet, 1, 2, 1, 1, SPRITE_SIZE));
  tileSprites.put(RUBBLE_STONE,  getSprite(tilesheet, 2, 2, 1, 1, SPRITE_SIZE));
  tileSprites.put(SKULL_STONE, getSprite(tilesheet, 3, 2, 1, 1, SPRITE_SIZE));
  
  tileSprites.put(GRASS, getSprite(tilesheet, 0, 3, 1, 1, SPRITE_SIZE));
  tileSprites.put(PATCH_GRASS, getSprite(tilesheet, 1, 3, 1, 1, SPRITE_SIZE));
  tileSprites.put(MUSHROOM_GRASS,  getSprite(tilesheet, 2, 3, 1, 1, SPRITE_SIZE));
  tileSprites.put(GRASS_TUFT, getSprite(tilesheet, 3, 3, 1, 1, SPRITE_SIZE));
  tileSprites.put(GRASS_LEAF, getSprite(tilesheet, 4, 3, 1, 1, SPRITE_SIZE));
  
  
  //-----ITEM SPRITES-----
  PImage itemsheet = loadImage("/assets/sprites/itemsheet.png");
  int itemSize = 16;
  
  //Stats
  itemSprites.put("SPEED_ICON", getSprite(itemsheet, 0, 0, 1, 1, itemSize));
  itemSprites.put("DEFENCE_ICON", getSprite(itemsheet, 1, 0, 1, 1, itemSize));
  itemSprites.put("ATTACK_ICON", getSprite(itemsheet, 2, 0, 1, 1, itemSize));
  itemSprites.put("VITALITY_ICON", getSprite(itemsheet, 3, 0, 1, 1, itemSize));
  itemSprites.put("WISDOM_ICON", getSprite(itemsheet, 4, 0, 1, 1, itemSize));
  
  //Scrolls
  itemSprites.put("SCROLL_1", getSprite(itemsheet, 0, 1, 1, 1, itemSize));
  itemSprites.put("SCROLL_2", getSprite(itemsheet, 1, 1, 1, 1, itemSize));
  itemSprites.put("SCROLL_3", getSprite(itemsheet, 2, 1, 1, 1, itemSize));
  itemSprites.put("SCROLL_4", getSprite(itemsheet, 3, 1, 1, 1, itemSize));
  
  //Weapons
  itemSprites.put("SHOTGUN", getSprite(itemsheet, 0, 2, 1, 1, itemSize));
  itemSprites.put("PISTOL", getSprite(itemsheet, 1, 2, 1, 1, itemSize));
  itemSprites.put("SNIPER", getSprite(itemsheet, 2, 2, 1, 1, itemSize));
  itemSprites.put("MACHINE_GUN", getSprite(itemsheet, 3, 2, 1, 1, itemSize));
  
  //Armour and abilities
  itemSprites.put("BOOTS", getSprite(itemsheet, 0, 3, 1, 1, itemSize));
  itemSprites.put("LEATHER_ARMOUR", getSprite(itemsheet, 0, 4, 1, 1, itemSize));
  itemSprites.put("FIREBOMB", getSprite(itemsheet, 1, 3, 1, 1, itemSize));
  
  //-----DROP SPRITES-----
  PImage dropsheet = loadImage("/assets/sprites/dropsheet.png");
  int dropSize = 8;

  dropSprites.put("BAG_0", getSprite(dropsheet, 0, 0, 1, 1, dropSize));
  dropSprites.put("BAG_1", getSprite(dropsheet, 1, 0, 1, 1, dropSize));
  dropSprites.put("BAG_2", getSprite(dropsheet, 2, 0, 1, 1, dropSize));
  dropSprites.put("ORB", getSprite(dropsheet, 0, 1, 1, 1, dropSize));
  
  //-----GUI SPRITES----
  PImage sheet = loadImage("/assets/sprites/spritesheet.png");
  int guiSize = 16;
  
  guiSprites.put("PLAY", getSprite(sheet, 0, 0, 2, 1, guiSize));  
  guiSprites.put("MENU", getSprite(sheet, 2, 0, 2, 1, guiSize));
  guiSprites.put("BACK", getSprite(sheet, 4, 0, 2, 1, guiSize));
  guiSprites.put("OPTIONS", getSprite(sheet, 6, 0, 2, 1, guiSize));
  guiSprites.put("PAUSE", getSprite(sheet, 0, 1, 1, 1, guiSize));
  guiSprites.put("EXIT", getSprite(sheet, 1, 1, 2, 1, guiSize));
  guiSprites.put("NEW", getSprite(sheet, 3, 1, 2, 1, guiSize));
  guiSprites.put("LOAD", getSprite(sheet, 5, 1, 2, 1, guiSize));
  guiSprites.put("CURSOR", getSprite(sheet, 6, 6, 2, 2, guiSize));
  guiSprites.put("BAR", getSprite(sheet, 0, 4, 3, 1, guiSize));
  guiSprites.put("BLANK_2x1", getSprite(sheet, 0, 7, 2, 1, guiSize));
  guiSprites.put("BLANK_1x1", getSprite(sheet, 2, 7, 1, 1, guiSize));
  
  //-----CHAR SPRITES-----
  PImage charsheet = loadImage("/assets/sprites/charsheet.png");
  int charSize = 8;
  
  //Load player sprites
  charSprites.put("PLAYER_FRONT", getSprite(charsheet, 6, 0, 1, 1, charSize));
  charSprites.put("PLAYER_BACK", getSprite(charsheet, 7, 0, 1, 1, charSize));
  charSprites.put("PLAYER_LEFT", getSprite(charsheet, 6, 1, 1, 1, charSize));
  charSprites.put("PLAYER_RIGHT", getSprite(charsheet, 7, 1, 1, 1, charSize));
  
  charSprites.put("FACE_FRONT", getSprite(charsheet, 8, 0, 1, 1, charSize));
  charSprites.put("FACE_BACK", getSprite(charsheet, 9, 0, 1, 1, charSize));
  charSprites.put("FACE_LEFT", getSprite(charsheet, 8, 1, 1, 1, charSize));
  charSprites.put("FACE_RIGHT", getSprite(charsheet, 9, 1, 1, 1, charSize));
  
  charSprites.put("BODY_FRONT", getSprite(charsheet, 10, 0, 1, 1, charSize));
  charSprites.put("BODY_BACK", getSprite(charsheet, 11, 0, 1, 1, charSize));
  charSprites.put("BODY_LEFT", getSprite(charsheet, 10, 1, 1, 1, charSize));
  charSprites.put("BODY_RIGHT", getSprite(charsheet, 11, 1, 1, 1, charSize));
  
  //Load chomp sprites
  charSprites.put("CHOMP_WHITE_SMALL", getSprite(charsheet, 4, 0, 1, 1, charSize));
  charSprites.put("CHOMP_BLACK_SMALL", getSprite(charsheet, 5, 0, 1, 1, charSize));
  charSprites.put("CHOMP_WHITE", getSprite(charsheet, 0, 0, 2, 2, charSize));
  charSprites.put("CHOMP_BLACK", getSprite(charsheet, 2, 0, 2, 2, charSize));
  charSprites.put("CHOMP_BOSS", getSprite(charsheet, 0, 2, 4, 4, charSize));
  
  //-----BULLET SPRITES-----
  PImage bulletsheet = loadImage("/assets/sprites/bulletsheet.png");
  int bulletSize = 8;
  
  projectileSprites.put("SNIPER", getSprite(bulletsheet, 0, 0, 1, 1, bulletSize));
  projectileSprites.put("PISTOL", getSprite(bulletsheet, 1, 0, 1, 1, bulletSize));
  projectileSprites.put("SHOTGUN", getSprite(bulletsheet, 2, 0, 1, 1, bulletSize));
  projectileSprites.put("FIREBALL", getSprite(bulletsheet, 3, 0, 1, 1, bulletSize));
  
  cursor(guiSprites.get("CURSOR"));
  assetsLoaded = true;
  loadStats();
}

public PImage getSprite(PImage image, int x, int y, int w, int h, int spriteSize) {
  return image.get(x * spriteSize, y * spriteSize, w * spriteSize, h * spriteSize);
}

class TileSet {
  //this tile holds reference to a collection of Sprites, these can be used when generating a dungeon, to make them look nice
  public int floor, spawn;
  public ArrayList<Integer> extras = new ArrayList<Integer>();  //Extras are variations of floor tiles to spice shit up a bit
  public int[] walls = new int[16];
}

public int[] testWalls() {
  int[] wall = new int[16];
  
  wall[0] = TEST_00;
  wall[1] = TEST_01;
  wall[2] = TEST_02;
  wall[3] = TEST_03;
  wall[4] = TEST_04;
  wall[5] = TEST_05;
  wall[6] = TEST_06;
  wall[7] = TEST_07;
  wall[8] = TEST_08;
  wall[9] = TEST_09;
  wall[10] = TEST_10;
  wall[11] = TEST_11;
  wall[12] = TEST_12;
  wall[13] = TEST_13;
  wall[14] = TEST_14;
  wall[15] = TEST_15;
  
  return wall;
}

public int[] stoneBrickWalls() {
  int[] wall = new int[16];
  
  wall[0] = STONE_BRICK_00;
  wall[1] = STONE_BRICK_01;
  wall[2] = STONE_BRICK_02;
  wall[3] = STONE_BRICK_03;
  wall[4] = STONE_BRICK_04;
  wall[5] = STONE_BRICK_05;
  wall[6] = STONE_BRICK_06;
  wall[7] = STONE_BRICK_07;
  wall[8] = STONE_BRICK_08;
  wall[9] = STONE_BRICK_09;
  wall[10] = STONE_BRICK_10;
  wall[11] = STONE_BRICK_11;
  wall[12] = STONE_BRICK_12;
  wall[13] = STONE_BRICK_13;
  wall[14] = STONE_BRICK_14;
  wall[15] = STONE_BRICK_15;
  
  return wall;
}

public int[] rockWalls() {
  int[] wall = new int[16];
  
  wall[0] = ROCK_00;
  wall[1] = ROCK_01;
  wall[2] = ROCK_02;
  wall[3] = ROCK_03;
  wall[4] = ROCK_04;
  wall[5] = ROCK_05;
  wall[6] = ROCK_06;
  wall[7] = ROCK_07;
  wall[8] = ROCK_08;
  wall[9] = ROCK_09;
  wall[10] = ROCK_10;
  wall[11] = ROCK_11;
  wall[12] = ROCK_12;
  wall[13] = ROCK_13;
  wall[14] = ROCK_14;
  wall[15] = ROCK_15;
  
  return wall;
}

public int[] hedgeWalls() {
  int[] wall = new int[16];
  
  wall[0] = HEDGE_00;
  wall[1] = HEDGE_01;
  wall[2] = HEDGE_02;
  wall[3] = HEDGE_03;
  wall[4] = HEDGE_04;
  wall[5] = HEDGE_05;
  wall[6] = HEDGE_06;
  wall[7] = HEDGE_07;
  wall[8] = HEDGE_08;
  wall[9] = HEDGE_09;
  wall[10] = HEDGE_10;
  wall[11] = HEDGE_11;
  wall[12] = HEDGE_12;
  wall[13] = HEDGE_13;
  wall[14] = HEDGE_14;
  wall[15] = HEDGE_15;
  
  return wall;
}

public TileSet testTileset() {
  TileSet tileset = new TileSet();
  
  tileset.walls = testWalls();
  tileset.floor = FLOOR;
  tileset.spawn = FLOOR;
   
  return tileset;
}

public TileSet grassTileset() {
  TileSet tileset = new TileSet();
  
  tileset.walls = hedgeWalls();
  
  tileset.floor = GRASS;
  tileset.spawn = PATCH_GRASS;
  tileset.extras.add(MUSHROOM_GRASS);
  tileset.extras.add(GRASS_TUFT);
  tileset.extras.add(GRASS_LEAF);
   
  return tileset;
}

public TileSet caveTileset() {
  TileSet tileset = new TileSet();

  tileset.walls = rockWalls();

  tileset.floor = STONE;
  tileset.spawn = X_STONE;
  tileset.extras.add(RUBBLE_STONE);
  tileset.extras.add(SKULL_STONE); 
  
  return tileset;
}

public TileSet dungeonTileset() {
  TileSet tileset = new TileSet();

  tileset.walls = stoneBrickWalls();

  tileset.floor = WOOD;
  tileset.spawn = STAR_WOOD;
  tileset.extras.add(BROKEN_WOOD);
  tileset.extras.add(LONG_WOOD);
  
  return tileset;
}
