/*
 PIOKA
 Dessins génératifs pour Flux (flux.bzh)
 Quimper, Dour Ru, 20231003 / emoc / pierre@lesporteslogiques.net
 Processing 4.0b2 @ kirin / Debian Stretch 9.5
 
 003 : tous les tracés graphiques se font dans un buffer (les classes tracent dans le buffer)
 004 / pioka : version définitive, les valeurs des différents presets ont été modifiées au fur et à mesure
 
 Interactions clavier
   's' pour enregistrer (en haute définition selon la valeur de SAVE_HIRES ci-dessous)
   'r' pour remlancer la génération d'une nouvelle image
 
 */

boolean SAVE_HIRES = true; // Enregistrer en haute définition, pour impression, ou pas

// fonctions de dates pour l'export d'images de log
import java.util.Date;
import java.text.SimpleDateFormat;
String SKETCH_NAME = getClass().getSimpleName();

// Paramètres principaux
int mode_courbe = 6;             //  /!\ PRESETS : changer cete valeur modifie le graphisme
PImage logo;
ArrayList courbes = new ArrayList();

color[] colors = {
  #5D12D2, #B931FC, #362FD9, #6499E9, #9EDDFF, #A6F6FF, #5B0888, #713ABE, #9D76C1, 
  #27005D, #9400FF, #0E21A0, #4D2DB7, #9D44C0, #793FDF, #7091F5, #614BC3, #6F61C0, 
  #A084E8, #6528F7, #A076F9, #6527BE, #9681EB  };

color[] colors2 = {   // couleurs secondaires, de contraste
  #FF6AC2, #FFE5E5, #1AACAC, #2E97A7, #BEFFF7, #E5CFF7, #AED2FF, #97FFF4, #33BBC5, 
  #85E6C5, #C8FFE0, #8BE8E5, #45CFDD  };
  
color[] colors3 = {
  #5D12D2, #B931FC, #362FD9, #AED2FF, #97FFF4, #FF6AC2, #FFE5E5, #6499E9, #9EDDFF, #A6F6FF, #5B0888, #713ABE, #9D76C1, 
  #27005D, #1AACAC, #2E97A7, #9400FF, #0E21A0, #4D2DB7, #9D44C0, #33BBC5, #85E6C5, #793FDF, #7091F5, #614BC3, #6F61C0, 
  #A084E8, #C8FFE0, #6528F7, #A076F9, #BEFFF7, #E5CFF7, #6527BE, #9681EB, #8BE8E5, #45CFDD  };

PFont pixeltiny;
// Paramètres de dimensionnement et de buffer
// 40 x 60 @ 150 dpi : 2362 x 3543, arrondi à 2364 x 3544 (/4 : 591 x 886)
float mul = 4; // rapport entre la fenêtre d'affichage et la taille de buffer
PGraphics pg;

// Debug
//boolean SHOW_CONTROL = true; // passé en variable dans la classe
boolean SHOW_LEGEND = true;



void setup() {
  size(591, 886);
  pg = createGraphics(2364,3544); // buffer 40x60 @ 150dpi
  smooth();
  logo = loadImage("logo_flux.png");
  pixeltiny = loadFont("PixelTiny-48.vlw");
  initCourbes(mode_courbe);
}

void draw () {
  background(255);
  pg.beginDraw();
  pg.background(255);
  pg.endDraw();
  for (int i = 0; i < courbes.size(); i++) {
    Courbe s = (Courbe) courbes.get(i);
    
    pg.beginDraw();
    println("courbe " + i + " en cours");
    s.draw(pg);
    pg.endDraw();
    
  }
  
  // Signature
  pg.beginDraw();
  pg.fill(255);
  pg.rect(pg.width - (150 * mul) - 10, pg.height - (10 * mul) - 16, 216, 21);
  pg.fill(#5B0888);
  String emoc = signature();
  pg.textFont(pixeltiny, 36);
  pg.text(emoc, pg.width - (150 * mul), pg.height - (10 * mul));
  pg.endDraw();
    
  /* image(logo, width-125 - 10, 10, 125, 42); // Typo flux */
  image(pg, 0, 0, width, height);
  noLoop();
}

void initCourbes(int mode_courbe) {
  // Chacune de ces fonctions déclenchent des presets différents
  if (mode_courbe == 1) initCourbes1(mul);
  if (mode_courbe == 2) initCourbes2(mul);
  if (mode_courbe == 3) initCourbes3(mul);
  if (mode_courbe == 4) initCourbes4(mul);
  if (mode_courbe == 5) initCourbes5(mul);
  if (mode_courbe == 6) initCourbes6(mul);
  if (mode_courbe == 7) initCourbes7(mul);
  if (mode_courbe == 8) println("pas de presets pour le moment");
  if (mode_courbe == 9) println("pas de presets pour le moment");
}

String signature() {
  Date now = new Date();
  SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd-HHmmss");
  return "emoc-" + formater.format(now) + "-ic" + mode_courbe;
}


void keyPressed() {
  if (key == 's') {
    Date now = new Date();
    SimpleDateFormat formater = new SimpleDateFormat("yyyyMMdd_HHmmss");
    System.out.println(formater.format(now));
    saveFrame(SKETCH_NAME + "_" + formater.format(now) + "_ic" + mode_courbe + ".png");
    if (SAVE_HIRES) pg.save(SKETCH_NAME + "_" + formater.format(now) + "_HR_ic" + mode_courbe + ".png");
  }
  if (key == 'r') {
    // Relancer une génération en supprimant toutes les courbes
    for (int i = courbes.size() - 1; i >= 0; i--) {
      courbes.remove(i);
    }
    initCourbes(mode_courbe);
    redraw();
  }
}
