// Strided and indexed segment loads whose stride register is x8 or whose index register is v8
// (rs2 field = 01000) run as one-field loads on Ara: field 1 (v17, v21) is never written.
// Expected (Spike): v16[i] = data[3i], v17[i] = data[3i+1] (vlsseg2e8, stride 3 in x8);
//                   v20[i] = data[2i], v21[i] = data[2i+1] (vluxseg2ei8, offsets 2i in v8).
  j 2f
  .p2align 3
1:
  .set ii, 0
  .rept 64
  .byte ii*2
  .set ii, ii+1
  .endr
2:
  la t2, 1b
  la t1, data
  li x8, 3
  vsetvli t0, x0, e8, m1, ta, ma
  vlsseg2e8.v v16, (t1), x8
  vle8.v v8, (t2)
  vluxseg2ei8.v v20, (t1), v8
  DUMP 16
  DUMP 17
  DUMP 20
  DUMP 21
