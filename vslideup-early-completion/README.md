# vslideup with a non-word-aligned offset completes one VRF word early (#497 item 3)

Issue: [pulp-platform/ara#497](https://github.com/pulp-platform/ara/issues/497)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`); `ara-main-fix.txt` is Ara main with `fix.patch`.
Note: the reproducer matches Spike with this `fix.patch` together with the `fix.patch` of `../sldu-tail-byte-enable` (`ara-main-fix.txt`); `ara-main-fix-sl4-only.txt` is the output with this patch alone.
