const std = @import("std");

pub fn main() !void {
    const cwd = std.fs.cwd();

    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    defer _ = gpa.deinit();

    const allocator = gpa.allocator();

    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.debug.print("Usage: {s} <directory> [other_directory] ...\n", .{args[0]});
        return;
    }

    const paths = args[1..];
    for (paths) |path| {
        std.debug.print("{s}:\n", .{path});

        var dir = try cwd.openDir(path, .{ .iterate = true });
        defer dir.close();

        var iter = dir.iterate();
        while (try iter.next()) |entry| {
            std.debug.print("   {s} ({s})\n", .{ 
                entry.name, 
                @tagName(entry.kind)
            });
        }
    }
}