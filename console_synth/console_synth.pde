import processing.opengl.*;
import ddf.minim.*;
import ddf.minim.ugens.*;

String fakeConsole;
StringList stringList;

Minim minim;
AudioOutput out;

Sampler C;
Sampler Db;
Sampler D;
Sampler Eb;
Sampler E;
Sampler F;
Sampler Gb;
Sampler G;
Sampler Ab;
Sampler A;
Sampler Bb;
Sampler B;

int synth;
String[] synthList;

boolean[] C_Row = new boolean[16];
boolean[] Db_Row = new boolean[16];
boolean[] D_Row = new boolean[16];
boolean[] Eb_Row = new boolean[16];
boolean[] E_Row = new boolean[16];
boolean[] F_Row = new boolean[16];
boolean[] Gb_Row = new boolean[16];
boolean[] G_Row = new boolean[16];
boolean[] Ab_Row = new boolean[16];
boolean[] A_Row = new boolean[16];
boolean[] Bb_Row = new boolean[16];
boolean[] B_Row = new boolean[16];

int bpm = 120;

int beat;
int count = 0;

boolean playing = false;
boolean started = false;

EditMode editMode = EditMode.C;;

class Tick implements Instrument
{
  void noteOn( float dur )
  {
    if(beat%4 == 0){
      count++;
    }
    String info = str(count) + " : " + str(beat%4 + 1) + " : " + synthList[synth] + " : " + editMode + " : " + bpm ;
    toConsole(info);
    if ( C_Row[beat] ) C.trigger();
    if ( Db_Row[beat] ) Db.trigger();
    if ( D_Row[beat] ) D.trigger();
    if ( Eb_Row[beat] ) Eb.trigger();
    if ( E_Row[beat] ) E.trigger();
    if ( F_Row[beat] ) F.trigger();
    if ( Gb_Row[beat] ) Gb.trigger();
    if ( G_Row[beat] ) G.trigger();
    if ( Ab_Row[beat] ) Ab.trigger();
    if ( A_Row[beat] ) A.trigger();
    if ( Bb_Row[beat] ) Bb.trigger();
    if ( B_Row[beat] ) B.trigger();

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
  size(600, 1000);
  minim = new Minim(this);
  out   = minim.getLineOut();
  stringList = new StringList();
  splash();
  toConsole("\nconsole_synth initialising...");
  loadSynthList();
  synth = 0;
  loadSynth();
  beat = 0;
  toConsole("console_synth initialised");
  toConsole("\nPress 'p' to start sequencer\n");
  
}

void loadSynthList(){
  toConsole("Loading synth from synthList.txt...");
  synthList = loadStrings("synthList.txt");
  toConsole("Synths Loaded");
}

void loadSynth(){
  toConsole("Loading Synth: " + synthList[synth] + "");
  
  C  = new Sampler( "samples/" + synthList[synth] + "/C.wav", 4, minim );
  Db  = new Sampler( "samples/" + synthList[synth] + "/Db.wav", 4, minim );
  D  = new Sampler( "samples/" + synthList[synth] + "/D.wav", 4, minim );
  Eb  = new Sampler( "samples/" + synthList[synth] + "/Eb.wav", 4, minim );
  E  = new Sampler( "samples/" + synthList[synth] + "/E.wav", 4, minim );
  F  = new Sampler( "samples/" + synthList[synth] + "/F.wav", 4, minim );
  Gb  = new Sampler( "samples/" + synthList[synth] + "/Gb.wav", 4, minim );
  G  = new Sampler( "samples/" + synthList[synth] + "/G.wav", 4, minim );
  Ab  = new Sampler( "samples/" + synthList[synth] + "/Ab.wav", 4, minim );
  A  = new Sampler( "samples/" + synthList[synth] + "/A.wav", 4, minim );
  Bb  = new Sampler( "samples/" + synthList[synth] + "/Bb.wav", 4, minim );
  B  = new Sampler( "samples/" + synthList[synth] + "/B.wav", 4, minim );


  C.patch( out );
  Db.patch( out );
  D.patch( out );
  Eb.patch( out );
  E.patch( out );
  F.patch( out );
  Gb.patch( out );
  G.patch( out );
  Ab.patch( out );
  A.patch( out );
  Bb.patch( out );
  B.patch( out );

}

void startSequencer(){
  toConsole("Starting Sequencer...");
  out.setTempo( bpm );
  out.playNote( 0, 0.25f, new Tick() );
}

void keyPressed(){
   switch(key){
     case 'z':
       editMode = EditMode.C;
       break;
     case 's':
       editMode = EditMode.Db;
       break;      
     case 'x':
       editMode = EditMode.D;
       break;   
     case 'd':
       editMode = EditMode.Eb;
       break;   
     case 'c':
       editMode = EditMode.E;
       break;
     case 'v':
       editMode = EditMode.F;
       break;  
     case 'g':
       editMode = EditMode.Gb;
       break;   
     case 'b':
       editMode = EditMode.G;
       break;   
     case 'h':
       editMode = EditMode.Ab;
       break;   
     case 'n':
       editMode = EditMode.A;
       break;   
     case 'j':
       editMode = EditMode.Bb;
       break;   
     case 'm':
       editMode = EditMode.B;
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
       if(bpm > 0){
         bpm--;
       }
       toConsole("bpm: " + bpm);
       break;
     case '=':
       if(bpm < 300){
         bpm++;
       }
       toConsole("bpm: " + bpm);
       break;
       
     case '[':
       if(synth > 0){
         synth--;
       }
       loadSynth();
       break;
     case ']':
       if(synth < synthList.length-1){
         synth++;
       }             
       loadSynth();
       break;
       
     case ' ':
       fakeConsole = "";
       toConsole("clearAll...");
       clearNotes();
       break;
       
     case 'p':
       started = true;
       break;
   }

}

void updateSequencer(int step){
  switch(editMode){
    case C:
      if(C_Row[step] == true) C_Row[step] = false; else C_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(C_Row[step]));
      break;
    case Db:
      if(Db_Row[step] == true) Db_Row[step] = false; else Db_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(Db_Row[step]));
      break;
    case D:
      if(D_Row[step] == true) D_Row[step] = false; else D_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(D_Row[step]));
      break;
    case Eb:
      if(Eb_Row[step] == true) Eb_Row[step] = false; else Eb_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(Eb_Row[step]));
      break;
    case E:
      if(E_Row[step] == true) E_Row[step] = false; else E_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(E_Row[step]));
      break;
    case F:
      if(F_Row[step] == true) F_Row[step] = false; else F_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(F_Row[step]));
      break;
    case Gb:
      if(Gb_Row[step] == true) Gb_Row[step] = false; else Gb_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(Gb_Row[step]));
      break;
    case G:
      if(G_Row[step] == true) G_Row[step] = false; else G_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(G_Row[step]));
      break;
    case Ab:
      if(Ab_Row[step] == true) Ab_Row[step] = false; else Ab_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(Ab_Row[step]));
      break;
    case A:
      if(A_Row[step] == true) A_Row[step] = false; else A_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(A_Row[step]));
      break;
    case Bb:
      if(Bb_Row[step] == true) Bb_Row[step] = false; else Bb_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(Bb_Row[step]));
      break;
    case B:
      if(B_Row[step] == true) B_Row[step] = false; else B_Row[step] = true;
      toConsole(editMode + ":" + str(step+1) + ":" + str(B_Row[step]));
      break;
  }
}

void clearNotes(){
  for(int i = 0; i < 16; i++){
    C_Row [i] = false;
    Db_Row  [i] = false;
    D_Row  [i] = false;
    Eb_Row  [i] = false;
    E_Row  [i] = false;
    F_Row  [i] = false;
    Gb_Row  [i] = false;
    G_Row  [i] = false;
    Ab_Row  [i] = false;
    A_Row  [i] = false;
    Bb_Row  [i] = false;
    B_Row  [i] = false;
  }
}

enum EditMode{
  C, Db, D, Eb, E, F, Gb, G, Ab, A, Bb, B
}

void draw(){
  if(!playing && started){
     startSequencer();
     playing = true;
  }
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
  
void splash(){
  String str;
  str = "____ ____ _   _ ____ ____  _    ____       ___  ___ _  _ _  _ ";
  toConsole(str);
  str = " |        |    |  |\\   |   [__     |     |  |     |___        |    \\ |__/ |    | | \\ / | ";
  toConsole(str);
  str = " |___  |__|  |  \\ |   ___]   |_ _|  |__ |___ ___ |__/ |    \\ |__| |     | ";
  toConsole(str);
  toConsole("\n@author Shon");
  toConsole("@since   01.02.18");
}