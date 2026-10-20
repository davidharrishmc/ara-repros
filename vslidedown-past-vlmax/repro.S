// vslidedown.vx at e8, m1 (VLMAX = 64), vl = 8, tu: vd[i] = vs2[i + OFFSET] for i + OFFSET < VLMAX,
// else 0. Harness init: vN byte i = N*16 + i (v24 = 80 81 82 ..., v25 = 90 91 92 ...).
// OFFSET 60: elements 0-3 = bc bd be bf, elements 4-7 = 0 (Ara reads v25: 90 91 92 93).
// OFFSET 65536: elements 0-7 = 0 (Ara: the offset wraps to 0 and copies 80 81 ... 87).
// Bytes 8-63 are the tail and keep their old values.
  vsetivli t0, 8, e8, m1, tu, mu
  li s1, 60
  vslidedown.vx v8, v24, s1
  DUMP 8
  li s1, 65536
  vslidedown.vx v11, v24, s1
  DUMP 11
