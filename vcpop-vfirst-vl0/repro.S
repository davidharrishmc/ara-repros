// vcpop.m and vfirst.m with vl = 0 must write 0 and -1 to rd (no active elements).
// Expected (Spike): x lines 0 (vl), 0 (vcpop.m), ffffffffffffffff (vfirst.m). Ara main hangs at vcpop.m.
  vsetivli t0, 0, e8, m1, ta, ma
  XDUMP t0
  li a0, 0x55
  vcpop.m a0, v1
  XDUMP a0
  li a1, 0x55
  vfirst.m a1, v1
  XDUMP a1
