writeln();

use BlockDist;

param dummy = 1;

var dom = Block.createDomain(0..10);
var a: [dom] int;
var b: [dom] int;
var c = Block.createArray(0..10, int);

writeln("Loop 1 -- expecting destination aggregation");
forall i in a.domain {
  a[10-i] = dummy;
}
writeln("End Loop 1");

writeln(a);
writeln();

writeln("Loop 2 -- expecting no aggregation");
forall i in a.domain {
  a[i] = dummy;
}
writeln("End Loop 2");

writeln(a);
writeln();

// index is comming from an aligned follower
writeln("Loop 3 -- expecting no aggregation");
forall (elem,i) in zip(a, a.domain) {
  elem = 5;
  a[i] = dummy;
}
writeln("End Loop 3");

writeln(a);
writeln();

// index is comming from an aligned follower
writeln("Loop 4 -- expecting no aggregation");
forall (elem,i) in zip(b, a.domain) {
  elem = 5;
  a[i] = dummy;
}
writeln("End Loop 4");

writeln(a);
writeln(b);
writeln();

