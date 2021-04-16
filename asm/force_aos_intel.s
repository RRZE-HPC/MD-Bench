# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.5.281 Build 20190815";
# mark_description "-I./src/includes -S -masm=intel -D_GNU_SOURCE -DAOS -DPRECISION=2 -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX";
# mark_description "512 -qopt-zmm-usage=high -o ICC/force.s";
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
# r8 <- atom
        mov       r8, rsi                                       #35.1
# xmm2 <- param->cutforce
        vmovsd    xmm2, QWORD PTR [72+rdi]                      #38.27
# rax <- neighbors
        mov       rax, rdx                                      #35.1
# xmm1 <- param->sigma6
        vmovsd    xmm1, QWORD PTR [8+rdi]                       #39.23
# xmm0 <- param->epsilon
        vmovsd    xmm0, QWORD PTR [rdi]                         #40.24
# r12d <- atom->Nlocal
        mov       r12d, DWORD PTR [4+r8]                        #36.18
# r11 <- atom->fx
        mov       r11, QWORD PTR [64+r8]                        #41.20
# rdx <- atom->fy
        mov       rdx, QWORD PTR [72+r8]                        #41.45
# r9 <- atom->fz
        mov       r9, QWORD PTR [80+r8]                         #41.70
# atom->Nlocal > 0
        test      r12d, r12d                                    #44.24
        jle       ..B1.42       # Prob 50%                      #44.24
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.2:                         # Preds ..B1.1
                                # Execution count [1.00e+00]
# edi <- atom->Nlocal
        mov       edi, r12d                                     #44.5
# esi <- 0
        xor       esi, esi                                      #44.5
# r10d <- 1
        mov       r10d, 1                                       #44.5
# ecx <- 0
        xor       ecx, ecx                                      #44.5
# edi <- atom->Nlocal >> 1
        shr       edi, 1                                        #44.5
        je        ..B1.6        # Prob 9%                       #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r11 r14 r15 r10d r12d xmm0 xmm1 xmm2
..B1.3:                         # Preds ..B1.2
                                # Execution count [9.00e-01]
# r10d <- 0
        xor       r10d, r10d                                    #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.4:                         # Preds ..B1.4 ..B1.3
                                # Execution count [2.50e+00]
# atom->fx[i] <- 0.0
        mov       QWORD PTR [rcx+r11], r10                      #45.9
# i++
        inc       rsi                                           #44.5
# atom->fy[i] <- 0.0
        mov       QWORD PTR [rcx+rdx], r10                      #46.9
# atom->fz[i] <- 0.0
        mov       QWORD PTR [rcx+r9], r10                       #47.9
        mov       QWORD PTR [8+rcx+r11], r10                    #45.9
        mov       QWORD PTR [8+rcx+rdx], r10                    #46.9
        mov       QWORD PTR [8+rcx+r9], r10                     #47.9
        add       rcx, 16                                       #44.5
        cmp       rsi, rdi                                      #44.5
        jb        ..B1.4        # Prob 63%                      #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.5:                         # Preds ..B1.4
                                # Execution count [9.00e-01]
        lea       r10d, DWORD PTR [1+rsi+rsi]                   #45.9
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r10d r12d xmm0 xmm1 xmm2
..B1.6:                         # Preds ..B1.2 ..B1.5
                                # Execution count [1.00e+00]
        lea       ecx, DWORD PTR [-1+r10]                       #44.5
        cmp       ecx, r12d                                     #44.5
        jae       ..B1.8        # Prob 9%                       #44.5
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r10d r12d xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.6
                                # Execution count [9.00e-01]
        movsxd    r10, r10d                                     #44.5
        xor       ecx, ecx                                      #45.9
        mov       QWORD PTR [-8+r11+r10*8], rcx                 #45.9
        mov       QWORD PTR [-8+rdx+r10*8], rcx                 #46.9
        mov       QWORD PTR [-8+r9+r10*8], rcx                  #47.9
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.6 ..B1.7
                                # Execution count [9.00e-01]
# xmm13 <- cutforcesq
        vmulsd    xmm13, xmm2, xmm2                             #38.45
# ecx <- i
        xor       ecx, ecx                                      #55.15
# ymm16 <- 8 (vector width / sizeof(double) ?)
        vmovdqu32 ymm16, YMMWORD PTR .L_2il0floatpacket.0[rip]  #67.9
# xmm0 <- 48 * sr6
        vmulsd    xmm0, xmm0, QWORD PTR .L_2il0floatpacket.3[rip] #77.41
# ymm15 <- [0..7]
        vmovdqu   ymm15, YMMWORD PTR .L_2il0floatpacket.1[rip]  #67.9
# zmm5 <- 0.5
        vmovups   zmm5, ZMMWORD PTR .L_2il0floatpacket.4[rip]   #77.54
# zmm14 <- cutforcesq
        vbroadcastsd zmm14, xmm13                               #38.25
# zmm13 <- param->sigma6
        vbroadcastsd zmm13, xmm1                                #39.21
# zmm10 <- param->epsilon
        vbroadcastsd zmm10, xmm0                                #77.41
# r12 <- atom->nlocal
        movsxd    r12, r12d                                     #55.5
# esi <- 0 (i)
        xor       esi, esi                                      #55.5
# r13 <- neighbor->numneighs
        mov       r13, QWORD PTR [24+rax]                       #57.25
# rdi <- atom->x
        mov       rdi, QWORD PTR [16+r8]                        #58.25
# r8 <- neighbor->maxneighs
        movsxd    r8, DWORD PTR [16+rax]                        #56.43
# r10 <- neighbor->neighbors
        mov       r10, QWORD PTR [8+rax]                        #56.19
# eax <- 0 (i * 3)
        xor       eax, eax                                      #55.5
# r8 <- neighbor->maxneighs << 2
        shl       r8, 2                                         #37.5
# [-24+rsp] <- atom->nlocal
        mov       QWORD PTR [-24+rsp], r12                      #55.5[spill]
# [-16+rsp] <- neighbor->numneigh
        mov       QWORD PTR [-16+rsp], r13                      #55.5[spill]
# [-8+rsp] <- atom->fx
        mov       QWORD PTR [-8+rsp], r11                       #55.5[spill]
# [-88+rsp] <- r14 (unused so far)
        mov       QWORD PTR [-88+rsp], r14                      #55.5[spill]
# [-96+rsp] <- r15 (unused so far)
        mov       QWORD PTR [-96+rsp], r15                      #55.5[spill]
# [-104+rsp] <- rbx (unused so far)
        mov       QWORD PTR [-104+rsp], rbx                     #55.5[spill]
	.cfi_offset 3, -128
	.cfi_offset 14, -112
	.cfi_offset 15, -120
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.9:                         # Preds ..B1.39 ..B1.8
                                # Execution count [5.00e+00]
# rbx <- neighbor->numneigh
        mov       rbx, QWORD PTR [-16+rsp]                      #57.25[spill]
# xmm24 <- 0 (fix)
        vxorpd    xmm24, xmm24, xmm24                           #61.22
# xmm18 <- 0 (fiy)
        vmovapd   xmm18, xmm24                                  #62.22
# r11d <- neighbor->numneigh[i]
        mov       r11d, DWORD PTR [rbx+rsi*4]                   #57.25
# xmm4 <- 0 (fiz)
        vmovapd   xmm4, xmm18                                   #63.22
# xmm6 <- atom->x[i * 3]
        vmovsd    xmm6, QWORD PTR [rax+rdi]                     #58.25
# xmm6 <- atom->x[i * 3 + 1]
        vmovsd    xmm7, QWORD PTR [8+rax+rdi]                   #59.25
# xmm6 <- atom->x[i * 3 + 2]
        vmovsd    xmm12, QWORD PTR [16+rax+rdi]                 #60.25
# neighbor->numneigh[i] > 0
        test      r11d, r11d                                    #67.28
        jle       ..B1.39       # Prob 50%                      #67.28
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d xmm4 xmm6 xmm7 xmm12 xmm18 xmm24 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
# zmm9 <- 0 (fix)
        vpxord    zmm9, zmm9, zmm9                              #61.22
# zmm8 <- 0 (fiy)
        vmovaps   zmm8, zmm9                                    #62.22
# zmm11 <- 0 (fiz)
        vmovaps   zmm11, zmm8                                   #63.22
# neighbor->numneigh[i] < 8
        cmp       r11d, 8                                       #67.9
        jl        ..B1.44       # Prob 10%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
# neighbor->numneigh[i] < 1200
# L1? 1200 * 3 * 8 = 28800 = 28.8kB
        cmp       r11d, 1200                                    #67.9
        jl        ..B1.43       # Prob 10%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14






































..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
# r15 <- neighbor->maxneighs 
        mov       r15, r8                                       #56.43
# r15 <- neighbor->maxneighs * i
        imul      r15, rcx                                      #56.43
# r15 <- neighbor->neighbors + neighbor->maxneighs * i
        add       r15, r10                                      #37.5
# r12 <- neighbor->neighbors + neighbor->maxneighs * i
        mov       r12, r15                                      #67.9
# r12 <- (neighbor->neighbors + neighbor->maxneighs * i) & 63 -- 0b00111111
        and       r12, 63                                       #67.9
# (neighbor->neighbors + neighbor->maxneighs * i) & 63 == 3 -- 0b00000011
        test      r12d, 3                                       #67.9
        je        ..B1.14       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
# r12d <- 0
        xor       r12d, r12d                                    #67.9
        jmp       ..B1.16       # Prob 100%                     #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.14:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
# r12d == 0
        test      r12d, r12d                                    #67.9
        je        ..B1.16       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.15:                        # Preds ..B1.14
                                # Execution count [2.50e+01]
# r12d <- ~r12d + 1
        neg       r12d                                          #67.9
# r12d <- (~r12d + 1) + 64
        add       r12d, 64                                      #67.9
# r12d <- ((~r12d + 1) + 64) >> 2
        shr       r12d, 2                                       #67.9
# neighbor->numneigh[i] < r12d
        cmp       r11d, r12d                                    #67.9
# r12d <- min(r12d, neighbor->numneigh[i])
        cmovl     r12d, r11d                                    #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.16:                        # Preds ..B1.13 ..B1.15 ..B1.14
                                # Execution count [5.00e+00]
# r14d <- neighbor->numneigh[i]
        mov       r14d, r11d                                    #67.9
# r14d <- neighbor->numneigh[i] - r12d
        sub       r14d, r12d                                    #67.9
# r14d <- (neighbor->numneigh[i] - r12d) & 7 (0b0111)
        and       r14d, 7                                       #67.9
# r14d <- ~r14d + 1
        neg       r14d                                          #67.9
# r14d <- r14d + neighbor->numneigh[i]
        add       r14d, r11d                                    #67.9
# r12d < 1
        cmp       r12d, 1                                       #67.9
        jb        ..B1.24       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
# ymm3 <- [0..7]
        vmovdqa   ymm3, ymm15                                   #67.9
# r13d <- 0
        xor       r13d, r13d                                    #67.9
# ymm2 <- r12d (k? amount of neighs?)
        vpbroadcastd ymm2, r12d                                 #67.9
# zmm1 <- atom->x[i * 3]
        vbroadcastsd zmm1, xmm6                                 #58.23
# zmm0 <- atom->x[i * 3 + 1]
        vbroadcastsd zmm0, xmm7                                 #59.23
# zmm4 <- atom->x[i * 3 + 2]
        vbroadcastsd zmm4, xmm12                                #60.23
# rbx <- r12d (k? amount of neighs?)
        movsxd    rbx, r12d                                     #67.9
# [-80+rsp] <- atom->fz
        mov       QWORD PTR [-80+rsp], r9                       #67.9[spill]
# [-72+rdx] <- atom->fy
        mov       QWORD PTR [-72+rsp], rdx                      #67.9[spill]
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.18:                        # Preds ..B1.22 ..B1.17
                                # Execution count [2.50e+01]
# k3 <- [x when amount_of_neighs < [0..7](x)] (i.e. mask of available neighbors)
        vpcmpgtd  k3, ymm2, ymm3                                #67.9
# ymm17 <- neighs[k]
        vmovdqu32 ymm17{k3}{z}, YMMWORD PTR [r15+r13*4]         #68.21
# r9d <- k3
        kmovw     r9d, k3                                       #67.9
# ymm18 <- neighs[k] * 2
        vpaddd    ymm18, ymm17, ymm17                           #69.36
# ymm17 <- neighs[k] * 3
        vpaddd    ymm17, ymm17, ymm18                           #69.36
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r9d r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 ymm17 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 k3
..B1.21:                        # Preds ..B1.18
                                # Execution count [1.25e+01]
# k1 <- k3
        kmovw     k1, k3                                        #69.36
# k2 <- k3
        kmovw     k2, k3                                        #69.36
# zmm18 <- 0.0
        vpxord    zmm18, zmm18, zmm18                           #69.36
# zmm19 <- 0.0
        vpxord    zmm19, zmm19, zmm19                           #69.36
# zmm20 <- 0.0
        vpxord    zmm20, zmm20, zmm20                           #69.36
# zmm18 <- atom->x[j * 3 + 2]
        vgatherdpd zmm18{k1}, QWORD PTR [16+rdi+ymm17*8]        #69.36
# zmm19 <- atom->x[j * 3 + 1]
        vgatherdpd zmm19{k2}, QWORD PTR [8+rdi+ymm17*8]         #69.36
# zmm20 <- atom->x[j * 3]
        vgatherdpd zmm20{k3}, QWORD PTR [rdi+ymm17*8]           #69.36
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r9d r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 zmm18 zmm19 zmm20
..B1.22:                        # Preds ..B1.21
                                # Execution count [2.50e+01]
# k++ (+= 8)
        add       r13, 8                                        #67.9
# ymm3 <- [0..7] + 8
        vpaddd    ymm3, ymm3, ymm16                             #67.9
# zmm29 <- atom->x[i * 3 + 2] - atom->x[j * 3 + 2]
        vsubpd    zmm29, zmm4, zmm18                            #71.36
# zmm27 <- atom->x[i * 3 + 1] - atom->x[j * 3 + 1]
        vsubpd    zmm27, zmm0, zmm19                            #70.36
# zmm26 <- atom->x[i * 3] - atom->x[j * 3]
        vsubpd    zmm26, zmm1, zmm20                            #69.36
# zmm25 <- dely * dely 
        vmulpd    zmm25, zmm27, zmm27                           #72.49
# zmm25 <- delx * delx + dely * dely
        vfmadd231pd zmm25, zmm26, zmm26                         #72.49
# zmm25 <- rsq (delz * delz + delx * delx + dely * dely)
        vfmadd231pd zmm25, zmm29, zmm29                         #72.63
# zmm24 <- sr2 (1.0 / rsq -- compute reciprocal)
        vrcp14pd  zmm24, zmm25                                  #75.38
# k2 <- [rsq < cutforcesq]
        vcmppd    k2, zmm25, zmm14, 1                           #74.22
# k0 <- [true when +0, Neg. 0, +inf, -inf] 
        vfpclasspd k0, zmm24, 30                                #75.38
# edx <- k2
        kmovw     edx, k2                                       #74.22
# k1 <- [false when +0, Neg. 0, +inf, -inf]
        knotw     k1, k0                                        #75.38
# zmm17 <- rsq
        vmovaps   zmm17, zmm25                                  #75.38
# r9d <- [true if k < numneighs and rsq < cutforcesq]
        and       r9d, edx                                      #74.22
# zmm17 <- [-(rsq * sr2) + 1.0] -- check if 1.0 / rsq is valid! -- call it error?
        vfnmadd213pd zmm17, zmm24, QWORD BCST .L_2il0floatpacket.9[rip] #75.38
# k3 <- [true if k < numneighs and rsq < cutforcesq]
        kmovw     k3, r9d                                       #78.17
# zmm18 <- [(-rsq * sr2 + 1.0) * (-rsq * sr2 + 1.0)] -- errorsq
        vmulpd    zmm18, zmm17, zmm17                           #75.38
# zmm24 <- [sr2 * error + sr2]
        vfmadd213pd zmm24{k1}, zmm17, zmm24                     #75.38
# zmm24 <- [(sr2 * error + sr2) * errorsq + (sr2 * error + sr2)]
        vfmadd213pd zmm24{k1}, zmm18, zmm24                     #75.38
# zmm19 <- sr2 * sigma6
        vmulpd    zmm19, zmm24, zmm13                           #76.38
# zmm21 <- sr2 * epsilon
        vmulpd    zmm21, zmm24, zmm10                           #77.54
# zmm22 <- sr2 * sr2 * sigma6
        vmulpd    zmm22, zmm24, zmm19                           #76.44
# zmm20 <- sr6 (sr2 * sr2 * sr2 * sigma6)
        vmulpd    zmm20, zmm24, zmm22                           #76.50
# zmm24 <- sr2 * (sr2 * sr2 * sigma) - 0.5 (why not vsubpd zmm24, zmm20, zmm5 ?)
        vfmsub213pd zmm24, zmm22, zmm5                          #77.54
# zmm23 <- (sr6) * (sr2 * epsilon)
        vmulpd    zmm23, zmm20, zmm21                           #77.61
# zmm28 <- force -- (sr6 * sr2 * epsilon) * (sr6 - 0.5)
        vmulpd    zmm28, zmm23, zmm24                           #77.67
# zmm9 <- force * delx + fix
        vfmadd231pd zmm9{k3}, zmm28, zmm26                      #78.17
# zmm8 <- force * dely + fiy
        vfmadd231pd zmm8{k3}, zmm28, zmm27                      #79.17
# zmm11 <- force * delz + fiz
        vfmadd231pd zmm11{k3}, zmm28, zmm29                     #80.17
# k < numneighs
        cmp       r13, rbx                                      #67.9
        jb        ..B1.18       # Prob 82%                      #67.9
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.23:                        # Preds ..B1.22
                                # Execution count [4.50e+00]
# r9 <- atom->fz
        mov       r9, QWORD PTR [-80+rsp]                       #[spill]
# rdx <- atom->fy
        mov       rdx, QWORD PTR [-72+rsp]                      #[spill]
# numneighs == amount_of_neighs
        cmp       r11d, r12d                                    #67.9
        je        ..B1.38       # Prob 10%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14









































































..B1.24:                        # Preds ..B1.23 ..B1.16 ..B1.43
                                # Execution count [2.50e+01]
# COND: neighbor->numneigh[i] < 1200
# ebx <- k + 8 
        lea       ebx, DWORD PTR [8+r12]                        #67.9
# k - (k % 8) < k + 8   TODO: this may be wrong, but probably checks if the number of remaining neighbors is less than 8
        cmp       r14d, ebx                                     #67.9
        jl        ..B1.32       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.25:                        # Preds ..B1.24
                                # Execution count [4.50e+00]
# r13 <- neighbor->maxneighs << 2
        mov       r13, r8                                       #56.43
# r13 <- neighbor->maxneighs * 4 * i
        imul      r13, rcx                                      #56.43
# zmm2 <- atom->x[i * 3]
        vbroadcastsd zmm2, xmm6                                 #58.23
# zmm1 <- atom->x[i * 3 + 1]
        vbroadcastsd zmm1, xmm7                                 #59.23
# zmm0 <- atom->x[i * 3 + 2]
        vbroadcastsd zmm0, xmm12                                #60.23
# rbx <- r12d (k? amount of neighs?)
        movsxd    rbx, r12d                                     #67.9
# r13 <- neighs (neighbor->neighbors + neighbor->maxneighs * 4 * i)
        add       r13, r10                                      #37.5
        mov       QWORD PTR [-64+rsp], rax                      #37.5[spill]
        mov       QWORD PTR [-56+rsp], r8                       #37.5[spill]
        mov       QWORD PTR [-48+rsp], r10                      #37.5[spill]
        mov       QWORD PTR [-40+rsp], rsi                      #37.5[spill]
        mov       QWORD PTR [-32+rsp], rcx                      #37.5[spill]
        mov       QWORD PTR [-80+rsp], r9                       #37.5[spill]
        mov       QWORD PTR [-72+rsp], rdx                      #37.5[spill]
                                # LOE rbx rbp rdi r13 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.26:                        # Preds ..B1.30 ..B1.25
                                # Execution count [2.50e+01]
# ymm3 <- neighs[k]
        vmovdqu   ymm3, YMMWORD PTR [r13+rbx*4]                 #68.21
# ymm4 <- neighs[k] * 2
        vpaddd    ymm4, ymm3, ymm3                              #69.36
# ymm3 <- neighs[k] * 3
        vpaddd    ymm3, ymm3, ymm4                              #69.36

# Prefetching Instructions????????????
# r10d <- neighs[k]
        mov       r10d, DWORD PTR [r13+rbx*4]                   #68.21
# r9d <- neighs[k + 1]
        mov       r9d, DWORD PTR [4+r13+rbx*4]                  #68.21
# r8d <- neighs[k + 2]
        mov       r8d, DWORD PTR [8+r13+rbx*4]                  #68.21
# esi <- neighs[k + 3]
        mov       esi, DWORD PTR [12+r13+rbx*4]                 #68.21
# r10d <- neighs[k] * 3
        lea       r10d, DWORD PTR [r10+r10*2]                   #69.36
# ecx <- neighs[k + 4]
        mov       ecx, DWORD PTR [16+r13+rbx*4]                 #68.21
# r9d <- neighs[k + 1] * 3
        lea       r9d, DWORD PTR [r9+r9*2]                      #69.36
# edx <- neighs[k + 5]
        mov       edx, DWORD PTR [20+r13+rbx*4]                 #68.21
# r8d <- neighs[k + 2] * 3
        lea       r8d, DWORD PTR [r8+r8*2]                      #69.36
# edx <- neighs[k + 6]
        mov       eax, DWORD PTR [24+r13+rbx*4]                 #68.21
# esi <- neighs[k + 3] * 3
        lea       esi, DWORD PTR [rsi+rsi*2]                    #69.36
# edx <- neighs[k + 7]
        mov       r15d, DWORD PTR [28+r13+rbx*4]                #68.21
# ecx <- neighs[k + 4] * 3
        lea       ecx, DWORD PTR [rcx+rcx*2]                    #69.36
# ecx <- neighs[k + 5] * 3
        lea       edx, DWORD PTR [rdx+rdx*2]                    #69.36
# ecx <- neighs[k + 6] * 3
        lea       eax, DWORD PTR [rax+rax*2]                    #69.36
# ecx <- neighs[k + 7] * 3
        lea       r15d, DWORD PTR [r15+r15*2]                   #69.36
                                # LOE rbx rbp rdi r13 eax edx ecx esi r8d r9d r10d r11d r12d r14d r15d xmm6 xmm7 xmm12 ymm3 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.29:                        # Preds ..B1.26
                                # Execution count [1.25e+01]
        vpcmpeqb  k1, xmm0, xmm0                                #69.36
        vpcmpeqb  k2, xmm0, xmm0                                #69.36
        vpcmpeqb  k3, xmm0, xmm0                                #69.36
        vpxord    zmm4, zmm4, zmm4                              #69.36
        vpxord    zmm17, zmm17, zmm17                           #69.36
        vpxord    zmm18, zmm18, zmm18                           #69.36
        vgatherdpd zmm4{k1}, QWORD PTR [16+rdi+ymm3*8]          #69.36
        vgatherdpd zmm17{k2}, QWORD PTR [8+rdi+ymm3*8]          #69.36
        vgatherdpd zmm18{k3}, QWORD PTR [rdi+ymm3*8]            #69.36
                                # LOE rbx rbp rdi r13 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 zmm17 zmm18
..B1.30:                        # Preds ..B1.29
                                # Execution count [2.50e+01]
        add       r12d, 8                                       #67.9
        add       rbx, 8                                        #67.9
        vsubpd    zmm26, zmm0, zmm4                             #71.36
        vsubpd    zmm24, zmm1, zmm17                            #70.36
        vsubpd    zmm23, zmm2, zmm18                            #69.36
        vmulpd    zmm3, zmm24, zmm24                            #72.49
        vfmadd231pd zmm3, zmm23, zmm23                          #72.49
        vfmadd231pd zmm3, zmm26, zmm26                          #72.63
        vrcp14pd  zmm22, zmm3                                   #75.38
        vcmppd    k2, zmm3, zmm14, 1                            #74.22
        vfpclasspd k0, zmm22, 30                                #75.38
        vfnmadd213pd zmm3, zmm22, QWORD BCST .L_2il0floatpacket.9[rip] #75.38
        knotw     k1, k0                                        #75.38
        vmulpd    zmm4, zmm3, zmm3                              #75.38
        vfmadd213pd zmm22{k1}, zmm3, zmm22                      #75.38
        vfmadd213pd zmm22{k1}, zmm4, zmm22                      #75.38
        vmulpd    zmm17, zmm22, zmm13                           #76.38
        vmulpd    zmm19, zmm22, zmm10                           #77.54
        vmulpd    zmm20, zmm22, zmm17                           #76.44
        vmulpd    zmm18, zmm22, zmm20                           #76.50
        vfmsub213pd zmm22, zmm20, zmm5                          #77.54
        vmulpd    zmm21, zmm18, zmm19                           #77.61
        vmulpd    zmm25, zmm21, zmm22                           #77.67
        vfmadd231pd zmm9{k2}, zmm25, zmm23                      #78.17
        vfmadd231pd zmm8{k2}, zmm25, zmm24                      #79.17
        vfmadd231pd zmm11{k2}, zmm25, zmm26                     #80.17
        cmp       r12d, r14d                                    #67.9
        jb        ..B1.26       # Prob 82%                      #67.9
                                # LOE rbx rbp rdi r13 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.31:                        # Preds ..B1.30
                                # Execution count [4.50e+00]
        mov       rax, QWORD PTR [-64+rsp]                      #[spill]
        mov       r8, QWORD PTR [-56+rsp]                       #[spill]
        mov       r10, QWORD PTR [-48+rsp]                      #[spill]
        mov       rsi, QWORD PTR [-40+rsp]                      #[spill]
        mov       rcx, QWORD PTR [-32+rsp]                      #[spill]
        mov       r9, QWORD PTR [-80+rsp]                       #[spill]
        mov       rdx, QWORD PTR [-72+rsp]                      #[spill]
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14




































































..B1.32:                        # Preds ..B1.31 ..B1.24 ..B1.44
                                # Execution count [5.00e+00]
# COND: neighbor->numneigh[i] < 8
        lea       ebx, DWORD PTR [1+r14]                        #67.9
        cmp       ebx, r11d                                     #67.9
        ja        ..B1.38       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.33:                        # Preds ..B1.32
                                # Execution count [2.50e+01]
        imul      rcx, r8                                       #56.43
        vbroadcastsd zmm4, xmm6                                 #58.23
        sub       r11d, r14d                                    #67.9
        add       rcx, r10                                      #37.5
        vpbroadcastd ymm0, r11d                                 #67.9
        vpcmpgtd  k3, ymm0, ymm15                               #67.9
        movsxd    r14, r14d                                     #67.9
        kmovw     ebx, k3                                       #67.9
        vmovdqu32 ymm1{k3}{z}, YMMWORD PTR [rcx+r14*4]          #68.21
        vpaddd    ymm2, ymm1, ymm1                              #69.36
        vpaddd    ymm0, ymm1, ymm2                              #69.36
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 ebx xmm7 xmm12 ymm0 ymm15 ymm16 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 k3
..B1.36:                        # Preds ..B1.33
                                # Execution count [1.25e+01]
        kmovw     k1, k3                                        #69.36
        kmovw     k2, k3                                        #69.36
        vpxord    zmm1, zmm1, zmm1                              #69.36
        vpxord    zmm2, zmm2, zmm2                              #69.36
        vpxord    zmm3, zmm3, zmm3                              #69.36
        vgatherdpd zmm1{k1}, QWORD PTR [16+rdi+ymm0*8]          #69.36
        vgatherdpd zmm2{k2}, QWORD PTR [8+rdi+ymm0*8]           #69.36
        vgatherdpd zmm3{k3}, QWORD PTR [rdi+ymm0*8]             #69.36
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 ebx xmm7 xmm12 ymm15 ymm16 zmm1 zmm2 zmm3 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.37:                        # Preds ..B1.36
                                # Execution count [2.50e+01]
        vbroadcastsd zmm7, xmm7                                 #59.23
        vbroadcastsd zmm12, xmm12                               #60.23
        vsubpd    zmm23, zmm12, zmm1                            #71.36
        vsubpd    zmm21, zmm7, zmm2                             #70.36
        vsubpd    zmm20, zmm4, zmm3                             #69.36
        vmulpd    zmm19, zmm21, zmm21                           #72.49
        vfmadd231pd zmm19, zmm20, zmm20                         #72.49
        vfmadd231pd zmm19, zmm23, zmm23                         #72.63
        vrcp14pd  zmm18, zmm19                                  #75.38
        vcmppd    k2, zmm19, zmm14, 1                           #74.22
        vfpclasspd k0, zmm18, 30                                #75.38
        kmovw     ecx, k2                                       #74.22
        knotw     k1, k0                                        #75.38
        vmovaps   zmm0, zmm19                                   #75.38
        and       ebx, ecx                                      #74.22
        vfnmadd213pd zmm0, zmm18, QWORD BCST .L_2il0floatpacket.9[rip] #75.38
        kmovw     k3, ebx                                       #78.17
        vmulpd    zmm1, zmm0, zmm0                              #75.38
        vfmadd213pd zmm18{k1}, zmm0, zmm18                      #75.38
        vfmadd213pd zmm18{k1}, zmm1, zmm18                      #75.38
        vmulpd    zmm2, zmm18, zmm13                            #76.38
        vmulpd    zmm4, zmm18, zmm10                            #77.54
        vmulpd    zmm6, zmm18, zmm2                             #76.44
        vmulpd    zmm3, zmm18, zmm6                             #76.50
        vfmsub213pd zmm18, zmm6, zmm5                           #77.54
        vmulpd    zmm17, zmm3, zmm4                             #77.61
        vmulpd    zmm22, zmm17, zmm18                           #77.67
        vfmadd231pd zmm9{k3}, zmm22, zmm20                      #78.17
        vfmadd231pd zmm8{k3}, zmm22, zmm21                      #79.17
        vfmadd231pd zmm11{k3}, zmm22, zmm23                     #80.17









































                                # LOE rax rdx rbp rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.38:                        # Preds ..B1.23 ..B1.37 ..B1.32
                                # Execution count [4.50e+00]
        vmovups   zmm19, ZMMWORD PTR .L_2il0floatpacket.10[rip] #63.22
        vpermd    zmm0, zmm19, zmm11                            #63.22
        vpermd    zmm6, zmm19, zmm8                             #62.22
        vpermd    zmm20, zmm19, zmm9                            #61.22
        vaddpd    zmm11, zmm0, zmm11                            #63.22
        vaddpd    zmm8, zmm6, zmm8                              #62.22
        vaddpd    zmm9, zmm20, zmm9                             #61.22
        vpermpd   zmm1, zmm11, 78                               #63.22
        vpermpd   zmm7, zmm8, 78                                #62.22
        vpermpd   zmm21, zmm9, 78                               #61.22
        vaddpd    zmm2, zmm11, zmm1                             #63.22
        vaddpd    zmm12, zmm8, zmm7                             #62.22
        vaddpd    zmm22, zmm9, zmm21                            #61.22
        vpermpd   zmm3, zmm2, 177                               #63.22
        vpermpd   zmm17, zmm12, 177                             #62.22
        vpermpd   zmm23, zmm22, 177                             #61.22
        vaddpd    zmm4, zmm2, zmm3                              #63.22
        vaddpd    zmm18, zmm12, zmm17                           #62.22
        vaddpd    zmm24, zmm22, zmm23                           #61.22
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 xmm4 xmm18 xmm24 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.39:                        # Preds ..B1.38 ..B1.9
                                # Execution count [5.00e+00]
        mov       rcx, QWORD PTR [-8+rsp]                       #84.9[spill]
        add       rax, 24                                       #55.5
        vaddsd    xmm0, xmm24, QWORD PTR [rcx+rsi*8]            #84.9
        vmovsd    QWORD PTR [rcx+rsi*8], xmm0                   #84.9
        movsxd    rcx, esi                                      #55.32
        vaddsd    xmm1, xmm18, QWORD PTR [rdx+rsi*8]            #85.9
        vmovsd    QWORD PTR [rdx+rsi*8], xmm1                   #85.9
        inc       rcx                                           #55.32
        vaddsd    xmm2, xmm4, QWORD PTR [r9+rsi*8]              #86.9
        vmovsd    QWORD PTR [r9+rsi*8], xmm2                    #86.9
        inc       rsi                                           #55.5
        cmp       rsi, QWORD PTR [-24+rsp]                      #55.5[spill]
        jb        ..B1.9        # Prob 82%                      #55.5
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.40:                        # Preds ..B1.39
                                # Execution count [9.00e-01]
        mov       r14, QWORD PTR [-88+rsp]                      #[spill]
	.cfi_restore 14
        mov       r15, QWORD PTR [-96+rsp]                      #[spill]
	.cfi_restore 15
        mov       rbx, QWORD PTR [-104+rsp]                     #[spill]
	.cfi_restore 3
                                # LOE rbx rbp r14 r15
..B1.42:                        # Preds ..B1.1 ..B1.40
                                # Execution count [1.00e+00]
        vzeroupper                                              #93.12
        vxorpd    xmm0, xmm0, xmm0                              #93.12
	.cfi_restore 13
        pop       r13                                           #93.12
	.cfi_def_cfa_offset 16
	.cfi_restore 12
        pop       r12                                           #93.12
	.cfi_def_cfa_offset 8
        ret                                                     #93.12
	.cfi_def_cfa_offset 24
	.cfi_offset 3, -128
	.cfi_offset 12, -16
	.cfi_offset 13, -24
	.cfi_offset 14, -112
	.cfi_offset 15, -120
                                # LOE
..B1.43:                        # Preds ..B1.11
                                # Execution count [4.50e-01]: Infreq
# COND: neighbor->numneigh[i] < 1200
# r14d <- numneighs
        mov       r14d, r11d                                    #67.9
# r12d <- 0 (k)
        xor       r12d, r12d                                    #67.9
# r14d <- numneighs & -8 (0b1111...111000), 32bits -- k - (k % 8)
        and       r14d, -8                                      #67.9
        jmp       ..B1.24       # Prob 100%                     #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.44:                        # Preds ..B1.10
                                # Execution count [4.50e-01]: Infreq
# COND: neighbor->numneigh[i] < 8
        xor       r14d, r14d                                    #67.9
        jmp       ..B1.32       # Prob 100%                     #67.9
        .align    16,0x90
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
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
.L_2il0floatpacket.5:
	.long	0x02010101,0x04040202,0x08080804,0x20101010,0x40402020,0x80808040,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000,0x00000000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,64
	.align 64
.L_2il0floatpacket.6:
	.long	0x00000000,0x00000000,0x00000004,0x00000000,0x00000008,0x00000000,0x0000000c,0x00000000,0x00000001,0x00000000,0x00000005,0x00000000,0x00000009,0x00000000,0x0000000d,0x00000000
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,64
	.align 64
.L_2il0floatpacket.7:
	.long	0x00000001,0x00000000,0x00000005,0x00000000,0x00000009,0x00000000,0x0000000d,0x00000000,0x00000000,0x00000000,0x00000004,0x00000000,0x00000008,0x00000000,0x0000000c,0x00000000
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,64
	.align 64
.L_2il0floatpacket.8:
	.long	0x00000002,0x00000000,0x00000006,0x00000000,0x0000000a,0x00000000,0x0000000e,0x00000000,0x00000002,0x00000000,0x00000006,0x00000000,0x0000000a,0x00000000,0x0000000e,0x00000000
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,64
	.align 64
.L_2il0floatpacket.10:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.10,@object
	.size	.L_2il0floatpacket.10,64
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
.L_2il0floatpacket.9:
	.long	0x00000000,0x3ff00000
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,8
	.data
	.section .note.GNU-stack, ""
# End
