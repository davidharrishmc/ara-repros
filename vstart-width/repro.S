// vstart writable width at VLEN=512: max VLMAX = 512, so vstart holds 9 bits (0..511).
  li t0, -1
  csrw vstart, t0
  csrr a0, vstart
  XDUMP a0
  li t0, 512
  csrw vstart, t0
  csrr a0, vstart
  XDUMP a0
  csrw vstart, x0
