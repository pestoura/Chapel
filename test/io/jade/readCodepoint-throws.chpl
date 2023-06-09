use IO;

var f = open("test.txt", ioMode.cwr);

{
  var w = f.writer();
  w.writeCodepoint(0x1F600);
  w.close();
}

{
  var r = f.reader();
  r.readCodepoint(); // should not throw
  try {
    r.readCodepoint(); // should throw
    writeln("Incorrectly did not throw");
  } catch e:UnexpectedEofError {
    writeln("Correctly threw UnexpectedEofError");
  } catch { 
    writeln("Incorrectly threw some other error");
  }
}
