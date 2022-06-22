//Libraries: uses Sketch / Import Library / Add Library / Minim
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;
//
//Global Variables
Minim minim; //object to access all music player fuctions
int numberOfSongs = 4;
AudioPlayer[] song = new AudioPlayer[numberOfSongs]; //creates "Play List" variables holding extensions WAV, AIFF, AU, SND, & MP3
AudioMetaData[] songMetaData = new AudioMetaData[numberOfSongs]; //song1's meta data
int currentSong = numberOfSongs - numberOfSongs;
//
color purple = #E60AFF;
PFont titleFont;
//

void setup()
{
  fullScreen();
  minim = new Minim(this); //loads from data directory, loads from project folder
  song[currentSong] = minim.loadFile("MusicDownload/groove.mp3"); //able to pass absulute path, file name & extension, and URL
  song[currentSong+=1] = minim.loadFile("MusicDownload/The_Simplest.mp3");
  song[currentSong+=1] = minim.loadFile("MusicDownload/Start_Your_Engines.mp3");
  song[currentSong+=1] = minim.loadFile("MusicDownload/Beat_Your_Competition.mp3");
  //
  currentSong-=currentSong; //currentSong = currentSong - currentSong
  for ( int i=currentSong; i<song.length; i++ ) {
    songMetaData[i] = song[i].getMetaData();
  }//End Meta Data

  //songMetaData[0] = song[0].getMetaData();
  //songMetaData[1] = song[1].getMetaData();
  //songMetaData[2] = song[2].getMetaData();
  //songMetaData[3] = song[3].getMetaData();
  
  titleFont = createFont( "Fascinate", 50 ); //Must also Tools / Create Font / Find Font / Do Not Press "OK"
  //
  println("Start of Console");
  println("Click the console to finish starting this program");
  println("Title:", songMetaData[currentSong].title() );
  println( "Author: ", songMetaData[currentSong].author() ); 
  println( "Album: ", songMetaData[currentSong].album() );
  println( "Genre: ", songMetaData[currentSong].genre() );
}//End setup
//
void draw() {
  //if ( song[currentSong].isLooping() ) println("There are", song[currentSong].loopCount(), "loops left.");
  //if ( song[currentSong].isPlaying() && !song[currentSong].isLooping() ) println("Play Once");
  //
  println("Computer Number of Current Song:", currentSong);
  println("Song Position", song[currentSong].position(), "Song Length", song[currentSong].length() ); //Values in milliseconds
  //
  background (black);
  rect(displayWidth*1/4, displayHeight*0, displayWidth*1/2, displayHeight*1/10);
  fill(purple);
  textAlign (CENTER, CENTER); 
  //Values: [LEFT | CENTER | RIGHT] & [TOP | CENTER | BOTTOM | BASELINE]
  textFont(titleFont, 40); 
  text(songMetaData[currentSong].title(), displayWidth*1/4, displayHeight*0, displayWidth*1/2, displayHeight*1/10);
  fill(255);
  //
  //
  rect(displayWidth*1/4, displayHeight*1/8, displayWidth*1/2, displayHeight*1/10);
  fill(purple);
  textAlign (CENTER, CENTER); 
  //Values: [LEFT | CENTER | RIGHT] & [TOP | CENTER | BOTTOM | BASELINE]
  textFont(titleFont, 35); 
  text(songMetaData[currentSong].author(), displayWidth*1/4, displayHeight*1/8, displayWidth*1/2, displayHeight*1/10);
  fill(255); //Reset to white for rest of the program
  //
  rect(displayWidth*1/4, displayHeight*3/8, displayWidth*1/2, displayHeight*1/10);
  fill(purple);
  textAlign (CENTER, CENTER); 
  textFont(titleFont, 35); 
  text(songMetaData[currentSong].album(), displayWidth*1/4, displayHeight*3/8, displayWidth*1/2, displayHeight*1/10);
  fill(255);
  //
  //Visualizer
  for (int i = 0; i < song[currentSong].bufferSize() - 1; i++)
  {
    float x1 = map( i, 0, song[currentSong].bufferSize(), 100, 500 );
    float x2 = map( i+1, 0, song[currentSong].bufferSize(), 100, 500 );
    line( x1, 50 + song[currentSong].left.get(i)*30, x2, 50 + song[currentSong].left.get(i+1)*30 );
    line( x2, 150 + song[currentSong].right.get(i)*30, x2, 150 + song[currentSong].right.get(i+1)*30 );
  }

  //Draw a line to show where in the song playback is currently located
  float posx = map(song[currentSong].position(), 0, song[currentSong].length(), 50, 500);
  stroke(0, 200, 0);
  line(posx, 0, posx, 190);
  //End visualizer
}//End draw

//

void keyPressed()
{
  //Only press a number for this code below
  if ( key=='1' || key=='9' ) {//Looping Funtions
    //Note: "9" is assumed to be massive! "Simulate Infinite"
      if ( key == '1' ) println("Looping 1 time"); //Once
    if ( key == '9' ) println("Looping 9 times"); //Simulating Infinity
    String keystr = String.valueOf(key);
    println("Number of Repeats is", keystr);
    int num = int(keystr);
    song[currentSong].loop(num);
  }//End LOOP
   if ( key=='1' || key=='L' ) song[currentSong].loop(); //No parameter means "infinite loops"
  //
  if ( key>='2' && key!='9' ) println("Le Loop");
  //
  //Play-Paused button
  if ( key=='l' || key=='L') song[currentSong].loop();
  if ( key>='4' && key!='9') println("Le Loop");
  //
  //Alternate Play-Pause Button
  if ( key=='p' || key=='P' ) { 
    if ( song[currentSong].isPlaying() ) {
      song[currentSong].pause();
    } else if ( song[currentSong].position() >= song[currentSong].length() - song[currentSong].length()*1/6 ) { //Special situation
       //End of Song Calculation: hardcode 1000 OR use formula to say "listen to 80% of the song"
      //Alternate formula: song1.length() - song1.position() <= 1000
      song[currentSong].rewind();
      song[currentSong].play();
    } else {
      song[currentSong].play(); //Parameter is milli-seconds from start of auido file to start of playing
    }
  }//End PLAY-PAUSE Button
 //
 if ( key=='f' || key=='F' ) song[currentSong].skip(1000) ; //skip forward 1 second (1000 millisecond)
  if ( key=='r' || key=='R' ) song[currentSong].skip(-1000) ; //skip backward, or reverse, 1 second (1000 millisecond)
  //
  if ( key=='m' || key=='M' ) { //MUTE Button
    if ( song[currentSong].isMuted() ) { 
      song[currentSong].unmute();
    } else {
      song[currentSong].mute();
    }
  }//End MUTE

  //STOP
  if ( key=='s' || key=='S' ) {
    if ( song[currentSong].isPlaying() ) {
      song[currentSong].pause();
      song[currentSong].rewind();
    } else {
      song[currentSong].rewind();
    }
  }//End STOP button
  //
  if ( key=='n' || key=='N' ) {//Next Button
    if ( song [currentSong].isPlaying() ) {
      song[currentSong].pause();
      song[currentSong].rewind();
      nextButtonArrayCatch();
      song[currentSong].play();
   } else {
      song[currentSong].rewind(); ////Built-in rewind feature feature so all songs start at ZERO
      nextButtonArrayCatch();
      song[currentSong].play();
    }
  }//End Next Button

    }//End Next Button
  //
  if ( key=='b' || key=='B' ) {}//End Back Button
  //An Empty Body will not break our program but you will not have a working bee button
  //Assignment: create a working bee button
  //
  
  //End Back Button

  if (  key=='d' || key=='D' ) {
    println("Gain is", song[currentSong].getGain());
    gain = gain+song[currentSong].getGain();
    song[currentSong].setGain(gain);
  }
  //End Amplify Button


  if (  key=='a' || key=='A' ) AutoPlay(); //End AutoPlay Button 

  if (  key=='f' || key=='F' ) SongSkip(); //End Song Skip Button 
  //Note it sometimes works
}//End keyPressed

//

void mousePressed() 
{
}//End mousePressed
//

//End Main Program
//
