import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

String fakeConsole;
StringList stringList;

Minim minim;
AudioOutput out;

Sampler kick;
Sampler snare;
Sampler clap;
Sampler low_tom;
Sampler high_tom;
Sampler hi_hat;
Sampler cymbal;

String kit;

boolean[] kickRow = new boolean[16];
boolean[] snareRow = new boolean[16];
boolean[] clapRow = new boolean[16];
boolean[] low_tomRow = new boolean[16];
boolean[] high_tomRow = new boolean[16];
boolean[] hi_hatRow = new boolean[16];
boolean[] cymbalRow = new boolean[16];

int bpm = 120;

int beat;
int count = 0;

boolean playing = false;

EditMode editMode = EditMode.KICK;;

class Tick implements Instrument
{
  void noteOn( float dur )
  {
    if(beat%4 == 0){
      count++;
    }
    String info = str(count) + " : " + str(beat%4 + 1) + " : " + kit + " : " + editMode;
    toConsole(info);
    if ( kickRow[beat] ) kick.trigger();
    if ( snareRow[beat] ) snare.trigger();
    if ( clapRow[beat] ) clap.trigger();
    if ( low_tomRow[beat] ) low_tom.trigger();
    if ( high_tomRow[beat] ) high_tom.trigger();
    if ( hi_hatRow[beat] ) hi_hat.trigger();
    if ( cymbalRow[beat] ) cymbal.trigger();  
  }
  
  void noteOff()
  {
    beat = (beat+1)%16;
    out.setTempo( bpm );
    out.playNote( 0, 0.25f, this );
  }
}

void setup()
{
  size(200, 1000);
  minim = new Minim(this);
  out   = minim.getLineOut();
  stringList = new StringList();
  toConsole("\nInitialising...");

  kit = "808";
  loadKit();

  beat = 0;
  
  while(!playing){
     toConsole(str(playing));
  }
  startSequencer();
  
}

void loadKit(){
  toConsole("Loading Kit: " + kit + "");
  kick  = new Sampler( "samples/" + kit + "/kick.wav", 4, minim );
  snare = new Sampler( "samples/" + kit + "/snare.wav", 4, minim );
  clap = new Sampler( "samples/" + kit + "/clap.wav", 4, minim );
  low_tom = new Sampler( "samples/" + kit + "/low_tom.wav", 4, minim );
  high_tom = new Sampler( "samples/" + kit + "/high_tom.wav", 4, minim );
  hi_hat   = new Sampler( "samples/" + kit + "/hi_hat.wav", 4, minim );
  cymbal = new Sampler( "samples/" + kit + "/cymbal.wav", 4, minim );

  kick.patch( out );
  snare.patch( out );
  clap.patch( out );
  low_tom.patch( out );
  high_tom.patch( out );
  hi_hat.patch( out );
  cymbal.patch( out );
}

void startSequencer(){
  toConsole("Starting Sequencer...");
  out.setTempo( bpm );
  out.playNote( 0, 0.25f, new Tick() );
}

void keyPressed(){
   switch(key){
     case 'z':
       editMode = EditMode.KICK;
       break;
     case 'x':
       editMode = EditMode.SNARE;
       break;
     case 'c':
       editMode = EditMode.CLAP;
       break;
     case 'v':
       editMode = EditMode.LOW_TOM;
       break;
     case 'b':
       editMode = EditMode.HIGH_TOM;
       break;       
     case 'n':
       editMode = EditMode.HI_HAT;
       break;
     case 'm':
       editMode = EditMode.CYMBAL;
       break;       
       
     case '1':
       updateSequencer(0);
       break;       
     case '2':
       updateSequencer(1);
       break;       
     case '3': 
       updateSequencer(2);
       break;       
     case '4':
       updateSequencer(3);
       break;       
     case '5':
       updateSequencer(4);
       break;       
     case '6':
       updateSequencer(5);
       break;       
     case '7':
       updateSequencer(6);
       break;       
     case '8':
       updateSequencer(7);
       break;       
     case 'q':
       updateSequencer(8);
       break;       
     case 'w':
       updateSequencer(9);
       break;       
     case 'e':
       updateSequencer(10);
       break;       
     case 'r':
       updateSequencer(11);
       break;       
     case 't':
       updateSequencer(12);
       break;       
     case 'y':
       updateSequencer(13);
       break;       
     case 'u':
       updateSequencer(14);
       break;       
     case 'i':
       updateSequencer(15);
       break;
       
     case '-':
       toConsole("(bpm--)");
       bpm--;
       break;
     case '=':
       toConsole("(bpm++)");
       bpm++;
       break;
       
     case 'a':
       kit = "808";
       loadKit();
       break;
     case 's':
       kit = "909";
       loadKit();
       break;
       
     case ' ':
       fakeConsole = "";
       toConsole("clearAll...");
       clearNotes();
       break;
       
     case '#':
       playing = true;
       break;
   }

}

void updateSequencer(int step){
  switch(editMode){
    case KICK:
      if(kickRow[step] == true) kickRow[step] = false; else kickRow[step] = true;
      toConsole(step + ":" + str(kickRow[step]));
      break;
    case SNARE:
      if(snareRow[step] == true) snareRow[step] = false; else snareRow[step] = true;
      toConsole(step + ":" + str(snareRow[step]));
      break;
    case CLAP:
      if(clapRow[step] == true) clapRow[step] = false; else clapRow[step] = true;
      toConsole(step + ":" + str(clapRow[step]));
      break;
    case LOW_TOM:
      if(low_tomRow[step] == true) low_tomRow[step] = false; else low_tomRow[step] = true;
      toConsole(step + ":" + str(low_tomRow[step]));
      break;
    case HIGH_TOM:
      if(high_tomRow[step] == true) high_tomRow[step] = false; else high_tomRow[step] = true;
      toConsole(step + ":" + str(high_tomRow[step]));
      break;
    case HI_HAT:
      if(hi_hatRow[step] == true) hi_hatRow[step] = false; else hi_hatRow[step] = true;
      toConsole(step + ":" + str(hi_hatRow[step]));
      break;
    case CYMBAL:
      if(cymbalRow[step] == true) cymbalRow[step] = false; else cymbalRow[step] = true;
      toConsole(step + ":" + str(cymbalRow[step]));
      break;
  }
}

void clearNotes(){
  for(int i = 0; i < 16; i++){
    kickRow[i] = false;
    snareRow[i] = false;
    clapRow[i] = false;
    low_tomRow[i] = false;
    high_tomRow[i] = false;
    hi_hatRow[i] = false;
    cymbalRow[i] = false;
  }
}

enum EditMode{
  CLAP, CYMBAL, HI_HAT, HIGH_TOM, KICK, LOW_TOM, SNARE
}

void draw(){
  background(0);
  fill(0, 255, 0);
  text(fakeConsole, 20, 20, width-40, height-40);
}

void toConsole(String string){
  fakeConsole = "";
  stringList.append(string);
  if(stringList.size() > 65){
    stringList.remove(0);
  }
  for(int i = 0; i < stringList.size(); i++){
    fakeConsole += "\n" + stringList.get(i);
  }
}