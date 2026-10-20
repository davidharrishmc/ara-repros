// A segment load that partially writes a register last written at another EEW makes the
// dispatcher reshuffle vd first. Here v16 holds EEW8 data (harness init) and vlseg2e32.v writes
// only element 0 (vl=1, tail undisturbed). Expected (Spike): v16[0] = data word 0, bytes 4..63
// of v16 unchanged. Ara main zeroes them.
  la t1, data
  vsetivli t0, 1, e32, m1, tu, mu
  vlseg2e32.v v16, (t1)
  DUMP 16
