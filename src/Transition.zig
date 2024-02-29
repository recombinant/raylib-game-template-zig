// The code in this file is translated from https://github.com/raysan5/raylib-game-template

// Header comments from original source code:

// ----------------------------------------------------------------------------
//
//  raylib - Advanced Game template
//
//  Screen transition logic
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

const screen_width = @import("constants.zig").screen_width;
const screen_height = @import("constants.zig").screen_height;

const ScreenTag = @import("screen.zig").ScreenTag;

const Self = @This();

/// Required variables to manage screen transitions (fade-in, fade-out)
active: bool,
alpha: f32,
fade_out: bool,
to_screen: ScreenTag,

/// Request transition to next screen.
/// Change to next screen with smooth transition.
/// Unless `screen` is .unknown when transition will be inactive.
pub fn init(screen: ScreenTag) Self {
    return .{
        .active = (screen != .unknown),
        .alpha = 0,
        .fade_out = false,
        .to_screen = screen,
    };
}

/// Update transition effect (fade-in, fade-out)
pub fn update(self: *Self, game: anytype) void {
    if (self.fade_out) {
        self.alpha -= 0.02;

        if (self.alpha < -0.01)
            self.* = init(.unknown); // re-initialize
    } else {
        self.alpha += 0.05;

        // NOTE: Due to float internal representation, condition jumps on 1.0 instead of 1.05
        // For that reason we compare against 1.01, to avoid last frame loading stop
        if (self.alpha > 1.01) {
            self.alpha = 1.0;

            // Transition is mid-way, so simply change to screen
            game.changeToScreen(self.to_screen);

            // Activate fade out effect to next loaded screen
            self.fade_out = true;
        }
    }
}

/// Draw transition effect (full-screen rectangle)
pub fn draw(self: Self) void {
    rl.DrawRectangle(
        0,
        0,
        screen_width,
        screen_height,
        rl.Fade(rl.BLACK, self.alpha),
    );
}
