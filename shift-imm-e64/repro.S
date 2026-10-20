// Shift immediates are unsigned (uimm). At SEW=64 (and for narrowing shifts from 2*SEW=64) an
// immediate of 16..31 must shift by 16..31. Ara main sign-extends it to 6 bits and shifts by imm+32.
// vsll/vsra/vsrl/vssrl/vssra.vi at e64 m1, then vnsrl/vnsra.wi at e32 mf2 from e64; vl = VLMAX.
  la s4, data
  vsetvli t0, x0, e64, m1, ta, ma
  vle64.v v14, (s4)
  vsll.vi v1, v14, 19
  DUMP 1
  vsra.vi v2, v14, 31
  DUMP 2
  vsrl.vi v3, v14, 16
  DUMP 3
  vssrl.vi v5, v14, 17
  DUMP 5
  vssra.vi v6, v14, 30
  DUMP 6
  vsetvli t0, x0, e32, mf2, ta, ma
  vnsrl.wi v7, v14, 20
  DUMP 7
  vnsra.wi v9, v14, 24
  DUMP 9
