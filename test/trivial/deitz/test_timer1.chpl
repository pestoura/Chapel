use Time;

var t: Timer;

t.start();
sleep(5);
t.stop();
if t.elapsed() < 5.0 then
  writeln("too short of a time");
else if t.elapsed() > 5.1 then
  writeln("too long of a time");
else
  writeln("time value is okay");
