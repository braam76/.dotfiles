const std = @import("std");

pub fn main() !void {
    const cwd = std.fs.cwd();

    var gpa = std.heap.GeneralPurposeAllocator(.{ .thread_safe = true }){};
    const allocator = gpa.allocator();
    defer _ = gpa.deinit();

    // For reading arguments
    const args = try std.process.argsAlloc(allocator);
    defer std.process.argsFree(allocator, args);

    if (args.len < 2) {
        std.debug.print("Usage: {s} <directory> [other_directory] ...\n", .{args[0]});
        return;
    }

    const paths = args[1..];
    for (paths) |path| {
        std.debug.print("{s}:\n", .{path});

        const file = try cwd.openFile(path, .{});
        defer file.close();

        var buf_reader = std.io.bufferedReader(file.reader());
        const reader = buf_reader.reader();

        var line = std.ArrayList(u8).init(allocator);
        defer line.deinit();

        var writer = line.writer();
        while (reader.streamUntilDelimiter(writer, '\n', null)) {
            defer line.clearRetainingCapacity();
            std.debug.print("{s}\n", .{line.items});
            writer = line.writer();
        } else |err| switch (err) {
            error.EndOfStream => { // end of file
                if (line.items.len > 0) {
                    std.debug.print("{s}\n", .{line.items});
                }
            },
            else => return err, // Propagate error
        }
    }
}
