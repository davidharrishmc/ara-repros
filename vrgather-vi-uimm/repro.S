// vrgather.vi with an index of 16 or more (uimm, 5-bit unsigned) at e8 m1, vl = VLMAX = 64.
// Expected (Spike): every element of v10 = v24[16] = 0x90, v11 = v24[31] = 0x9f.
// vrgather.vx with x = 16 and vrgather.vi with index 15 are controls; Ara main completes them
// and then hangs at vrgather.vi v10, v24, 16 (the index is sign-extended to -16: out of range).
  vsetvli t0, x0, e8, m1, ta, ma
  li t1, 16
  vrgather.vx v8, v24, t1
  DUMP 8
  vrgather.vi v9, v24, 15
  DUMP 9
  vrgather.vi v10, v24, 16
  DUMP 10
  vrgather.vi v11, v24, 31
  DUMP 11
