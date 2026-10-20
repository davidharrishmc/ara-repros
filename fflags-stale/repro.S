// fflags/fcsr accesses right after a vector FP instruction must see that instruction's flags.
// 1.0 + 2^-24 at e32 is inexact (NX = 0x01). x lines:
//   1. csrr fflags right after vfadd.vv (vl = 8)                      expected 0x01
//   2. frcsr right after vfadd.vv                                     expected 0x01
//   3. csrr fflags after vmv.x.s of the result (instruction complete) expected 0x01
//   4. csrwi fflags, 0 right after vfadd.vv (vl = VLMAX at m8), read later: the clear comes
//      after the vfadd in program order, so its NX must not reappear  expected 0x00
// Ara main: 0x00, 0x00, 0x01, 0x01 (the flags arrive after the CSR access).
  vsetivli t0, 8, e32, m1, ta, ma
  li t2, 0x3f800000                   # 1.0
  fmv.w.x f1, t2
  li t2, 0x33800000                   # 2^-24
  fmv.w.x f2, t2
  vfmv.v.f v2, f1
  vfmv.v.f v3, f2
  csrwi fflags, 0
  vfadd.vv v4, v2, v3
  csrr a0, fflags
  XDUMP a0
  csrwi fflags, 0
  vfadd.vv v5, v2, v3
  frcsr a0
  XDUMP a0
  csrwi fflags, 0
  vfadd.vv v6, v2, v3
  vmv.x.s a3, v6
  csrr a0, fflags
  XDUMP a0
  vsetvli t0, x0, e32, m8, ta, ma
  vfmv.v.f v8, f1
  vfmv.v.f v16, f2
  vfadd.vv v24, v8, v16
  csrwi fflags, 0
  vmv.x.s a3, v24
  csrr a0, fflags
  XDUMP a0
