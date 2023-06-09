// This code elaborates on recursive-ifc-1-error.chpl
// by defining THREE mutually-recursive interfaces.
//
// Within the recursive-ifc-3-* family,
// it checks whether we can report an "assoc. type is not defined" error.

interface Ifc1 {
  type AT1;
  AT1 implements Ifc2;
}

interface Ifc2 {
  type AT2;
  AT2 implements Ifc3;
}

interface Ifc3 {
  type AT3;
  AT3 implements Ifc1;
}

implements Ifc1(int(8));
implements Ifc2(int(16)); // error: AT2 is not defined
implements Ifc3(int(32));

proc integral.AT1 type do return int(16);
//proc integral.AT2 type do return int(32);
proc integral.AT3 type do return int(8);
