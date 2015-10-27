// TAB TO BE MODIFIED BY THE STUDENTS FOR THE PROJECT
// STUDENT'S NAMES:
// PROJECT TITLE:

float to=0, te=4, so=0, se=12; // coordinates of the diagonal line

void showLine() {strokeWeight(6); stroke(250,200,100); line(x0+to*dx,y0-so*dy-dy/2,x0+te*dx,y0-se*dy-dy/2);}


// CODE TO BE MODIFIED BY THE STUDENTS TO COMPSE A MORE BEAUTIFUL PHRASE ALONG THE DIAGONAL

void compose(float t0, float s0, float t1, float s1) {
  songLength=0; // needed reset !! (songLength is adjusted each time you add or append a note)
  n=0; // empties the song  
  int ni=6; // number of intermediate steps (total of 7 notes)
  float dt=(t1-t0)/(ni); // increments for my ramp
  float ds=(s1-s0)/(ni);
  addNote(s0,t0*tm,dt*tm); // first note
  for(int i=1; i<=ni; i++) appendNote(s0+ds*i,dt*tm); // other ramp notes
  
    // use such prints for debugging
    println("t0="+nf(t0,1,2)+", s0="+nf(s0,1,2)+", t1="+nf(t1,1,2)+", s1="+nf(s1,1,2));
    println("dt="+nf(dt,1,2)+", ds="+nf(ds,1,2));

}
  
