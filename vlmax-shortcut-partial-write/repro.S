// With vl = VLMAX, Ara skips the reshuffle of a vd register whose EEW differs, assuming every vd
// element is overwritten. Here each vd holds e8 data (harness init) and is written at e32 m1,
// vl = VLMAX = 16, tu, mu. Elements the instruction does not write must keep their old value:
// v8: masked vadd.vv (v0 = 0x55..): inactive elements 1, 3, 5, 7, 9, 11, 13, 15 unchanged
// v9: vredsum.vs: element 0 = sum, elements 1..15 (tail) unchanged
// v10: vslideup.vi by 8: elements 0..7 unchanged, elements 8..15 = v16[0..7]
  li t2, 0x55
  vsetvli t0, x0, e8, m1, ta, ma
  vmv.v.x v0, t2
  vsetvli t0, x0, e32, m1, tu, mu
  vadd.vv v8, v16, v24, v0.t
  vredsum.vs v9, v16, v24
  vslideup.vi v10, v16, 8
  DUMP 8
  DUMP 9
  DUMP 10
