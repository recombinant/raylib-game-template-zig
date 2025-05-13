# raylib-game-template-zig

The code in this repository is a translation and refactoring of C source code found at:

https://github.com/raysan5/raylib-game-template

The original code is _Copyright (c) 2014-2025 Ramon Santamaria_

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
- the screen instances are held in a [tagged union](https://ziglang.org/documentation/master/#Tagged-union)
- there are no zig tests
- developed and run on Microsoft Windows 11 only

## zig and raylib versions

- `zig-0.15.0-dev.515` (May 2025)
- raylib dev (May 2025)

Please don't be surprised if the project does not compile without tweaking - this is not set up for the unwary.

## to run

`zig build run`
