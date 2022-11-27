class Persona {
  // sprites
  JSONObject spritedata;
  PImage spritesheet;
  PImage[] animacoes;
  int imageCount = 4;
  int index;
  // posição atual da personagem
  PVector posicao;
  // posição de resete para a personagem
  PVector posiResete;
  
  int dimensaoBloco = 30, // dimensões de altura e largura da personagem
    dimensaoImagem = dimensaoBloco*2,
    xVel = 7, yVel = 20, // velocidade da pesonagem no eixos
    forcaSalto = 340, salto = 0, // força total de um alto e força atual do salto
    grav = 5, // gravidade sobre a personagem
    velCorrida, // velocidade da pista
    xVelNegativa;
  boolean noAr = true, // se a personagem está no ar
    estaParado = true, // se está parado
    gameover = false; // se perdeu o jogo
  
  Persona(int x, int y, int velCorrida_) {
    velCorrida = velCorrida_;
    xVelNegativa = -velCorrida;
    posicao = new PVector(x, y);
    posiResete = new PVector(x, y);
    spritedata = loadJSONObject("animacoes/animacoes.json");
    spritesheet = loadImage("animacoes/persona.png");
    animacoes = new PImage[imageCount];
    
    JSONArray frames = spritedata.getJSONArray("idle");
    for (int i = 0; i < frames.size(); i++) {
      JSONObject pos = frames.getJSONObject(i).getJSONObject("position");
      //let img = spritesheet.get(pos.x, pos.y, pos.w, pos.h);
      PImage img = spritesheet.get(pos.getInt("x"), pos.getInt("y"), pos.getInt("w"), pos.getInt("h"));
      animacoes[i] = img;
    }
  }
  
  // exibe o personagem
  void display() {
    if(frameCount%9==0){
      index = index+1 < 4 ? index+1 : 0;
    }
    push();
    imageMode(CENTER);
    image(animacoes[index], posicao.x+(dimensaoBloco/2), posicao.y+(dimensaoBloco/2.5), dimensaoImagem, dimensaoImagem);
    pop();
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
      if(posicao.x+xVelNegativa >= 0) {
        posicao.x += xVelNegativa;
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
    if(posicao.x+vel <= width-dimensaoBloco) {
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
      posicao.y += grav;
    }
  }
  // checa se a personagem está sob uma plataforma da lista
  void checaPlataformas(ArrayList<Plataforma> plats){
    boolean emAlgumaPlat = false;
    Plataforma nestaPlat = new Plataforma(0, 0);
    // itera as plataformas
    for(int i=0; i < plats.size(); i++){
      // busca informações sobre a plataforma
      Plataforma plat = plats.get(i);
      PVector posiPlat = plat.getPosicao();
      int alturaPlat = plat.getAltura(), larguraPlat = plat.getLargura();
      
      // verificar se está sob a plataforma
      if (posicao.x+dimensaoBloco > posiPlat.x && posicao.x < posiPlat.x+larguraPlat && posicao.y+dimensaoBloco == posiPlat.y) {
        emAlgumaPlat = true;
        nestaPlat = plats.get(i);
      } else {
        xVelNegativa = -velCorrida;
      }
      // veificar se bateu embaixo da plataforma
    }
    
    // atualiza se a personagem continua no ar ou não
    if(emAlgumaPlat == true) {
      noAr = false;
      xVelNegativa = -nestaPlat.getVelocidade();
    } else {
      noAr = true;
      xVelNegativa = -velCorrida;
    }
  }
  // checa se a personagem caiu para fora da tela
  void checaGameOver(){
    if(posicao.y > height-dimensaoBloco) {
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
