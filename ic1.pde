void initCourbes1(float mul) {

  int index_col  = int(random(colors.length));
  int index_col2 = int(random(colors2.length));
  //int nb_courbes = 8;
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

  float angle1, angle2, lmin, lmax, dice;
  int compteur = 0;

  // ******************************************************************************
  // ******************************************************************************
  // ******************************************************************************

  for (int i=0; i < 5; i++) {

    dice = random(100);

    // Utiliser compteur pour définir le point de départ et l'angle des courbes
    float xx = 0, yy = 0, aa = 0;
    if (compteur == 0) { // départ du bas
      xx = random(pg.width);
      yy = random(pg.height + 30, pg.height + 100);
      aa = random(210, 330);
    }
    if (compteur == 1) { // départ de la gauche
      xx = random(- 100, -30);
      yy = random(100, pg.height - 100);
      aa = random(280, 440);
    }
    if (compteur == 2) { // départ du haut
      xx = random(100, pg.width - 100);
      yy = random(- 100, -30);
      aa = random(40, 130);
    }
    if (compteur == 3) { // départ de la droite
      xx = random(pg.width + 30, pg.width + 100);
      yy = random(100, pg.height - 100);
      aa = random(100, 260);
    }
    compteur ++;
    if (compteur > 3) compteur = 0; // reset du compteur!


    angle2 = random(10);
    angle1 = -angle2;
    //angle2 = angle1 + random(2, 8);

    courbes.add(  new Courbe(
      mul,
      xx, // x
      yy, // y
      int(random(40, 80)), // nbre de segments
      random(60, 100) * mul, // longueur des segments
      random(4, 24) * mul, // largeur des segments
      aa, // angle de départ
      angle1, angle2, // angle mini, angle maxi
      40, // inversion d'angle si random(100) < à cette valeur
      2.0, // nombres de branches
      0.9, // diminution des dimensions de branche
      3, // génération de branches
      colors[index_col],         // couleur
      true       // visibilité des traites de contrôle      
      )
      );

    index_col ++;
    index_col %= colors.length;
  }

  // ******************************************************************************
  // ******************************************************************************
  // ******************************************************************************


  for (int i=0; i < 12; i++) {

    dice = random(100);

    // Utiliser compteur pour définir le point de départ et l'angle des courbes
    float xx = 0, yy = 0, aa = 0;
    if (compteur == 0) { // départ du bas
      xx = random(pg.width);
      yy = random(pg.height + 30, pg.height + 100);
      aa = random(210, 330);
    }
    if (compteur == 1) { // départ de la gauche
      xx = random(- 100, -30);
      yy = random(100, pg.height - 100);
      aa = random(280, 440);
    }
    if (compteur == 2) { // départ du haut
      xx = random(100, pg.width - 100);
      yy = random(- 100, -30);
      aa = random(40, 130);
    }
    if (compteur == 3) { // départ de la droite
      xx = random(pg.width + 30, pg.width + 100);
      yy = random(100, pg.height - 100);
      aa = random(100, 260);
    }
    compteur ++;
    if (compteur > 3) compteur = 0; // reset du compteur!


    angle2 = random(10, 30);
    angle1 = -angle2;
    //angle2 = angle1 + random(2, 8);

    courbes.add(  new Courbe(
      mul,
      xx, // x
      yy, // y
      int(random(8, 16)), // nbre de segments
      random(12, 40) * mul, // longueur des segments
      random(1, 3) * mul, // largeur des segments
      aa, // angle de départ
      angle1, angle2, // angle mini, angle maxi
      10, // inversion d'angle si random(100) < à cette valeur
      4.0, // nombres de branches
      0.7, // diminution des dimensions de branche
      1, // génération de branches
      colors2[index_col2],         // couleur
      true       // visibilité des traites de contrôle      
      )
      );

    index_col2 ++;
    index_col2 %= colors2.length;
  }

  // ******************************************************************************
  // ******************************************************************************
  // ******************************************************************************
  
  float xx = 0, yy = 0, aa = 0;
  xx = random(pg.width);
  yy = random(pg.height);
  int ic = int(random(colors2.length));

  for (int i=0; i < 12; i++) {

    dice = random(100);

    aa = random(360);

    angle2 = random(5, 10);
    angle1 = -angle2;
    //angle2 = angle1 + random(2, 8);

    courbes.add(  new Courbe(
      mul,
      xx, // x
      yy, // y
      int(random(12, 24)), // nbre de segments
      random(6, 36) * mul, // longueur des segments
      random(1, 3) * mul, // largeur des segments
      aa, // angle de départ
      angle1, angle2, // angle mini, angle maxi
      0, // inversion d'angle si random(100) < à cette valeur
      6.0, // nombres de branches
      0.7, // diminution des dimensions de branche
      5, // génération de branches
      colors2[ic],         // couleur
      true       // visibilité des traites de contrôle      
      )
      );

    index_col2 ++;
    index_col2 %= colors2.length;
  }
}
