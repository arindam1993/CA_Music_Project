float xQuantOffset = 12.5f;
boolean hasBeat = false;

public class MusicCurve{
  
  //Four control points for Cubic Neville 
  private pt controlPt1;
  private pt controlPt2;
  private pt controlPt3;
  private pt controlPt4;
  private pt controlPt5;
  private pt controlPt6;
  private pt controlPt7;
  
  
  //Interplated points on the curve
  private pt[] interpPts;
  private pt[] interpPts2;
  
  //No of interpolcated points
  static final int INTERP_COUNT = 100;
  static final float CLICK_DISTANCE = 10.0f;
  
  
  //Constructor
  public MusicCurve(pt controlPt1, pt controlPt2, pt controlPt3,pt controlPt4,
    pt controlPt5, pt controlPt6, pt controlPt7){
  
    this.controlPt1 = controlPt1;
    this.controlPt2 = controlPt2;
    this.controlPt3 = controlPt3;
    this.controlPt4 = controlPt4;
    this.controlPt5 = controlPt5;
    this.controlPt6 = controlPt6;
    this.controlPt7 = controlPt7;
    
    interpPts = new pt[INTERP_COUNT];
    interpPts2 = new pt[INTERP_COUNT];
    
    curveChanged();
  }
  
  //Call this to recalculate interpolated points
  private void calcInterps(){
    float step = 1/float(INTERP_COUNT);
    
    int ptI = 0;
    for (float s = 0 ; s < 1; s+= step){
        if( ptI < 100) {
          interpPts[ptI] = XDistKnotCubic(controlPt1, controlPt2, controlPt3, controlPt4 , s);
          interpPts2[ptI] = XDistKnotCubic(controlPt4, controlPt5, controlPt6, controlPt7 , s);
        }
        ptI++;
    }
    
  }
  
  public void drawCurve(){
    
    //Draw the control points
    fill(red);
    pen(black, 1.0f);
    ellipse(controlPt1.x, controlPt1.y, 10.0f, 10.0f);
    ellipse(controlPt2.x, controlPt2.y, 10.0f, 10.0f);
    ellipse(controlPt3.x, controlPt3.y, 10.0f, 10.0f);
    ellipse(controlPt4.x, controlPt4.y, 10.0f, 10.0f);
    ellipse(controlPt5.x, controlPt5.y, 10.0f, 10.0f);
    ellipse(controlPt6.x, controlPt6.y, 10.0f, 10.0f);
    ellipse(controlPt7.x, controlPt7.y, 10.0f, 10.0f);
    
    //Draw the curve
    noFill();
    pen(sand, 3.0f);
    curve(interpPts);
    curve(interpPts2);
    
  }
  
  
  
  
  public float sampleAtX(float X){
    
    //If it is in valid range
    if( X > controlPt1.x && X < controlPt4.x){
      float s = (X - controlPt1.x)/(controlPt4.x - controlPt1.x);
      pt toRet = XDistKnotCubic(controlPt1, controlPt2, controlPt3, controlPt4 , s);
      return toRet.y;
    }
    else if( X >= controlPt4.x && X < controlPt7.x){
      float s = (X - controlPt4.x)/(controlPt7.x - controlPt4.x);
      pt toRet = XDistKnotCubic(controlPt4, controlPt5, controlPt6, controlPt7 , s);
      return toRet.y;
    }
    
    //Invalid state( X is beyond or before curve )
    return -1.0f;
  }
  
  // Quantizes musicCurve by sampling along X  
  void computeNotes(){
    float time = 0;
    for(float i = 0; i<20; i+=1./tm){
      float x = x0+i*dx + xQuantOffset;
      float y = this.sampleAtX(x);
      if( y != -1.0f ){
        addNoteWithExtend(getSemitone(y), time, 1);
      }
      time+=1;
    }
  }
  
  public float getSemitone(float y){
     
    float currSemitone = 23; 
    for(float toneStart = 0; toneStart < width ; toneStart+=dy){ //dy defined in notes.pde    
      float toneEnd = toneStart + dy;
      if(y > toneStart && y<=toneEnd){
        return currSemitone;
      }
      currSemitone--;
    }
    
    //IF no semitone found
    return SILENCE;  
  }
  
  public void curveChanged(){
    hasBeat = false;
    calcInterps();
    
    clearNotes();
    
    computeNotes();
    
    addBeat();
  }
  
  /* Getters and Setters */
  public void setPt1(pt P){
    if( d(P, controlPt1) < CLICK_DISTANCE){
      controlPt1 = P;
      curveChanged();
    }
    
  }
  
  public void setPt2(pt P){
     if( d(P, controlPt2) < CLICK_DISTANCE){
      controlPt2 = P;
      curveChanged();
    }
  }
  
  public void setPt3(pt P){
     if( d(P, controlPt3) < CLICK_DISTANCE){
      controlPt3 = P;
      curveChanged();
    }
  }
  
  public void setPt4(pt P){
     if( d(P, controlPt4) < CLICK_DISTANCE){
      controlPt4 = P;
      curveChanged();
    }
  }
  
    public void setPt5(pt P){
     if( d(P, controlPt5) < CLICK_DISTANCE){
      controlPt5 = P;
      curveChanged();
    }
  }
  
  public void setPt6(pt P){
     if( d(P, controlPt6) < CLICK_DISTANCE){
      controlPt6 = P;
      curveChanged();
    }
  }
  
  public void setPt7(pt P){
     if( d(P, controlPt7) < CLICK_DISTANCE){
      controlPt7 = P;
      curveChanged();
    }
  }
  
}
