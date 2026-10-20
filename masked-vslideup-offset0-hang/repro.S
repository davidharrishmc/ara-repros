// Masked vslideup.vx by OFFSET = 0 at e8, mf2, vl = 11, tu, mu, v0 = 5a 5a ...: vd[i] = vs2[i]
// where mask bit i is set, else unchanged. Then store vd (vs1r.v in DUMP).
// Expected (Spike) v14 = e0 41 e2 43 44 e5 46 e7 e8 49 ea | eb ec ...; Ara never completes the
// vslideup, and the store of v14 waits for it forever (simulation timeout).
  li s3, 11
  li t0, 0x5a
  vsetvli t1, x0, e8, m1, ta, ma
  vmv.v.x v0, t0
  vsetvli t1, s3, e8, mf2, tu, mu
  li s1, 0
  vslideup.vx v14, v4, s1, v0.t
  DUMP 14
