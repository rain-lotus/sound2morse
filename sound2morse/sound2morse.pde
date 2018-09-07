import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import de.bezier.data.sql.mapper.*;
import de.bezier.data.sql.*;

//var
int delayTime = 15;
int ton = 6;
int tu = 0;
HashMap<String, String> morse = new HashMap<String, String>();
//lib
SQLite db;
Minim minim;
AudioPlayer player;
String filename = "test3.wav";
FFT fft;

void setup() {
  size(100, 100);
  minim = new Minim(this);
  player = minim.loadFile(filename);
  player.play();
  fft = new FFT(player.bufferSize(), player.sampleRate());
  fft.window(FFT.HAMMING);

  db = new SQLite(this, "morse.sqlite");
  if ( db.connect() ) {
    String sql = "select * from morse_table";
    db.query( sql );
    //リストにデータを格納
    while ( db.next() ) {
      morse.put(db.getString("morse"), db.getString("char"));
    }
  }
}

int count = 0;
String cha = "";

void draw() {
  background(0);
  judg();
  count++;//常にカウントしておく

  if (getVol() <= 0 && count > delayTime) {
    if (!cha.equals("")) {
      println(cha);
      println(morse.get(cha));
      cha = "";
    }
  }
  //println(getVol()-50);
}

//void mousePressed() {
//  //新しく始まったときに0にする
//  count = 0;
//}

//void mouseReleased() {
//  String status = "";
//  if (count < ton) {
//    status = "・";
//    cha += 1;
//  } else {
//    status = "-";
//    cha += 3;
//  }
//  println(status);
//  count = 0;
//}