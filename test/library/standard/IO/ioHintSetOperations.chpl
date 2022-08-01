use IO;
use Set;

// constructors work
const empty = ioHintSet.empty;
const seq = ioHintSet.sequential;
const rand = ioHintSet.random;
const pref = ioHintSet.prefetch;
const mmap = ioHintSet.mmap;

// equality and inequality
writeln(seq != rand);
writeln(seq == seq);
writeln(seq & rand == empty);
writeln(seq | rand != empty);

// union and intersection
writeln(pref | rand == rand | pref);
writeln(pref & rand == rand & pref);
writeln(ioHintSet.direct(pref._internal | mmap._internal) == pref | mmap);
writeln(ioHintSet.direct(seq._internal & rand._internal) == seq & rand);

// internal bits are unique
var s = new set(int(32));
s.add(empty._internal);
s.add(seq._internal);
s.add(rand._internal);
s.add(pref._internal);
s.add(mmap._internal);
writeln(s.size);
