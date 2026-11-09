// vill=1 from an unsupported vtype (vlmul = 4, reserved), then vle8.v and vse8.v must raise illegal instruction
// (mcause 2). Controls: vadd.vv must trap too; vl1re8.v must not.
  li t0, 4
  li t1, 4
  vsetvl x0, t1, t0
  csrr a0, vtype
  XDUMP a0
  la t2, data
  vle8.v v1, (t2)
  vse8.v v1, (t2)
  vadd.vv v1, v2, v3
  vl1re8.v v4, (t2)
  li a0, 0x600d
  XDUMP a0
