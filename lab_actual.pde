/**
 * Laberinto Recursivo - Versión Mejorada
 * por Sebastian Peñaranda y Willman Giraldo
 */
 
//definicion de variables

int columnas, filas;  // Número de columnas y filas en el laberinto
int TC = 40;  // Tamaño de cada celda en el laberinto
int[][] cuadricula;  // Representación del laberinto como una matriz de enteros
boolean[][] visitado;   // Matriz para rastrear las celdas visitadas durante la generación
int posXActual = 0;  // Posición actual en el eje x
int posYActual = 0;  // Posición actual en el eje y
ArrayList<PVector> historialMovimientos  = new ArrayList<PVector>();  // Historial de movimiento
int page = 1;   // Variable para controlar la página actual del programa
int num;  // Variable sin uso aparente
PFont letras;  // Fuente utilizada para el texto en la interfaz
boolean manual=false;   // Modo manual para mover el cuadrado
int a =1;   // Variable sin uso aparente
boolean[][] visitadod ; // Matriz para rastrear las celdas visitadas durante la resolución automática
boolean completado =false;  // Indica si el laberinto ha sido completado
boolean auto =false;   // Modo automático para resolver el laberinto
int contador =1;   // Contador para realizar acciones específicas en el código
int squareX =width / 2 - (filas * TC) / 2 + 5; // Posición inicial X del cuadrado
int squareY = height / 2 - (filas * TC) / 2 + 5; // Posición inicial Y del cuadrado

/**
 * Configuración inicial de la aplicación
 */
void setup() {
  letras = createFont("Beyonders.otf", 16);
  textFont(letras);
  fullScreen();
}
/**
 * Bucle principal de dibujo
 * se dibujan las diferenteas pantallas dependiendo de cual seleccione
 */

void draw() {
  background(75, 174, 206);
  if (page ==1) {
    drawStart();
  }
  if (page == 2) {
    drawLevels();
  }
  if (page ==3) {
    drawLab();
  }
}

/**
 * Dibuja la pantalla de inicio
 * menu inicual
 */

void drawStart() {
  fill(0);
  background(75, 174, 206);
  rect(width/2-120, height/2+5, 250, 100);
  fill(102, 130, 167);
  rect(width/2-125, height/2, 250, 100);
  fill(0);
  textSize(80);
  text("maze mania", width/3.5, height/3);
  textSize(40);
  text("Start", width/2-100, height/2+75);
  textSize(20);
  text("Credits:", width/2-90, height/1.5);
  text("generate maze By Sebastian Peñaranda - Willman Giraldo", width/4.5, height/1.4);
  fill(255);
  textSize(80);
  text("maze mania", width/3.5-20, height/3);
  
}
/**
 * Dibuja la pantalla de selección de niveles
 * dibuja seleccion de dificultad
 */

void drawLevels() {

  fill(0);
  textSize(100);
  text("LEVELS", width/2-300, height/6);
  fill(255);
  textSize(100);
  text("LEVELS", width/2-285, height/6);
  fill(0);
  rect(width/4-120, height/1.5+5, 250, 100);
  fill(102, 130, 167);
  rect(width/4-125, height/1.5, 250, 100);
  fill(0);
  textSize(35);
  text("Easy", width/4-65, height/1.5+70);
  fill(0);
  rect(width/2-120, height/1.5+5, 250, 100);
  fill(102, 130, 167);
  rect(width/2-125, height/1.5, 250, 100);
  fill(0);
  text("Medium", width/2-120, height/1.5+70);
  fill(0);
  rect(width/1.3-120, height/1.5+5, 250, 100);
  fill(102, 130, 167);
  rect(width/1.3-125, height/1.5, 250, 100);
  fill(0);
  text("Hard", width/1.3-80, height/1.5+70);
}
/**
 * Dibuja el laberinto y gestiona la interactividad
 * dibuja toda la parte de interactividad
 */
void drawLab() {
  for (int i = 0; i < filas; i++) {
    for (int j = 0; j < columnas; j++) {
      int x = width/2-(filas*TC)/2+j * TC;
      int y = height/2-(filas*TC)/2+i * TC;
      int celda = cuadricula[i][j];
      //dibuja el laberinto y dibuja el camino que recorrio el codigo recursivo para llegar al punto
      if (auto && visitadod[i][j]) {
        fill(0, 91, 167);
        noStroke();
        rect(x, y, TC, TC);
      }
      stroke(1);
      if ((celda & 1) > 0) line(x, y, x + TC, y); // Arriba
      if ((celda & 2) > 0) line(x + TC, y, x + TC, y + TC); // Derecha
      if ((celda & 4) > 0) line(x + TC, y + TC, x, y + TC); // Abajo
      if ((celda & 8) > 0) line(x, y + TC, x, y); // Izquierda

      // Verifica si la celda está marcada como visitada durante el recorrido automático
    }
  }
  //se encarga de la generacion del laberinto
  if (historialMovimientos .size()>0) {

    if (historialMovimientos .size() > 0) {
      PVector siguiente = revisarVecinos(posXActual, posYActual);
      if (siguiente != null) {
        int sigPosX = (int) siguiente.x;
        int sigPosY = (int) siguiente.y;

        historialMovimientos .add(new PVector(sigPosX, sigPosY));
        eliminarParedes(posXActual, posYActual, sigPosX, sigPosY);
        posXActual = sigPosX;
        posYActual = sigPosY;
        visitado[posYActual][posXActual] = true;
      } else if (historialMovimientos .size() > 0) {
        PVector regresar = historialMovimientos.remove(historialMovimientos.size() - 1);
        posXActual = (int) regresar.x;
        posYActual = (int) regresar.y;
      }
    }
  } else {
    if (a==1) {
      for (int i = 0; i < filas; i++) {
        for (int j = 0; j < columnas; j++) {
          visitado[i][j]=false;
        }
      }
      a++;
    }
  }
  if (auto) {
    resolverLaberinto(0, 0);
  }



  fill(0, 255, 0); // Verde
  rect(width / 2 - (filas * TC) / 2 + 5, height / 2 - (filas * TC) / 2 + 5, TC - 10, TC - 10);

  // Dibujar el punto final en rojo (por ejemplo)
  fill(255, 0, 0); // Rojo
  rect(width / 2 + (filas * TC) / 2 - TC + 5, height / 2 + (filas * TC) / 2 - TC + 5, TC - 10, TC - 10);
  fill(0);
  rect(width-260+5, 20+5, 220, 70);
  fill(102, 130, 167);
  rect(width-260, 20, 220, 70);
  fill(0);
  textSize(35);
  text("Back", width-220, 75);
  rect(width/12+5, height/2-45, 250, 100);
  rect(width/1.27+5, height/2-45, 250, 100);
  fill(102, 130, 167);
  rect(width/12, height/2-50, 250, 100);
  rect(width/1.27, height/2-50, 250, 100);
  fill(0);
  textSize(26);
  text("Manual", width/12+35, height/2+20);
  text("Automatic", width/1.27+2, height/2+20);
  if (auto) {
  }
  if (manual) {
    fill(0, 255, 155); // Verde
    rect(squareX, squareY, TC - 10, TC - 10);
  }
  if (squareX==width / 2 + (filas * TC) / 2 - TC + 5 && squareY == height / 2 + (filas * TC) / 2 - TC + 5) {
    textSize(70);
    completado=true;
    fill(0);
    text("Completado", width/3-100, height/2);
  }
}

/**
 * Revisa los vecinos de una celda para generar el laberinto
 * se encarga de revisar que cuadros no han sido revisados o visitados
 * @param x La coordenada x de la celda actual
 * @param y La coordenada y de la celda actual
 * @return El siguiente vecino no visitado
 */
PVector revisarVecinos(int x, int y) {
  ArrayList<PVector> vecinos = new ArrayList<PVector>();

  PVector arriba = new PVector(x, y - 1);
  PVector derecha = new PVector(x + 1, y);
  PVector abajo = new PVector(x, y + 1);
  PVector izquierda = new PVector(x - 1, y);

  if (x - 1 >= 0 && !visitado[y][x - 1]) {
    vecinos.add(izquierda);
  }
  if (y - 1 >= 0 && !visitado[y - 1][x]) {
    vecinos.add(arriba);
  }
  if (x + 1 < columnas && !visitado[y][x + 1]) {
    vecinos.add(derecha);
  }
  if (y + 1 < filas && !visitado[y + 1][x]) {
    vecinos.add(abajo);
  }

  if (vecinos.size() > 0) {
    int indiceAleatorio = floor(random(0, vecinos.size()));
    return vecinos.get(indiceAleatorio);
  } else {
    return null;
  }
}

/**
* resuelve el laberinto verificando los vecinos de forma recursiva hasta llegar al punto de meta
* resuelve el laberinto de forma automatica
*/
void resolverLaberinto(int x, int y) {
  if (x == columnas - 1 && y == filas - 1) {
    // Llegamos al punto final
    return;
  }

  ArrayList<PVector> vecinos2 = new ArrayList<PVector>();

  PVector arriba = new PVector(x, y - 1);
  PVector derecha = new PVector(x + 1, y);
  PVector abajo = new PVector(x, y + 1);
  PVector izquierda = new PVector(x - 1, y);

  if (x + 1 < columnas && (cuadricula[y][x] & 2) == 0 && !visitadod[y][x + 1]) {
    vecinos2.add(derecha);
  }
  if (y + 1 < filas && (cuadricula[y][x] & 4) == 0 && !visitadod[y + 1][x]) {
    vecinos2.add(abajo);
  }
  if (y - 1 >= 0 && (cuadricula[y][x] & 1) == 0 && !visitadod[y - 1][x]) {
    vecinos2.add(arriba);
  }
  if (x - 1 >= 0 && (cuadricula[y][x] & 8) == 0 && !visitadod[y][x - 1]) {
    vecinos2.add(izquierda);
  }


  for (PVector vecino : vecinos2) {
    int nextX = (int) vecino.x;
    int nextY = (int) vecino.y;

    visitadod[nextY][nextX] = true;
    
      resolverLaberinto(nextX, nextY);
    
    if (nextX == columnas - 1 && nextY == filas - 1) {
      return;
    }
  }
}

/**
 * Elimina las paredes entre dos celdas
 * se encarga de eliminar las parede despues de generar la matriz
 * @param posXActual La coordenada x de la celda actual
 * @param posYActual La coordenada y de la celda actual
 * @param sigPosX La coordenada x de la siguiente celda
 * @param sigPosY La coordenada y de la siguiente celda
 */
void eliminarParedes(int posXActual, int posYActual, int sigPosX, int sigPosY) {
  int x = posXActual - sigPosX;
  int y = posYActual - sigPosY;

  if (x == 1) {
    cuadricula[posYActual][posXActual] &= ~8;
    cuadricula[sigPosY][sigPosX] &= ~2;
  } else if (x == -1) {
    cuadricula[posYActual][posXActual] &= ~2;
    cuadricula[sigPosY][sigPosX] &= ~8;
  }
  if (y == 1) {
    cuadricula[posYActual][posXActual] &= ~1;
    cuadricula[sigPosY][sigPosX] &= ~4;
  } else if (y == -1) {
    cuadricula[posYActual][posXActual] &= ~4;
    cuadricula[sigPosY][sigPosX] &= ~1;
  }
}
/**
* genera el tamaño de la matriz o laberinto
*/
public void generarValores(int a, int b) {
  int M=int(random(a, b));
  while (M < 3) {
    M=int(random(a, b));
  }
  filas = M;
  columnas =M;
}
/**
 * Acciones realizadas al presionar el mouse
 * para configurar las acciones del mouse en cada pantalla
 */
public void mousePressed() {
  if (page == 1) {
    if (mouseX>width/2-125 &&mouseX<width/2+125 && mouseY>height/2 &&mouseY<height/2+100) {
      page = 2;
    }
  }
  if (page == 2) {
    if (mouseX > width / 4 - 120 && mouseY > height / 1.5 + 5 && mouseX < width / 4 - 120 + 250 && mouseY < height / 1.5 + 5 + 100) {
      generarValores(0, 5);
      TC=120;
      page = 3;
      squareX =width / 2 - (filas * TC) / 2 + 5; // Posición inicial X del cuadrado
      squareY = height / 2 - (filas * TC) / 2 + 5;
    } else if (mouseX > width / 2 - 120 && mouseY > height / 1.5 + 5 && mouseX < width / 2 - 120 + 250 && mouseY < height / 1.5 + 5 + 100) {
      TC=100;
      generarValores(5, 10);
      page = 3;
      squareX =width / 2 - (filas * TC) / 2 + 5; // Posición inicial X del cuadrado
      squareY = height / 2 - (filas * TC) / 2 + 5;
    } else if (mouseX > width / 1.3 - 120 && mouseY > height / 1.5 + 5 && mouseX < width / 1.3 - 120 + 250 && mouseY < height / 1.5 + 5 + 100) {
      generarValores(13, 17);
      page = 3;
      TC=60;
      squareX =width / 2 - (filas * TC) / 2 + 5; // Posición inicial X del cuadrado
      squareY = height / 2 - (filas * TC) / 2 + 5;
    }
    cuadricula = new int[filas][columnas];
    visitado = new boolean[filas][columnas];
    visitadod = new boolean[filas][columnas];
    

    for (int i = 0; i < filas; i++) {
      for (int j = 0; j < columnas; j++) {
        cuadricula[i][j] = 15; // Todas las paredes cerradas
        visitado[i][j] = false;
        visitadod[i][j] = false;
      }
    }
  }

  if (page == 3) {

    if (contador == 1) {
      historialMovimientos.add(new PVector(0, 0));
      visitado[0][0] = true;
      contador =2;
    }
    if (mouseX>width-260&&mouseY>20&&mouseX<width-260+220&& mouseY<20+70) {
      page=1;
      manual=false;
      contador =1;
      manual=false;
      auto=false;
      completado = false;
      for (int i = 0; i < filas; i++) {
        for (int j = 0; j < columnas; j++) {
          visitadod[i][j] = false;
        }
      }
    }
    if (mouseX>width/12 && mouseX< width/12+250 && mouseY>height/2-25 && mouseY<height/2+75) {
      manual=true;
    }
    if (mouseX>width/1.27 && mouseX< width/1.27+250 && mouseY>height/2-25 && mouseY<height/2+75 && !completado) {
      auto =true;
      // Dibujar el camino solución en rojo
    }
  }
}
boolean stop=false;

/**
 * Acciones realizadas al liberar una tecla
 * se usa para poder mover el cuadrado en el modo manual
 */
void keyReleased() {
  if (manual && !completado) {


    if (key == 'A' || key =='a') {
      if (stop) {
        stop = false;
      } else {
        stop = true;
      }
    }
    if (keyCode == UP &&!stop) {
      squareY -= TC;
    } else if (keyCode == DOWN&&!stop) {
      squareY += TC;
    } else if (keyCode == LEFT&&!stop) {
      squareX -= TC;
    } else if (keyCode == RIGHT&&!stop) {
      squareX += TC;
    }

  }
}
