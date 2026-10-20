# vslidedown reads past VLMAX (next registers, wrapped VRF address) instead of returning 0

Issue: [pulp-platform/ara#533](https://github.com/pulp-platform/ara/issues/533)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`); `ara-main-fix.txt`, where present, is Ara main with `fix.patch`.
