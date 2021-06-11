# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.5.281 Build 20190815";
# mark_description "-I./src/includes -S -masm=intel -D_GNU_SOURCE -DPRECISION=2 -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -q";
# mark_description "opt-zmm-usage=high -o ICC/force.s";
	.intel_syntax noprefix
	.file "force.c"
	.text
..TXTST0:
.L_2__routine_start_computeForce_0:
# -- Begin  computeForce
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForce
# --- computeForce(Parameter *, Atom *, Neighbor *, int)
computeForce:
# parameter 1: rdi
# parameter 2: rsi
# parameter 3: rdx
# parameter 4: ecx
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForce.1:
..L2:
                                                          #35.1
        push      r12                                           #35.1
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
        push      r13                                           #35.1
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
        push      r14                                           #35.1
	.cfi_def_cfa_offset 32
	.cfi_offset 14, -32
# r9d <- atom->Nlocal
        mov       r9d, DWORD PTR [4+rsi]                        #36.18
# xmm2 <- param->cutforce
        vmovsd    xmm2, QWORD PTR [72+rdi]                      #38.27
# xmm1 <- param->sigma6
        vmovsd    xmm1, QWORD PTR [8+rdi]                       #39.23
# xmm0 <- param->epsilon
        vmovsd    xmm0, QWORD PTR [rdi]                         #40.24
# r13 <- atom->fx
        mov       r13, QWORD PTR [64+rsi]                       #41.20
# r14 <- atom->fy
        mov       r14, QWORD PTR [72+rsi]                       #41.45
# rdi <- atom->fz
        mov       rdi, QWORD PTR [80+rsi]                       #41.70
# atom->Nlocal <= 0
        test      r9d, r9d                                      #44.24
        jle       ..B1.30       # Prob 50%                      #44.24
                                # LOE rdx rbx rbp rsi rdi r13 r14 r15 r9d xmm0 xmm1 xmm2
..B1.2:                         # Preds ..B1.1
                                # Execution count [1.00e+00]
# r10d <- 0
        xor       r10d, r10d                                    #44.5
# ecx <- atom->Nlocal
        mov       ecx, r9d                                      #44.5
# r8d <- 0
        xor       r8d, r8d                                      #44.5
# r11d <- 1
        mov       r11d, 1                                       #44.5
# eax <- 0
        xor       eax, eax                                      #45.17
# ecx <- atom->Nlocal >> 1
        shr       ecx, 1                                        #44.5
        je        ..B1.6        # Prob 9%                       #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r10 r13 r14 r15 r9d r11d xmm0 xmm1 xmm2
..B1.4:                         # Preds ..B1.2 ..B1.4
                                # Execution count [2.50e+00]
# fx[i] <- 0
        mov       QWORD PTR [r8+r13], rax                       #45.9
# i++
        inc       r10                                           #44.5
# fy[i] <- 0
        mov       QWORD PTR [r8+r14], rax                       #46.9
# fz[i] <- 0
        mov       QWORD PTR [r8+rdi], rax                       #47.9
# fx[i] <- 0
        mov       QWORD PTR [8+r8+r13], rax                     #45.9
# fy[i] <- 0
        mov       QWORD PTR [8+r8+r14], rax                     #46.9
# fz[i] <- 0
        mov       QWORD PTR [8+r8+rdi], rax                     #47.9
# i++
        add       r8, 16                                        #44.5
# i < Nlocal
        cmp       r10, rcx                                      #44.5
        jb        ..B1.4        # Prob 63%                      #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r10 r13 r14 r15 r9d xmm0 xmm1 xmm2
..B1.5:                         # Preds ..B1.4
                                # Execution count [9.00e-01]
# r11d <- i * 2 + 1
        lea       r11d, DWORD PTR [1+r10+r10]                   #45.9
                                # LOE rax rdx rbx rbp rsi rdi r13 r14 r15 r9d r11d xmm0 xmm1 xmm2
..B1.6:                         # Preds ..B1.2 ..B1.5
                                # Execution count [1.00e+00]
# r11d <- i * 2
        lea       ecx, DWORD PTR [-1+r11]                       #44.5
# i < Nlocal
        cmp       ecx, r9d                                      #44.5
        jae       ..B1.8        # Prob 9%                       #44.5
                                # LOE rax rdx rbx rbp rsi rdi r13 r14 r15 r9d r11d xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.6
                                # Execution count [9.00e-01]
# r11 <- i * 2
        movsxd    r11, r11d                                     #44.5
# fx[i] <- 0
        mov       QWORD PTR [-8+r13+r11*8], rax                 #45.9
# fy[i] <- 0
        mov       QWORD PTR [-8+r14+r11*8], rax                 #46.9
# fz[i] <- 0
        mov       QWORD PTR [-8+rdi+r11*8], rax                 #47.9
                                # LOE rdx rbx rbp rsi rdi r13 r14 r15 r9d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.6 ..B1.7
                                # Execution count [9.00e-01]
# xmm15 <- cutforcesq
        vmulsd    xmm15, xmm2, xmm2                             #38.45
# r8d <- 0
        xor       r8d, r8d                                      #55.15
# ymm18 <- 8
        vmovdqu32 ymm18, YMMWORD PTR .L_2il0floatpacket.0[rip]  #67.9
# xmm0 <- 48 * sr6 * epsilon
        vmulsd    xmm0, xmm0, QWORD PTR .L_2il0floatpacket.3[rip] #77.41
# ymm17 <- [0..7]
        vmovdqu32 ymm17, YMMWORD PTR .L_2il0floatpacket.1[rip]  #67.9
# zmm7 <- 0.5
        vmovups   zmm7, ZMMWORD PTR .L_2il0floatpacket.4[rip]   #77.54
# zmm16 <- cutforcesq
        vbroadcastsd zmm16, xmm15                               #38.25
# zmm15 <- param->sigma6
        vbroadcastsd zmm15, xmm1                                #39.21
# zmm16 <- 48 * sr6 * epsilon
        vbroadcastsd zmm14, xmm0                                #77.41
# r9 <- atom->Nlocal
        movsxd    r9, r9d                                       #55.5
# r10d <- 0 (i)
        xor       r10d, r10d                                    #55.5
# rcx <- neighbor->numneigh
        mov       rcx, QWORD PTR [24+rdx]                       #57.25
# r11 <- neighbor->neighbors
        mov       r11, QWORD PTR [8+rdx]                        #56.19
# r12 <- neighbor->maxneighs
        movsxd    r12, DWORD PTR [16+rdx]                       #56.43
# rdx <- atom->x
        mov       rdx, QWORD PTR [16+rsi]                       #58.25
# rax <- atom->y
        mov       rax, QWORD PTR [24+rsi]                       #59.25
# rsi <- atom->z
        mov       rsi, QWORD PTR [32+rsi]                       #60.25
# r12 <- neighbor->maxneighs * 4
        shl       r12, 2                                        #37.5
# [-32+rsp] <- atom->Nlocal
        mov       QWORD PTR [-32+rsp], r9                       #60.25[spill]
# [-24+rsp] <- neighbor->numneigh
        mov       QWORD PTR [-24+rsp], rcx                      #60.25[spill]
# [-16+rsp] <- atom->fy
        mov       QWORD PTR [-16+rsp], r14                      #60.25[spill]
# [-8+rsp] <- atom->fx
        mov       QWORD PTR [-8+rsp], r13                       #60.25[spill]
# [-40+rsp] <- r15
        mov       QWORD PTR [-40+rsp], r15                      #60.25[spill]
# [-48+rsp] <- rbx
        mov       QWORD PTR [-48+rsp], rbx                      #60.25[spill]
# zmm19 <- 0
        vpxord    zmm19, zmm19, zmm19                           #61.22
	.cfi_offset 3, -80
	.cfi_offset 15, -72
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.9:                         # Preds ..B1.27 ..B1.8
                                # Execution count [5.00e+00]
# rcx <- neighbor->numneigh
        mov       rcx, QWORD PTR [-24+rsp]                      #57.25[spill]
# xmm25 <- 0
        vxorpd    xmm25, xmm25, xmm25                           #61.22
# xmm20 <- 0
        vmovapd   xmm20, xmm25                                  #62.22
# r13d <- neighbor->numneigh[i] (numneighs)
        mov       r13d, DWORD PTR [rcx+r10*4]                   #57.25
# xmm4 <- 0
        vmovapd   xmm4, xmm20                                   #63.22
# xmm8 <- atom->x[i]
        vmovsd    xmm8, QWORD PTR [rdx+r10*8]                   #58.25
# xmm9 <- atom->y[i]
        vmovsd    xmm9, QWORD PTR [rax+r10*8]                   #59.25
# xmm9 <- atom->z[i]
        vmovsd    xmm10, QWORD PTR [rsi+r10*8]                  #60.25
# numneighs <= 0
        test      r13d, r13d                                    #67.28
        jle       ..B1.27       # Prob 50%                      #67.28
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 r13d xmm4 xmm8 xmm9 xmm10 xmm20 xmm25 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
# zmm13 <- 0
        vmovaps   zmm13, zmm19                                  #61.22
# zmm12 <- 0
        vmovaps   zmm12, zmm13                                  #62.22
# zmm11 <- 0
        vmovaps   zmm11, zmm12                                  #63.22
# numneighs < 8
        cmp       r13d, 8                                       #67.9
        jl        ..B1.32       # Prob 10%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
# numneighs < 1200
        cmp       r13d, 1200                                    #67.9
        jl        ..B1.31       # Prob 10%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
        mov       rcx, r12                                      #56.43
        imul      rcx, r8                                       #56.43
        add       rcx, r11                                      #37.5
        mov       r9, rcx                                       #67.9
        and       r9, 63                                        #67.9
        test      r9d, 3                                        #67.9
        je        ..B1.14       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        xor       r9d, r9d                                      #67.9
        jmp       ..B1.16       # Prob 100%                     #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.14:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        test      r9d, r9d                                      #67.9
        je        ..B1.16       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.15:                        # Preds ..B1.14
                                # Execution count [2.50e+01]
        neg       r9d                                           #67.9
        add       r9d, 64                                       #67.9
        shr       r9d, 2                                        #67.9
        cmp       r13d, r9d                                     #67.9
        cmovl     r9d, r13d                                     #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.16:                        # Preds ..B1.13 ..B1.15 ..B1.14
                                # Execution count [5.00e+00]
        mov       ebx, r13d                                     #67.9
        sub       ebx, r9d                                      #67.9
        and       ebx, 7                                        #67.9
        neg       ebx                                           #67.9
        add       ebx, r13d                                     #67.9
        cmp       r9d, 1                                        #67.9
        jb        ..B1.20       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        vmovdqa32 ymm4, ymm17                                   #67.9
        xor       r15d, r15d                                    #67.9
        vpbroadcastd ymm3, r9d                                  #67.9
        vbroadcastsd zmm2, xmm8                                 #58.23
        vbroadcastsd zmm5, xmm9                                 #59.23
        vbroadcastsd zmm6, xmm10                                #60.23
        movsxd    r14, r9d                                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 r15 ebx r9d r13d xmm8 xmm9 xmm10 ymm3 ymm4 ymm17 ymm18 zmm2 zmm5 zmm6 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.18:                        # Preds ..B1.18 ..B1.17
                                # Execution count [2.50e+01]
        vpcmpgtd  k5, ymm3, ymm4                                #67.9
        vpaddd    ymm4, ymm4, ymm18                             #67.9
        vmovdqu32 ymm20{k5}{z}, YMMWORD PTR [rcx+r15*4]         #68.21
        vmovaps   zmm22, zmm19                                  #70.36
        add       r15, 8                                        #67.9
        kmovw     k2, k5                                        #70.36
        vmovaps   zmm21, zmm19                                  #69.36
        kmovw     k1, k5                                        #69.36
        vmovaps   zmm23, zmm19                                  #71.36
        kmovw     k3, k5                                        #71.36
        vgatherdpd zmm23{k3}, QWORD PTR [rsi+ymm20*8]           #71.36
        vgatherdpd zmm22{k2}, QWORD PTR [rax+ymm20*8]           #70.36
        vgatherdpd zmm21{k1}, QWORD PTR [rdx+ymm20*8]           #69.36
        vsubpd    zmm0, zmm5, zmm22                             #70.36
        vsubpd    zmm1, zmm2, zmm21                             #69.36
        vsubpd    zmm21, zmm6, zmm23                            #71.36
        vmulpd    zmm20, zmm0, zmm0                             #72.49
        vfmadd231pd zmm20, zmm1, zmm1                           #72.49
        vfmadd231pd zmm20, zmm21, zmm21                         #72.63
        vrcp14pd  zmm31, zmm20                                  #75.38
        vcmppd    k6{k5}, zmm20, zmm16, 1                       #74.22
        vfpclasspd k0, zmm31, 30                                #75.38
        vmovaps   zmm24, zmm20                                  #75.38
        vfnmadd213pd zmm24, zmm31, QWORD BCST .L_2il0floatpacket.5[rip] #75.38
        knotw     k4, k0                                        #75.38
        vmulpd    zmm25, zmm24, zmm24                           #75.38
        vfmadd213pd zmm31{k4}, zmm24, zmm31                     #75.38
        vfmadd213pd zmm31{k4}, zmm25, zmm31                     #75.38
        vmulpd    zmm26, zmm31, zmm15                           #76.38
        vmulpd    zmm28, zmm31, zmm14                           #77.54
        vmulpd    zmm29, zmm31, zmm26                           #76.44
        vmulpd    zmm27, zmm31, zmm29                           #76.50
        vfmsub213pd zmm31, zmm29, zmm7                          #77.54
        vmulpd    zmm30, zmm27, zmm28                           #77.61
        vmulpd    zmm24, zmm30, zmm31                           #77.67
        vfmadd231pd zmm13{k6}, zmm24, zmm1                      #78.17
        vfmadd231pd zmm12{k6}, zmm24, zmm0                      #79.17
        vfmadd231pd zmm11{k6}, zmm24, zmm21                     #80.17
        cmp       r15, r14                                      #67.9
        jb        ..B1.18       # Prob 82%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 r15 ebx r9d r13d xmm8 xmm9 xmm10 ymm3 ymm4 ymm17 ymm18 zmm2 zmm5 zmm6 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        cmp       r13d, r9d                                     #67.9
        je        ..B1.26       # Prob 10%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.20:                        # Preds ..B1.19 ..B1.16 ..B1.31
                                # Execution count [2.50e+01]
        lea       ecx, DWORD PTR [8+r9]                         #67.9
        cmp       ebx, ecx                                      #67.9
        jl        ..B1.24       # Prob 50%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.21:                        # Preds ..B1.20
                                # Execution count [4.50e+00]
        mov       rcx, r12                                      #56.43
        imul      rcx, r8                                       #56.43
        vbroadcastsd zmm0, xmm8                                 #58.23
        vbroadcastsd zmm1, xmm9                                 #59.23
        vbroadcastsd zmm2, xmm10                                #60.23
        movsxd    r14, r9d                                      #67.9
        add       rcx, r11                                      #37.5
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm0 zmm1 zmm2 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.22:                        # Preds ..B1.22 ..B1.21
                                # Execution count [2.50e+01]
        vpcmpeqb  k2, xmm0, xmm0                                #70.36
        add       r9d, 8                                        #67.9
        vpcmpeqb  k1, xmm0, xmm0                                #69.36
        vpcmpeqb  k3, xmm0, xmm0                                #71.36
        vmovdqu   ymm3, YMMWORD PTR [rcx+r14*4]                 #68.21
        add       r14, 8                                        #67.9
        vpxord    zmm5, zmm5, zmm5                              #70.36
        vpxord    zmm4, zmm4, zmm4                              #69.36
        vpxord    zmm6, zmm6, zmm6                              #71.36
        vgatherdpd zmm5{k2}, QWORD PTR [rax+ymm3*8]             #70.36
        vgatherdpd zmm4{k1}, QWORD PTR [rdx+ymm3*8]             #69.36
        vgatherdpd zmm6{k3}, QWORD PTR [rsi+ymm3*8]             #71.36
        vsubpd    zmm29, zmm1, zmm5                             #70.36
        vsubpd    zmm28, zmm0, zmm4                             #69.36
        vsubpd    zmm31, zmm2, zmm6                             #71.36
        vmulpd    zmm20, zmm29, zmm29                           #72.49
        vfmadd231pd zmm20, zmm28, zmm28                         #72.49
        vfmadd231pd zmm20, zmm31, zmm31                         #72.63
        vrcp14pd  zmm27, zmm20                                  #75.38
        vcmppd    k5, zmm20, zmm16, 1                           #74.22
        vfpclasspd k0, zmm27, 30                                #75.38
        vfnmadd213pd zmm20, zmm27, QWORD BCST .L_2il0floatpacket.5[rip] #75.38
        knotw     k4, k0                                        #75.38
        vmulpd    zmm21, zmm20, zmm20                           #75.38
        vfmadd213pd zmm27{k4}, zmm20, zmm27                     #75.38
        vfmadd213pd zmm27{k4}, zmm21, zmm27                     #75.38
        vmulpd    zmm22, zmm27, zmm15                           #76.38
        vmulpd    zmm24, zmm27, zmm14                           #77.54
        vmulpd    zmm25, zmm27, zmm22                           #76.44
        vmulpd    zmm23, zmm27, zmm25                           #76.50
        vfmsub213pd zmm27, zmm25, zmm7                          #77.54
        vmulpd    zmm26, zmm23, zmm24                           #77.61
        vmulpd    zmm30, zmm26, zmm27                           #77.67
        vfmadd231pd zmm13{k5}, zmm30, zmm28                     #78.17
        vfmadd231pd zmm12{k5}, zmm30, zmm29                     #79.17
        vfmadd231pd zmm11{k5}, zmm30, zmm31                     #80.17
        cmp       r9d, ebx                                      #67.9
        jb        ..B1.22       # Prob 82%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm0 zmm1 zmm2 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.24:                        # Preds ..B1.22 ..B1.20 ..B1.32
                                # Execution count [5.00e+00]
        lea       ecx, DWORD PTR [1+rbx]                        #67.9
        cmp       ecx, r13d                                     #67.9
        ja        ..B1.26       # Prob 50%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.25:                        # Preds ..B1.24
                                # Execution count [2.50e+01]
        imul      r8, r12                                       #56.43
        vbroadcastsd zmm9, xmm9                                 #59.23
        vbroadcastsd zmm2, xmm8                                 #58.23
        vbroadcastsd zmm10, xmm10                               #60.23
        sub       r13d, ebx                                     #67.9
        add       r8, r11                                       #37.5
        vpbroadcastd ymm0, r13d                                 #67.9
        vpcmpgtd  k5, ymm0, ymm17                               #67.9
        movsxd    rbx, ebx                                      #67.9
        vmovaps   zmm4, zmm19                                   #70.36
        kmovw     k2, k5                                        #70.36
        vmovaps   zmm3, zmm19                                   #69.36
        vmovdqu32 ymm1{k5}{z}, YMMWORD PTR [r8+rbx*4]           #68.21
        kmovw     k1, k5                                        #69.36
        vmovaps   zmm5, zmm19                                   #71.36
        kmovw     k3, k5                                        #71.36
        vgatherdpd zmm5{k3}, QWORD PTR [rsi+ymm1*8]             #71.36
        vgatherdpd zmm4{k2}, QWORD PTR [rax+ymm1*8]             #70.36
        vgatherdpd zmm3{k1}, QWORD PTR [rdx+ymm1*8]             #69.36
        vsubpd    zmm30, zmm10, zmm5                            #71.36
        vsubpd    zmm28, zmm9, zmm4                             #70.36
        vsubpd    zmm27, zmm2, zmm3                             #69.36
        vmulpd    zmm26, zmm28, zmm28                           #72.49
        vfmadd231pd zmm26, zmm27, zmm27                         #72.49
        vfmadd231pd zmm26, zmm30, zmm30                         #72.63
        vrcp14pd  zmm25, zmm26                                  #75.38
        vcmppd    k6{k5}, zmm26, zmm16, 1                       #74.22
        vfpclasspd k0, zmm25, 30                                #75.38
        vmovaps   zmm6, zmm26                                   #75.38
        vfnmadd213pd zmm6, zmm25, QWORD BCST .L_2il0floatpacket.5[rip] #75.38
        knotw     k4, k0                                        #75.38
        vmulpd    zmm8, zmm6, zmm6                              #75.38
        vfmadd213pd zmm25{k4}, zmm6, zmm25                      #75.38
        vfmadd213pd zmm25{k4}, zmm8, zmm25                      #75.38
        vmulpd    zmm20, zmm25, zmm15                           #76.38
        vmulpd    zmm22, zmm25, zmm14                           #77.54
        vmulpd    zmm23, zmm25, zmm20                           #76.44
        vmulpd    zmm21, zmm25, zmm23                           #76.50
        vfmsub213pd zmm25, zmm23, zmm7                          #77.54
        vmulpd    zmm24, zmm21, zmm22                           #77.61
        vmulpd    zmm29, zmm24, zmm25                           #77.67
        vfmadd231pd zmm13{k6}, zmm29, zmm27                     #78.17
        vfmadd231pd zmm12{k6}, zmm29, zmm28                     #79.17
        vfmadd231pd zmm11{k6}, zmm29, zmm30                     #80.17
                                # LOE rax rdx rbp rsi rdi r10 r11 r12 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.26:                        # Preds ..B1.19 ..B1.25 ..B1.24
                                # Execution count [4.50e+00]
        vmovups   zmm10, ZMMWORD PTR .L_2il0floatpacket.6[rip]  #63.22
        vpermd    zmm0, zmm10, zmm11                            #63.22
        vpermd    zmm5, zmm10, zmm12                            #62.22
        vpermd    zmm21, zmm10, zmm13                           #61.22
        vaddpd    zmm11, zmm0, zmm11                            #63.22
        vaddpd    zmm12, zmm5, zmm12                            #62.22
        vaddpd    zmm13, zmm21, zmm13                           #61.22
        vpermpd   zmm1, zmm11, 78                               #63.22
        vpermpd   zmm6, zmm12, 78                               #62.22
        vpermpd   zmm22, zmm13, 78                              #61.22
        vaddpd    zmm2, zmm11, zmm1                             #63.22
        vaddpd    zmm8, zmm12, zmm6                             #62.22
        vaddpd    zmm23, zmm13, zmm22                           #61.22
        vpermpd   zmm3, zmm2, 177                               #63.22
        vpermpd   zmm9, zmm8, 177                               #62.22
        vpermpd   zmm24, zmm23, 177                             #61.22
        vaddpd    zmm4, zmm2, zmm3                              #63.22
        vaddpd    zmm20, zmm8, zmm9                             #62.22
        vaddpd    zmm25, zmm23, zmm24                           #61.22
                                # LOE rax rdx rbp rsi rdi r10 r11 r12 xmm4 xmm20 xmm25 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.27:                        # Preds ..B1.26 ..B1.9
                                # Execution count [5.00e+00]
        mov       rcx, QWORD PTR [-8+rsp]                       #84.9[spill]
        mov       rbx, QWORD PTR [-16+rsp]                      #85.9[spill]
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
        jb        ..B1.9        # Prob 82%                      #55.5
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.28:                        # Preds ..B1.27
                                # Execution count [9.00e-01]
        mov       r15, QWORD PTR [-40+rsp]                      #[spill]
	.cfi_restore 15
        mov       rbx, QWORD PTR [-48+rsp]                      #[spill]
	.cfi_restore 3
                                # LOE rbx rbp r15
..B1.30:                        # Preds ..B1.1 ..B1.28
                                # Execution count [1.00e+00]
        vzeroupper                                              #93.12
        vxorpd    xmm0, xmm0, xmm0                              #93.12
	.cfi_restore 14
        pop       r14                                           #93.12
	.cfi_def_cfa_offset 24
	.cfi_restore 13
        pop       r13                                           #93.12
	.cfi_def_cfa_offset 16
	.cfi_restore 12
        pop       r12                                           #93.12
	.cfi_def_cfa_offset 8
        ret                                                     #93.12
	.cfi_def_cfa_offset 32
	.cfi_offset 3, -80
	.cfi_offset 12, -16
	.cfi_offset 13, -24
	.cfi_offset 14, -32
	.cfi_offset 15, -72
                                # LOE
..B1.31:                        # Preds ..B1.11
                                # Execution count [4.50e-01]: Infreq
        mov       ebx, r13d                                     #67.9
        xor       r9d, r9d                                      #67.9
        and       ebx, -8                                       #67.9
        jmp       ..B1.20       # Prob 100%                     #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.32:                        # Preds ..B1.10
                                # Execution count [4.50e-01]: Infreq
        xor       ebx, ebx                                      #67.9
        jmp       ..B1.24       # Prob 100%                     #67.9
        .align    16,0x90
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
	.cfi_endproc
# mark_end;
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
