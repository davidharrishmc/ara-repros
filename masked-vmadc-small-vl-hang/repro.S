// Masked vmadc.vvm (carry-in from v0) at e8, m1, vl=1, then a store that reads its vd (DUMP).
// Expected: v4 bit 0 = carry of 0x0d + 0x0d + 1 = 0, tail bits stay 1: v4 = fe ff ff ...
  vsetvli t0, x0, e8, m1, ta, ma
  vmv.v.i v0, 1
  vmv.v.i v12, 0xd
  vmv.v.i v30, 0xd
  vmv.v.i v4, -1
  vsetivli t0, 1, e8, m1, ta, ma
  vmadc.vvm v4, v12, v30, v0
  DUMP 4
