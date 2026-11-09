# Masked-off elements of unit-stride and strided accesses raise page faults

Issue: (being filed)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`).

The probe runs its body in S-mode with Sv39 (identity map, page 0x80201000 invalid); the trap handler stays in M-mode.
