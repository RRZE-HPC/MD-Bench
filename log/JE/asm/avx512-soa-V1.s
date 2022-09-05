vpcmpeqb k2, xmm0, xmm0
add r9d, 0x8
vpcmpeqb k1, xmm0, xmm0
vpcmpeqb k3, xmm0, xmm0
vmovdqu ymm3, ymmword ptr [rcx+r14*4]
add r14, 0x8

vpxord zmm5, zmm5, zmm5
vpxord zmm4, zmm4, zmm4
vpxord zmm6, zmm6, zmm6
vgatherdpd zmm5, k2, zmmword ptr [rax+ymm3*8]
vgatherdpd zmm4, k1, zmmword ptr [rdx+ymm3*8]
vgatherdpd zmm6, k3, zmmword ptr [rsi+ymm3*8]

vsubpd zmm29, zmm1, zmm5
vsubpd zmm28, zmm0, zmm4
vsubpd zmm31, zmm2, zmm6
vmulpd zmm20, zmm29, zmm29
vfmadd231pd zmm20, zmm28, zmm28
vfmadd231pd zmm20, zmm31, zmm31

vrcp14pd zmm27, zmm20
vcmppd k5, zmm20, zmm16, 0x1
vfpclasspd k0, zmm27, 0x1e

vfnmadd213pd zmm20, zmm27, qword ptr [rip]{1to8}
knotw k4, k0

vmulpd zmm21, zmm20, zmm20
vfmadd213pd zmm27{k4}, zmm20, zmm27
vfmadd213pd zmm27{k4}, zmm21, zmm27
vmulpd zmm22, zmm27, zmm15
vmulpd zmm24, zmm27, zmm14
vmulpd zmm25, zmm27, zmm22
vmulpd zmm23, zmm27, zmm25
vfmsub213pd zmm27, zmm25, zmm7
vmulpd zmm26, zmm23, zmm24
vmulpd zmm30, zmm26, zmm27
vfmadd231pd zmm13{k5}, zmm30, zmm28
vfmadd231pd zmm12{k5}, zmm30, zmm29
vfmadd231pd zmm11{k5}, zmm30, zmm31
cmp r9d, ebx
jb 0xffffffffffffff22
