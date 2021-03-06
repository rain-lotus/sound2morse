import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import de.bezier.data.sql.mapper.*;
import de.bezier.data.sql.*;

//var
int delayTime = 10;
int ton = 6;
int tu = 0;
HashMap<String, String> morse = new HashMap<String, String>();

PFont font;
//lib
SQLite db;
Minim minim;
AudioPlayer player;
String filename = "morse.wav";
FFT fft;

void setup() {
  size(800, 800);
  font = createFont("MeiryoUI", 32);
  textFont(font);
  textSize(20);
  fill(255);
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
String text = "";
String mor = "";

void draw() {
  background(0);
  judg();
  count++;//常にカウントしておく

  if (getVol() <= 0 && count > delayTime) {
    if (!cha.equals("")) {
      //println(cha);
      //println(morse.get(cha));
      String temp = morse.get(cha);
      if (temp == null) temp = "?";
      text += temp;
      mor += "　";
      cha = "";
    }
  }

  text(text, 50, 50, 700, 800);
  text(mor, 50, 350, 700, 800);
}