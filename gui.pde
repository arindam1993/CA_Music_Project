// GUI
void keyPressed() {
  if(key=='!') selectFolder("Select a Folder to write PDF images to:", "selectFolderForPDFs");  // to select where PDFs go
  if(key=='`') snapPic=true; // to snap an image of the canvas and save as a PDF
  if(key==',') F00=max(80,F00/pow(2,1./12)); 
  if(key=='.') F00*=pow(2,1./12);
  if(key==' ') startOrStopPlaying();
  if(key=='/') startRecording(); // will save a .pdf and a .wav file in the data folder
  if(key=='s') initSong();
  if(key=='b') addBeat();
  if(key=='c') {compose(to,so,te,se); addBeat();} // creates a phrase from the diagonal
  if(key=='Q') {stop(); exit();}
 }
