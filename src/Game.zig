// The code in this file is translated from https://github.com/raysan5/raylib-game-template

// Header comments from original source code:

// ----------------------------------------------------------------------------
//
//  raylib - Advanced Game template
//
//  Screen change logic
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

const LogoScreen = @import("LogoScreen.zig");
const OptionsScreen = @import("OptionsScreen.zig");
const TitleScreen = @import("TitleScreen.zig");
const GameplayScreen = @import("GameplayScreen.zig");
const EndingScreen = @import("EndingScreen.zig");
const Transition = @import("Transition.zig");
const Screen = @import("screen.zig").Screen;
const ScreenTag = @import("screen.zig").ScreenTag;

const Self = @This();

const FONT_TTF_DEFAULT_FIRST_CHAR = 32;

font: rl.Font,
fx_coin: rl.Sound,
music: rl.Music,

current_screen: Screen,
transition: Transition,

pub fn init() Self {
    const image_data = @embedFile("resources/mecha.png");
    const image = rl.LoadImageFromMemory(".png", image_data, @intCast(image_data.len));
    const font = rl.LoadFontFromImage(image, rl.MAGENTA, FONT_TTF_DEFAULT_FIRST_CHAR);

    const music_data = @embedFile("resources/ambient.ogg");
    const music = rl.LoadMusicStreamFromMemory(".ogg", music_data, @intCast(music_data.len));

    const wave_data = @embedFile("resources/coin.wav");
    const wave = rl.LoadWaveFromMemory(".wav", wave_data, @intCast(wave_data.len));
    defer rl.UnloadWave(wave);
    const fx_coin = rl.LoadSoundFromWave(wave);

    rl.SetMusicVolume(music, 1.0);
    rl.PlayMusicStream(music);

    // Setup and init first screen
    const current_screen = Screen{ .logo = LogoScreen.init() };

    return Self{
        .font = font,
        .music = music,
        .fx_coin = fx_coin,
        .current_screen = current_screen,
        .transition = Transition.init(.unknown),
    };
}

pub fn deinit(self: *Self) void {
    // Unload current screen data before closing
    switch (self.current_screen) {
        .unknown => unreachable,
        inline else => |*current_screen| current_screen.deinit(),
    }

    rl.StopMusicStream(self.music);
    rl.UnloadMusicStream(self.music);
    rl.UnloadSound(self.fx_coin);
    rl.UnloadFont(self.font);
}

/// Update and draw game frame
pub fn update(self: *Self) void {
    rl.UpdateMusicStream(self.music); // NOTE: Music keeps playing between screens

    if (self.transition.active)
        self.transition.update(self) // Update transition (fade-in, fade-out)

    else {
        switch (self.current_screen) {
            .logo => |*logo_screen| {
                logo_screen.update();

                if (logo_screen.isFinished()) {
                    self.transition = Transition.init(.title);
                    //   or for instant change without transition
                    // self.changeToScreen(.title);
                }
            },
            .title => |*title_screen| {
                title_screen.update();

                if (title_screen.getNextScreen() == .options)
                    self.transition = Transition.init(.options)
                else if (title_screen.getNextScreen() == .gameplay)
                    self.transition = Transition.init(.gameplay);
            },
            .options => |*options_screen| {
                options_screen.update();

                if (options_screen.isFinished())
                    self.transition = Transition.init(.title);
            },
            .gameplay => |*gameplay_screen| {
                gameplay_screen.update();

                if (gameplay_screen.getNextScreen() == .ending)
                    self.transition = Transition.init(.ending);
                // else if (gameplay_screen.getNextScreen() == .title)
                //     self.transition = Transition.init(.title);
            },
            .ending => |*ending_screen| {
                ending_screen.update();

                if (ending_screen.getNextScreen() == .title)
                    self.transition = Transition.init(.title);
            },

            .unknown => unreachable,
        }
    }
}

pub fn draw(self: *const Self) void {
    switch (self.current_screen) {
        .unknown => unreachable,
        inline else => |screen| screen.draw(),
    }

    // Draw full screen rectangle in front of everything
    if (self.transition.active)
        self.transition.draw();

    // rl.DrawFPS(10, 10);
}

// --------------------------------------------------- screen change/transition

/// Change to next screen, no transition. This is called by transition.toScreen()
/// when the transition is mid-way and everything is black.
/// This can be called directly as a direct replacement transition.toScreen() to
/// provide instant changes of screen without the transition fade out/fade in.
pub fn changeToScreen(self: *Self, screen: ScreenTag) void {
    // Unload current screen
    switch (self.current_screen) {
        .unknown => unreachable,
        inline else => |*current_screen| current_screen.deinit(),
    }

    // Init next screen
    self.current_screen = switch (screen) {
        .logo => .{ .logo = LogoScreen.init() },
        .title => .{ .title = TitleScreen.init(self.fx_coin, self.font) },
        .options => .{ .options = OptionsScreen.init() },
        .gameplay => .{ .gameplay = GameplayScreen.init(self.fx_coin, self.font) },
        .ending => .{ .ending = EndingScreen.init(self.fx_coin, self.font) },

        .unknown => unreachable,
    };
}
