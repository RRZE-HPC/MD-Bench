vpcmpgtd k5, ymm3, ymm4
vpaddd ymm4, ymm4, ymm18
vmovdqu32 ymm20{k5}{z}, ymmword ptr [rcx+r15*4]
vmovaps zmm22, zmm19
add r15, 0x8
kmovw k2, k5
vmovaps zmm21, zmm19
kmovw k1, k5
vmovaps zmm23, zmm19
kmovw k3, k5

vgatherdpd zmm23, k3, zmmword ptr [rsi+ymm20*8]
vgatherdpd zmm22, k2, zmmword ptr [rax+ymm20*8]
vgatherdpd zmm21, k1, zmmword ptr [rdx+ymm20*8]

vsubpd zmm0, zmm5, zmm22
vsubpd zmm1, zmm2, zmm21
vsubpd zmm21, zmm6, zmm23
vmulpd zmm20, zmm0, zmm0
vfmadd231pd zmm20, zmm1, zmm1
vfmadd231pd zmm20, zmm21, zmm21

vrcp14pd zmm31, zmm20
vcmppd k6{k5}, zmm20, zmm16, 0x1
vfpclasspd k0, zmm31, 0x1e

vmovaps zmm24, zmm20
vfnmadd213pd zmm24, zmm31, qword ptr [rip]{1to8}
knotw k4, k0

vmulpd zmm25, zmm24, zmm24
vfmadd213pd zmm31{k4}, zmm24, zmm31
vfmadd213pd zmm31{k4}, zmm25, zmm31
vmulpd zmm26, zmm31, zmm15
vmulpd zmm28, zmm31, zmm14
vmulpd zmm29, zmm31, zmm26
vmulpd zmm27, zmm31, zmm29
vfmsub213pd zmm31, zmm29, zmm7
vmulpd zmm30, zmm27, zmm28
vmulpd zmm24, zmm30, zmm31
vfmadd231pd zmm13{k6}, zmm24, zmm1
vfmadd231pd zmm12{k6}, zmm24, zmm0
vfmadd231pd zmm11{k6}, zmm24, zmm21
cmp r15, r14
jb 0xffffffffffffff19
