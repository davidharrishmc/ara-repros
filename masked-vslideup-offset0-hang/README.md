# Masked vslideup by 0 with vl < NrLanes*64 hangs (one cause of #495)

Issue: [pulp-platform/ara#495](https://github.com/pulp-platform/ara/issues/495)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`); `ara-main-fix.txt` is Ara main with `fix.patch`.
