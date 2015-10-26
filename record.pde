// tools for saving a recording of the phrase as a .wav file

String RecordingOutputPath="data/WAVrecordings/R";
int recordingCounter=0;
boolean recording=false;
int frameCounter=0; // incremented in draw() and used to stop at the end of the song

void startRecording() {
      snapPic=true;
      recording=true; frameCounter=0;
      playing=true; 
      out = minim.getLineOut(); 
      recorder = minim.createRecorder(out, RecordingOutputPath+nf(recordingCounter++,2,0)+".wav");
      recorder.beginRecord();
      playPhrase();
      } 
      
void saveRecording() {
    frameCounter++;
    if(frameCounter>=totalDuration*30){
      recorder.endRecord(); 
      recorder.save(); 
      playing=false; 
      out.close();
      recording=false;
      }
    }
