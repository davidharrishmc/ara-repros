# Ara reproducers

Standalone reproducers for [pulp-platform/ara](https://github.com/pulp-platform/ara) issues, one directory
per issue. Each directory has the probe body (`repro.S`), the shared harness (`harness.S`, `link.ld`,
`data.inc`) and a `Makefile`, prebuilt ELFs for the Ara testbench (`repro.elf`) and for Spike
(`repro-spike.elf`), the outputs of Spike (`spike.txt`) and of Ara main 34bd3bc with `nr_lanes=4 vlen=512`
(`ara-main.txt`), and, where a fix exists, `fix.patch` (against Ara main 34bd3bc) and the output with it
(`ara-main-fix.txt`).

The harness initializes byte i of vN to N*16 + i, runs the probe, and prints each register the probe
dumps (`DUMP n`) or each GPR it prints (`XDUMP r`); a trap prints `TRAP mcause=... mepc=...` and resumes
after the trapping instruction.

| Directory | Issue |
| --------- | ----- |
| [cmp-tail-zeros](cmp-tail-zeros/) | (pending) |
| [fflags-stale](fflags-stale/) | (pending) |
| [fredminmax-nan-neutral](fredminmax-nan-neutral/) | (pending) |
| [gather-vs2-raw](gather-vs2-raw/) | (pending) |
| [indexed-vd-index-overlap](indexed-vd-index-overlap/) | (pending) |
| [masked-fcmp-nv](masked-fcmp-nv/) | (pending) |
| [masked-vstart-mask-entries](masked-vstart-mask-entries/) | (pending) |
| [reduction-tags-emul-group](reduction-tags-emul-group/) | (pending) |
| [segment-reshuffle-microop](segment-reshuffle-microop/) | (pending) |
| [segment-rs2-x8-v8](segment-rs2-x8-v8/) | (pending) |
| [segstore-field-eew](segstore-field-eew/) | (pending) |
| [vcompress-vs1-illegal](vcompress-vs1-illegal/) | (pending) |
| [vlmax-shortcut-partial-write](vlmax-shortcut-partial-write/) | (pending) |
| [vrgather-vi-uimm](vrgather-vi-uimm/) | (pending) |
| [vslidedown-past-vlmax](vslidedown-past-vlmax/) | (pending) |
| [widening-snan-nv](widening-snan-nv/) | (pending) |
