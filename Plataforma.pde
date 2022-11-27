class Plataforma {
  PVector posicao; // posiçaõ da plataforma
  int xVel, // velocidade do ambiente
    altura = 40,largura = altura*6; // dimensões da plataformas
  int[] yMultPos = {2,4,6,2,4}; // possíveis posições que ela pode aparecer
  
  Plataforma(int xVel_, int posXInicial){
    xVel = xVel_;
    int intPos = (int) random(0,5);
    int mult = yMultPos[intPos];
    posicao = new PVector(posXInicial, height - altura*mult);
  }
  // exibe a plataforma
  void display() {
    rect(posicao.x, posicao.y, largura, altura);
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
} 
