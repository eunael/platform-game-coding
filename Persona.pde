class Persona {
  // posição atual da personagem
  PVector posicao;
  // posição de resete para a personagem
  PVector posiResete;
  
  int dimensao = 20, // dimensões de altura e largura da personagem
    xVel = 10, yVel = 20, // velocidade da pesonagem no eixos
    forcaSalto = 340, salto = 0, // força total de um alto e força atual do salto
    grav = 7, // gravidade sobre a personagem
    velCorrida; // velocidade da pista
  boolean noAr = true, // se a personagem está no ar
    estaParado = true, // se está parado
    gameover = false; // se perdeu o jogo
  
  Persona(int x, int y, int velCorrida_) {
    velCorrida = velCorrida_;
    posicao = new PVector(x, y);
    posiResete = new PVector(x, y);
  }
  
  // exibe o personagem
  void display() {
    rect(posicao.x, posicao.y, dimensao, dimensao);
  }
  // atualiza a personagem
  void update() {
    checaGameOver();
    pulando();
    gravidade();
    parado();
  }
  // checa se a personagem está parado, se sim, aplica a velocidade da pista
  void parado() {
    if(estaParado && !noAr) {
      if(posicao.x-velCorrida >= 0) {
        posicao.x += -velCorrida;
      }
    }
  }
  // move a personagem para esquerda
  void paraEsquerda() {
    int vel = -xVel;
    if(posicao.x+vel >= 0) {
      posicao.x += vel;
    }
  }
  // move a personagem para direita
  void paraDireita() {
    int vel = xVel;
    if(posicao.x+vel <= width-dimensao) {
      posicao.x += vel;
    }
  }
  // aplica força de salto na personagem
  void pular() {
    if(!noAr){
      noAr = true;
      salto = forcaSalto;
    }
  }
  // faz a personagem pular na tela
  void pulando() {
    int vel = -yVel;
    if(salto > 0) {
      posicao.y += vel;
      salto -= yVel;
    }
  }
  // aplica a gravida na personagem enquanto estiver no ar
  void gravidade() {
    if(noAr) {
      posicao.y += 5;
    }
  }
  // checa se a personagem está sob uma plataforma da lista
  void checaPlataformas(ArrayList<Plataforma> plats){
    boolean emAlgumaPlat = false;
    // itera as plataformas
    for(int i=0; i < plats.size(); i++){
      // busca informações sobre a plataforma
      Plataforma plat = plats.get(i);
      PVector posiPlat = plat.getPosicao();
      int alturaPlat = plat.getAltura(), larguraPlat = plat.getLargura();
      
      // verificar se está sob a plataforma
      if (posicao.x+dimensao > posiPlat.x && posicao.x < posiPlat.x+larguraPlat && posicao.y+dimensao == posiPlat.y) {
        emAlgumaPlat = true;
      }     
      // veificar se bateu embaixo da plataforma
    }
    
    // atualiza se a personagem continua no ar ou não
    if(emAlgumaPlat == true) {
      noAr = false;
    } else {
      noAr = true;
    }
  }
  // checa se a personagem caiu para fora da tela
  void checaGameOver(){
    if(posicao.y > height-dimensao) {
      gameover = true;
    }
  }
  // reseta as informações da personagem
  void resete() {
    gameover = false;
    posicao.set(posiResete);
  }
  
  boolean getGameOver() {
    return gameover;
  }
  
  void personaKeyPressed(){
    if(keyCode==LEFT || keyCode==RIGHT){
      estaParado = false;
    }
  }
  void personaKeyReleased(){
    if(keyCode==LEFT || keyCode==RIGHT){
      estaParado = true;
    }
  }
}
