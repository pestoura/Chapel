use Regex;
var re = new regex("a+b+");
writeln(re.fullMatch("a").matched);
writeln(re.fullMatch("b").matched);
writeln(re.fullMatch("abc").matched);
writeln(re.fullMatch("cab").matched);
writeln(re.fullMatch("aab").matched);
writeln(re.fullMatch("abb").matched);
writeln(re.fullMatch("bab").matched);
writeln(re.fullMatch("aaaaabbbbbccccc").matched);
writeln(re.fullMatch("aaabbb\n").matched);
