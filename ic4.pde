void initCourbes4(float mul) {

  int index_col  = int(random(colors.length));
  int index_col2 = int(random(colors2.length));
  int index_col3 = int(random(colors3.length));

  float angle1, angle2, lmin, lmax, dice;
  int compteur = 0;

  // ******************************************************************************

  for ( int j=0; j < 32; j++) {
    float xx = 0, yy = 0, aa = 0;
    xx = random(pg.width);
    yy = random(pg.height);
    int ic = int(random(colors3.length));

    for (int i=0; i < 1; i++) {

      dice = random(100);

      aa = random(360);

      angle2 = random(40, 90);
      angle1 = -angle2;

      courbes.add(  new Courbe(
        mul,
        xx, // x
        yy, // y
        int(random(16, 96)),     // nbre de segments
        random(18, 128) * mul,     // longueur des segments
        random(0.2, 3) * mul,       // largeur des segments
        aa,                       // angle de départ
        angle1, angle2,           // angle mini, angle maxi
        60,                       // inversion d'angle si random(100) < à cette valeur
        1,                        // nombres de branches
        0.7,                      // diminution des dimensions de branche
        2,                        // génération de branches
        colors3[ic],              // couleur
      false                       // visibilité des traits de contrôle      
        )
        );

      index_col2 ++;
      index_col2 %= colors2.length;
      index_col ++;
      index_col %= colors.length;
    }
  }
}
