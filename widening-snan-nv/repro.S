// Widening FP ops with a signaling-NaN input must raise NV (fflags bit 4 = 0x10).
// x lines: fflags then result, for vfadd.vv (control), vfwadd.vv and vfwmul.vv (e32 -> e64),
// each with one sNaN operand and vl = 1.
// Expected (Spike): fflags 0x10 after every one. Ara main: 0x00 after the widening ops.
// fflags is read after vmv.x.s of the result, so the instruction has completed.
  vsetivli t0, 1, e32, mf2, tu, mu
  li t2, 0x7f800001                   # FP32 sNaN
  fmv.w.x f1, t2
  li t2, 0x3f800000                   # 1.0
  fmv.w.x f2, t2
  vfmv.v.f v2, f1
  vfmv.v.f v3, f2
  csrwi fflags, 0
  vfadd.vv v6, v2, v3
  vmv.x.s s3, v6
  csrr s1, fflags
  XDUMP s1
  XDUMP s3
  csrwi fflags, 0
  vfwadd.vv v4, v2, v3
  vsetivli t0, 1, e64, m1, tu, mu
  vmv.x.s s3, v4
  csrr s1, fflags
  XDUMP s1
  XDUMP s3
  vsetivli t0, 1, e32, mf2, tu, mu
  csrwi fflags, 0
  vfwmul.vv v8, v2, v3
  vsetivli t0, 1, e64, m1, tu, mu
  vmv.x.s s3, v8
  csrr s1, fflags
  XDUMP s1
  XDUMP s3
