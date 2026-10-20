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
| [cmp-tail-zeros](cmp-tail-zeros/) | [pulp-platform/ara#528](https://github.com/pulp-platform/ara/issues/528) |
| [fflags-stale](fflags-stale/) | [pulp-platform/ara#523](https://github.com/pulp-platform/ara/issues/523) |
| [fredminmax-nan-neutral](fredminmax-nan-neutral/) | [pulp-platform/ara#525](https://github.com/pulp-platform/ara/issues/525) |
| [gather-vs2-raw](gather-vs2-raw/) | [pulp-platform/ara#527](https://github.com/pulp-platform/ara/issues/527) |
| [indexed-vd-index-overlap](indexed-vd-index-overlap/) | [pulp-platform/ara#530](https://github.com/pulp-platform/ara/issues/530) |
| [masked-fcmp-nv](masked-fcmp-nv/) | [pulp-platform/ara#536](https://github.com/pulp-platform/ara/issues/536) |
| [masked-vstart-mask-entries](masked-vstart-mask-entries/) | [pulp-platform/ara#529](https://github.com/pulp-platform/ara/issues/529) |
| [reduction-tags-emul-group](reduction-tags-emul-group/) | [pulp-platform/ara#532](https://github.com/pulp-platform/ara/issues/532) |
| [segment-reshuffle-microop](segment-reshuffle-microop/) | [pulp-platform/ara#534](https://github.com/pulp-platform/ara/issues/534) |
| [segment-rs2-x8-v8](segment-rs2-x8-v8/) | [pulp-platform/ara#535](https://github.com/pulp-platform/ara/issues/535) |
| [segstore-field-eew](segstore-field-eew/) | [pulp-platform/ara#538](https://github.com/pulp-platform/ara/issues/538) |
| [vcompress-vs1-illegal](vcompress-vs1-illegal/) | [pulp-platform/ara#537](https://github.com/pulp-platform/ara/issues/537) |
| [vlmax-shortcut-partial-write](vlmax-shortcut-partial-write/) | [pulp-platform/ara#531](https://github.com/pulp-platform/ara/issues/531) |
| [vrgather-vi-uimm](vrgather-vi-uimm/) | [pulp-platform/ara#526](https://github.com/pulp-platform/ara/issues/526) |
| [vslidedown-past-vlmax](vslidedown-past-vlmax/) | [pulp-platform/ara#533](https://github.com/pulp-platform/ara/issues/533) |
| [widening-snan-nv](widening-snan-nv/) | [pulp-platform/ara#524](https://github.com/pulp-platform/ara/issues/524) |
