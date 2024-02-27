// The code in this file is translated from https://github.com/raysan5/raylib-game-template

// Header comments from original source code:

// ----------------------------------------------------------------------------
//
//  raylib - Advanced Game template
//
//  enum and tagged union for screens
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
const LogoScreen = @import("LogoScreen.zig");
const OptionsScreen = @import("OptionsScreen.zig");
const TitleScreen = @import("TitleScreen.zig");
const GameplayScreen = @import("GameplayScreen.zig");
const EndingScreen = @import("EndingScreen.zig");

pub const ScreenTag = enum {
    unknown,
    logo,
    title,
    options,
    gameplay,
    ending,
};

pub const Screen = union(ScreenTag) {
    unknown: void,
    logo: LogoScreen,
    title: TitleScreen,
    options: OptionsScreen,
    gameplay: GameplayScreen,
    ending: EndingScreen,
};
