// vcompress.vm at e8, m2, vl=4 with the mask in v1 (an odd register: vs1 is a single mask
// register, not a group, so it need not be a multiple of LMUL). All 4 elements selected.
// Expected: no trap, v4 bytes 0..3 = v2 bytes 0..3 (20 21 22 23), rest of v4 unchanged.
  vsetvli t0, x0, e8, m1, ta, ma
  vmv.v.i v1, -1
  vsetivli t0, 4, e8, m2, tu, mu
  vcompress.vm v4, v2, v1
  DUMP 4
