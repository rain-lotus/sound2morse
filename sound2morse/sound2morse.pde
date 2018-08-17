import de.bezier.data.sql.mapper.*;
import de.bezier.data.sql.*;

int delayTime = 15;
int ton = 6;
int tu = 0;
HashMap<String, String> morse = new HashMap<String, String>();
SQLite db;
void setup() {
  size(100, 100);
  
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
  if (mousePressed) background(255);
  count++;
  if (!mousePressed && count > delayTime) {
    if (!cha.equals("")) {
      println(cha);
      println(morse.get(cha));
      cha = "";
    }
  }
}

void mousePressed() {
  count = 0;
}

void mouseReleased() {
  String status = "";
  if (count < ton) {
    status = "・";
    cha += 1;
  } else {
    status = "-";
    cha += 3;
  }
  println(status);
  count = 0;
}