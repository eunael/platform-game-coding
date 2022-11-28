// GIT: https://github.com/naelallves/platform-game-coding

//PImage bg;
// instância do personagem
Persona persona;
// array list para as plataformas na tela
ArrayList<Plataforma> plats;
// frequência de aparição das plataformas
int freqPlataformas;
// velocidade do ambiente 
int velCorrida = 5;
// verificar se está esperando iniciar uma partida
boolean esperandoInicio = true;
// status possíveis do jogo
String[] statusDoJogo = {"jogar", "jogando", "fim"};
// status atual do jogo
String status = "jogar";
// fonte
PFont font;
// placar
int placar;
// numero padrão para os frames
int numFrames = 60;

boolean rightpress=false, leftpress=false;

void setup() {
  size(600, 800);
  frameRate(numFrames);
  
  // instaciando o personagem
  persona = new Persona(300, 100, velCorrida);
  
  //bg = loadImage("animacoes/background.png");
  
  font = createFont("fonts/NerkoOne-Regular.ttf", 24);
  textFont(font);
  
  freqPlataformas = int(numFrames / 2);
  
  placar = 0;
}

void draw() {
  // com imagem trava muito
  //image(bg, 0, 0, width, height);
  
  background(135, 206, 235);
  
  if(status == "jogar") {
    // exibi texto de intrução
    push();
    fill(#e8f4fc);
    textSize(40);
    textAlign(CENTER);
    text("Pressione Enter para\niniciar um novo jogo", width/2, height/2);
    pop();
  } else if (status == "jogando") {
    jogando();
  } else if (status == "fim") {
    // exibi texto de intrução
    push();
    fill(#e8f4fc);
    textAlign(CENTER);
    textSize(60);
    text("GAME OVER!!", width/2, 270);
    textSize(40);
    text("Pontuação: " + placar + "s", width/2, height/2+40);
    textSize(24);
    text("Pressione Enter para\niniciar um novo jogo", width/2, 500);
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
  
  zeraPlacar();
}
// executar a partida para o jogador jogar
void jogando() {
  mostraPlacar();
  
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
  if(plats.size() < 4 && frameCount%freqPlataformas==0) {
    int randomVelPlat;
    do{
      randomVelPlat = int(random(velCorrida, velCorrida+5));
    } while(freqPlataformas%5!=0);
    
    Plataforma np = new Plataforma(randomVelPlat, width);
    plats.add(np);
  }
  // --- PLATAFORMAS ---
  
  // --- PERSONAGEM ---
  movimentaPersona();
  // exibe o personagem
  persona.display();
  // atualiza a personagem
  persona.update();
  // checa se ele está em uma das plataformas da lista
  persona.checaPlataformas(plats);
  // muda o status do jogo se for gameover para o personagem
  if(persona.getGameOver() == true) status = statusDoJogo[2];
  // --- PERSONAGEM ---
  
  if(frameCount%numFrames == 0) {
    somaPlacar();
  }
}

void movimentaPersona() {
  if(rightpress == true) {
    persona.paraDireita();
  }
  if(leftpress == true) {
    persona.paraEsquerda();
  }
}

void keyPressed(){
  
  // --- MOVIMENTAR PERSONAGEM ---
  if (keyCode == UP) {
    persona.pular();
  }
  if (keyCode == RIGHT) {
    rightpress = true;
  }
  if (keyCode == LEFT) {
    leftpress = true;
  }
  // --- MOVIMENTAR PERSONAGEM ---
  
  persona.personaKeyPressed();
}

void somaPlacar() {
  placar++;
}
void zeraPlacar() {
  placar = 0;
}
void mostraPlacar() {
  push();
  fill(#e8f4fc);
  textSize(40);
  textAlign(CENTER);
  text(placar + "s", 40, 40);
  pop();
}

void keyReleased(){
  // muda status do jogo
  if(keyCode == ENTER && (status == "jogar" || status == "fim")) jogar();
  
  if (keyCode == RIGHT) {
    rightpress = false;
  }
  if (keyCode == LEFT) {
    leftpress = false;
  }
  
  persona.personaKeyReleased();
}
