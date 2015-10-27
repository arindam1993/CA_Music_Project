//*****************************************************************************
  // TITLE:         GEOMETRY UTILITIES IN 2D  
  // DESCRIPTION:   Classes and functions for manipulating points, vectors, edges, triangles, quads, frames, and circular arcs  
  // AUTHOR:        Prof Jarek Rossignac
  // DATE CREATED:  September 2009
  // EDITS:         Revised July 2011
  //*****************************************************************************
  //************************************************************************
  //**** POINT CLASS
  //************************************************************************
  public class pt { float x=0,y=0; 
    // CREATE
    pt () {}
    pt (float px, float py) {x = px; y = py;};
  
    // MODIFY
    public pt setTo(float px, float py) {x = px; y = py; return this;};  
    public pt setTo(pt P) {x = P.x; y = P.y; return this;}; 
    public pt setToMouse() { x = mouseX; y = mouseY;  return this;}; 
    public pt add(float u, float v) {x += u; y += v; return this;}                       // P.add(u,v): P+=<u,v>
    public pt add(pt P) {x += P.x; y += P.y; return this;};                              // incorrect notation, but useful for computing weighted averages
    public pt add(float s, pt P)   {x += s*P.x; y += s*P.y; return this;};               // adds s*P
    public pt add(vec V) {x += V.x; y += V.y; return this;}                              // P.add(V): P+=V
    public pt add(float s, vec V) {x += s*V.x; y += s*V.y; return this;}                 // P.add(s,V): P+=sV
    public pt translateTowards(float s, pt P) {x+=s*(P.x-x);  y+=s*(P.y-y);  return this;};  // transalte by ratio s towards P
    public pt scale(float u, float v) {x*=u; y*=v; return this;};
    public pt scale(float s) {x*=s; y*=s; return this;}                                  // P.scale(s): P*=s
    public pt scale(float s, pt C) {x*=C.x+s*(x-C.x); y*=C.y+s*(y-C.y); return this;}    // P.scale(s,C): scales wrt C: P=L(C,P,s);
    public pt rotate(float a) {float dx=x, dy=y, c=cos(a), s=sin(a); x=c*dx+s*dy; y=-s*dx+c*dy; return this;};     // P.rotate(a): rotate P around origin by angle a in radians
    public pt rotate(float a, pt G) {float dx=x-G.x, dy=y-G.y, c=cos(a), s=sin(a); x=G.x+c*dx+s*dy; y=G.y-s*dx+c*dy; return this;};   // P.rotate(a,G): rotate P around G by angle a in radians
    public pt rotate(float s, float t, pt G) {float dx=x-G.x, dy=y-G.y; dx-=dy*t; dy+=dx*s; dx-=dy*t; x=G.x+dx; y=G.y+dy;  return this;};   // fast rotate s=sin(a); t=tan(a/2); 
    public pt moveWithMouse() { x += mouseX-pmouseX; y += mouseY-pmouseY;  return this;}; 
       
    // DRAW , WRITE
    public pt write() {print("("+x+","+y+")"); return this;};  // writes point coordinates in text window
    public pt v() {vertex(x,y); return this;};  // used for drawing polygons between beginShape(); and endShape();
    public pt show(float r) {ellipse(x, y, 2*r, 2*r); return this;}; // shows point as disk of radius r
    public void v(pt P) {vertex(P.x,P.y);};                                           // vertex for shading or drawing
    public pt show() {show(3); return this;}; // shows point as small dot
    public pt label(String s, float u, float v) {fill(black); text(s, x+u, y+v); noFill(); return this; };
    public pt label(String s, vec V) {fill(black); text(s, x+V.x, y+V.y); noFill(); return this; };
    public pt label(String s) {label(s,5,4); return this; };
    public String toString(){return "{x: "+x+", y: "+y+"}";};
    } // end of pt class
  
  //************************************************************************
  //**** VECTOR CLASS
  //************************************************************************
  public class vec { float x=0,y=0; 
   // CREATE
    vec () {};
    vec (float px, float py) {x = px; y = py;};
   
   // MODIFY
    public vec setTo(float px, float py) {x = px; y = py; return this;}; 
    public vec setTo(vec V) {x = V.x; y = V.y; return this;}; 
    public vec zero() {x=0; y=0; return this;}
    public vec scaleBy(float u, float v) {x*=u; y*=v; return this;};
    public vec scaleBy(float f) {x*=f; y*=f; return this;};
    public vec mul(float f) {x*=f; y*=f; return this;}    
    public vec reverse() {x=-x; y=-y; return this;};
    public vec divideBy(float f) {x/=f; y/=f; return this;};
    public vec normalize() {float n=sqrt(sq(x)+sq(y)); if (n>0.000001f) {x/=n; y/=n;}; return this;};
    public vec add(float u, float v) {x += u; y += v; return this;};
    public vec add(vec V) {x += V.x; y += V.y; return this;};   
    public vec add(float s, vec V) {x += s*V.x; y += s*V.y; return this;};   
    public vec rotateBy(float a) {float xx=x, yy=y; x=xx*cos(a)-yy*sin(a); y=xx*sin(a)+yy*cos(a); return this;};
    public vec left() {float m=x; x=-y; y=m; return this;};
   
    // OUTPUT VEC
    public vec clone() {return(new vec(x,y));}; 
    public String toString(){return "{x: "+x+", y: "+y+"}";};
  
    // OUTPUT TEST MEASURE
    public float norm() {return(sqrt(sq(x)+sq(y)));}
    public boolean isNull() {return((abs(x)+abs(y)<0.000001f));}
    public float angle() {return(atan2(y,x)); }
  
    // DRAW, PRINT
    public void write() {println("<"+x+","+y+">");};
    public void showAt (pt P) {line(P.x,P.y,P.x+x,P.y+y); }; 
    public void showArrowAt (pt P) {line(P.x,P.y,P.x+x,P.y+y); 
        float n=min(this.norm()/10.f,height/50.f); 
        pt Q=P(P,this); 
        vec U = S(-n,U(this));
        vec W = S(.3f,R(U)); 
        beginShape(); Q.add(U).add(W).v(); Q.v(); Q.add(U).add(M(W)).v(); endShape(CLOSE); }; 
    public void label(String s, pt P) {P(P).add(0.5f,this).add(3,R(U(this))).label(s); };
    } // end vec class
  
  //************************************************************************
  //**** POINTS FUNCTIONS
  //************************************************************************
  // create 
  public pt P() {return P(0,0); };                                                                            // make point (0,0)
  public pt P(float x, float y) {return new pt(x,y); };                                                       // make point (x,y)
  public pt P(pt P) {return P(P.x,P.y); };                                                                    // make copy of point A
  public pt P(pt O, float x, vec I, float y, vec J) {return P(O.x+x*I.x+y*J.x,O.y+x*I.y+y*J.y);}  // O+xI+yJ
  public pt Mouse() {return P(mouseX,mouseY);};                                                                 // returns point at current mouse location
  public pt Pmouse() {return P(pmouseX,pmouseY);};                                                              // returns point at previous mouse location
  public pt ScreenCenter() {return P(width/2,height/2);}                                                        //  point in center of  canvas
  public pt P(vec V) { return P(V.x,V.y);}
  // transform 
  public pt R(pt Q, float a) {float dx=Q.x, dy=Q.y, c=cos(a), s=sin(a); return new pt(c*dx+s*dy,-s*dx+c*dy); };  // Q rotated by angle a around the origin
  public pt R(pt Q, float a, pt C) {float dx=Q.x-C.x, dy=Q.y-C.y, c=cos(a), s=sin(a); return P(C.x+c*dx-s*dy, C.y+s*dx+c*dy); };  // Q rotated by angle a around point C
  public pt P(pt P, vec V) {return P(P.x + V.x, P.y + V.y); }                                                 //  P+V (P transalted by vector V)
  public pt P(pt P, float s, vec V) {return P(P,W(s,V)); }                                                    //  P+sV (P transalted by sV)
  public pt MoveByDistanceTowards(pt P, float d, pt Q) { return P(P,d,U(V(P,Q))); };                          //  P+dU(PQ) (transLAted P by *distance* s towards Q)!!!
  
  // average 
  public pt P(pt A, pt B) {return P((A.x+B.x)/2.0f,(A.y+B.y)/2.0f); };                                          // (A+B)/2 (average)
  public pt P(pt A, pt B, pt C) {return P((A.x+B.x+C.x)/3.0f,(A.y+B.y+C.y)/3.0f); };                            // (A+B+C)/3 (average)
  public pt P(pt A, pt B, pt C, pt D) {return P(P(A,B),P(C,D)); };                                            // (A+B+C+D)/4 (average)
  
  // weighted average 
  public pt P(float a, pt A) {return P(a*A.x,a*A.y);}                                                      // aA  
  public pt P(float a, pt A, float b, pt B) {return P(a*A.x+b*B.x,a*A.y+b*B.y);}                              // aA+bB, (a+b=1) 
  public pt P(float a, pt A, float b, pt B, float c, pt C) {return P(a*A.x+b*B.x+c*C.x,a*A.y+b*B.y+c*C.y);}   // aA+bB+cC 
  public pt P(float a, pt A, float b, pt B, float c, pt C, float d, pt D){return P(a*A.x+b*B.x+c*C.x+d*D.x,a*A.y+b*B.y+c*C.y+d*D.y);} // aA+bB+cC+dD 
  
  // LERP
  public pt L(pt A, pt B, float t) {return P(A.x+t*(B.x-A.x),A.y+t*(B.y-A.y));}
  public pt L(pt A, float t, pt B) {return L(A,B,t);}                //just a different config for imported classes
          
  // measure 
  public boolean isSame(pt A, pt B) {return (A.x==B.x)&&(A.y==B.y) ;}                                         // A==B
  public boolean isSame(pt A, pt B, float e) {return ((abs(A.x-B.x)<e)&&(abs(A.y-B.y)<e));}                   // ||A-B||<e
  public float d(pt P, pt Q) {return sqrt(d2(P,Q));  };                                                       // ||AB|| (Distance)
  public float d2(pt P, pt Q) {return sq(Q.x-P.x)+sq(Q.y-P.y); };                                             // AB*AB (Distance squared)
  
  //************************************************************************
  //**** VECTOR FUNCTIONS
  //************************************************************************
  // create 
  public vec V(vec V) {return new vec(V.x,V.y); };                                                             // make copy of vector V
  public vec V(pt P) {return new vec(P.x,P.y); };                                                              // make vector from origin to P
  public vec V(float x, float y) {return new vec(x,y); };                                                      // make vector (x,y)
  public vec V(pt P, pt Q) {return new vec(Q.x-P.x,Q.y-P.y);};                                                 // PQ (make vector Q-P from P to Q
  public vec U(vec V) {float n = n(V); if (n==0) return new vec(0,0); else return new vec(V.x/n,V.y/n);};      // V/||V|| (Unit vector : normalized version of V)
  public vec U(pt P, pt Q) {return U(V(P,Q));};                                                                // PQ/||PQ| (Unit vector : from P towards Q)
  public vec MouseDrag() {return new vec(mouseX-pmouseX,mouseY-pmouseY);};                                      // vector representing recent mouse displacement
  
  // weighted sum 
  public vec W(float s,vec V) {return V(s*V.x,s*V.y);}                                                      // sV
  public vec W(vec U, vec V) {return V(U.x+V.x,U.y+V.y);}                                                   // U+V 
  public vec W(vec U,float s,vec V) {return W(U,S(s,V));}                                                   // U+sV
  public vec W(float u, vec U, float v, vec V) {return W(S(u,U),S(v,V));}                                   // uU+vV ( Linear combination)
  
  // transformed 
  public vec R(vec V) {return new vec(-V.y,V.x);};                                                             // V turned right 90 degrees (as seen on screen)
  public vec R(vec V, float a) {float c=cos(a), s=sin(a); return(new vec(V.x*c-V.y*s,V.x*s+V.y*c)); };                                     // V rotated by a radians
  public pt R(pt P, float a, vec I, vec J, pt G) {float x=dot(V(G,P),I), y=dot(V(G,P),J); float c=cos(a), s=sin(a); return P(P,x*c-x-y*s,I,x*s+y*c-y,J); }; 
  
  
  public vec S(float s,vec V) {return new vec(s*V.x,s*V.y);};                                                  // sV
  public vec Reflection(vec V, vec N) { return W(V,-2.f*dot(V,N),N);};                                          // reflection
  public vec M(vec V) { return V(-V.x,-V.y); }                                                                  // -V
  
  // Interpolation 
  public vec L(vec U, vec V, float s) {return new vec(U.x+s*(V.x-U.x),U.y+s*(V.y-U.y));};                      // (1-s)U+sV (Linear interpolation between vectors)
  public vec L(vec U, float s, vec V) {return new vec(U.x+s*(V.x-U.x),U.y+s*(V.y-U.y));};                      // alt call for imported functions

  public vec S(vec U, vec V, float s) {float a = angle(U,V); vec W = R(U,s*a); float u = n(U), v=n(V); return W(pow(v/u,s),W); } // steady interpolation from U to V
  public vec S(vec U, float s, vec V) {float a = angle(U,V); vec W = R(U,s*a); float u = n(U), v=n(V); return W(pow(v/u,s),W); } // alt call for imported functions
  
  // measure 
  public float dot(vec U, vec V) {return U.x*V.x+U.y*V.y; }                                                     // dot(U,V): U*V (dot product U*V)
  public float det(vec U, vec V) {return dot(R(U),V); }                                                         // det | U V | = scalar cross UxV 
  public float n(vec V) {return sqrt(dot(V,V));};                                                               // n(V): ||V|| (norm: length of V)
  public float n2(vec V) {return sq(V.x)+sq(V.y);};                                                             // n2(V): V*V (norm squared)
  public boolean parallel (vec U, vec V) {return dot(U,R(V))==0; }; 
  
  public float angle (vec U, vec V) {return atan2(det(U,V),dot(U,V)); };                                   // angle <U,V> (between -PI and PI)
  public float angle(vec V) {return(atan2(V.y,V.x)); };                                                       // angle between <1,0> and V (between -PI and PI)
  public float angle(pt A, pt B, pt C) {return  angle(V(B,A),V(B,C)); }                                       // angle <BA,BC>
  public float turnAngle(pt A, pt B, pt C) {return  angle(V(A,B),V(B,C)); }                                   // angle <AB,BC> (positive when right turn as seen on screen)
  public int toDeg(float a) {return PApplet.parseInt(a*180/PI);}                                                           // convert radians to degrees
  public float toRad(float a) {return(a*PI/180);}                                                             // convert degrees to radians 
  public float positive(float a) { if(a<0) return a+TWO_PI; else return a;}                                   // adds 2PI to make angle positive
  
  // SLERP
  public vec slerp(vec U, float t, vec V) {float a = angle(U,V); float b=sin((1.f-t)*a),c=sin(t*a),d=sin(a); return W(b/d,U,c/d,V); } // UNIT vectors ONLY!
  
  //************************************************************************
  //**** DISPLAY
  //************************************************************************
  // point / polygon
  public void show(pt P, float r) {ellipse(P.x, P.y, 2*r, 2*r);};                                             // draws circle of center r around P
  public void show(pt P) {ellipse(P.x, P.y, 6,6);};                                                           // draws small circle around point
  public void show(pt[] ara) {beginShape(); for(int i=0;i<ara.length;++i){v(ara[i]);} endShape(CLOSE);};                      // volume of tet 
  public void curveVertex(pt P) {curveVertex((float)P.x,(float)P.y);};                                           // curveVertex for shading or drawing
  public void curve(pt[] ara) {if(ara.length == 0){return;}beginShape(); curveVertex(ara[0]);for(int i=0;i<ara.length;++i){curveVertex(ara[i]);} curveVertex(ara[ara.length-1]);endShape();};                      // volume of tet 

  //draw a circle - JT
  void circle(pt P, float r, vec I, vec J, int n) {pt[] pts = new pt[n];pts[0] = P(P,r,U(I));float a = (2*PI)/(1.0f*n);for(int i=1;i<n;++i){pts[i] = R(pts[i-1],a,J,I,P);}pushMatrix(); pushStyle();noFill(); show(pts);popStyle();popMatrix();}; // render sphere of radius r and center P
  
  // edge / arrow
  public void edge(pt P, pt Q) {line(P.x,P.y,Q.x,Q.y); };                                                      // draws edge (P,Q)
  public void arrow(pt P, pt Q) {arrow(P,V(P,Q)); }                                                            // draws arrow from P to Q
  public void show(pt P, vec V) {line(P.x,P.y,P.x+V.x,P.y+V.y); }                                              // show V as line-segment from P 
  public void show(pt P, float s, vec V) {show(P,S(s,V));}                                                     // show sV as line-segment from P 
  public void arrow(pt P, float s, vec V) {arrow(P,S(s,V));}                                                   // show sV as arrow from P 
  public void arrow(pt P, vec V, String S) {arrow(P,V); P(P(P,0.70f,V),15,R(U(V))).label(S,V(-5,4));}       // show V as arrow from P and print string S on its side
  public void arrow(pt P, vec V) {show(P,V);  float n=n(V); if(n<0.01f) return; float s=max(min(0.2f,20.f/n),6.f/n);       // show V as arrow from P 
       pt Q=P(P,V); vec U = S(-s,V); vec W = R(S(.3f,U)); beginShape(); v(P(P(Q,U),W)); v(Q); v(P(P(Q,U),-1,W)); endShape(CLOSE);}; 
  
  // triangle, polygon
  public void v(pt P) {vertex(P.x,P.y);};                                                                     // vertex for drawing polygons between beginShape() and endShape()
  public void v(pt P, float u, float v) { vertex(P.x, P.y, u, v); }
  public void show(pt A, pt B, pt C)  {beginShape();  A.v(); B.v(); C.v(); endShape(CLOSE);}                   // render triangle A, B, C
  public void show(pt A, pt B, pt C, pt D)  {beginShape();  A.v(); B.v(); C.v(); D.v(); endShape(CLOSE);}      // render quad A, B, C, D
  
  // text
  public void label(pt P, String S) {text(S, P.x-4,P.y+6.5f); }                                                 // writes string S next to P on the screen ( for example label(P[i],str(i));)
  public void label(pt P, vec V, String S) {text(S, P.x-3.5f+V.x,P.y+7+V.y); }                                  // writes string S at P+V
  
  
  // ************************************************************************ COLORS 
  int black=0xff000000, white=0xffFFFFFF, // set more colors using Menu >  Tools > Color Selector
     red=0xffFF0000, green=0xff00FF01, blue=0xff0300FF, yellow=0xffFEFF00, cyan=0xff00FDFF, magenta=0xffFF00FB, grey=0xff5F5F5F, brown=0xffAF6407,
     sand=0xffFCBA69, pink=0xffFF8EE7 ;
  // ************************************************************************ GRAPHICS 
  public void pen(int c, float w) {stroke(c); strokeWeight(w);}
  public void showDisk(float x, float y, float r) {ellipse(x,y,r*2,r*2);}
  
