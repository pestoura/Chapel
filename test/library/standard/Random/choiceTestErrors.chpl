use Random;

config const debug = false;

/* Confirm a number of cases that should throw errors */
proc main() throws {

  var success = true;

  // Empty array
  try {
    var empty: [1..0] real;
    var c = choice(empty);
    success = false;
  } catch e: IllegalArgumentError {
    if debug then writeln(e.message());
  }

  // Non-matching domain
  try {
    var c = choice([1,2,3], [0.5, 0.5]);
    success = false;
  } catch e: IllegalArgumentError {
    if debug then writeln(e.message());
  }


  // Array of 0s
  try {
    var c = choice([0, 0]);
    success = false;
  } catch e: IllegalArgumentError {
    if debug then writeln(e.message());
  }

  // Negative values
  try {
    var c = choice([1, -1]);
    success = false;
  } catch e: IllegalArgumentError {
    if debug then writeln(e.message());
  }


  if !success {
    writeln('Error: An error was not thrown');
  }

}
