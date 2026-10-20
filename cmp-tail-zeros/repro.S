// Mask-producing compares / vmadc with vl < VLMAX into a destination that holds all 1s.
// Mask destination tails are always agnostic: each tail bit must stay 1 (old value) or be
// written with 1, so the whole tail must read as 1s.
// 1) vmseq.vv v8 / vmadc.vv v9 at e8, m1, vl=10: expected byte 0 = 00, byte 1 = fc
//    (bits 8, 9 = 0 results; bits 10..15 = 1), bytes 2.. = ff.
// 2) vmseq.vv v8 at e8, m8, vl=283 (tail starts in the 2nd VRF word of mask bits): expected
//    bytes 0..34 = 00, byte 35 = f8 (bits 283..287 = 1), bytes 36.. = ff.
  vsetvli t0, x0, e8, m1, ta, ma
  vmv.v.i v8, -1
  vmv.v.i v9, -1
  vmv.v.i v1, 1
  vmv.v.i v2, 2
  vsetivli t0, 10, e8, m1, ta, ma
  vmseq.vv v8, v1, v2
  vmadc.vv v9, v1, v2
  DUMP 8
  DUMP 9
  vsetvli t0, x0, e8, m8, ta, ma
  vmv.v.i v16, 1
  vmv.v.i v24, 2
  vsetvli t0, x0, e8, m1, ta, ma
  vmv.v.i v8, -1
  li s3, 283
  vsetvli t0, s3, e8, m8, ta, ma
  vmseq.vv v8, v16, v24
  DUMP 8
