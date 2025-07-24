// import raylib header into zig
pub const rl = @cImport({
    @cInclude("raylib.h");
    // @cInclude("raymath.h");
    // @cInclude("rlgl.h");
});
