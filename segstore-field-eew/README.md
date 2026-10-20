# Segment stores read fields 1..nf with the EEW of field 0: field registers written at another EEW are stored permuted

Issue: [pulp-platform/ara#538](https://github.com/pulp-platform/ara/issues/538)

Build with `make` (riscv64-unknown-elf-gcc); run with `make run-spike` and `make ARA_SIM=<path>/Vara_tb_verilator run-ara`. `spike.txt` and `ara-main.txt` are the outputs of Spike and of Ara main 34bd3bc (`nr_lanes=4 vlen=512`); `ara-main-fix.txt`, where present, is Ara main with `fix.patch`.
