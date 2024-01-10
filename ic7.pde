void initCourbes7(float mul) {

  int index_col  = int(random(colors.length));
  int index_col2 = int(random(colors2.length));
  int index_col3 = int(random(colors3.length));

  float angle1, angle2, lmin, lmax, dice;
  int compteur = 0;
  int ic, ic2, ic3;

  // ******************************************************************************

  for ( int j=0; j < 4; j++) {
    float xx = 0, yy = 0, aa = 0;

    for (int i=0; i < 12; i++) {

      dice = random(100);
      
      ic = index_col;
      ic2 = index_col2;
      ic3 = int(random(colors3.length));

      // départ du bas
      xx = random(pg.width);
      yy = random(pg.height + 30, pg.height + 100);
      aa = random(230, 310);

      angle2 = random(4, 24);
      angle1 = -angle2;

      courbes.add(  new Courbe(
        mul,
        xx, // x
        yy, // y
        int(random(18, 46)), // nbre de segments
        random(18, 56) * mul, // longueur des segments
        random(1, 6) * mul, // largeur des segments
        aa, // angle de départ
        angle1, angle2, // angle mini, angle maxi
        20, // inversion d'angle si random(100) < à cette valeur
        12.0, // nombres de branches
        0.8, // diminution des dimensions de branche
        4, // génération de branches
        colors3[ic3],         // couleur
        true       // visibilité des traites de contrôle      
        )
        );

      
      index_col2 ++;
      index_col2 %= colors2.length;
      index_col ++;
      index_col %= colors.length;
      
      
    }
  }
}
