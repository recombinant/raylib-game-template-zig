// The code in this file is translated from https://github.com/raysan5/raylib-game-template

// Header comments from original source code:

// ----------------------------------------------------------------------------
//
//   raylib game template
//
//   <Game title>
//   <Game description>
//
//   This game has been created using raylib (www.raylib.com)
//   raylib is licensed under an unmodified zlib/libpng license (View raylib.h for details)
//
//   Copyright (c) 2021 Ramon Santamaria (@raysan5)
//
// ----------------------------------------------------------------------------
const Game = @import("Game.zig");
const rl = @import("rl.zig").rl;

const screen_width = @import("constants.zig").screen_width;
const screen_height = @import("constants.zig").screen_height;

pub fn main() void {
    rl.InitWindow(screen_width, screen_height, "raylib game template");
    defer rl.CloseWindow();

    rl.InitAudioDevice();
    defer rl.CloseAudioDevice();

    var game = Game.init();
    defer game.deinit();

    rl.SetTargetFPS(60); // Set our game to run at 60 frames-per-second
    //--------------------------------------------------------------------------------------

    // Main game loop
    while (!rl.WindowShouldClose()) // Detect window close button or ESC key
    {
        game.update();

        rl.BeginDrawing();
        defer rl.EndDrawing();

        rl.ClearBackground(rl.RAYWHITE);

        game.draw();
    }
}
