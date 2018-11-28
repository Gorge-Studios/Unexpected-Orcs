class Chomp implements Enemy {
  
  public int tier = 0;
  public float x = 0;
  public float y = 0;
  
  private float angle;
  private float attackWait;
  
  protected Stats stats;
  protected PImage sprite;
  protected float radius;
  
  public Chomp(float x, float y, int tier) {
    this.tier = tier;
    this.x = x;
    this.y = y;
    radius = 0.25;
    attackWait = 0;
    if(random(2) < 1) {
      sprite = charSprites.get("CHOMP_WHITE_SMALL");
    } else {
      sprite = charSprites.get("CHOMP_BLACK_SMALL");
    }
    stats = new Stats();
    stats.setHealth(14 * tier);
    stats.setAttack(5 * tier);
    stats.setSpeed(1.3 * tier);
    stats.setDefence(1 * tier);
  }
  
  /* Enemies need to update on tics */
  public boolean update(double delta, float playerX, float playerY) {
    //If player in range attack.
    if(distanceFrom(playerX, playerY) < 6) {
      angle = atan2(playerY - y, playerX - x);
      attackWait += delta;
      if(distanceFrom(playerX, playerY) < radius) {
        attack();
      } else {
        move(delta);
      }
    }
    
    //Return true if chomp is alive
    return stats.getHealth() > 0;
  }
  
  /* Displays enemy to screen */
  public void show(PGraphics screen, PVector renderOffset){
    screen.pushMatrix();
    screen.translate(x * TILE_SIZE - renderOffset.x, y * TILE_SIZE - renderOffset.y);
    if((angle < PI/2) && (angle > -PI/2)) {
      screen.rotate(angle);
      screen.image(sprite, -sprite.width * SCALE/2, -sprite.height * SCALE/2, sprite.width * SCALE, sprite.height * SCALE);
    } else {
      screen.scale(-1.0, 1.0);
      screen.rotate(PI - angle);
      screen.image(sprite, sprite.width * SCALE/2, -sprite.height * SCALE/2, -sprite.width * SCALE, sprite.height * SCALE);
    }
    screen.popMatrix();
  }
  
  /* This mob takes damage */
  public void damage(int amount){
    if(amount > stats.getDefence()) {
      stats.setHealth(stats.getHealth() - (amount - stats.getDefence()));
    }
    engine.addText(String.valueOf(amount > stats.getDefence() ? amount - stats.getDefence() : 0), x, y - radius, 0.5, color(200, 0 , 0));
  }
  
  private void attack() {
    if(attackWait > 1) {
      attackWait = 0;
      engine.player.damage(stats.getAttack() * 2);
    }
  }
  
  public void onDeath() {
    engine.addDrop(new StatOrb(x, y, tier, "SPEED"));
  }
  
  /* Checks collision with point */
  public boolean pointCollides(float pointX, float pointY) {
    return (distanceFrom(pointX, pointY) < radius);
  }
  
  /* Checks collision with area  */
  public boolean AABBCollides(AABB box){
    return false;
  }
    
    private void move(double delta) {
    float moveX = (float)(stats.getSpeed() * cos(angle) * delta);
    float moveY = (float)(stats.getSpeed() * sin(angle) * delta);
    x += moveX;
    y += moveY;
    if(!validPosition(engine.currentLevel, x, y)) {
      if(!validCentre(engine.currentLevel, x, y)) {
        x -= moveX;
        y -= moveY;
      } else {
        if(!validLeft(engine.currentLevel, x, y)) {
          x = floor(x) + radius;
        } else if(!validRight(engine.currentLevel, x, y)) {
          x = ceil(x) - radius;
        }
        if(!validTop(engine.currentLevel, x, y)) {
          y = floor(y) + radius;
        } else if(!validBottom(engine.currentLevel, x, y)) {
          y = ceil(y) - radius;
        }
      }
    }
  }
  
  //Calculates if coordinates mean chomp is not in a wall
  //Needs level because it's used in setup
  public boolean validPosition(Level level, float xPos, float yPos) {
    return validCentre(level, xPos, yPos) &&
        (level.getTile((int)xPos, (int)(yPos + radius)) > WALL) &&
        (level.getTile((int)xPos, (int)(yPos - radius)) > WALL) && 
        (level.getTile((int)(xPos + radius), (int)yPos) > WALL) && 
        (level.getTile((int)(xPos - radius), (int)yPos) > WALL);
  }
  
  private boolean validCentre(Level level, float xPos, float yPos) {
    return level.getTile((int)xPos, (int)yPos) > WALL;
  }
  
  private boolean validLeft(Level level, float xPos, float yPos) {
    return level.getTile((int)(xPos - radius), (int)yPos) > WALL;
  }
  
  private boolean validRight(Level level, float xPos, float yPos) {
    return level.getTile((int)(xPos + radius), (int)yPos) > WALL;
  }
  
  private boolean validTop(Level level, float xPos, float yPos) {
    return level.getTile((int)xPos, (int)(yPos - radius)) > WALL;
  }
  
  private boolean validBottom(Level level, float xPos, float yPos) {
    return level.getTile((int)xPos, (int)(yPos + radius)) > WALL;
  }
  
  protected float distanceFrom(float pointX, float pointY) {
    return sqrt(pow(x - pointX, 2) + pow(y - pointY, 2));
  }
  
  protected int sign(float value){
    if(value < 0) {
      return -1;
    } else if(value > 0) {
      return 1;
    }
    return 0;
  }
  
}

class BigChomp extends Chomp {
  
  public BigChomp(float x, float y, int tier) {
    super(x, y, tier);
    radius = 0.5;
    if(random(2) < 1) {
      sprite = charSprites.get("CHOMP_WHITE");
    } else {
      sprite = charSprites.get("CHOMP_BLACK");
    }
    stats.setHealth(25 * tier);
    stats.setAttack(11 * tier);
    stats.setSpeed(1.2 * tier);
    stats.setDefence(3 * tier); 
  }
  
  /* Checks collision with point */
  public boolean pointCollides(float pointX, float pointY) {
    return (distanceFrom(pointX, pointY) < 0.5);
  }
  
  public void onDeath() {
    engine.addDrop(new StatOrb(x, y, tier, "ATTACK"));
  }
}

class BossChomp extends Chomp {
  
  public BossChomp(float x, float y, int tier) {
    super(x, y, tier);
    radius = 1;
    sprite = charSprites.get("CHOMP_BOSS");
    stats.setHealth(45 * tier);
    stats.setAttack(20 * tier);
    stats.setSpeed(1.1 * tier);
    stats.setDefence(8 * tier); 
  }
  
  /* Checks collision with point */
  public boolean pointCollides(float pointX, float pointY) {
    return (distanceFrom(pointX, pointY) < 1);
  }
  
  public void onDeath() {
    engine.addDrop(new StatOrb(x, y, tier, "HEALTH"));
  }
  
}
