use IO, MatrixMarket;
const filename : string = "complexsp.mtx";

var o = mmreadsp(complex, filename);
writeln(o);

mmwrite("cmplx.mtx", o);

var r = openReader("cmplx.mtx");
for l in r.lines() { writeln(l); }
