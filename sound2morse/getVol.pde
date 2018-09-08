//それっぽい周波数の音量をざっくり取って返す
float getVol() {
  float vol = 0;
  fft.forward(player.mix);
  for (int i = 0; i < fft.specSize(); i++) {
    vol += fft.getBand(i)*8;
  }
  
  return vol-50;
}