// vslide1up.vx at e8, m1, vl = 5, tu: vd[0] = x[rs1] = 5a, vd[i] = vs2[i-1] for 1 <= i < 5, and the
// tail (elements 5-63) keeps its old values. Harness init: vN byte i = N*16 + i, so v16 = 00 01 02 ...
// and v8 = 80 81 82 ... Expected v8 = 5a 00 01 02 03 | 85 86 ...; Ara also writes element 5 (= vs2[4] = 04).
  vsetivli t0, 5, e8, m1, tu, mu
  li s1, 0x5a
  vslide1up.vx v8, v16, s1
  DUMP 8
