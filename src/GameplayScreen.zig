// The code in this file is translated from https://github.com/raysan5/raylib-game-template

// Header comments from original source code:

// ----------------------------------------------------------------------------
//
//  raylib - Advanced Game template
//
//  Gameplay Screen Function Definitions (init, deinit, update, draw)
//
//  Copyright (c) 2014-2022 Ramon Santamaria (@raysan5)
//
//  This software is provided "as-is", without any express or implied warranty. In no event
//  will the authors be held liable for any damages arising from the use of this software.
//
//  Permission is granted to anyone to use this software for any purpose, including commercial
//  applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//    1. The origin of this software must not be misrepresented; you must not claim that you
//    wrote the original software. If you use this software in a product, an acknowledgment
//    in the product documentation would be appreciated but is not required.
//
//    2. Altered source versions must be plainly marked as such, and must not be misrepresented
//    as being the original software.
//
//    3. This notice may not be removed or altered from any source distribution.
//
// ----------------------------------------------------------------------------
const rl = @import("rl.zig").rl;

const screen_width = @import("constants.zig").screen_width;
const screen_height = @import("constants.zig").screen_height;

const Self = @This();

const ScreenState = enum { unfinished, ending, title };

//----------------------------------------------------------------------------------
// Module Variables Definition (local)
//----------------------------------------------------------------------------------
state: ScreenState,
fx_coin: rl.Sound,
font: rl.Font,

//----------------------------------------------------------------------------------
// Gameplay Screen Functions Definition
//----------------------------------------------------------------------------------

/// Gameplay Screen Initialization logic
pub fn init(fx_coin: rl.Sound, font: rl.Font) Self {
    // TODO: Initialize GAMEPLAY screen variables here!
    return Self{
        .state = .unfinished,
        .fx_coin = fx_coin,
        .font = font,
    };
}

/// Gameplay Screen Unload logic
pub fn deinit(self: *Self) void {
    // TODO: Unload GAMEPLAY screen variables here!
    _ = self;
}

/// Gameplay Screen Update logic
pub fn update(self: *Self) void {
    // TODO: Update GAMEPLAY screen variables here!

    // Press enter or tap to change to ENDING screen
    if (rl.IsKeyPressed(rl.KEY_ENTER) or rl.IsGestureDetected(rl.GESTURE_TAP)) {
        self.state = .ending;
        rl.PlaySound(self.fx_coin);
    }
}

/// Gameplay Screen Draw logic
pub fn draw(self: *const Self) void {
    // TODO: Draw GAMEPLAY screen here!
    rl.DrawRectangle(0, 0, screen_width, screen_height, rl.PURPLE);
    const pos = rl.Vector2{ .x = 20, .y = 10 };
    rl.DrawTextEx(self.font, "GAMEPLAY SCREEN", pos, @floatFromInt(self.font.baseSize * 3), 4, rl.MAROON);
    rl.DrawText("PRESS ENTER or TAP to JUMP to ending SCREEN", 130, 220, 20, rl.MAROON);
}

/// Gameplay Screen should finish?
pub fn getNextScreen(self: *const Self) ScreenState {
    return self.state;
}
