// Reductions write only element 0 of vd, a single register whatever LMUL is. Ara tags the whole
// vd register group (EMUL) with the result EEW, so the registers after vd, which the reduction
// does not write, are relabelled without converting their data. vd already holds data at the
// result EEW (no reshuffle of vd); vd+1 holds e8 data (harness init) and must be unchanged.
// vwredsum.vs at e8 m1 (EEW16 result, EMUL 2): v8 = vd, v9 must be unchanged
// vfredmax.vs at e32 m2: v12 = vd, v13 must be unchanged
  la t1, data
  vsetvli t0, x0, e16, m1, ta, ma
  vle16.v v8, (t1)
  vsetvli t0, x0, e32, m1, ta, ma
  vle32.v v12, (t1)
  vsetvli t0, x0, e8, m1, tu, mu
  vwredsum.vs v8, v16, v24
  vsetvli t0, x0, e32, m2, tu, mu
  vfredmax.vs v12, v16, v24
  DUMP 8
  DUMP 9
  DUMP 13
