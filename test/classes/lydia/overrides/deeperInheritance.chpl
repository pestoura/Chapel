// Checks that you can access the overridden method.
class A {
  proc foo() {
    writeln("in A.foo()");
  }
}

class B: A {
  proc foo() {
    super.foo();
    writeln("in B.foo()");
  }
}

class C: B {
  proc foo() {
    super.super.foo();
    super.foo();
    writeln("in C.foo()");
  }
}

var a = new A();
var b = new B();
var c = new C();
a.foo();
b.foo();
c.foo();
