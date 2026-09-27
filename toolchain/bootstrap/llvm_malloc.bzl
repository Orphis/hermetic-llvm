"""Allocator choices for the source-built LLVM binaries (stage1 to stage3).

Kept free of load() dependencies so //config can use it without fetching
@llvm-project.
"""

# musl's allocator does not scale with threads: multithreaded lld and ThinLTO
# links spend most of their time in the kernel. Every bootstrap stage uses the
# same allocator, so the instrumented stage2 records the FDO profile with the
# allocator stage3 ships with.
LLVM_MALLOC_DEFAULT = "mimalloc"

LLVM_MALLOC = {
    # Resolves to the system allocator on targets mimalloc is not wired for.
    "mimalloc": Label("//toolchain/bootstrap:mimalloc"),
    "system": None,
}
