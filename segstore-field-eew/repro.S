// vsseg2e8.v v8, (s5) at e8 m1, vl = 16: field 0 = v8 (e8 data), field 1 = v9 holds e32 data.
// Reload the 32 stored bytes with vle8.v and dump them. Expected: even bytes = v8, odd bytes = the
// bytes of v9 in memory order (as stored by vle32.v).
  la s4, data
  la s5, data
  addi s5, s5, 512
  vsetvli t0, x0, e32, m1, ta, ma
  vle32.v v9, (s4)
  vsetivli t0, 16, e8, m1, ta, ma
  vsseg2e8.v v8, (s5)
  vsetvli t0, x0, e8, m1, ta, ma
  vle8.v v20, (s5)
  DUMP 20
