// v9 last written at e32; vmflt.vv / vmslt.vv at e32 m8 (vl = 32) into v8 must leave v9 (and v1) unchanged.
  vsetivli x0, 4, e32, m1, tu, mu
  vadd.vi v9, v9, 0
  vadd.vi v1, v1, 0
  li t0, 32
  vsetvli x0, t0, e32, m8, ta, ma
  vmflt.vv v8, v16, v24
  vmslt.vv v0, v16, v24
  vsetivli x0, 4, e32, m1, tu, mu
  vadd.vi v9, v9, 0
  vadd.vi v1, v1, 0
  DUMP 9
  DUMP 1
