// Masked vmfle.vv at e32, m1, vl=16, v0 = 0x05 in every byte (elements 0, 2, 8, 10 active).
// Case 1: vs2 holds a quiet NaN in the 12 INACTIVE elements and 1.0 in the active ones. vmfle
// signals invalid on a quiet NaN, but inactive elements do not set FP exception flags:
// expected fflags = 0 (first "x:" line).
// Case 2 (control): NaN in the ACTIVE elements: expected fflags = 0x10 (NV).
// fflags are read after DUMP (a store of the compare result) so that the compare has completed.
  li t1, 0x7fc00000
  li t2, 0x3f800000
  vsetvli t0, x0, e8, m1, ta, ma
  vmv.v.i v0, 5
  vsetvli t0, x0, e32, m1, tu, mu
  vmv.v.x v8, t2
  vmv.v.x v9, t1
  vmerge.vvm v10, v9, v8, v0
  vmerge.vvm v11, v8, v9, v0
  vmv.v.i v4, -1
  vmv.v.i v5, -1
  fsflagsi 0
  vmfle.vv v4, v10, v8, v0.t
  DUMP 4
  frflags s1
  XDUMP s1
  fsflagsi 0
  vmfle.vv v5, v11, v8, v0.t
  DUMP 5
  frflags s1
  XDUMP s1
