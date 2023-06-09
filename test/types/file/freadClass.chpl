use IO;

class myClass {
  var x: int;
  var y: real;
}

var a: borrowed myClass = (new owned myClass(x = 1, y = 2.3)).borrow();
var b: borrowed myClass = (new owned myClass(x = 9, y = 9.9)).borrow();

writeln("a is initialized to: ", a);
writeln("b is initialized to: ", b);

var f = open("_test_freadClass.txt", ioMode.cwr);
var writer = f.writer();
writer.writeln(a);
writer.close();

var reader = f.reader();
reader.read(b);
writeln("b after reading in a's values from a file: ", b);
