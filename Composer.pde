//*****************************************************************************
// Base code for the Music Project for Computational Aesthetics
// Author Jarek Rossignac
// Last updated: June 22, 2015
// Functionality
// plays a song (press SPACE)
// saves a .wav file of the song and the image of the music sheet (press '/')
// let's the user edit the endpoints of the orange diagonal (hold '1' or '2' and drag the mouse)
// generates a equisempled pitch ramp (press 'c')
//
// STUDENTS OROJECT:
// TEAM MEMBERS:
//     edit function 'compose' in tab 'phrase'
//*****************************************************************************

void setup() {             
   size(1200, 1200);         
   smooth();  strokeJoin(ROUND); strokeCap(ROUND); 
   frameRate(30);
   minim = new Minim(this); // Declares minim which we use for sounds
   initSongChart(); // inits measures for drawing the music sheet
   initSong();      // inits the phrase with one from Jobin's "Desafinado"
//   addBeat();       // adds a very bad beat over that song
   } 
 
void draw() {   
  if(snapPic) beginRecord(PDF, PicturesOutputPath+"/P"+nf(pictureCounter++,3)+".pdf"); // start saving a .pdf of the screen
  background(255); noFill(); 
  
  if(keyPressed&&key=='1') {to+=(float)(mouseX-pmouseX)/dx; so-=(float)(mouseY-pmouseY)/dy;}
  if(keyPressed&&key=='2') {te+=(float)(mouseX-pmouseX)/dx; se-=(float)(mouseY-pmouseY)/dy;}
  fill(0); text("to="+nf(to,1,2)+", so="+nf(so,1,2)+", te="+nf(te,1,2)+", se="+nf(se,1,2),width-300,height-100); // for precise aligment
  showLine(); // shows the orange diagonal
  
  if(playing) {playFrameCounter++; drawTimeLine();} // advances the red vertical timeline
  
  drawSong(); // draws the sheet with notes

  if(playing && recording) saveRecording(); // stops recording and sets playing = false when totalDuration is exceeded

  // enter team memeber names below !!!
  fill(50); text("Computational Aesthetics--Music Project: Interpolating phrase. Student 1, Student 2",10,height-100);
  if(snapPic) {endRecord(); snapPic=false;} // end saving a .pdf of the screen
 
 
  // Help text (not showing on print)
  fill(100);
  text("press'1'/'2' and drag to edit diagonal, 'c' to compose, SPACE to play/stop, ` to save .pdf or / to record .wav & .pdf",10,height-20);
  
  }
