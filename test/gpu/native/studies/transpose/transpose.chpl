use CTypes;
use GPUDiagnostics;
use GPU;
use Time;

config const sizeX = 2048*8,
             sizeY = 2048*8;
config param blockSize = 16;

pragma "codegen for GPU"
pragma "always resolve function"
export proc transposeMatrix(odata: c_ptr(real(32)), idata: c_ptr(real(32)), width: int, height: int) {
  var smVoidPtr = __primitive("gpu allocShared", numBytes(real(32))*blockSize*blockSize);
  var smArrPtr = smVoidPtr : c_ptr(real(32));

  const blockIdxX = __primitive("gpu blockIdx x"),
        threadIdxX = __primitive("gpu threadIdx x"),
        blockIdxY = __primitive("gpu blockIdx y"),
        threadIdxY = __primitive("gpu threadIdx y");
  var idxX = blockIdxX * blockSize + threadIdxX,
      idxY = blockIdxY * blockSize + threadIdxY;

  // Store the input data in transposed order into temporary array
  // i.e., the below is effectively smArrPtr[y][x] instead of
  // smArrPtr[x][y] for copy
  if (idxX < width && idxY < height) {
    smArrPtr[blockSize * threadIdxX + threadIdxY] = idata[idxY * width + idxX];
  }

  // synchronize the threads
  __primitive("gpu syncThreads");

  // Swap coordinates and write back out
  idxX = blockIdxY * blockSize + threadIdxX;
  idxY = blockIdxX * blockSize + threadIdxY;
  if (idxX < height && idxY < width) {
    odata[idxY * height + idxX] = smArrPtr[blockSize * threadIdxY + threadIdxX];
  }
}

proc transposeTiled(original, output) {
  __primitive("gpu kernel launch",
          c"transposeMatrix",
          /* grid size */  sizeX / blockSize, sizeY / blockSize, 1,
          /* block size */ blockSize, blockSize, 1,
          /* kernel args */ c_ptrTo(output), c_ptrTo(original), sizeX, sizeY);
}

proc transposeNaive(original, output) {
  foreach (x,y) in original.domain do output[y,x] = original[x,y];
}

config const useNaive = false;

on here.gpus[0] {
  var original: [0..#sizeX, 0..#sizeY] real(32);
  var output: [0..#sizeY, 0..#sizeY] real(32);

  for (a, (x,y)) in zip(original, original.domain) {
    a = x*sizeY + y;
  }

  // Make sure a is on device if we're using unified memory.
  foreach a in original do a = a + 1;

  var timer: stopwatch;
  timer.start();
  if useNaive {
    transposeNaive(original, output);
  } else {
    transposeTiled(original, output);
  }
  timer.stop();
  var elapsed = timer.elapsed();
  var sizeInBytes = original.size * numBytes(real(32));
  var sizeInGb = sizeInBytes / (1000.0 * 1000.0 * 1000.0);
  var gbPerSec = sizeInGb / elapsed;
  writeln("Wall clock time (s): ", elapsed);
  writeln("Performance (GB/s): ", gbPerSec);
}
