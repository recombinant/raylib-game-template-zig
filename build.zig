const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
    });
    const exe = b.addExecutable(.{
        .name = "raylib-game-template",
        .root_module = exe_mod,
    });

    const raylib = b.dependency("raylib", .{
        .raudio = true,
        .rmodels = false,
        .rshapes = true,
        .rtext = true,
        .rtextures = true,
    });
    exe_mod.linkLibrary(raylib.artifact("raylib"));
    exe_mod.addAnonymousImport("mecha.png", .{ .root_source_file = b.path("assets/mecha.png") });
    exe_mod.addAnonymousImport("ambient.ogg", .{ .root_source_file = b.path("assets/ambient.ogg") });
    exe_mod.addAnonymousImport("coin.wav", .{ .root_source_file = b.path("assets/coin.wav") });

    if (target.result.os.tag == .windows)
        exe_mod.addWin32ResourceFile(.{ .file = b.path("src/raylib_game.rc"), .flags = &.{} });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
