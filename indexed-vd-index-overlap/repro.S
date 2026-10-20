// vluxei16.v v8, (t1), v8 at e8, m1, vl=4, tu: the 16-bit index group is v8..v9 (EMUL=2) and the
// 8-bit destination v8 (EMUL=1) overlaps its lowest-numbered register, which RVV 1.0 allows.
// Indices idx[i] = 5i+3. Expected (Spike): v8[i] = data[idx[i]] for i < 4, bytes 4..63 of v8
// unchanged. With vd = v4 instead of v8, Ara main matches Spike.
  j 2f
  .p2align 3
1:
  .set ii, 0
  .rept 64
  .half (ii*5 + 3) & 0xff
  .set ii, ii+1
  .endr
2:
  la t2, 1b
  la t1, data
  vsetvli t0, x0, e16, m2, ta, ma
  vle16.v v8, (t2)
  li s3, 4
  vsetvli t0, s3, e8, m1, tu, mu
  vluxei16.v v8, (t1), v8
  DUMP 8
