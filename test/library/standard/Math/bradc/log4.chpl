use Math;

for i in 1..4**3 {
  writeln("i = ", i, "; log4(i) = ", log4(i));
}

proc log4(x) do return logBasePow2(x, 2);
