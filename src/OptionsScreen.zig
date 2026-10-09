// The code in this file is translated from https://github.com/raysan5/raylib-game-template

// Header comments from original source code:

// ----------------------------------------------------------------------------
//
//  raylib - Advanced Game template
//
//  Options Screen Function Definitions (init, deinit, update, draw)
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
const rl = @import("raylib");

const OptionScreen = @This();

//----------------------------------------------------------------------------------
// Module Variables Definition (local)
//----------------------------------------------------------------------------------
is_finished: bool,

//----------------------------------------------------------------------------------
// Options Screen Functions Definition
//----------------------------------------------------------------------------------

/// Options Screen Initialization logic
pub fn init() OptionScreen {
    // TODO: Initialize OPTIONS screen variables here!
    return OptionScreen{
        .is_finished = false,
    };
}

/// Options Screen Unload logic
pub fn deinit(self: *OptionScreen) void {
    _ = self;
    // TODO: Unload OPTIONS screen variables here!
}

/// Options Screen Update logic
pub fn update(self: *OptionScreen) void {
    _ = self;
    // TODO: Update OPTIONS screen variables here!
}

/// Options Screen Draw logic
pub fn draw(self: *const OptionScreen) void {
    _ = self;
    // TODO: Draw OPTIONS screen here!
}

/// Options Screen should finish?
pub fn isFinished(self: *const OptionScreen) bool {
    return self.is_finished;
}
