const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    // Build executables
    const lsz = buildExecutable(b, "lsz", "src/lsz.zig", target, optimize);
    const catz = buildExecutable(b, "catz", "src/catz.zig", target, optimize);

    // Install artifacts
    b.installArtifact(lsz);
    b.installArtifact(catz);

    // // Setup run command
    // setupRunCommand(b, lsz);
    // setupRunCommand(b, catz); // Added for 'catz' executable

    // // Setup unit tests
    // setupUnitTests(b, lsz);
    // setupUnitTests(b, catz); // Added for 'catz' executable
}

fn buildExecutable(b: *std.Build, name: []const u8, source_file: []const u8, target: std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode) *std.Build.Step.Compile {
    const mod = b.createModule(.{
        .root_source_file = b.path(source_file),
        .target = target,
        .optimize = optimize,
    });

    return b.addExecutable(.{
        .name = name,
        .root_module = mod,
    });
}

// fn setupRunCommand(b: *std.Build, executable: *std.Build.Step.Compile) void {
//     const run_cmd = b.addRunArtifact(executable);
//     run_cmd.step.dependOn(b.getInstallStep());

//     if (b.args) |args| {
//         run_cmd.addArgs(args);
//     }

//     const run_step = b.step("run." ++ executable.name, "Run the " ++ executable.name ++ " app");
//     run_step.dependOn(&run_cmd.step);
// }

// fn setupUnitTests(b: *std.Build, executable: *std.Executable) void {
//     const unit_tests = b.addTest(.{
//         .root_module = executable.root_module,
//         .name = executable.name ++ "_tests",
//         // Optional: you can specify other test parameters here if needed.
//     });

//     const run_tests_cmd = b.addRunArtifact(unit_tests);
    
//     const test_step = b.step("test." ++ executable.name, "Run unit tests for " ++ executable.name);
//     test_step.dependOn(&run_tests_cmd.step);
// }
