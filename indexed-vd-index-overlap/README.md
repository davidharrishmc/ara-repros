# Indexed loads whose destination overlaps the lowest register of a wider index group load from wrong addresses

Issue: [pulp-platform/ara#530](https://github.com/pulp-platform/ara/issues/530)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`); `ara-main-fix.txt`, where present, is Ara main with `fix.patch`.
