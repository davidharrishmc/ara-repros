// vrgather.vx right after the vle32.v that writes its source vs2 (e32, m2, vl=VLMAX=32, index 30).
// Expected: every element of v4..v5 = element 30 of the loaded data (bytes 120..123: 82 56 8b 96).
  la s4, data
  li s2, 30
  vsetvli t0, x0, e32, m2, ta, ma
  vle32.v v26, (s4)
  vrgather.vx v4, v26, s2
  DUMP 4
  DUMP 5
