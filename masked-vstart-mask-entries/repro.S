// Masked vle8.v with vstart in the second VRF word (e8, m2, vl=41, vstart=40; one VRF word holds
// 32 e8 elements with NrLanes=4) leaves a mask entry behind in the MASKU, which the next masked
// load consumes. v0..v15 are all ones for the first load, so any mask bit it reads is 1; then
// v0 = 0x55.. and vle8.v v20 (vl=8, mu, vstart=0) must load only the even elements.
// Expected (Spike): v16[40] = data[40]; v20[0,2,4,6] = data[0,2,4,6], v20[1,3,5,7] unchanged.
  la s4, data
  vsetvli t0, x0, e8, m8, ta, ma
  vmv.v.i v0, -1
  vmv.v.i v8, -1
  li s3, 41
  vsetvli t0, s3, e8, m2, tu, mu
  li s2, 40
  csrw vstart, s2
  vle8.v v16, (s4), v0.t
  vsetvli t0, x0, e8, m1, ta, ma
  li s2, 0x55
  vmv.v.x v0, s2
  li s3, 8
  vsetvli t0, s3, e8, m1, tu, mu
  vle8.v v20, (s4), v0.t
  DUMP 16
  DUMP 20
