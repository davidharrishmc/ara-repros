# Masked loads with vstart past the first VRF word leave stale MASKU mask entries for the next masked op, or hang

Issue: [pulp-platform/ara#529](https://github.com/pulp-platform/ara/issues/529)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`); `ara-main-fix.txt`, where present, is Ara main with `fix.patch`.
