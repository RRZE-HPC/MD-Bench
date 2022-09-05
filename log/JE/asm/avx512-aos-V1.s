mov r13, r8
imul r13, rcx
vbroadcastsd zmm2, xmm6
vbroadcastsd zmm1, xmm7
vbroadcastsd zmm0, xmm12
movsxd rbx, r12d
add r13, r10
mov qword ptr [rsp-0x40], rax
mov qword ptr [rsp-0x38], r8
mov qword ptr [rsp-0x30], r10
mov qword ptr [rsp-0x28], rsi
mov qword ptr [rsp-0x20], rcx
mov qword ptr [rsp-0x50], r9
mov qword ptr [rsp-0x48], rdx
vmovdqu ymm3, ymmword ptr [r13+rbx*4]
vpaddd ymm4, ymm3, ymm3
vpaddd ymm3, ymm3, ymm4
mov r10d, dword ptr [r13+rbx*4]
mov r9d, dword ptr [r13+rbx*4+0x4]
mov r8d, dword ptr [r13+rbx*4+0x8]
mov esi, dword ptr [r13+rbx*4+0xc]
lea r10d, ptr [r10+r10*2]
mov ecx, dword ptr [r13+rbx*4+0x10]
lea r9d, ptr [r9+r9*2]
mov edx, dword ptr [r13+rbx*4+0x14]
lea r8d, ptr [r8+r8*2]
mov eax, dword ptr [r13+rbx*4+0x18]
lea esi, ptr [rsi+rsi*2]
mov r15d, dword ptr [r13+rbx*4+0x1c]
lea ecx, ptr [rcx+rcx*2]
lea edx, ptr [rdx+rdx*2]
lea eax, ptr [rax+rax*2]
lea r15d, ptr [r15+r15*2]

vpcmpeqb k1, xmm0, xmm0
vpcmpeqb k2, xmm0, xmm0
vpcmpeqb k3, xmm0, xmm0

vpxord zmm4, zmm4, zmm4
vpxord zmm17, zmm17, zmm17
vpxord zmm18, zmm18, zmm18
vgatherdpd zmm4, k1, zmmword ptr [rdi+ymm3*8+0x10]
vgatherdpd zmm17, k2, zmmword ptr [rdi+ymm3*8+0x8]
vgatherdpd zmm18, k3, zmmword ptr [rdi+ymm3*8]
add r12d, 0x8
add rbx, 0x8

vsubpd zmm26, zmm0, zmm4
vsubpd zmm24, zmm1, zmm17
vsubpd zmm23, zmm2, zmm18
vmulpd zmm3, zmm24, zmm24
vfmadd231pd zmm3, zmm23, zmm23
vfmadd231pd zmm3, zmm26, zmm26

vrcp14pd zmm22, zmm3
vcmppd k2, zmm3, zmm14, 0x1
vfpclasspd k0, zmm22, 0x1e

vfnmadd213pd zmm3, zmm22, qword ptr [rip]{1to8}
knotw k1, k0

vmulpd zmm4, zmm3, zmm3
vfmadd213pd zmm22{k1}, zmm3, zmm22
vfmadd213pd zmm22{k1}, zmm4, zmm22
vmulpd zmm17, zmm22, zmm13
vmulpd zmm19, zmm22, zmm10
vmulpd zmm20, zmm22, zmm17
vmulpd zmm18, zmm22, zmm20
vfmsub213pd zmm22, zmm20, zmm5
vmulpd zmm21, zmm18, zmm19
vmulpd zmm25, zmm21, zmm22
vfmadd231pd zmm9{k2}, zmm25, zmm23
vfmadd231pd zmm8{k2}, zmm25, zmm24
vfmadd231pd zmm11{k2}, zmm25, zmm26
cmp r12d, r14d
jb 0xfffffffffffffed3
