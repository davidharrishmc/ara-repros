// FS = Off, then vfadd.vv (must trap, FS must stay Off), read mstatus.FS; vfmv.f.s (must trap).
  vsetivli x0, 1, e32, m1, ta, ma
  li t0, 3 << 13
  csrc mstatus, t0
  csrr a0, mstatus
  srli a0, a0, 13
  andi a0, a0, 3
  XDUMP a0
  vfadd.vv v2, v3, v4
  csrr a0, mstatus
  srli a0, a0, 13
  andi a0, a0, 3
  XDUMP a0
  vfmv.f.s fa0, v1
  li a0, 0x600d
  XDUMP a0
