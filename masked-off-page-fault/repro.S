// Masked-off (inactive) elements must not raise exceptions. Sv39 in S-mode: identity map, except that the
// 4 KiB page 0x80201000 is invalid (V = 0). Each access below has only inactive elements on that page.
// Expected: no trap. A trap prints TRAP mcause=... (13 = load page fault, 15 = store page fault).
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
  // data: words 0x11111111.. at 0x80200000 and 0x80200ff8
  li   t0, 0x80200000
  li   t1, 0x11111111
  sw   t1, 0(t0)
  li   t1, 0x22222222
  sw   t1, 8(t0)
  li   t0, 0x80200ff8
  li   t1, 0x33333333
  sw   t1, 0(t0)
  li   t1, 0x44444444
  sw   t1, 4(t0)
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
  // S-mode. Mask v0 = 0b0011: elements 0, 1 active, 2, 3 inactive.
  li   t0, 3
  vsetivli x0, 1, e8, m1, tu, mu
  vmv.s.x v0, t0
  // unit stride: elements 0, 1 at 0x80200ff8/0x80200ffc (valid), 2, 3 at 0x80201000/0x80201004 (invalid page)
  li   a0, 0x80200ff8
  vsetivli x0, 4, e32, m1, tu, mu
  vle32.v v8, (a0), v0.t
  DUMP 8
  li   a0, 0x80200ff8
  vse32.v v8, (a0), v0.t
  // strided, stride 4 KiB: element 0 at 0x80200000 (valid), element 1 at 0x80201000 (invalid), element 2 at
  // 0x80202000 (valid). Mask 0b101: element 1 inactive.
  li   t0, 5
  vsetivli x0, 1, e8, m1, tu, mu
  vmv.s.x v0, t0
  li   a0, 0x80200000
  li   a1, 0x1000
  vsetivli x0, 3, e32, m1, tu, mu
  vlse32.v v9, (a0), a1, v0.t
  DUMP 9
  li   a0, 0x80200000
  li   a1, 0x1000
  vsse32.v v9, (a0), a1, v0.t
  li   a0, 0x600d
  XDUMP a0
