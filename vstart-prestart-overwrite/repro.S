// With vstart > 0, prestart elements must stay undisturbed (or the instruction may raise illegal instruction).
// vmv1r.v with vstart = 1, vmnand.mm with vstart = 5, vadd.vi with vstart = 1 (the case open PR 544 covers).
// vstart is cleared after each one so that the dump (vs1r.v) stores the whole register on Spike, which traps.
  vsetivli x0, 4, e8, m1, tu, mu
  csrwi vstart, 1
  vmv1r.v v8, v1
  csrwi vstart, 0
  DUMP 8
  vsetivli x0, 16, e8, m1, tu, mu
  csrwi vstart, 5
  vmnand.mm v9, v2, v3
  csrwi vstart, 0
  DUMP 9
  vmnand.mm v11, v2, v3   // control: vstart = 0
  DUMP 11
  vsetivli x0, 4, e8, m1, tu, mu
  csrwi vstart, 1
  vadd.vi v10, v1, 1
  csrwi vstart, 0
  DUMP 10
