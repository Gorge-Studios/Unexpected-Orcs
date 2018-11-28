class Cave extends Level{
  
  float chance = 0.4; //chance the a cell will be a wall
  int iterations = 5;
  
  Cave() {    
    super(120, 90);
    name = "Cave";
    
    //--set tiles in tileset--
    tileset = caveTileset();
    //tileset = testTileset();
    
    this.setTiles(generateCave(w, h, iterations, chance));
  }
  
}
