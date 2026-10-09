const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const upstream = b.dependency("upstream", .{
        .target = target,
        .optimize = optimize,
        .raudio = true,
        .rmodels = false,
        .rshapes = true,
        .rtext = true,
        .rtextures = true,
    });

    const raylib = b.addTranslateC(.{
        .root_source_file = b.path("src/rl.h"),
        .target = target,
        .optimize = optimize,
    });
    raylib.addIncludePath(upstream.path("src"));

    const exe_mod = b.createModule(.{
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .imports = &.{
            .{ .name = "raylib", .module = raylib.createModule() },
        },
    });
    const exe = b.addExecutable(.{
        .name = "raylib-game-template",
        .root_module = exe_mod,
    });

    exe_mod.linkLibrary(upstream.artifact("raylib"));
    exe_mod.addAnonymousImport("mecha.png", .{ .root_source_file = b.path("assets/mecha.png") });
    exe_mod.addAnonymousImport("ambient.ogg", .{ .root_source_file = b.path("assets/ambient.ogg") });
    exe_mod.addAnonymousImport("coin.wav", .{ .root_source_file = b.path("assets/coin.wav") });

    if (target.result.os.tag == .windows)
        exe_mod.addWin32ResourceFile(.{ .file = b.path("src/raylib_game.rc"), .flags = &.{} });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    run_cmd.addPassthruArgs();

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
