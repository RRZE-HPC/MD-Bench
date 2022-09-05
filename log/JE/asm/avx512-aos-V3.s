imul rcx, r8
vbroadcastsd zmm4, xmm6
sub r11d, r14d
add rcx, r10
vpbroadcastd ymm0, r11d
vpcmpgtd k3, ymm0, ymm15
movsxd r14, r14d
kmovw ebx, k3
vmovdqu32 ymm1{k3}{z}, ymmword ptr [rcx+r14*4]
vpaddd ymm2, ymm1, ymm1
vpaddd ymm0, ymm1, ymm2
kmovw k1, k3
kmovw k2, k3
vpxord zmm1, zmm1, zmm1
vpxord zmm2, zmm2, zmm2
vpxord zmm3, zmm3, zmm3
vgatherdpd zmm1, k1, zmmword ptr [rdi+ymm0*8+0x10]
vgatherdpd zmm2, k2, zmmword ptr [rdi+ymm0*8+0x8]
vgatherdpd zmm3, k3, zmmword ptr [rdi+ymm0*8]
vbroadcastsd zmm7, xmm7
vbroadcastsd zmm12, xmm12
vsubpd zmm23, zmm12, zmm1
vsubpd zmm21, zmm7, zmm2
vsubpd zmm20, zmm4, zmm3
vmulpd zmm19, zmm21, zmm21
vfmadd231pd zmm19, zmm20, zmm20
vfmadd231pd zmm19, zmm23, zmm23
vrcp14pd zmm18, zmm19
vcmppd k2, zmm19, zmm14, 0x1
vfpclasspd k0, zmm18, 0x1e
kmovw ecx, k2
knotw k1, k0
vmovaps zmm0, zmm19
and ebx, ecx
vfnmadd213pd zmm0, zmm18, qword ptr [rip]{1to8}
kmovw k3, ebx
vmulpd zmm1, zmm0, zmm0
vfmadd213pd zmm18{k1}, zmm0, zmm18
vfmadd213pd zmm18{k1}, zmm1, zmm18
vmulpd zmm2, zmm18, zmm13
vmulpd zmm4, zmm18, zmm10
vmulpd zmm6, zmm18, zmm2
vmulpd zmm3, zmm18, zmm6
vfmsub213pd zmm18, zmm6, zmm5
vmulpd zmm17, zmm3, zmm4
vmulpd zmm22, zmm17, zmm18
vfmadd231pd zmm9{k3}, zmm22, zmm20
vfmadd231pd zmm8{k3}, zmm22, zmm21
vfmadd231pd zmm11{k3}, zmm22, zmm23
