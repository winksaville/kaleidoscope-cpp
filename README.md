# Kaleidoscope in C++

This is based on ["Kaleidoscope: Implementing a Language with LLVM"](https://llvm.org/docs/tutorial/index.html#kaleidoscope-implementing-a-language-with-llvm),
but the code is coming from [llvm-mirror/llvm/examples/Kaleidoscope](https://github.com/llvm-mirror/llvm/tree/master/examples/Kaleidoscope) from master as of July, 2018.

I'd like to eventually have this staticaly link with
`-stdlib=libc++`, but have not been successful. So for
now we'll just dynamicaly link with gcc's libstdc++.

## Prerequisites

clang
gcc
...

## Building

Release build is the default
```bash
make
```

You can also specify build-type=release|debug.
So a debug build is:
```bash
make build-type=debug
```

You can also do a verbose build passing `v=true` on make command line
```bash
make v=true build-type=release
```

## clean

Clean the build delete object and executables
```bash
make clean
```

## distclean

Invokes clean and then deletes `toy.*.asm` files
```bash
make distclean
```
