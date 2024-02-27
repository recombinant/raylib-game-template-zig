// ----------------------------------------------------------------------------
//
//  raylib - Advanced Game template
//
//  Ending Screen Function Definitions (init, deinit, update, draw)
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

const FinishScreen = enum { unfinished, title };

//----------------------------------------------------------------------------------
// Module Variables Definition (local)
//----------------------------------------------------------------------------------
finish_screen: FinishScreen,
fx_coin: rl.Sound,
font: rl.Font,

//----------------------------------------------------------------------------------
// Ending Screen Functions Definition
//----------------------------------------------------------------------------------

/// Ending Screen Initialization logic
pub fn init(fx_coin: rl.Sound, font: rl.Font) Self {
    // TODO: Initialize ENDING screen variables here!
    return Self{
        .finish_screen = .unfinished,
        .fx_coin = fx_coin,
        .font = font,
    };
}

/// Ending Screen Unload logic
pub fn deinit(self: *Self) void {
    _ = self;
    // TODO: Unload ENDING screen variables here!
}

/// Ending Screen Update logic
pub fn update(self: *Self) void {
    // TODO: Update ENDING screen variables here!

    // Press enter or tap to return to TITLE screen
    if (rl.IsKeyPressed(rl.KEY_ENTER) or rl.IsGestureDetected(rl.GESTURE_TAP)) {
        self.finish_screen = .title;
        rl.PlaySound(self.fx_coin);
    }
}

/// Ending Screen Draw logic
pub fn draw(self: *const Self) void {
    // TODO: Draw ENDING screen here!
    rl.DrawRectangle(0, 0, rl.GetScreenWidth(), rl.GetScreenHeight(), rl.BLUE);

    const pos = rl.Vector2{ .x = 20, .y = 10 };
    rl.DrawTextEx(self.font, "ENDING SCREEN", pos, @floatFromInt(self.font.baseSize * 3), 4, rl.DARKBLUE);
    rl.DrawText("PRESS ENTER or TAP to RETURN to TITLE SCREEN", 120, 220, 20, rl.DARKBLUE);
}

/// Ending Screen should finish?
pub fn getNextScreen(self: *Self) FinishScreen {
    return self.finish_screen;
}
