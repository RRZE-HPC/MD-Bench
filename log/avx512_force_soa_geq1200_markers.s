# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.5.281 Build 20190815";
# mark_description "-I./src/includes -S -D_GNU_SOURCE -DPRECISION=2 -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usag";
# mark_description "e=high -o ICC/force.s";
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
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %ecx
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForce.1:
..L2:
                                                          #35.1
        pushq     %r12                                          #35.1
	.cfi_def_cfa_offset 16
	.cfi_offset 12, -16
        pushq     %r13                                          #35.1
	.cfi_def_cfa_offset 24
	.cfi_offset 13, -24
        pushq     %r14                                          #35.1
	.cfi_def_cfa_offset 32
	.cfi_offset 14, -32
        movl      4(%rsi), %r9d                                 #36.18
        vmovsd    72(%rdi), %xmm2                               #38.27
        vmovsd    8(%rdi), %xmm1                                #39.23
        vmovsd    (%rdi), %xmm0                                 #40.24
        movq      64(%rsi), %r13                                #41.20
        movq      72(%rsi), %r14                                #41.45
        movq      80(%rsi), %rdi                                #41.70
        testl     %r9d, %r9d                                    #44.24
        jle       ..B1.30       # Prob 50%                      #44.24
                                # LOE rdx rbx rbp rsi rdi r13 r14 r15 r9d xmm0 xmm1 xmm2
..B1.2:                         # Preds ..B1.1
                                # Execution count [1.00e+00]
        xorl      %r10d, %r10d                                  #44.5
        movl      %r9d, %ecx                                    #44.5
        xorl      %r8d, %r8d                                    #44.5
        movl      $1, %r11d                                     #44.5
        xorl      %eax, %eax                                    #45.17
        shrl      $1, %ecx                                      #44.5
        je        ..B1.6        # Prob 9%                       #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r10 r13 r14 r15 r9d r11d xmm0 xmm1 xmm2
..B1.4:                         # Preds ..B1.2 ..B1.4
                                # Execution count [2.50e+00]
        movq      %rax, (%r8,%r13)                              #45.9
        incq      %r10                                          #44.5
        movq      %rax, (%r8,%r14)                              #46.9
        movq      %rax, (%r8,%rdi)                              #47.9
        movq      %rax, 8(%r8,%r13)                             #45.9
        movq      %rax, 8(%r8,%r14)                             #46.9
        movq      %rax, 8(%r8,%rdi)                             #47.9
        addq      $16, %r8                                      #44.5
        cmpq      %rcx, %r10                                    #44.5
        jb        ..B1.4        # Prob 63%                      #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r10 r13 r14 r15 r9d xmm0 xmm1 xmm2
..B1.5:                         # Preds ..B1.4
                                # Execution count [9.00e-01]
        lea       1(%r10,%r10), %r11d                           #45.9
                                # LOE rax rdx rbx rbp rsi rdi r13 r14 r15 r9d r11d xmm0 xmm1 xmm2
..B1.6:                         # Preds ..B1.2 ..B1.5
                                # Execution count [1.00e+00]
        lea       -1(%r11), %ecx                                #44.5
        cmpl      %r9d, %ecx                                    #44.5
        jae       ..B1.8        # Prob 9%                       #44.5
                                # LOE rax rdx rbx rbp rsi rdi r13 r14 r15 r9d r11d xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.6
                                # Execution count [9.00e-01]
        movslq    %r11d, %r11                                   #44.5
        movq      %rax, -8(%r13,%r11,8)                         #45.9
        movq      %rax, -8(%r14,%r11,8)                         #46.9
        movq      %rax, -8(%rdi,%r11,8)                         #47.9
                                # LOE rdx rbx rbp rsi rdi r13 r14 r15 r9d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.6 ..B1.7
                                # Execution count [9.00e-01]
        vmulsd    %xmm2, %xmm2, %xmm15                          #38.45
        xorl      %r8d, %r8d                                    #55.15
        vmovdqu32 .L_2il0floatpacket.0(%rip), %ymm18            #67.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm0      #77.41
        vmovdqu32 .L_2il0floatpacket.1(%rip), %ymm17            #67.9
        vmovups   .L_2il0floatpacket.4(%rip), %zmm7             #77.54
        vbroadcastsd %xmm15, %zmm16                             #38.25
        vbroadcastsd %xmm1, %zmm15                              #39.21
        vbroadcastsd %xmm0, %zmm14                              #77.41
        movslq    %r9d, %r9                                     #55.5
        xorl      %r10d, %r10d                                  #55.5
        movq      24(%rdx), %rcx                                #57.25
        movq      8(%rdx), %r11                                 #56.19
        movslq    16(%rdx), %r12                                #56.43
        movq      16(%rsi), %rdx                                #58.25
        movq      24(%rsi), %rax                                #59.25
        movq      32(%rsi), %rsi                                #60.25
        shlq      $2, %r12                                      #37.5
        movq      %r9, -32(%rsp)                                #60.25[spill]
        movq      %rcx, -24(%rsp)                               #60.25[spill]
        movq      %r14, -16(%rsp)                               #60.25[spill]
        movq      %r13, -8(%rsp)                                #60.25[spill]
        movq      %r15, -40(%rsp)                               #60.25[spill]
        movq      %rbx, -48(%rsp)                               #60.25[spill]
        vpxord    %zmm19, %zmm19, %zmm19                        #61.22
	.cfi_offset 3, -80
	.cfi_offset 15, -72
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.9:                         # Preds ..B1.27 ..B1.8
                                # Execution count [5.00e+00]
        movq      -24(%rsp), %rcx                               #57.25[spill]
        vxorpd    %xmm25, %xmm25, %xmm25                        #61.22
        vmovapd   %xmm25, %xmm20                                #62.22
        movl      (%rcx,%r10,4), %r13d                          #57.25
        vmovapd   %xmm20, %xmm4                                 #63.22
        vmovsd    (%rdx,%r10,8), %xmm8                          #58.25
        vmovsd    (%rax,%r10,8), %xmm9                          #59.25
        vmovsd    (%rsi,%r10,8), %xmm10                         #60.25
        testl     %r13d, %r13d                                  #67.28
        jle       ..B1.27       # Prob 50%                      #67.28
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 r13d xmm4 xmm8 xmm9 xmm10 xmm20 xmm25 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        vmovaps   %zmm19, %zmm13                                #61.22
        vmovaps   %zmm13, %zmm12                                #62.22
        vmovaps   %zmm12, %zmm11                                #63.22
        cmpl      $8, %r13d                                     #67.9
        jl        ..B1.32       # Prob 10%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
        cmpl      $1200, %r13d                                  #67.9
        jl        ..B1.31       # Prob 10%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
        movq      %r12, %rcx                                    #56.43
        imulq     %r8, %rcx                                     #56.43
        addq      %r11, %rcx                                    #37.5
        movq      %rcx, %r9                                     #67.9
        andq      $63, %r9                                      #67.9
        testl     $3, %r9d                                      #67.9
        je        ..B1.14       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        xorl      %r9d, %r9d                                    #67.9
        jmp       ..B1.16       # Prob 100%                     #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.14:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        testl     %r9d, %r9d                                    #67.9
        je        ..B1.16       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.15:                        # Preds ..B1.14
                                # Execution count [2.50e+01]
        negl      %r9d                                          #67.9
        addl      $64, %r9d                                     #67.9
        shrl      $2, %r9d                                      #67.9
        cmpl      %r9d, %r13d                                   #67.9
        cmovl     %r13d, %r9d                                   #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.16:                        # Preds ..B1.13 ..B1.15 ..B1.14
                                # Execution count [5.00e+00]
        movl      %r13d, %ebx                                   #67.9
        subl      %r9d, %ebx                                    #67.9
        andl      $7, %ebx                                      #67.9
        negl      %ebx                                          #67.9
        addl      %r13d, %ebx                                   #67.9
        cmpl      $1, %r9d                                      #67.9
        jb        ..B1.20       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        vmovdqa32 %ymm17, %ymm4                                 #67.9
        xorl      %r15d, %r15d                                  #67.9
        vpbroadcastd %r9d, %ymm3                                #67.9
        vbroadcastsd %xmm8, %zmm2                               #58.23
        vbroadcastsd %xmm9, %zmm5                               #59.23
        vbroadcastsd %xmm10, %zmm6                              #60.23
        movslq    %r9d, %r14                                    #67.9
        movl    $111,%ebx       #IACA/OSACA START MARKER
        .byte   100,103,144     #IACA/OSACA START MARKER
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 r15 ebx r9d r13d xmm8 xmm9 xmm10 ymm3 ymm4 ymm17 ymm18 zmm2 zmm5 zmm6 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.18:                        # Preds ..B1.18 ..B1.17
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm4, %ymm3, %k5                             #67.9
        vpaddd    %ymm18, %ymm4, %ymm4                          #67.9
        vmovdqu32 (%rcx,%r15,4), %ymm20{%k5}{z}                 #68.21
        vmovaps   %zmm19, %zmm22                                #70.36
        addq      $8, %r15                                      #67.9
        kmovw     %k5, %k2                                      #70.36
        vmovaps   %zmm19, %zmm21                                #69.36
        kmovw     %k5, %k1                                      #69.36
        vmovaps   %zmm19, %zmm23                                #71.36
        kmovw     %k5, %k3                                      #71.36
        vgatherdpd (%rsi,%ymm20,8), %zmm23{%k3}                 #71.36
        vgatherdpd (%rax,%ymm20,8), %zmm22{%k2}                 #70.36
        vgatherdpd (%rdx,%ymm20,8), %zmm21{%k1}                 #69.36
        vsubpd    %zmm22, %zmm5, %zmm0                          #70.36
        vsubpd    %zmm21, %zmm2, %zmm1                          #69.36
        vsubpd    %zmm23, %zmm6, %zmm21                         #71.36
        vmulpd    %zmm0, %zmm0, %zmm20                          #72.49
        vfmadd231pd %zmm1, %zmm1, %zmm20                        #72.49
        vfmadd231pd %zmm21, %zmm21, %zmm20                      #72.63
        vrcp14pd  %zmm20, %zmm31                                #75.38
        vcmppd    $1, %zmm16, %zmm20, %k6{%k5}                  #74.22
        vfpclasspd $30, %zmm31, %k0                             #75.38
        vmovaps   %zmm20, %zmm24                                #75.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm31, %zmm24 #75.38
        knotw     %k0, %k4                                      #75.38
        vmulpd    %zmm24, %zmm24, %zmm25                        #75.38
        vfmadd213pd %zmm31, %zmm24, %zmm31{%k4}                 #75.38
        vfmadd213pd %zmm31, %zmm25, %zmm31{%k4}                 #75.38
        vmulpd    %zmm15, %zmm31, %zmm26                        #76.38
        vmulpd    %zmm14, %zmm31, %zmm28                        #77.54
        vmulpd    %zmm26, %zmm31, %zmm29                        #76.44
        vmulpd    %zmm29, %zmm31, %zmm27                        #76.50
        vfmsub213pd %zmm7, %zmm29, %zmm31                       #77.54
        vmulpd    %zmm28, %zmm27, %zmm30                        #77.61
        vmulpd    %zmm31, %zmm30, %zmm24                        #77.67
        vfmadd231pd %zmm1, %zmm24, %zmm13{%k6}                  #78.17
        vfmadd231pd %zmm0, %zmm24, %zmm12{%k6}                  #79.17
        vfmadd231pd %zmm21, %zmm24, %zmm11{%k6}                 #80.17
        cmpq      %r14, %r15                                    #67.9
        jb        ..B1.18       # Prob 82%                      #67.9
        movl    $222,%ebx       #IACA/OSACA END MARKER
        .byte   100,103,144     #IACA/OSACA END MARKER
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 r15 ebx r9d r13d xmm8 xmm9 xmm10 ymm3 ymm4 ymm17 ymm18 zmm2 zmm5 zmm6 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        cmpl      %r9d, %r13d                                   #67.9
        je        ..B1.26       # Prob 10%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.20:                        # Preds ..B1.19 ..B1.16 ..B1.31
                                # Execution count [2.50e+01]
        lea       8(%r9), %ecx                                  #67.9
        cmpl      %ecx, %ebx                                    #67.9
        jl        ..B1.24       # Prob 50%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.21:                        # Preds ..B1.20
                                # Execution count [4.50e+00]
        movq      %r12, %rcx                                    #56.43
        imulq     %r8, %rcx                                     #56.43
        vbroadcastsd %xmm8, %zmm0                               #58.23
        vbroadcastsd %xmm9, %zmm1                               #59.23
        vbroadcastsd %xmm10, %zmm2                              #60.23
        movslq    %r9d, %r14                                    #67.9
        addq      %r11, %rcx                                    #37.5
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm0 zmm1 zmm2 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.22:                        # Preds ..B1.22 ..B1.21
                                # Execution count [2.50e+01]
        vpcmpeqb  %xmm0, %xmm0, %k2                             #70.36
        addl      $8, %r9d                                      #67.9
        vpcmpeqb  %xmm0, %xmm0, %k1                             #69.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #71.36
        vmovdqu   (%rcx,%r14,4), %ymm3                          #68.21
        addq      $8, %r14                                      #67.9
        vpxord    %zmm5, %zmm5, %zmm5                           #70.36
        vpxord    %zmm4, %zmm4, %zmm4                           #69.36
        vpxord    %zmm6, %zmm6, %zmm6                           #71.36
        vgatherdpd (%rax,%ymm3,8), %zmm5{%k2}                   #70.36
        vgatherdpd (%rdx,%ymm3,8), %zmm4{%k1}                   #69.36
        vgatherdpd (%rsi,%ymm3,8), %zmm6{%k3}                   #71.36
        vsubpd    %zmm5, %zmm1, %zmm29                          #70.36
        vsubpd    %zmm4, %zmm0, %zmm28                          #69.36
        vsubpd    %zmm6, %zmm2, %zmm31                          #71.36
        vmulpd    %zmm29, %zmm29, %zmm20                        #72.49
        vfmadd231pd %zmm28, %zmm28, %zmm20                      #72.49
        vfmadd231pd %zmm31, %zmm31, %zmm20                      #72.63
        vrcp14pd  %zmm20, %zmm27                                #75.38
        vcmppd    $1, %zmm16, %zmm20, %k5                       #74.22
        vfpclasspd $30, %zmm27, %k0                             #75.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm27, %zmm20 #75.38
        knotw     %k0, %k4                                      #75.38
        vmulpd    %zmm20, %zmm20, %zmm21                        #75.38
        vfmadd213pd %zmm27, %zmm20, %zmm27{%k4}                 #75.38
        vfmadd213pd %zmm27, %zmm21, %zmm27{%k4}                 #75.38
        vmulpd    %zmm15, %zmm27, %zmm22                        #76.38
        vmulpd    %zmm14, %zmm27, %zmm24                        #77.54
        vmulpd    %zmm22, %zmm27, %zmm25                        #76.44
        vmulpd    %zmm25, %zmm27, %zmm23                        #76.50
        vfmsub213pd %zmm7, %zmm25, %zmm27                       #77.54
        vmulpd    %zmm24, %zmm23, %zmm26                        #77.61
        vmulpd    %zmm27, %zmm26, %zmm30                        #77.67
        vfmadd231pd %zmm28, %zmm30, %zmm13{%k5}                 #78.17
        vfmadd231pd %zmm29, %zmm30, %zmm12{%k5}                 #79.17
        vfmadd231pd %zmm31, %zmm30, %zmm11{%k5}                 #80.17
        cmpl      %ebx, %r9d                                    #67.9
        jb        ..B1.22       # Prob 82%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r10 r11 r12 r14 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm0 zmm1 zmm2 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.24:                        # Preds ..B1.22 ..B1.20 ..B1.32
                                # Execution count [5.00e+00]
        lea       1(%rbx), %ecx                                 #67.9
        cmpl      %r13d, %ecx                                   #67.9
        ja        ..B1.26       # Prob 50%                      #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.25:                        # Preds ..B1.24
                                # Execution count [2.50e+01]
        imulq     %r12, %r8                                     #56.43
        vbroadcastsd %xmm9, %zmm9                               #59.23
        vbroadcastsd %xmm8, %zmm2                               #58.23
        vbroadcastsd %xmm10, %zmm10                             #60.23
        subl      %ebx, %r13d                                   #67.9
        addq      %r11, %r8                                     #37.5
        vpbroadcastd %r13d, %ymm0                               #67.9
        vpcmpgtd  %ymm17, %ymm0, %k5                            #67.9
        movslq    %ebx, %rbx                                    #67.9
        vmovaps   %zmm19, %zmm4                                 #70.36
        kmovw     %k5, %k2                                      #70.36
        vmovaps   %zmm19, %zmm3                                 #69.36
        vmovdqu32 (%r8,%rbx,4), %ymm1{%k5}{z}                   #68.21
        kmovw     %k5, %k1                                      #69.36
        vmovaps   %zmm19, %zmm5                                 #71.36
        kmovw     %k5, %k3                                      #71.36
        vgatherdpd (%rsi,%ymm1,8), %zmm5{%k3}                   #71.36
        vgatherdpd (%rax,%ymm1,8), %zmm4{%k2}                   #70.36
        vgatherdpd (%rdx,%ymm1,8), %zmm3{%k1}                   #69.36
        vsubpd    %zmm5, %zmm10, %zmm30                         #71.36
        vsubpd    %zmm4, %zmm9, %zmm28                          #70.36
        vsubpd    %zmm3, %zmm2, %zmm27                          #69.36
        vmulpd    %zmm28, %zmm28, %zmm26                        #72.49
        vfmadd231pd %zmm27, %zmm27, %zmm26                      #72.49
        vfmadd231pd %zmm30, %zmm30, %zmm26                      #72.63
        vrcp14pd  %zmm26, %zmm25                                #75.38
        vcmppd    $1, %zmm16, %zmm26, %k6{%k5}                  #74.22
        vfpclasspd $30, %zmm25, %k0                             #75.38
        vmovaps   %zmm26, %zmm6                                 #75.38
        vfnmadd213pd .L_2il0floatpacket.5(%rip){1to8}, %zmm25, %zmm6 #75.38
        knotw     %k0, %k4                                      #75.38
        vmulpd    %zmm6, %zmm6, %zmm8                           #75.38
        vfmadd213pd %zmm25, %zmm6, %zmm25{%k4}                  #75.38
        vfmadd213pd %zmm25, %zmm8, %zmm25{%k4}                  #75.38
        vmulpd    %zmm15, %zmm25, %zmm20                        #76.38
        vmulpd    %zmm14, %zmm25, %zmm22                        #77.54
        vmulpd    %zmm20, %zmm25, %zmm23                        #76.44
        vmulpd    %zmm23, %zmm25, %zmm21                        #76.50
        vfmsub213pd %zmm7, %zmm23, %zmm25                       #77.54
        vmulpd    %zmm22, %zmm21, %zmm24                        #77.61
        vmulpd    %zmm25, %zmm24, %zmm29                        #77.67
        vfmadd231pd %zmm27, %zmm29, %zmm13{%k6}                 #78.17
        vfmadd231pd %zmm28, %zmm29, %zmm12{%k6}                 #79.17
        vfmadd231pd %zmm30, %zmm29, %zmm11{%k6}                 #80.17
                                # LOE rax rdx rbp rsi rdi r10 r11 r12 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.26:                        # Preds ..B1.19 ..B1.25 ..B1.24
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm10            #63.22
        vpermd    %zmm11, %zmm10, %zmm0                         #63.22
        vpermd    %zmm12, %zmm10, %zmm5                         #62.22
        vpermd    %zmm13, %zmm10, %zmm21                        #61.22
        vaddpd    %zmm11, %zmm0, %zmm11                         #63.22
        vaddpd    %zmm12, %zmm5, %zmm12                         #62.22
        vaddpd    %zmm13, %zmm21, %zmm13                        #61.22
        vpermpd   $78, %zmm11, %zmm1                            #63.22
        vpermpd   $78, %zmm12, %zmm6                            #62.22
        vpermpd   $78, %zmm13, %zmm22                           #61.22
        vaddpd    %zmm1, %zmm11, %zmm2                          #63.22
        vaddpd    %zmm6, %zmm12, %zmm8                          #62.22
        vaddpd    %zmm22, %zmm13, %zmm23                        #61.22
        vpermpd   $177, %zmm2, %zmm3                            #63.22
        vpermpd   $177, %zmm8, %zmm9                            #62.22
        vpermpd   $177, %zmm23, %zmm24                          #61.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #63.22
        vaddpd    %zmm9, %zmm8, %zmm20                          #62.22
        vaddpd    %zmm24, %zmm23, %zmm25                        #61.22
                                # LOE rax rdx rbp rsi rdi r10 r11 r12 xmm4 xmm20 xmm25 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.27:                        # Preds ..B1.26 ..B1.9
                                # Execution count [5.00e+00]
        movq      -8(%rsp), %rcx                                #84.9[spill]
        movq      -16(%rsp), %rbx                               #85.9[spill]
        movslq    %r10d, %r8                                    #55.32
        incq      %r8                                           #55.32
        vaddsd    (%rcx,%r10,8), %xmm25, %xmm0                  #84.9
        vmovsd    %xmm0, (%rcx,%r10,8)                          #84.9
        vaddsd    (%rbx,%r10,8), %xmm20, %xmm1                  #85.9
        vmovsd    %xmm1, (%rbx,%r10,8)                          #85.9
        vaddsd    (%rdi,%r10,8), %xmm4, %xmm2                   #86.9
        vmovsd    %xmm2, (%rdi,%r10,8)                          #86.9
        incq      %r10                                          #55.5
        cmpq      -32(%rsp), %r10                               #55.5[spill]
        jb        ..B1.9        # Prob 82%                      #55.5
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ymm17 ymm18 zmm7 zmm14 zmm15 zmm16 zmm19
..B1.28:                        # Preds ..B1.27
                                # Execution count [9.00e-01]
        movq      -40(%rsp), %r15                               #[spill]
	.cfi_restore 15
        movq      -48(%rsp), %rbx                               #[spill]
	.cfi_restore 3
                                # LOE rbx rbp r15
..B1.30:                        # Preds ..B1.1 ..B1.28
                                # Execution count [1.00e+00]
        vzeroupper                                              #93.12
        vxorpd    %xmm0, %xmm0, %xmm0                           #93.12
	.cfi_restore 14
        popq      %r14                                          #93.12
	.cfi_def_cfa_offset 24
	.cfi_restore 13
        popq      %r13                                          #93.12
	.cfi_def_cfa_offset 16
	.cfi_restore 12
        popq      %r12                                          #93.12
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
        movl      %r13d, %ebx                                   #67.9
        xorl      %r9d, %r9d                                    #67.9
        andl      $-8, %ebx                                     #67.9
        jmp       ..B1.20       # Prob 100%                     #67.9
                                # LOE rax rdx rbp rsi rdi r8 r10 r11 r12 ebx r9d r13d xmm8 xmm9 xmm10 ymm17 ymm18 zmm7 zmm11 zmm12 zmm13 zmm14 zmm15 zmm16 zmm19
..B1.32:                        # Preds ..B1.10
                                # Execution count [4.50e-01]: Infreq
        xorl      %ebx, %ebx                                    #67.9
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
