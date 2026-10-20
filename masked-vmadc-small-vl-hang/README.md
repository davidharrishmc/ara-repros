# Masked vmadc/vmsbc with vl < NrLanes hangs (one cause of #495)

Issue: [pulp-platform/ara#495](https://github.com/pulp-platform/ara/issues/495)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`); `ara-main-fix.txt` is Ara main with `fix.patch`.
Note: `masked-vmadc-small-vl-hang` matches Spike with its `fix.patch` together with the fix for #528 (`ara-main-fix.txt`); `ara-main-fix-mc1-only.txt` is the output with this patch alone.
