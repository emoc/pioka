class Courbe {
  float[][] sg;          // tableau contenant les coordonnées de points pour chaque segment
  float mul;             // multiplicateur d'échelle
  float x;               // coordonnées x du point de départ
  float y;               // coordonnées y du point de départ
  int seg;               // nombre de segments
  float ln;              // longueur de chaque segment (en pixels)
  float wd;              // largeur de chaque segment (en pixels)
  float angstart;        // angle de départ
  float angd1;           // variation de l'angle entre chaque segment, borne basse
  float angd2;           // variation de l'angle entre chaque segment, borne haute
  float anginvert;       // % en dessous duquel l'angle s'inverse à chaque segment (0 : pas d'inversion, 100 : inversion à chaque segment)
  //float lnc;           // longueur des controles de courbe
  float lnmod;           // modulation de la longueur des vecteurs de controle
  float cbase = 155;     // couleur de base
  color col;             // couleur de la ligne
  float branches;        // nombre branches max
  float branche_dim;     // diminution des dimensions (largeur, longueur) des nouveaux embranchements (entre 0 et 1)
  float branches_gen;    // nombre de génération d'embranchements, diminue à chaque nouvelle génération
  boolean viewcontrol;   // afficher ou pas les vecteurs de contrôle
  


  /*
    Courbe (float _mul, float _x, float _y, int _seg, float _length, float _width, float _angstart, float _ang1, float _ang2, float _branches, color _col) {
   _mul : multiplicateur d'échelle
   _x : coordonnée x du point départ
   _y : coordonnée y du point de départ
   _seg : nombre de segments
   _length : longueur d'un segment (en pixels)
   _width : largeur d'un segment (en pixels)
   _angstart : angle de départ (en degrés)
   _ang1 : variation de l'angle entre chaque segment, borne basse (en degrés)
   _ang2 : variation de l'angle entre chaque segment, borne haute (en degrés)
   _anginvert : pourcentage en dessous duquel l'angle s'inverse à chaque calcul (entre 0 : pas d'inversion et 100 : inversion à chaque segment)
   _branches : nombre d'embranchements
   _branche_dim : diminution des dimensions des nouveaux embranchements (entre 0 et 1)
   _branches_gen : nombre de génération d'embranchements
   _col : couleur de la courbe
   _viewcontrol : affichage ou pas des traites de contrôle
   */


  Courbe (float _mul, float _x, float _y, int _seg, float _ln, float _wd, 
          float _angstart, float _ang1, float _ang2, float _anginvert, 
          float _br, float _brdim, float _brgen, color _col, boolean _viewcontrol) {
    mul = _mul;
    x = _x;
    y = _y;
    seg = _seg;
    ln = _ln;
    wd = _wd;
    lnmod = 1;
    angstart = radians(_angstart);
    angd1 = radians(_ang1);
    angd2 = radians(_ang2);
    anginvert = _anginvert;
    sg = new float[seg][15];
    col = _col;
    branches = _br;
    branche_dim = _brdim;
    branches_gen = _brgen;
    viewcontrol = _viewcontrol;

    initSegments();
  }

  void nouvelleBranche( float sx, float sy, float bang) {

    if (random(100) > 80 && branches > 0 && branches_gen > 0) {

      branches --;
      branches_gen --;
      
      if (branches < 0) branches = 0;

      courbes.add(  new Courbe(
        mul,
        sx, // x
        sy, // y
        int(seg * branche_dim), // nbre de segments
        ln * branche_dim, // longueur des segments
        wd * branche_dim, // largeur des segments
        degrees(bang) + random(-20, 20), // angle de départ
        degrees(angd1), degrees(angd2), // angle mini, angle maxi
        anginvert,    // inversion d'angle si random(100) < à cette valeur
        branches,   // nombres de branches
        branche_dim,
        branches_gen,
        col,
        viewcontrol)                     
        );
    }
  }

  void initSegments() {
    float s_x = 0, s_y = 0, s_a = 0, s_ax = 0, s_ay = 0, s_bx = 0, s_by = 0;
    float s_c1ax, s_c1ay, s_c2ax, s_c2ay, s_c1bx, s_c1by, s_c2bx, s_c2by;
    float s_x0 = 0, s_y0 = 0, s_a0 = 0, s_ax0 = 0, s_ay0 = 0, s_bx0 = 0, s_by0 = 0;

    /* que contient le tableau sg des segments ?
     
     c2 (c2ax, c2ay)
     /
     /
     *  a (ax,ay) ------------------ * a {n+1} ------- ...
     / |                               |
     /  |                               |
     c1  |                               |
     |                               |
     * point de départ (x, y)        * (point suivant
     |                               |
     |  c2 (c2bx, c2by)              |
     | /                             |
     |/                              |
     *  b (bx, by) ------------------* b {n+1} --------- ...
     /
     /
     c1 (c1bx, c1by)
     
     sg[n][0] ;  // coordonnée X du point de départ            (s_x)
     sg[n][1] ;  // coordonnée Y du point de départ            (s_y)
     sg[n][2] ;  // angle de direction du segment              (s_a)
     sg[n][3] ;  // coordonnée X du point externe a            (s_ax)
     sg[n][4] ;  // coordonnée Y du point externe a            (s_ay)
     sg[n][5] ;  // coordonnée X du point externe b            (s_bx)
     sg[n][6] ;  // coordonnée Y du point externe b            (s_by)
     sg[n][7] ;  // coordonnée X du point de controle 1 de a   (s_c1ax)
     sg[n][8] ;  // coordonnée Y du point de controle 1 de a   (s_c1ay)
     sg[n][9] ;  // coordonnée X du point de controle 2 de a   (s_c2ax)
     sg[n][10] ; // coordonnée Y du point de controle 2 de a   (s_c2ay)
     sg[n][11] ; // coordonnée X du point de controle 1 de b   (s_c1bx)
     sg[n][12] ; // coordonnée Y du point de controle 1 de b   (s_c1by)
     sg[n][13] ; // coordonnée X du point de controle 2 de b   (s_c2bx)
     sg[n][14] ; // coordonnée Y du point de controle 2 de b   (s_c2by)
     
     */

    // on commence par créer tous les points et les angles entre les segments...
    for (int i = 0; i < seg; i++) {
      if (i == 0) { // cas particulier du premier segment
        sg[i][2] = angstart; //random(-PI, PI);
        sg[i][0] = x;
        sg[i][1] = y;
      } else {
        if (random(100) < anginvert) {
          angd1 = -angd1;
          angd2 = -angd2;
        }
        sg[i][2] = sg[i-1][2] + random(angd1, angd2);
        sg[i][0] = sg[i-1][0] + ln * cos(sg[i-1][2]);
        sg[i][1] = sg[i-1][1] + ln * sin(sg[i-1][2]);
      }
    }
    for (int i = 0; i < seg; i++) {

      float lnc;

      if (i == 0) { // cas particulier du premier segment

        s_x = sg[0][0];
        s_y = sg[0][1];
        s_a = sg[0][2];

        s_ax = s_x + wd * cos(s_a - HALF_PI);
        s_ay = s_y + wd * sin(s_a - HALF_PI);
        s_bx = s_x + wd * cos(s_a + HALF_PI);
        s_by = s_y + wd * sin(s_a + HALF_PI);

        lnc = ln / 2 * lnmod;

        s_c1ax = s_ax + lnc * cos(s_a - PI);
        s_c1ay = s_ay + lnc * sin(s_a - PI);
        s_c2ax = s_ax + lnc * cos(s_a);
        s_c2ay = s_ay + lnc * sin(s_a);

        s_c1bx = s_bx + lnc * cos(s_a - PI);
        s_c1by = s_by + lnc * sin(s_a - PI);
        s_c2bx = s_bx + lnc * cos(s_a);
        s_c2by = s_by + lnc * sin(s_a);

        // ajouter les valeurs au tableau
        sg[i][0]  = s_x;
        sg[i][1]  = s_y;
        sg[i][2]  = s_a;
        sg[i][3]  = s_ax;
        sg[i][4]  = s_ay;
        sg[i][5]  = s_bx;
        sg[i][6]  = s_by;
        sg[i][7]  = s_c1ax;
        sg[i][8]  = s_c1ay;
        sg[i][9]  = s_c2ax;
        sg[i][10] = s_c2ay;
        sg[i][11] = s_c1bx;
        sg[i][12] = s_c1by;
        sg[i][13] = s_c2bx;
        sg[i][14] = s_c2by;

      } else {

        s_x = sg[i][0];
        s_y = sg[i][1];
        s_a = sg[i][2];

        float ang1, ang2;

        ang1 = atan2(sg[i][1] - sg[i-1][1], sg[i][0] - sg[i-1][0]);
        if (i == seg - 1) ang2 = ang1;
        else ang2 = atan2(sg[i+1][1] - sg[i][1], sg[i+1][0] - sg[i][0]);

        if (abs(ang2 - ang1) > (TWO_PI - abs(angd2) - abs(angd1))) {
          ang2 = ang2 * -1;
        }
        // probleme ici quand on est proche de -PI et + PI la moyenne est faussée...
        //float angmed = (ang2 + ang1) / 2;
        float angmed = (ang2 - ang1) / 2 + ang1;

        //println(i + " ang1 : " + ang1 + " ang2 : " + ang2 + " angmed : " + angmed );

        s_ax = s_x + wd * cos(angmed - HALF_PI);
        s_ay = s_y + wd * sin(angmed - HALF_PI);
        s_bx = s_x + wd * cos(angmed + HALF_PI);
        s_by = s_y + wd * sin(angmed + HALF_PI);


        // calculer les points de contrôle
        // TODO : définir la longeur des vecteurs de controle
        // en fonction de la distance entre les points de controle...
        lnc = ln / 2 * lnmod;

        s_c1ax = s_ax + lnc * cos(angmed - PI);
        s_c1ay = s_ay + lnc * sin(angmed - PI);
        s_c2ax = s_ax + lnc * cos(angmed);
        s_c2ay = s_ay + lnc * sin(angmed);

        s_c1bx = s_bx + lnc * cos(angmed - PI);
        s_c1by = s_by + lnc * sin(angmed - PI);
        s_c2bx = s_bx + lnc * cos(angmed);
        s_c2by = s_by + lnc * sin(angmed);

        // ajouter les valeurs au tableau
        sg[i][0]  = s_x;
        sg[i][1]  = s_y;
        sg[i][2]  = s_a;
        sg[i][3]  = s_ax;
        sg[i][4]  = s_ay;
        sg[i][5]  = s_bx;
        sg[i][6]  = s_by;
        sg[i][7]  = s_c1ax;
        sg[i][8]  = s_c1ay;
        sg[i][9]  = s_c2ax;
        sg[i][10] = s_c2ay;
        sg[i][11] = s_c1bx;
        sg[i][12] = s_c1by;
        sg[i][13] = s_c2bx;
        sg[i][14] = s_c2by;

        // TODO :  prévoir le cas du dernier segment

      }
    }
  }

  void updateColBase(float cnew) {
    cbase = cnew;
  }

  void draw(PGraphics pg) {
    pg.stroke(255);
    pg.fill(255);
    pg.strokeWeight(mul);

    for (int i = 0; i < seg-1; i++) {
      pg.stroke(col);
      pg.fill(col);

      if (i == 0) pg.ellipse(sg[i][0], sg[i][1], wd*2, wd*2);
      if (i == seg - 2) pg.ellipse(sg[i+1][0], sg[i+1][1], wd*2, wd*2);

      nouvelleBranche(sg[i][0], sg[i][1], sg[i][2]);


      pg.beginShape();
      pg.vertex(sg[i][3], sg[i][4]);
      pg.bezierVertex(sg[i][9], sg[i][10], sg[i+1][7], sg[i+1][8], sg[i+1][3], sg[i+1][4]);
      pg.vertex(sg[i+1][5], sg[i+1][6]);
      pg.bezierVertex(sg[i+1][11], sg[i+1][12], sg[i][13], sg[i][14], sg[i][5], sg[i][6]);
      pg.endShape(CLOSE);

      if (viewcontrol) {
        /* ************ afficher les points de controle */
        pg.stroke(0);
        pg.strokeWeight(mul * 0.5);
        pg.line(sg[i][3], sg[i][4], sg[i][7], sg[i][8]);
        pg.line(sg[i][3], sg[i][4], sg[i][9], sg[i][10]);
        pg.line(sg[i][5], sg[i][6], sg[i][11], sg[i][12]);
        pg.line(sg[i][5], sg[i][6], sg[i][13], sg[i][14]);
      }
    }
  }
}
