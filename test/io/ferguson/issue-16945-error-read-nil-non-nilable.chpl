use IO;

class C {
  var x: int;
}

var f = openMemFile();

var x = new owned C(1);
f.writer().write("nil");

f.reader().read(x);
writeln(x);
