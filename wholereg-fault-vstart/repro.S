// A whole-register load that page-faults part-way must report vstart in elements of its encoded EEW.
// Sv39 in S-mode: identity map, except that the 4 KiB page 0x80201000 is invalid (V = 0).
// vl1re16.v and vl1re32.v from 0x80200ff8: bytes 0-7 are on a valid page, byte 8 is the first faulting byte.
// Expected: load page fault (mcause 13) and vstart = 4 (vl1re16.v) / 2 (vl1re32.v), the element holding byte 8.
  .section .data
  .p2align 12
pt_l2: .space 4096
pt_l1: .space 4096
pt_l0: .space 4096
  .section .text
  // root: GiB 2 (0x80000000) -> pt_l1; GiB 3 (0xC0000000, console and exit) -> identity gigapage
  la   t0, pt_l2
  la   t1, pt_l1
  srli t1, t1, 12
  slli t1, t1, 10
  ori  t1, t1, 1
  sd   t1, 16(t0)
  li   t1, ((0xC0000000 >> 12) << 10) | 0xcf
  sd   t1, 24(t0)
  // pt_l1: identity 2 MiB pages; entry 1 (0x80200000) -> pt_l0
  la   t0, pt_l1
  li   t1, ((0x80000000 >> 12) << 10) | 0xcf
  li   t2, (0x200000 >> 12) << 10
  li   t3, 512
1:
  sd   t1, 0(t0)
  add  t1, t1, t2
  addi t0, t0, 8
  addi t3, t3, -1
  bnez t3, 1b
  la   t0, pt_l1
  la   t1, pt_l0
  srli t1, t1, 12
  slli t1, t1, 10
  ori  t1, t1, 1
  sd   t1, 8(t0)
  // pt_l0: identity 4 KiB pages from 0x80200000; entry 1 (0x80201000) invalid
  la   t0, pt_l0
  li   t1, ((0x80200000 >> 12) << 10) | 0xcf
  li   t2, 1 << 10
  li   t3, 512
1:
  sd   t1, 0(t0)
  add  t1, t1, t2
  addi t0, t0, 8
  addi t3, t3, -1
  bnez t3, 1b
  la   t0, pt_l0
  sd   zero, 8(t0)
  // satp = Sv39, then mret to S-mode
  la   t0, pt_l2
  srli t0, t0, 12
  li   t1, 8 << 60
  or   t0, t0, t1
  csrw satp, t0
  sfence.vma
  li   t0, 3 << 11
  csrc mstatus, t0
  li   t0, 1 << 11
  csrs mstatus, t0
  la   t0, 1f
  csrw mepc, t0
  mret
1:
  li   a0, 0x80200ff8
  vl1re16.v v8, (a0)
  csrr a0, vstart          // expect 4
  XDUMP a0
  csrwi vstart, 0
  li   a0, 0x80200ff8
  vl1re32.v v8, (a0)
  csrr a0, vstart          // expect 2
  XDUMP a0
  csrwi vstart, 0
