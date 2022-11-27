// instância do personagem
Persona persona;
// array list para as plataformas na tela
ArrayList<Plataforma> plats;
// frequência de aparição das plataformas
int freqPlataformas = 80;
// velocidade do ambiente 
int velCorrida = 5;
// verificar se está esperando iniciar uma partida
boolean esperandoInicio = true;
// status possíveis do jogo
String[] statusDoJogo = {"jogar", "jogando", "fim"};
// status atual do jogo
String status = "jogar";

void setup() {
  size(800, 600);
  
  // instaciando o personagem
  persona = new Persona(300, 100, velCorrida);
}

void draw() {
  background(190);
  
  if(status == "jogar") {
    // exibi texto de intrução
    push();
    fill(#FF0F0F);
    textSize(40);
    textAlign(CENTER);
    text("Pressione Enter para iniciar um novo jogo", width/2, height/2);
    pop();
  } else if (status == "jogando") {
    jogando();
  } else if (status == "fim") {
    // exibi texto de intrução
    push();
    fill(#FF0F0F);
    textSize(40);
    textAlign(CENTER);
    text("GAME OVER!!\nPressione Enter para iniciar um novo jogo", width/2, height/2);
    pop();
  }
}

// para iniciar um novo jogo
void jogar() {
  // reseta o personagem
  persona.resete();

  plats = new ArrayList<Plataforma>();
  // adicionando as plataformas iniciais
  Plataforma p1 = new Plataforma(velCorrida, width/2);
  PVector vp1 = p1.getPosicao();
  plats.add(p1);
  Plataforma p2 = new Plataforma(velCorrida, (int) vp1.x + p1.getLargura() + 130);
  PVector vp2 = p2.getPosicao();
  plats.add(p2);
  Plataforma p3 = new Plataforma(velCorrida, (int) vp2.x + p2.getLargura() + 130);
  plats.add(p3);
  
  // alterando o status do jogo
  status = statusDoJogo[1];
}
// executar a partida para o jogador jogar
void jogando() {
  
  // --- PLATAFORMAS ---
  // percorre as plataformas das lista
  for(int i=0; i < plats.size(); i++){
    // exibe a plataforma
    Plataforma p = plats.get(i);
    p.display();
    
    if(p.saiuDaTela()){
      // remove se ela saiu da tela
      plats.remove(i);
    }
  }
  // adiciona uma nova plataforma na lista
  if(plats.size() < 3 && frameCount%freqPlataformas==0) {
    Plataforma np = new Plataforma(velCorrida, width);
    plats.add(np);
  }
  // --- PLATAFORMAS ---
  
  // --- PERSONAGEM ---
  // exibe o personagem
  persona.display();
  // atualiza a personagem
  persona.update();
  // checa se ele está em uma das plataformas da lista
  persona.checaPlataformas(plats);
  // muda o status do jogo se for gameover para o personagem
  if(persona.getGameOver() == true) status = statusDoJogo[2];
  // --- PERSONAGEM ---
}

void keyPressed(){
  
  // --- MOVIMENTAR PERSONAGEM ---
  if (keyCode == UP) {
    persona.pular();
  } else if (keyCode == RIGHT) {
    persona.paraDireita();
  } else if (keyCode == LEFT) {
    persona.paraEsquerda();
  }
  // --- MOVIMENTAR PERSONAGEM ---
  
  persona.personaKeyPressed();
}


void keyReleased(){
  // muda status do jogo
  if(keyCode == ENTER && (status == "jogar" || status == "fim")) jogar();
  
  persona.personaKeyReleased();
}
