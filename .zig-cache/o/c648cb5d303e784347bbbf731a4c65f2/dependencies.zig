pub const packages = struct {
    pub const @"12202097d817adcf30a420dfb63266dd3402de94a1012736204749fdd76f41d37bd0" = struct {
        pub const build_root = "c:\\Projects\\raylib-game-template-zig\\raylib";
        pub const build_zig = @import("12202097d817adcf30a420dfb63266dd3402de94a1012736204749fdd76f41d37bd0");
        pub const deps: []const struct { []const u8, []const u8 } = &.{};
    };
};

pub const root_deps: []const struct { []const u8, []const u8 } = &.{
    .{ "raylib", "12202097d817adcf30a420dfb63266dd3402de94a1012736204749fdd76f41d37bd0" },
};
