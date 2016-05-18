void keyPressed(){
  if(key == '='){
    if(vote_threshold <= 255) vote_threshold++;
  }
  else if(key == '-'){
    if(vote_threshold >= 0) vote_threshold--;
  }
  else if(key == 'n'){
    if(vote_threshold >= 0) norm_factor++;
  }
  else if(key == 'N'){
    if(vote_threshold >= 0) norm_factor--;
  }
  else if(key == 'v'){
    if(seeRed) seeRed = false;
    else seeRed = true;
  }
  
  println(vote_threshold);
}