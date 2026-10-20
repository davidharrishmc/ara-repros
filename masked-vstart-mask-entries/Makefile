# Build the reproducer for the Ara testbench (repro.elf) and for Spike (repro-spike.elf), and run them.
# ARA_SIM: path to Vara_tb_verilator (Ara: make -C hardware verilate nr_lanes=4 vlen=512).
CC      ?= riscv64-unknown-elf-gcc
ARA_SIM ?= Vara_tb_verilator
CFLAGS  := -march=rv64gcv -mabi=lp64d -nostdlib -nostartfiles -T link.ld -I. \
           -DDATAINC='"data.inc"' -DBODY='"repro.S"'

all: repro.elf repro-spike.elf
repro.elf: harness.S repro.S data.inc link.ld
	$(CC) $(CFLAGS) -o $@ harness.S
repro-spike.elf: harness.S repro.S data.inc link.ld
	$(CC) $(CFLAGS) -DSPIKE -o $@ harness.S
run-spike: repro-spike.elf
	spike --isa=rv64gcv_zvl512b repro-spike.elf
run-ara: repro.elf
	$(ARA_SIM) -l ram,$(abspath repro.elf),elf | grep -E '^(v[0-9]+|x|TRAP|DONE)'
.PHONY: all run-spike run-ara
