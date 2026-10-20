// vfredmin.vs / vfredmax.vs whose operands (vs1[0] and all active vs2 elements) are all quiet NaNs
// must return the canonical NaN (0x7fc00000 / 0x7ff8000000000000), with no flags.
// x lines: result, then fflags, for vfredmin and vfredmax at e32 vl=3, e32 vl=16 (VLMAX) and e64 vl=3.
// Expected (Spike): canonical NaN, fflags 0. Ara main: +inf for vfredmin, -inf for vfredmax.
  li t2, 0x7fc00000
  fmv.w.x f1, t2
  vsetvli t0, x0, e32, m1, ta, ma
  vfmv.v.f v2, f1
  vsetivli t0, 3, e32, m1, ta, ma
  csrwi fflags, 0
  vfredmin.vs v4, v2, v2
  vfmv.f.s f10, v4
  fmv.x.w a0, f10
  csrr s1, fflags
  XDUMP a0
  XDUMP s1
  vfredmax.vs v5, v2, v2
  vfmv.f.s f10, v5
  fmv.x.w a0, f10
  csrr s1, fflags
  XDUMP a0
  XDUMP s1
  vsetvli t0, x0, e32, m1, ta, ma
  vfredmin.vs v6, v2, v2
  vfmv.f.s f10, v6
  fmv.x.w a0, f10
  csrr s1, fflags
  XDUMP a0
  XDUMP s1
  vfredmax.vs v7, v2, v2
  vfmv.f.s f10, v7
  fmv.x.w a0, f10
  csrr s1, fflags
  XDUMP a0
  XDUMP s1
  li t2, 0x7ff8000000000000
  fmv.d.x f2, t2
  vsetivli t0, 3, e64, m1, ta, ma
  vfmv.v.f v8, f2
  vfredmin.vs v9, v8, v8
  vfmv.f.s f10, v9
  fmv.x.d a0, f10
  csrr s1, fflags
  XDUMP a0
  XDUMP s1
  vfredmax.vs v10, v8, v8
  vfmv.f.s f10, v10
  fmv.x.d a0, f10
  csrr s1, fflags
  XDUMP a0
  XDUMP s1
