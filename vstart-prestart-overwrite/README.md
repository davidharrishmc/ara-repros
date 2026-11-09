# vmv<nr>r.v and mask-logical instructions with vstart > 0 overwrite prestart elements

Issue: [pulp-platform/ara#549](https://github.com/pulp-platform/ara/issues/549)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`).
