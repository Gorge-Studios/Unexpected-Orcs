class Ability extends Item {
  
  protected int manaCost;
  float cooldown;
  String useText;
  
  Ability(String sprite, String name, String useText) {
    super(sprite, name);
    this.type = "Ability";
    this.useText = useText;
  }
  
  public void makeText() {
    
    if (manaCost > engine.player.stats.getMana() && engine.player.textTimer >= 0.5){
      String cooldownText = "Low Mana";
      engine.addText(cooldownText, engine.player.x, engine.player.y, 0.5, color(0, 0, 200));
      engine.player.textTimer = 0;
    }
    
    if (engine.player.cooldownTimer <= 0 && manaCost <= engine.player.stats.getMana()){
      engine.player.cooldownTimer = cooldown;
      engine.player.stats.mana -= manaCost;
      engine.addText(useText, engine.player.x, engine.player.y, 0.5, color(0, 0, 200));
      engine.player.textTimer = 0;
    } else {
      if (engine.player.textTimer >= 0.5 && manaCost < engine.player.stats.getMana()) {
        String cooldownText = "";
        cooldownText = String.format("%.3gs%n", engine.player.cooldownTimer);
        engine.addText(cooldownText, engine.player.x, engine.player.y, 0.5, color(0,0,200));
        engine.player.textTimer = 0;
      }
    }
  }
  
  public boolean ability() { return false; }
  
}

class SwiftBoots extends Ability {
  
  SwiftBoots() {
    super("BOOTS", "Boots of Swiftness", "Speed Buff");
    this.cooldown = 4;
    this.manaCost = 30;
  }
  
  @Override
  public boolean ability(){
    if (engine.player.cooldownTimer <= 0 && manaCost <= engine.player.stats.getMana()){
      engine.player.stats.addStatusEffect("SWIFT", 3);
      // soundFiles.get("FLYBY").play();
      return true;
    }
    return false;
  }
  
}

class Telescope extends Ability {
  
  Telescope() {
    super("TELESCOPE", "Telescope of seeing", "Have a look");
    this.cooldown = 0.5;
    this.manaCost = 50;
  }
  
  @Override
  public boolean ability() {
    if (engine.player.cooldownTimer <= 0 && manaCost <= engine.player.stats.getMana()){
      engine.currentLevel.newSmoothUncover((int)engine.player.x, (int)engine.player.y, 30);
      return true;
    }
    return false;
  }
}

class FireBomb extends Ability {
  
  FireBomb() {
    super("FIREBOMB", "Fire Bomb", "Fire Bomb");
    this.cooldown = 0.5;
    this.manaCost = 30;
  }
  
  @Override
  public boolean ability() {
    if (engine.player.cooldownTimer <= 0 && manaCost <= engine.player.stats.getMana()){
      for (int i = 0; i < 8; i++) {
        engine.playerProjectiles.add(new Projectile(engine.player.x, engine.player.y, PVector.fromAngle(PI * i / 4), 
                5, 3, 100, projectileSprites.get("FIREBALL")));
      }
      // soundFiles.get("FLAME").play();
      return true;
    }
    return false;
  }
}

class SpellBomb extends Ability {
  
  SpellBomb() {
    super("FIREBOMB", "Spell Bomb", "Spell Bomb");
    this.cooldown = 0.5;
    this.manaCost = 30;
  }
  
  @Override
  public boolean ability() {
    float x = screenToTileCoordX(mouseX);
    float y = screenToTileCoordY(mouseY);
    if(engine.currentLevel.visited((int)x, (int)y) && engine.player.cooldownTimer <= 0 && manaCost <= engine.player.stats.getMana()){
      for (int i = 0; i < 8; i++) {
        engine.playerProjectiles.add(new Projectile(x, y, PVector.fromAngle(PI * i / 4), 
                5, 3, 100, projectileSprites.get("FIREBALL")));
      }
      return true;
      // soundFiles.get("FLAME").play();
    }
    return false;
  }
}

class Teleport extends Ability {
  
  Teleport() {
    super("TELESCOPE", "Teleport", "Teleport");
    this.cooldown = 0.5;
    this.manaCost = 5;
  }
  
  @Override
  public boolean ability() {
    float x = screenToTileCoordX(mouseX);
    float y = screenToTileCoordY(mouseY);
    if(engine.currentLevel.visited((int)x, (int)y) && engine.player.cooldownTimer <= 0 && manaCost <= engine.player.stats.getMana()){
      engine.player.x = x;
      engine.player.y = y;
      return true;
      // soundFiles.get("FLAME").play();
    }
    return false;
  }
}