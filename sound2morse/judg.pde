boolean start_rec = false;
void judg() {
  float vol = getVol();
  if (vol-50 > 0 && !start_rec) {
    //音が始まったとき
    start_rec = true;
    count = 0;
  }

  if (start_rec & vol <= 0) {
    //音が終わったとき
    start_rec = false;
    String status = "";
    if (count < ton) {
      status = "･";
      cha += 1;
    } else {
      status = "-";
      cha += 3;
    }
    //println(status);
    mor += status;
    count = 0;
  }
}