class Plataforma {
  // sprites
  PImage spritesheet;
  PVector posicao; // posiçaõ da plataforma
  int xVel, // velocidade do ambiente
    altura = 40,largura = altura*6; // dimensões da plataformas
  int[] yMultPos = {2,4,6,2,4}; // possíveis posições que ela pode aparecer
  
  Plataforma(int xVel_, int posXInicial){
    xVel = xVel_;
    int intPos = (int) random(0,5);
    int mult = yMultPos[intPos];
    posicao = new PVector(posXInicial, height - altura*mult);
    spritesheet = loadImage("animacoes/plataforma.png").get(24, 72, 72, 24);
  }
  // exibe a plataforma
  void display() {
    push();
    imageMode(CENTER);
    image(spritesheet, posicao.x+(largura/1.9), posicao.y+(altura/2), largura, altura);
    pop();
    
    movimenta();
  }
  // move a plataforma
  void movimenta() {
    posicao.x += -xVel;
  }
  // retorna se ela já saiu da tela
  boolean saiuDaTela(){
    return posicao.x+largura < 0 ? true : false;
  }
  
  PVector getPosicao() {
    return posicao;
  }
  int getAltura() {
    return altura;
  }
  int getLargura() {
    return largura;
  }
  int getVelocidade() {
    return xVel;
  }
} 
