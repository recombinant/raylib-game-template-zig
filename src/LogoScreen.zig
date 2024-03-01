// The code in this file is translated from https://github.com/raysan5/raylib-game-template

// Header comments from original source code:

// ----------------------------------------------------------------------------
//
// raylib - Advanced Game template
//
// Logo Screen Function Definitions (init, deinit, update, draw)
//
// Copyright (c) 2014-2022 Ramon Santamaria (@raysan5)
//
// This software is provided "as-is", without any express or implied warranty. In no event
// will the authors be held liable for any damages arising from the use of this software.
//
// Permission is granted to anyone to use this software for any purpose, including commercial
// applications, and to alter it and redistribute it freely, subject to the following restrictions:
//
//   1. The origin of this software must not be misrepresented; you must not claim that you
//   wrote the original software. If you use this software in a product, an acknowledgment
//   in the product documentation would be appreciated but is not required.
//
//   2. Altered source versions must be plainly marked as such, and must not be misrepresented
//   as being the original software.
//
//   3. This notice may not be removed or altered from any source distribution.
//
// ----------------------------------------------------------------------------
const rl = @import("rl.zig");

const screen_width = @import("constants.zig").screen_width;
const screen_height = @import("constants.zig").screen_height;

const Self = @This();

const LogoAnimationState = enum { blinking_square, bars_top_left, bars_bottom_right, raylib, finished };

//----------------------------------------------------------------------------------
// Module Variables Definition (local)
//----------------------------------------------------------------------------------
frames_counter: u16,

logo_x: c_int,
logo_y: c_int,

letters_count: c_int,

top_side_rec_width: c_int,
left_side_rec_height: c_int,

bottom_side_rec_width: c_int,
right_side_rec_height: c_int,

logo_animation_state: LogoAnimationState, // Logo animation states
alpha: f32, // Useful for fading

//----------------------------------------------------------------------------------
// Logo Screen Functions Definition
//----------------------------------------------------------------------------------

/// Logo Screen Initialization logic
pub fn init() Self {
    return Self{
        .frames_counter = 0,
        .letters_count = 0,

        .logo_x = @divTrunc(screen_width, 2) - 128,
        .logo_y = @divTrunc(screen_height, 2) - 128,

        .top_side_rec_width = 16,
        .left_side_rec_height = 16,
        .bottom_side_rec_width = 16,
        .right_side_rec_height = 16,

        .logo_animation_state = .blinking_square,
        .alpha = 1.0,
    };
}

/// Logo Screen Unload logic
pub fn deinit(self: *Self) void {
    _ = self;
    // Unload LOGO screen variables here!
}

/// Logo Screen Update logic
pub fn update(self: *Self) void {
    switch (self.logo_animation_state) {
        .blinking_square => {
            // blinking_square state: Top-left square corner blink logic
            self.frames_counter += 1;

            if (self.frames_counter == 80) {
                self.logo_animation_state = .bars_top_left;
                self.frames_counter = 0; // Reset counter... will be used later...
            }
        },
        .bars_top_left => {
            // bars_top_left state: Bars animation logic: top and left
            self.top_side_rec_width += 8;
            self.left_side_rec_height += 8;

            if (self.top_side_rec_width == 256)
                self.logo_animation_state = .bars_bottom_right;
        },
        .bars_bottom_right => {
            // bars_bottom_right state: Bars animation logic: bottom and right
            self.bottom_side_rec_width += 8;
            self.right_side_rec_height += 8;

            if (self.bottom_side_rec_width == 256)
                self.logo_animation_state = .raylib;
        },
        .raylib => {
            // raylib state: "raylib" text-write animation logic
            self.frames_counter += 1;

            if (self.letters_count < 10) {
                if (self.frames_counter / 12 != 0) // Every 12 frames, one more letter!
                {
                    self.letters_count += 1;
                    self.frames_counter = 0;
                }
            } else // When all letters have appeared, just fade out everything
            {
                if (self.frames_counter > 200) {
                    self.alpha -= 0.02;

                    if (self.alpha <= 0.0) {
                        self.alpha = 0.0;
                        self.logo_animation_state = .finished; // Jump to next screen
                    }
                }
            }
        },
        .finished => {},
    }
}

/// Logo Screen Draw logic
pub fn draw(self: *const Self) void {
    switch (self.logo_animation_state) {
        .blinking_square => {
            // Draw blinking top-left square corner
            if ((self.frames_counter / 10) % 2 != 0)
                rl.DrawRectangle(self.logo_x, self.logo_y, 16, 16, rl.BLACK);
        },
        .bars_top_left => {
            // Draw bars animation: top and left
            rl.DrawRectangle(self.logo_x, self.logo_y, self.top_side_rec_width, 16, rl.BLACK);
            rl.DrawRectangle(self.logo_x, self.logo_y, 16, self.left_side_rec_height, rl.BLACK);
        },
        .bars_bottom_right => {
            // Draw bars animation: bottom and right
            rl.DrawRectangle(self.logo_x, self.logo_y, self.top_side_rec_width, 16, rl.BLACK);
            rl.DrawRectangle(self.logo_x, self.logo_y, 16, self.left_side_rec_height, rl.BLACK);

            rl.DrawRectangle(self.logo_x + 240, self.logo_y, 16, self.right_side_rec_height, rl.BLACK);
            rl.DrawRectangle(self.logo_x, self.logo_y + 240, self.bottom_side_rec_width, 16, rl.BLACK);
        },
        .raylib, .finished => {
            // Draw "raylib" text-write animation + "powered by"
            rl.DrawRectangle(self.logo_x, self.logo_y, self.top_side_rec_width, 16, rl.Fade(rl.BLACK, self.alpha));
            rl.DrawRectangle(self.logo_x, self.logo_y + 16, 16, self.left_side_rec_height - 32, rl.Fade(rl.BLACK, self.alpha));

            rl.DrawRectangle(self.logo_x + 240, self.logo_y + 16, 16, self.right_side_rec_height - 32, rl.Fade(rl.BLACK, self.alpha));
            rl.DrawRectangle(self.logo_x, self.logo_y + 240, self.bottom_side_rec_width, 16, rl.Fade(rl.BLACK, self.alpha));

            const center_x = @divTrunc(screen_width, 2);
            const center_y = @divTrunc(screen_height, 2);
            rl.DrawRectangle(center_x - 112, center_y - 112, 224, 224, rl.Fade(rl.RAYWHITE, self.alpha));

            rl.DrawText(rl.TextSubtext("raylib", 0, self.letters_count), center_x - 44, center_y + 48, 50, rl.Fade(rl.BLACK, self.alpha));

            if (self.frames_counter > 20)
                rl.DrawText("powered by", self.logo_x, self.logo_y - 27, 20, rl.Fade(rl.DARKGRAY, self.alpha));
        },
    }
}

/// Logo Screen should finish?
pub fn isFinished(self: *const Self) bool {
    return self.logo_animation_state == .finished;
}
