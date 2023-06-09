use IO;

testAdvanceUpTo(openReader("multiByteInput.txt"), "<<<<123>>>>");
testAdvanceUpTo(openReader("multiByteInput.txt"), b"<<<<123>>>>");

proc testAdvanceUpTo(r, sep) {
  // try to read a separator that isn't in the channel (should throw 'EofError')
  try {
    r.advanceTo(sep);
  } catch e {
    writeln(e);
  }

  // confirm pointer is at EOF
  write(r.readAll());
}
