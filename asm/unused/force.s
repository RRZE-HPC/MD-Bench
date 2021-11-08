.intel_syntax noprefix

.text
.align    16,0x90
.globl computeForce
computeForce:
# parameter 1: rdi Parameter*
# parameter 2: rsi Atom*
# parameter 3: rdx Neighbor*
        push      r12
        push      r13
        push      r14
        mov       r9d, DWORD PTR [4+rsi]                            # r9d <- atom->Nlocal
        vmovsd    xmm2, QWORD PTR [72+rdi]                          # xmm2 <- param->cutforce
        vmovsd    xmm1, QWORD PTR [8+rdi]                           # xmm1 <- param->sigma6
        vmovsd    xmm0, QWORD PTR [rdi]                             # xmm0 <- param->epsilon
        mov       r13, QWORD PTR [64+rsi]                           # r13 <- atom->fx
        mov       r14, QWORD PTR [72+rsi]                           # r14 <- atom->fy
        mov       rdi, QWORD PTR [80+rsi]                           # rdi <- atom->fz
        test      r9d, r9d                                          # atom->Nlocal <= 0
        jle       ..exit_func

..B1.2:
        xor       r10d, r10d                                        # r10d <- 0
        mov       ecx, r9d                                          # ecx <- atom->Nlocal
        xor       r8d, r8d                                          # r8d <- 0
        mov       r11d, 1                                           # r11d <- 1
        xor       eax, eax                                          # eax <- 0
        shr       ecx, 1                                            # ecx <- atom->Nlocal >> 1
        je        ..B1.6                                            # ecx == 0

# Init forces to zero loop
..B1.4:
        mov       QWORD PTR [r8+r13], rax                           # fx[i] <- 0
        mov       QWORD PTR [r8+r14], rax                           # fy[i] <- 0
        mov       QWORD PTR [r8+rdi], rax                           # fz[i] <- 0
        mov       QWORD PTR [8+r8+r13], rax                         # fx[i] <- 0
        mov       QWORD PTR [8+r8+r14], rax                         # fy[i] <- 0
        mov       QWORD PTR [8+r8+rdi], rax                         # fz[i] <- 0
        add       r8, 16                                            # i++
        inc       r10                                               # i++
        cmp       r10, rcx                                          # i < Nlocal
        jb        ..B1.4

..B1.5:
        lea       r11d, DWORD PTR [1+r10+r10]                       # r11d <- i * 2 + 1
..B1.6:
        lea       ecx, DWORD PTR [-1+r11]                           # r11d <- i * 2
        cmp       ecx, r9d                                          # i < Nlocal
        jae       ..B1.8

..B1.7:
        movsxd    r11, r11d                                         # r11 <- i * 2
        mov       QWORD PTR [-8+r13+r11*8], rax                     # fx[i] <- 0
        mov       QWORD PTR [-8+r14+r11*8], rax                     # fy[i] <- 0
        mov       QWORD PTR [-8+rdi+r11*8], rax                     # fz[i] <- 0

..B1.8:
        vmulsd    xmm15, xmm2, xmm2                                 # xmm15 <- cutforcesq
        xor       r8d, r8d                                          # r8d <- 0
        vmovdqu32 ymm18, YMMWORD PTR .L_2il0floatpacket.0[rip]      # ymm18 <- [8, ...]
        vmulsd    xmm0, xmm0, QWORD PTR .L_2il0floatpacket.3[rip]   # xmm0 <- 48 *  epsilon
        vmovdqu32 ymm17, YMMWORD PTR .L_2il0floatpacket.1[rip]      # ymm17 <- [0..7]
        vmovups   zmm7, ZMMWORD PTR .L_2il0floatpacket.4[rip]       # zmm7 <- [0.5, ...]
        vbroadcastsd zmm16, xmm15                                   # zmm16 <- [cutforcesq, ...]
        vbroadcastsd zmm15, xmm1                                    # zmm15 <- [param->sigma6, ...]
        vbroadcastsd zmm14, xmm0                                    # zmm16 <- [48 * epsilon, ...]
        movsxd    r9, r9d                                           # r9 <- atom->Nlocal
        xor       r10d, r10d                                        # r10d <- 0 (i)
        mov       rcx, QWORD PTR [24+rdx]                           # rcx <- neighbor->numneigh
        mov       r11, QWORD PTR [8+rdx]                            # r11 <- neighbor->neighbors
        movsxd    r12, DWORD PTR [16+rdx]                           # r12 <- neighbor->maxneighs
        mov       rdx, QWORD PTR [16+rsi]                           # rdx <- atom->x

        ### AOS
        xor        eax, eax
        ### SOA
        #mov       rax, QWORD PTR [24+rsi]                           # rax <- atom->y
        #mov       rsi, QWORD PTR [32+rsi]                           # rsi <- atom->z
        ###

        shl       r12, 2                                            # r12 <- neighbor->maxneighs * 4
        mov       QWORD PTR [-32+rsp], r9                           # [-32+rsp] <- atom->Nlocal
        mov       QWORD PTR [-24+rsp], rcx                          # [-24+rsp] <- neighbor->numneigh
        mov       QWORD PTR [-16+rsp], r14                          # [-16+rsp] <- atom->fy
        mov       QWORD PTR [-8+rsp], r13                           # [-8+rsp] <- atom->fx
        mov       QWORD PTR [-40+rsp], r15                          # [-40+rsp] <- r15
        mov       QWORD PTR [-48+rsp], rbx                          # [-48+rsp] <- rbx

# Loop over all atoms
..B1.9:
        mov       rcx, QWORD PTR [-24+rsp]                          # rcx <- neighbor->numneigh
        vxorpd    xmm25, xmm25, xmm25                               # xmm25 <- 0
        vmovapd   xmm20, xmm25                                      # xmm20 <- 0
        mov       r13d, DWORD PTR [rcx+r10*4]                       # r13d <- neighbor->numneigh[i] (numneighs)
        vmovapd   xmm4, xmm20                                       # xmm4 <- 0

        ### AOS
        vmovsd    xmm8, QWORD PTR[rdx+rax]                          # xmm8 <- atom->x[i * 3]
        vmovsd    xmm9, QWORD PTR[8+rdx+rax]                        # xmm9 <- atom->x[i * 3 + 1]
        vmovsd    xmm10, QWORD PTR[16+rdx+rax]                      # xmm10 <- atom->x[i * 3 + 2]
        ### SOA
        #vmovsd    xmm8, QWORD PTR [rdx+r10*8]                      # xmm8 <- atom->x[i]
        #vmovsd    xmm9, QWORD PTR [rax+r10*8]                      # xmm9 <- atom->y[i]
        #vmovsd    xmm10, QWORD PTR [rsi+r10*8]                     # xmm10 <- atom->z[i]
        ###

        test      r13d, r13d                                        # numneighs <= 0
        jle       ..exit_func

..B1.10:
        vpxord    zmm13, zmm13, zmm13                               # zmm13 <- 0 (fix)
        vmovaps   zmm12, zmm13                                      # zmm12 <- 0 (fiy)
        vmovaps   zmm11, zmm12                                      # zmm11 <- 0 (fiz)

        mov       r14d, r13d                                        # r14d <- numneighs
        xor       r11d, r11d                                        # r11d <- 0
        and       r14d, -8                                          # r14d <- numneighs & (-8)
        lea       r9d, DWORD PTR [8+r11]                            # r9d <- 8 (why lea?)
        cmp       r14d, r9d                                         # r14d < r9d
        jl        ..B1.33

#        cmp       r13d, 8                                           # numneighs < 8
#        jl        ..B1.32
#..B1.11:
#        cmp       r13d, 1200                                        # numneighs < 1200
#        jl        ..B1.31
#..B1.12:
#        mov       rcx, r12
#        imul      rcx, r8
#        add       rcx, r11                                          # rcx <- &neighbor->neighbors[neighbor->maxneighs * i (r8)]
#        mov       r9, rcx                                           # r9 <- neighs
#        and       r9, 63                                            # r9 <- neighs & 63
#        test      r9d, 3                                            # (r9d & 3) == 0 => r9d divisible by 8
#        je        ..B1.14
#..B1.13:
#        xor       r9d, r9d                                          # r9d <- 0
#        jmp       ..B1.16
#..B1.14:
#        test      r9d, r9d                                          # r9d == 0 
#        je        ..B1.16
#..B1.15:
#        neg       r9d
#        add       r9d, 64
#        shr       r9d, 2                                            # r9d <- (64 - r9d) / 4
#        cmp       r13d, r9d                                         # numneighs < r9d
#        cmovl     r9d, r13d                                         # r9d <- MIN(numneighs, r9d)
#..B1.16:
#        mov       ebx, r13d
#        sub       ebx, r9d
#        and       ebx, 7
#        neg       ebx
#        add       ebx, r13d                                         # ebx <- -((numneighs - r9d) & 7) + numneighs
#        cmp       r9d, 1                                            # r9d < 1
#        jb        ..B1.20
#..B1.20:
#        lea       ecx, DWORD PTR [8+r9]                             # ecx <- r9d[1]
#        cmp       ebx, ecx                                          # -((numneighs - r9d) & 7) + numneighs < neighs
#        jl        ..B1.24

..B1.21:
        mov       rcx, r12
        imul      rcx, r8
        vbroadcastsd zmm0, xmm8
        vbroadcastsd zmm1, xmm9
        vbroadcastsd zmm2, xmm10
        movsxd    r14, r9d
        add       rcx, r11

..B1.22:
        vpcmpeqb  k2, xmm0, xmm0
        add       r9d, 8
        vpcmpeqb  k1, xmm0, xmm0
        vpcmpeqb  k3, xmm0, xmm0
        vmovdqu   ymm3, YMMWORD PTR [rcx+r14*4]
        add       r14, 8
        vpxord    zmm5, zmm5, zmm5
        vpxord    zmm6, zmm6, zmm6

        ### AOS
        vpaddd     ymm4, ymm3, ymm3
        vpaddd     ymm3, ymm3, ymm4
        vpxord     zmm4, zmm4, zmm4
        vgatherdpd zmm4{k1}, QWORD PTR [rdx+ymm3*8]
        vgatherdpd zmm5{k2}, QWORD PTR [8+rdx+ymm3*8]
        vgatherdpd zmm6{k3}, QWORD PTR [16+rdx+ymm3*8]
        ### SOA
        #vpxord     zmm4, zmm4, zmm4
        #vgatherdpd zmm5{k2}, QWORD PTR [rax+ymm3*8]
        #vgatherdpd zmm4{k1}, QWORD PTR [rdx+ymm3*8]
        #vgatherdpd zmm6{k3}, QWORD PTR [rsi+ymm3*8]
        ###

        vsubpd    zmm29, zmm1, zmm5
        vsubpd    zmm28, zmm0, zmm4
        vsubpd    zmm31, zmm2, zmm6
        vmulpd    zmm20, zmm29, zmm29
        vfmadd231pd zmm20, zmm28, zmm28
        vfmadd231pd zmm20, zmm31, zmm31

# if condition cutoff radius
        vrcp14pd  zmm27, zmm20 #-> sr2
        vcmppd    k5, zmm20, zmm16, 1
        vmulpd    zmm22, zmm27, zmm15                                   # zmm22 <-  sr2 * sigma6
        vmulpd    zmm24, zmm27, zmm14                                   # zmm24 <- 48.0 * epsilon * sr2
        vmulpd    zmm25, zmm27, zmm22                                   # zmm25 <- sr2 * sigma6 * sr2
        vmulpd    zmm23, zmm27, zmm25                                   # zmm23 <- sr2 * sigma6 * sr2 * sr2
        vfmsub213pd zmm27, zmm25, zmm7                                  # zmm27 <- sr2 * sigma * sr2 * sr2 - 0.5
        vmulpd    zmm26, zmm23, zmm24                                   # zmm26 <- 48.0 * epsilon * sr2 * sr2 * sigma6 * sr2
        vmulpd    zmm30, zmm26, zmm27                                   # zmm30 <- force
        vfmadd231pd zmm13{k5}, zmm30, zmm28
        vfmadd231pd zmm12{k5}, zmm30, zmm29
        vfmadd231pd zmm11{k5}, zmm30, zmm31
        cmp       r9d, ebx
        jb        ..B1.22
#end neighbor loop

..B1.26:
        vmovups   zmm10, ZMMWORD PTR .L_2il0floatpacket.6[rip]
        vpermd    zmm0, zmm10, zmm11
        vpermd    zmm5, zmm10, zmm12
        vpermd    zmm21, zmm10, zmm13
        vaddpd    zmm11, zmm0, zmm11
        vaddpd    zmm12, zmm5, zmm12
        vaddpd    zmm13, zmm21, zmm13
        vpermpd   zmm1, zmm11, 78
        vpermpd   zmm6, zmm12, 78
        vpermpd   zmm22, zmm13, 78
        vaddpd    zmm2, zmm11, zmm1
        vaddpd    zmm8, zmm12, zmm6
        vaddpd    zmm23, zmm13, zmm22
        vpermpd   zmm3, zmm2, 177
        vpermpd   zmm9, zmm8, 177
        vpermpd   zmm24, zmm23, 177
        vaddpd    zmm4, zmm2, zmm3
        vaddpd    zmm20, zmm8, zmm9
        vaddpd    zmm25, zmm23, zmm24

#exit function
..exit_func:
        mov       rcx, QWORD PTR [-8+rsp]                       #84.9[spill]
        mov       rbx, QWORD PTR [-16+rsp]                      #85.9[spill]

        ### AOS
        add       rax, 24
        ###

        movsxd    r8, r10d                                      #55.32
        inc       r8                                            #55.32
        vaddsd    xmm0, xmm25, QWORD PTR [rcx+r10*8]            #84.9
        vmovsd    QWORD PTR [rcx+r10*8], xmm0                   #84.9
        vaddsd    xmm1, xmm20, QWORD PTR [rbx+r10*8]            #85.9
        vmovsd    QWORD PTR [rbx+r10*8], xmm1                   #85.9
        vaddsd    xmm2, xmm4, QWORD PTR [rdi+r10*8]             #86.9
        vmovsd    QWORD PTR [rdi+r10*8], xmm2                   #86.9
        inc       r10                                           #55.5
        cmp       r10, QWORD PTR [-32+rsp]                      #55.5[spill]
        jb        ..B1.9
        vzeroupper                                              #93.12
        vxorpd    xmm0, xmm0, xmm0                              #93.12
        pop       r14                                           #93.12
        pop       r13                                           #93.12
        pop       r12                                           #93.12
        ret                                                     #93.12

.type	computeForce,@function
.size	computeForce,.-computeForce


..LNcomputeForce.0:
	.data
# -- End  computeForce
	.section .rodata, "a"
	.align 64
	.align 64
.L_2il0floatpacket.2:
	.long	0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000,0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,64
	.align 64
.L_2il0floatpacket.4:
	.long	0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,64
	.align 64
.L_2il0floatpacket.6:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,64
	.align 32
.L_2il0floatpacket.0:
	.long	0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008,0x00000008
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,32
	.align 32
.L_2il0floatpacket.1:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,32
	.align 8
.L_2il0floatpacket.3:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,8
	.align 8
.L_2il0floatpacket.5:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,8
	.data
	.section .note.GNU-stack, ""
# End
