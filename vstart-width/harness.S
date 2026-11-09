// Differential probe harness: run the same body on Spike and Ara and diff the dumps.
// DUMP vN prints the whole register (VLEN/8 bytes, byte 0 first) after the body runs it.
#define VLENB 64
  .section .text.init,"ax",@progbits
  .globl _start
_start:
  la   sp, __stack_top
  li   t0, (1 << 13) | (1 << 9)
  csrs mstatus, t0
  la   t0, trap
  csrw mtvec, t0
  csrwi vxrm, 0
#ifndef NOINIT
  // deterministic register file: vN byte i = N*16 + i (mod 256), all at EEW8. Loaded from a
  // table rather than computed with vid.v, which hangs stock Ara main (pulp-platform/ara#437).
  la   t1, init_tab
  .irp n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
  vl1re8.v v\n, (t1)
  addi t1, t1, VLENB
  .endr
#endif
  j body

.macro DUMP n
  la   t1, dumpbuf
  vs1r.v v\n, (t1)
  li   a0, \n
  call dumpreg
.endm

.macro XDUMP r
  mv   s5, \r
  la   a1, str_x
  call puts
  mv   a0, s5
  call puthex
  la   a1, str_nl
  call puts
.endm

dumpreg:                               // print "vN: " then VLENB bytes from dumpbuf
  mv   s7, ra
  mv   s8, a0
  la   a1, str_v
  call puts
  mv   a0, s8
  call putdec
  la   a1, str_colon
  call puts
  la   s9, dumpbuf
  li   s10, VLENB
1:
  lbu  a0, 0(s9)
  call puthex2
  addi s9, s9, 1
  addi s10, s10, -1
  bnez s10, 1b
  la   a1, str_nl
  call puts
  mv   ra, s7
  ret

  .p2align 2
trap:
  csrr s2, mcause
  la   a1, str_trap
  call puts
  mv   a0, s2
  call puthex
  la   a1, str_at
  call puts
  csrr a0, mepc
  call puthex
  la   a1, str_nl
  call puts
  csrr t6, mepc
  addi t6, t6, 4
  csrw mepc, t6
  mret

puts:
  mv   a6, ra
1:
  lbu  a3, 0(a1)
  beqz a3, 2f
  jal  a7, putc
  addi a1, a1, 1
  j    1b
2:
  jr   a6

puthex2:                               // print a0[7:0] as 2 hex digits
  mv   a6, ra
  li   a4, 4
  j    3f
puthex:
  mv   a6, ra
  li   a4, 60
3:
  srl  a3, a0, a4
  andi a3, a3, 0xf
  li   a5, 10
  blt  a3, a5, 4f
  addi a3, a3, 'a' - 10
  j    5f
4:
  addi a3, a3, '0'
5:
  jal  a7, putc
  addi a4, a4, -4
  bgez a4, 3b
  jr   a6

putdec:
  mv   a6, ra
  addi sp, sp, -32
  mv   a2, sp
  li   a5, 10
1:
  remu a3, a0, a5
  addi a3, a3, '0'
  sb   a3, 0(a2)
  addi a2, a2, 1
  divu a0, a0, a5
  bnez a0, 1b
2:
  addi a2, a2, -1
  lbu  a3, 0(a2)
  jal  a7, putc
  bne  a2, sp, 2b
  addi sp, sp, 32
  jr   a6

#ifdef SPIKE
putc:
  la   t3, tohost
1:
  ld   t5, 0(t3)
  bnez t5, 1b
  li   t5, 0x0101000000000000
  or   t5, t5, a3
  sd   t5, 0(t3)
  jr   a7
finish:
  la   a1, str_done
  call puts
  la   t3, tohost
1:
  ld   t5, 0(t3)
  bnez t5, 1b
  li   t5, 1
  sd   t5, 0(t3)
2:
  j    2b
  .section .tohost,"aw",@progbits
  .p2align 6
  .globl tohost
tohost: .dword 0
  .globl fromhost
fromhost: .dword 0
#else
putc:
  li   t5, 0xC0000000
  sb   a3, 0(t5)
  jr   a7
finish:
  la   a1, str_done
  call puts
  li   t5, 0xD0000000
  sd   zero, 0(t5)
1:
  j    1b
#endif

  .section .rodata
str_v: .asciz "v"
str_x: .asciz "x: "
str_colon: .asciz ": "
str_nl: .asciz "\n"
str_trap: .asciz "TRAP mcause="
str_at: .asciz " mepc="
str_done: .asciz "DONE\n"
  .section .data
  .p2align 6
init_tab:
  .irp n,0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31
  .set ii, 0
  .rept VLENB
  .byte ((\n*16) + ii) & 0xff
  .set ii, ii + 1
  .endr
  .endr
  .section .data
  .p2align 6
dumpbuf: .space 512
  .p2align 6
data: .include DATAINC

  .section .text
body:
#include BODY
  j finish
