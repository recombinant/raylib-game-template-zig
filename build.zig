const std = @import("std");

pub fn build(b: *std.Build) !void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    const raylib = try @import("raylib").addRaylib(b, target, optimize, .{
        .raudio = true,
        .rmodels = false,
        .rshapes = true,
        .rtext = true,
        .rtextures = true,
    });

    const exe = b.addExecutable(.{
        .name = "raylib-game-template-main",
        .root_source_file = b.path("src/main.zig"),
        .target = target,
        .optimize = optimize,
        .link_libc = true,
    });
    exe.linkLibrary(raylib);

    exe.addWin32ResourceFile(.{ .file = b.path("src/raylib_game.rc"), .flags = &.{} });

    b.installArtifact(exe);

    const run_cmd = b.addRunArtifact(exe);
    run_cmd.step.dependOn(b.getInstallStep());
    if (b.args) |args| {
        run_cmd.addArgs(args);
    }

    const run_step = b.step("run", "Run the app");
    run_step.dependOn(&run_cmd.step);
}
