// This test checks the ABI handling for export functions
// by comparing the declarations with those generated by clang.

// If the declarations change for some reason, check the full output
//  * do the types/attributes still match?
//  * does the movement of data to/from arguments look similar?
//    (it does not have to be identical as long as the same values
//     are read from / stored in the arguments)

import IO;

extern {
  #include <stdio.h>
  #include <stdbool.h>
  #include <inttypes.h>

  struct c_pair {
    int a;
    int b;
  };

  void print_output_prefix(void);

  int64_t int64_return_c(void);
  void int64_arg_c(int64_t i);

  int32_t int32_return_c(void);
  void int32_arg_c(int32_t i);

  int16_t int16_return_c(void);
  void int16_arg_c(int16_t i);

  int8_t int8_return_c(void);
  void int8_arg_c(int8_t i);


  uint64_t uint64_return_c(void);
  void uint64_arg_c(uint64_t i);

  uint32_t uint32_return_c(void);
  void uint32_arg_c(uint32_t i);

  uint16_t uint16_return_c(void);
  void uint16_arg_c(uint16_t i);

  uint8_t uint8_return_c(void);
  void uint8_arg_c(uint8_t i);


  bool bool_return_c(void);
  void bool_arg_c(bool i);


  struct c_pair struct_return_c(void);
  void struct_arg_c(struct c_pair arg);


  int64_t int64_return_c(void) {
    return -1;
  }
  void int64_arg_c(int64_t i) {
    print_output_prefix();
    printf("arg %i\n", (int) i);
  }

  int32_t int32_return_c(void) {
    return -1;
  }
  void int32_arg_c(int32_t i) {
    print_output_prefix();
    printf("arg %i\n", (int) i);
  }

  int16_t int16_return_c(void) {
    return -1;
  }
  void int16_arg_c(int16_t i) {
    print_output_prefix();
    printf("arg %i\n", (int) i);
  }

  int8_t int8_return_c(void) {
    return -1;
  }
  void int8_arg_c(int8_t i) {
    print_output_prefix();
    printf("arg %i\n", (int) i);
  }


  uint64_t uint64_return_c(void) {
    return 0xffffffffffffffffull;
  }
  void uint64_arg_c(uint64_t i) {
    print_output_prefix();
    printf("arg %llu\n", (unsigned long long) i);
  }

  uint32_t uint32_return_c(void) {
    return 0xffffffff;
  }
  void uint32_arg_c(uint32_t i) {
    print_output_prefix();
    printf("arg %u\n", (unsigned int) i);
  }

  uint16_t uint16_return_c(void) {
    return 0xffff;
  }
  void uint16_arg_c(uint16_t i) {
    print_output_prefix();
    printf("arg %i\n", (int) i);
  }

  uint8_t uint8_return_c(void) {
    return 0xff;
  }
  void uint8_arg_c(uint8_t i) {
    print_output_prefix();
    printf("arg %i\n", (int) i);
  }

  bool bool_return_c(void) {
    return true;
  }
  void bool_arg_c(bool i) {
    print_output_prefix();
    printf("arg %i\n", (int) i);
  }


  struct c_pair struct_return_c(void) {
    struct c_pair pair;
    pair.a = 0;
    pair.b = 1;
    return pair;
  }
  void struct_arg_c(struct c_pair arg) {
    print_output_prefix();
    printf("arg.a %i arg.b %i\n", arg.a, arg.b);
  }
}

var phase: string;
export proc print_output_prefix() {
  IO.stdout.write("OUTPUT ");
  IO.stdout.write(phase);
  IO.stdout.write(": ");
  IO.stdout.flush();
}
proc start_phase(name:string) {
  writeln("OUTPUT ", name);
  phase = name;
}

export proc int64_return_chapel(): int(64) {
  return int64_return_c();
}
export proc int64_arg_chapel(i: int(64)) {
  int64_arg_c(i);
}

export proc int32_return_chapel(): int(32) {
  return int32_return_c();
}
export proc int32_arg_chapel(i: int(32)) {
  int32_arg_c(i);
}

export proc int16_return_chapel(): int(16) {
  return int16_return_c();
}
export proc int16_arg_chapel(i: int(16)) {
  int16_arg_c(i);
}

export proc int8_return_chapel(): int(8) {
  return int8_return_c();
}
export proc int8_arg_chapel(i: int(8)) {
  int8_arg_c(i);
}


export proc uint64_return_chapel(): uint(64) {
  return uint64_return_c();
}
export proc uint64_arg_chapel(i: uint(64)) {
  uint64_arg_c(i);
}

export proc uint32_return_chapel(): uint(32) {
  return uint32_return_c();
}
export proc uint32_arg_chapel(i: uint(32)) {
  uint32_arg_c(i);
}

export proc uint16_return_chapel(): uint(16) {
  return uint16_return_c();
}
export proc uint16_arg_chapel(i: uint(16)) {
  uint16_arg_c(i);
}

export proc uint8_return_chapel(): uint(8) {
  return uint8_return_c();
}
export proc uint8_arg_chapel(i: uint(8)) {
  uint8_arg_c(i);
}


export proc bool_return_chapel(): bool {
  return bool_return_c();
}
export proc bool_arg_chapel(i: bool) {
  bool_arg_c(i);
}


export proc struct_return_chapel(): c_pair {
  var pair:c_pair;
  pair = struct_return_c();
  return pair;
}
export proc struct_arg_chapel(in arg: c_pair) {
  struct_arg_c(arg);
}

proc main() {
  {
    var i:int(64);
    start_phase("testing int64_..._c");
    i = int64_return_c();
    int64_arg_c(i);
    start_phase("testing int64_..._chapel");
    i = int64_return_chapel();
    int64_arg_chapel(i);
  }
  {
    var i:int(32);
    start_phase("testing int32_..._c");
    i = int32_return_c();
    int32_arg_c(i);
    start_phase("testing int32_..._chapel");
    i = int32_return_chapel();
    int32_arg_chapel(i);
  }
  {
    var i:int(16);
    start_phase("testing int16_..._c");
    i = int16_return_c();
    int16_arg_c(i);
    start_phase("testing int16_..._chapel");
    i = int16_return_chapel();
    int16_arg_chapel(i);
  }
  {
    var i:int(8);
    start_phase("testing int8_..._c");
    i = int8_return_c();
    int8_arg_c(i);
    start_phase("testing int8_..._chapel");
    i = int8_return_chapel();
    int8_arg_chapel(i);
  }

  {
    var i:uint(64);
    start_phase("testing uint64_..._c");
    i = uint64_return_c();
    uint64_arg_c(i);
    start_phase("testing uint64_..._chapel");
    i = uint64_return_chapel();
    uint64_arg_chapel(i);
  }
  {
    var i:uint(32);
    start_phase("testing uint32_..._c");
    i = uint32_return_c();
    uint32_arg_c(i);
    start_phase("testing uint32_..._chapel");
    i = uint32_return_chapel();
    uint32_arg_chapel(i);
  }
  {
    var i:uint(16);
    start_phase("testing uint16_..._c");
    i = uint16_return_c();
    uint16_arg_c(i);
    start_phase("testing uint16_..._chapel");
    i = uint16_return_chapel();
    uint16_arg_chapel(i);
  }
  {
    var i:uint(8);
    start_phase("testing uint8_..._c");
    i = uint8_return_c();
    uint8_arg_c(i);
    start_phase("testing uint8_..._chapel");
    i = uint8_return_chapel();
    uint8_arg_chapel(i);
  }

  {
    var i:bool;
    start_phase("testing bool_..._c");
    i = bool_return_c();
    bool_arg_c(i);
    start_phase("testing bool_..._chapel");
    i = bool_return_chapel();
    bool_arg_chapel(i);
  }


  {
    var pair:c_pair;
    start_phase("testing struct_..._c");
    pair = struct_return_c();
    struct_arg_c(pair);
    start_phase("testing struct_..._chapel");
    pair = struct_return_chapel();
    struct_arg_chapel(pair);
  }
}
