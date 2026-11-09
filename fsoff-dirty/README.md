# CVA6 + Ara: a vector FP instruction that traps because mstatus.FS = Off still sets FS to Dirty

Issue: [openhwfoundation/cva6#3725](https://github.com/openhwfoundation/cva6/issues/3725)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`), whose CVA6 is the pulp-platform fork at `pulp-v2.0.0-alpha.1` (99eac9a6).
