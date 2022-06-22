void nextButtonArrayCatch() {
  if ( currentSong >= song.length-1 ) { //CATCH ArrayIndexOutOfBoundsException
    currentSong -= currentSong; //Beginning of Play List
  } else {
    currentSong++;
  }//End of CATCH
}//End nextButtonArrayCatch

void backButtonArrayCatch() {
  if ( currentSong == 0 ) {
    currentSong = numberOfSongs - 1;
  } else {
    currentSong--;
  }//End of CATCH
}
//End backButtonArrayCatch
