class Random {
  // Avoid negative or very large seeds.
  var seed: uint = 1;
  def RandomNumber () {
    const multiplier: int(64) = 16807,
          modulus: int(64) = 2147483647;
    // The following calculation must be done in at least 46-bit arithmetic!
    seed = (seed * multiplier % modulus) : uint;
    return (seed-1) / (modulus-2) : real;
  }
  def RandomNumber (n) {
    return for 1..n do RandomNumber();
  }
}

config const seed: uint = 13,
             arraySize = 10;

def main {
  var r = Random (seed);
  var rArray: [1..arraySize] real;
  rArray = r.RandomNumber(arraySize);
  writeln (rArray);
}
