vpcmpgtd k3, ymm2, ymm3
vmovdqu32 ymm17{k3}{z}, ymmword ptr [r15+r13*4]
kmovw r9d, k3
vpaddd ymm18, ymm17, ymm17
vpaddd ymm17, ymm17, ymm18
kmovw k1, k3
kmovw k2, k3

vpxord zmm18, zmm18, zmm18
vpxord zmm19, zmm19, zmm19
vpxord zmm20, zmm20, zmm20
vgatherdpd zmm18, k1, zmmword ptr [rdi+ymm17*8+0x10]
vgatherdpd zmm19, k2, zmmword ptr [rdi+ymm17*8+0x8]
vgatherdpd zmm20, k3, zmmword ptr [rdi+ymm17*8]
add r13, 0x8
vpaddd ymm3, ymm3, ymm16

vsubpd zmm29, zmm4, zmm18
vsubpd zmm27, zmm0, zmm19
vsubpd zmm26, zmm1, zmm20
vmulpd zmm25, zmm27, zmm27
vfmadd231pd zmm25, zmm26, zmm26
vfmadd231pd zmm25, zmm29, zmm29

vrcp14pd zmm24, zmm25
vcmppd k2, zmm25, zmm14, 0x1
vfpclasspd k0, zmm24, 0x1e

kmovw edx, k2
knotw k1, k0
vmovaps zmm17, zmm25
and r9d, edx
vfnmadd213pd zmm17, zmm24, qword ptr [rip]{1to8}
kmovw k3, r9d

vmulpd zmm18, zmm17, zmm17
vfmadd213pd zmm24{k1}, zmm17, zmm24
vfmadd213pd zmm24{k1}, zmm18, zmm24
vmulpd zmm19, zmm24, zmm13
vmulpd zmm21, zmm24, zmm10
vmulpd zmm22, zmm24, zmm19
vmulpd zmm20, zmm24, zmm22
vfmsub213pd zmm24, zmm22, zmm5
vmulpd zmm23, zmm20, zmm21
vmulpd zmm28, zmm23, zmm24
vfmadd231pd zmm9{k3}, zmm28, zmm26
vfmadd231pd zmm8{k3}, zmm28, zmm27
vfmadd231pd zmm11{k3}, zmm28, zmm29
cmp r13, rbx
jb 0xfffffffffffffef7
