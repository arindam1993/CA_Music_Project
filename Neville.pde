
  public pt  GeneralQuadratic(pt A, float a, pt B, float b, pt C, float c, float t ){
    //UGLY
    return L(L(A,B ,(t-a)/(b-a)),L(B,C,(t-b)/(c-b)), (t-a)/(c-a));
  }

  public pt  GeneralCubic(pt A, float a, pt B, float b, pt C, float c, pt D, float d, float t ){
    pt P = GeneralQuadratic(A,a,B,b,C,c,t);
    pt Q = GeneralQuadratic(B,b,C,c,D,d,t);
    return L(P,Q ,(t-a)/(d-a));
  }

  public pt  StandardQuadratic(pt A, pt B, pt C, float t ){
    //UGLY
    return GeneralQuadratic(A, 0, B, 0.5f, C, 1, t );
  }
  
  public pt  StandardCubic(pt A, pt B, pt C, pt D, float t ){
    //UGLY
    return GeneralCubic(A, 0, B, 0.25f, C, 0.75f, D, 1, t );
  }
  
  /*
  Assumes:
  A.x < B.x < C.x < D.x (since X is time, this should be true for a musical phrase)
  */
  public pt XDistKnotCubic(pt A, pt B, pt C, pt D, float t ){
    float a = 0;
    float b = (B.x-A.x)/(D.x - A.x);
    float c = (C.x-A.x)/(D.x - A.x);
    float d =1;
     return GeneralCubic(A, a, B, b, C, c, D, d, t );
  }

