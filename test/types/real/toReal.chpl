config param u: uint = 42,
       u32: uint(32) = u;

param r: real = u.toReal();
param r32 = u32.toReal();

var uv = u,
    uv32 = u32;

var rv = uv.toReal(),
    rv32 = uv32.toReal();

print(u,r);
print(u32,r32);
print(uv,rv);
print(uv32,rv32);

proc print(param u, param r) {
  write('param ');
  var uv = u, rv = r;
  print(uv, rv);
}

proc print(u, r) {
  writeln(r, ": ", r.type:string, " == ", u, ":", u.type:string, ".toReal()");
}

