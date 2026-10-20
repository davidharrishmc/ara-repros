OUTPUT_ARCH("riscv")
ENTRY(_start)
MEMORY { ram (rwx) : ORIGIN = 0x80000000, LENGTH = 0x100000 }
SECTIONS {
  .text.init 0x80000000 : { *(.text.init) } > ram
  .text . : { *(.text) *(.text.*) } > ram
  .rodata . : { *(.rodata) *(.rodata.*) } > ram
  .data . : { *(.data) *(.data.*) } > ram
  .tohost . : { *(.tohost) } > ram
  . = ALIGN(16);
  __stack_bottom = .;
  . += 0x4000;
  __stack_top = .;
}
