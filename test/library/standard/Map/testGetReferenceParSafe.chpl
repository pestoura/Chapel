use Map;

proc test() {
  var m = new map(int, int, parSafe=true);
  m.add(0, 0);
  m[0] = 128;
}
test();

