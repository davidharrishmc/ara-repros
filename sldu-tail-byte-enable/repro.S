// vslidedown.vx at e8, m2 (VLMAX = 128), vl = 33, OFFSET = 1, tu: vd[i] = vs2[i+1] for i < 33;
// the tail (elements 33-127) keeps its old values. Harness init: vN byte i = N*16 + i, so
// v16 = 00 01 02 ..., v8 = 80 81 82 ... Elements 0-31 sit in the first 32-byte VRF word
// (NrLanes = 4), element 32 in the second. Expected v8 bytes 33-63 = a1 a2 ... bf (unchanged);
// Ara overwrites them with vs2[34..64] = 22 23 ... 40.
  vsetvli t0, x0, e8, m2, tu, mu
  li s3, 33
  vsetvli t0, s3, e8, m2, tu, mu
  li s1, 1
  vslidedown.vx v8, v16, s1
  DUMP 8
  DUMP 9
