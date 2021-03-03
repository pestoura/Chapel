record r {
  proc init() { writeln('default init'); }
  proc init=(other: r) { writeln('init='); }
  proc deinit() { writeln('deinit'); }
}

proc =(ref lhs: r, rhs: r) { writeln('assign'); }

proc consumeElement(in elem) {}

// I would expect elision to occur here for 'x', but it does not.
proc test1() {
  writeln('T1');
  var doBlock = true;
  if doBlock {
    var x = new r();
    consumeElement(x);
  }
}
test1();

// Same test but in an on block.
proc test2() {
  writeln('T2');
  on Locales[0] {
    var doBlock = true;
    if doBlock {
      var x = new r();
      consumeElement(x);
    }
  }
}
test2();

// This test mimics what I am trying to do in 'set._addElem()'.
proc test3() {
  use Memory.Initialization;

  writeln('T3');
  pragma "no auto destroy"
  var x = new r();
  on Locales[0] {
    var doBlock = true;
    if doBlock {
      var moved = moveToValue(x);
      consumeElement(moved);
    }
  }
}
test3();

proc test4() {
  writeln('T4');
  var doBlock = true;
  if doBlock {
    var x = new r();
    consumeElement(x);
  } else {
    var y = new r();
    consumeElement(y);
  }
}
test4();

proc test5() {
  writeln('T5');
  var doBlock = false;
  if doBlock {
    var x = new r();
    consumeElement(x);
  } else {
    var y = new r();
    consumeElement(y);
  }
}
test5();

