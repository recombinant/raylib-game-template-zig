# raylib-game-template-zig

The code in this repository is a translation and refactoring of C source code found at:

https://github.com/raysan5/raylib-game-template

The original code is _Copyright (c) 2014-2024 Ramon Santamaria_

For documentation refer to the repository above.

## translation

The original code is written in C. This code was manually translated to [zig](https://ziglang.org/) and then refactored to be more "zig like" using established zigisms.

- [zig naming conventions](https://ziglang.org/documentation/master/#Names) - except for all capitals constants names that were originally `#define`
- no global (ie. file scope) `var` variables
- each screen in the original is represented in zig by its own `struct` with consistent methods
  - init()
  - deinit() *where applicable*
  - update()
  - draw()
- there are no zig tests
- developed and run on Microsoft Windows 11 only

## zig and raylib versions

Both zig and raylib used for this project are development versions - primarily because zig is being heavily developed and raylib tracks changes in it's zig build.

- zig `0.12.0-dev.3033`
- raylib master branch dated 27 February 2024

## to run

`zig build run`
