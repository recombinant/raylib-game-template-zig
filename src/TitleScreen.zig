// ----------------------------------------------------------------------------
//
//  raylib - Advanced Game template
//
//  Title Screen Function Definitions (init, deinit, update, draw)
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
const rl = @import("rl.zig");

const Self = @This();

const FinishScreen = enum { unfinished, options, gameplay };

//----------------------------------------------------------------------------------
// Module Variables Definition (local)
//----------------------------------------------------------------------------------
finish_screen: FinishScreen,
fx_coin: rl.Sound,
font: rl.Font,

//----------------------------------------------------------------------------------
// Title Screen Functions Definition
//----------------------------------------------------------------------------------

/// Title Screen Initialization logic
pub fn init(fx_coin: rl.Sound, font: rl.Font) Self {
    // TODO: Initialize TITLE screen variables here!
    return Self{
        .finish_screen = .unfinished,
        .fx_coin = fx_coin,
        .font = font,
    };
}

/// Title Screen Unload logic
pub fn deinit(self: *Self) void {
    _ = self;
    // TODO: Unload TITLE screen variables here!
}

/// Title Screen Update logic
pub fn update(self: *Self) void {
    // TODO: Update TITLE screen variables here!

    // Press enter or tap to change to gameplay screen
    if (rl.IsKeyPressed(rl.KEY_ENTER) or rl.IsGestureDetected(rl.GESTURE_TAP)) {
        //finish_screen = .OPTIONS;
        self.finish_screen = .gameplay;
        rl.PlaySound(self.fx_coin);
    }
}

/// Title Screen Draw logic
pub fn draw(self: *const Self) void {
    // TODO: Draw TITLE screen here!
    rl.DrawRectangle(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight(), rl.GREEN);
    const pos = rl.Vector2{ .x = 20, .y = 10 };
    rl.DrawTextEx(self.font, "TITLE SCREEN", pos, @floatFromInt(self.font.baseSize * 3), 4, rl.DARKGREEN);
    rl.DrawText("PRESS ENTER or TAP to JUMP to gameplay SCREEN", 120, 220, 20, rl.DARKGREEN);
}

/// Title Screen should finish?
pub fn getNextScreen(self: *const Self) FinishScreen {
    return self.finish_screen;
}
