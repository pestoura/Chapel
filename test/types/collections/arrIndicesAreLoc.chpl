use BlockDist;

var A = Block.createArray({1..10}, real);

forall i in A.indices do
  A[i] = here.id;

writeln(A);

on Locales[numLocales-1] {
  forall i in A.indices do
    A[i] = here.id;
}

writeln(A);
