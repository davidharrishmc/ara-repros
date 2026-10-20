// vslideup.vx at e8, m1, vl = 33, OFFSET = 3, tu, immediately followed by a store of vd (the
// vs1r.v in DUMP): vd[i] = vs2[i-3] for 3 <= i < 33. Element 32 is the first byte of the second
// 32-byte VRF word (NrLanes = 4).
// Setup: v16 = 00 01 02 ... 3f (harness init). v8 = v16 - 3 at vl = 64 (byte j = j-3), then
// v8 += 0x40 at vl = 33, tu, so v8 = 3d 3e 3f 40 ... 5d | 1e 1f ... 3c. The tail bytes 33-63 thus
// already equal vs2[j-3], so a write of the tail would not show; only the body is checked.
// Expected v8 = 3d 3e 3f 00 01 ... 1c 1d | 1e ... 3c. Ara leaves element 32 at 5d.
  li s3, 64
  vsetvli t0, s3, e8, m1, tu, mu
  li s1, 3
  vsub.vx v8, v16, s1
  li s3, 33
  vsetvli t0, s3, e8, m1, tu, mu
  li s2, 0x40
  vadd.vx v8, v8, s2
  vslideup.vx v8, v16, s1
  DUMP 8
