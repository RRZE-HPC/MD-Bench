# mark_description "Intel(R) C Intel(R) 64 Compiler for applications running on Intel(R) 64, Version 19.0.5.281 Build 20190815";
# mark_description "-I./src/includes -S -D_GNU_SOURCE -DAOS -DPRECISION=2 -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zm";
# mark_description "m-usage=high -o ICC/force.s";
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
        movq      %rsi, %r8                                     #35.1
        vmovsd    72(%rdi), %xmm2                               #38.27
        movq      %rdx, %rax                                    #35.1
        vmovsd    8(%rdi), %xmm1                                #39.23
        vmovsd    (%rdi), %xmm0                                 #40.24
        movl      4(%r8), %r12d                                 #36.18
        movq      64(%r8), %r11                                 #41.20
        movq      72(%r8), %rdx                                 #41.45
        movq      80(%r8), %r9                                  #41.70
        testl     %r12d, %r12d                                  #44.24
        jle       ..B1.42       # Prob 50%                      #44.24
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.2:                         # Preds ..B1.1
                                # Execution count [1.00e+00]
        movl      %r12d, %edi                                   #44.5
        xorl      %esi, %esi                                    #44.5
        movl      $1, %r10d                                     #44.5
        xorl      %ecx, %ecx                                    #44.5
        shrl      $1, %edi                                      #44.5
        je        ..B1.6        # Prob 9%                       #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r11 r14 r15 r10d r12d xmm0 xmm1 xmm2
..B1.3:                         # Preds ..B1.2
                                # Execution count [9.00e-01]
        xorl      %r10d, %r10d                                  #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.4:                         # Preds ..B1.4 ..B1.3
                                # Execution count [2.50e+00]
        movq      %r10, (%rcx,%r11)                             #45.9
        incq      %rsi                                          #44.5
        movq      %r10, (%rcx,%rdx)                             #46.9
        movq      %r10, (%rcx,%r9)                              #47.9
        movq      %r10, 8(%rcx,%r11)                            #45.9
        movq      %r10, 8(%rcx,%rdx)                            #46.9
        movq      %r10, 8(%rcx,%r9)                             #47.9
        addq      $16, %rcx                                     #44.5
        cmpq      %rdi, %rsi                                    #44.5
        jb        ..B1.4        # Prob 63%                      #44.5
                                # LOE rax rdx rcx rbx rbp rsi rdi r8 r9 r10 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.5:                         # Preds ..B1.4
                                # Execution count [9.00e-01]
        lea       1(%rsi,%rsi), %r10d                           #45.9
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r10d r12d xmm0 xmm1 xmm2
..B1.6:                         # Preds ..B1.2 ..B1.5
                                # Execution count [1.00e+00]
        lea       -1(%r10), %ecx                                #44.5
        cmpl      %r12d, %ecx                                   #44.5
        jae       ..B1.8        # Prob 9%                       #44.5
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r10d r12d xmm0 xmm1 xmm2
..B1.7:                         # Preds ..B1.6
                                # Execution count [9.00e-01]
        movslq    %r10d, %r10                                   #44.5
        xorl      %ecx, %ecx                                    #45.9
        movq      %rcx, -8(%r11,%r10,8)                         #45.9
        movq      %rcx, -8(%rdx,%r10,8)                         #46.9
        movq      %rcx, -8(%r9,%r10,8)                          #47.9
                                # LOE rax rdx rbx rbp r8 r9 r11 r14 r15 r12d xmm0 xmm1 xmm2
..B1.8:                         # Preds ..B1.6 ..B1.7
                                # Execution count [9.00e-01]
        vmulsd    %xmm2, %xmm2, %xmm13                          #38.45
        xorl      %ecx, %ecx                                    #55.15
        vmovdqu32 .L_2il0floatpacket.0(%rip), %ymm16            #67.9
        vmulsd    .L_2il0floatpacket.3(%rip), %xmm0, %xmm0      #77.41
        vmovdqu   .L_2il0floatpacket.1(%rip), %ymm15            #67.9
        vmovups   .L_2il0floatpacket.4(%rip), %zmm5             #77.54
        vbroadcastsd %xmm13, %zmm14                             #38.25
        vbroadcastsd %xmm1, %zmm13                              #39.21
        vbroadcastsd %xmm0, %zmm10                              #77.41
        movslq    %r12d, %r12                                   #55.5
        xorl      %esi, %esi                                    #55.5
        movq      24(%rax), %r13                                #57.25
        movq      16(%r8), %rdi                                 #58.25
        movslq    16(%rax), %r8                                 #56.43
        movq      8(%rax), %r10                                 #56.19
        xorl      %eax, %eax                                    #55.5
        shlq      $2, %r8                                       #37.5
        movq      %r12, -24(%rsp)                               #55.5[spill]
        movq      %r13, -16(%rsp)                               #55.5[spill]
        movq      %r11, -8(%rsp)                                #55.5[spill]
        movq      %r14, -88(%rsp)                               #55.5[spill]
        movq      %r15, -96(%rsp)                               #55.5[spill]
        movq      %rbx, -104(%rsp)                              #55.5[spill]
	.cfi_offset 3, -128
	.cfi_offset 14, -112
	.cfi_offset 15, -120
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.9:                         # Preds ..B1.39 ..B1.8
                                # Execution count [5.00e+00]
        movq      -16(%rsp), %rbx                               #57.25[spill]
        vxorpd    %xmm24, %xmm24, %xmm24                        #61.22
        vmovapd   %xmm24, %xmm18                                #62.22
        movl      (%rbx,%rsi,4), %r11d                          #57.25
        vmovapd   %xmm18, %xmm4                                 #63.22
        vmovsd    (%rax,%rdi), %xmm6                            #58.25
        vmovsd    8(%rax,%rdi), %xmm7                           #59.25
        vmovsd    16(%rax,%rdi), %xmm12                         #60.25
        testl     %r11d, %r11d                                  #67.28
        jle       ..B1.39       # Prob 50%                      #67.28
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d xmm4 xmm6 xmm7 xmm12 xmm18 xmm24 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        vpxord    %zmm9, %zmm9, %zmm9                           #61.22
        vmovaps   %zmm9, %zmm8                                  #62.22
        vmovaps   %zmm8, %zmm11                                 #63.22
        cmpl      $8, %r11d                                     #67.9
        jl        ..B1.44       # Prob 10%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.11:                        # Preds ..B1.10
                                # Execution count [4.50e+00]
        cmpl      $1200, %r11d                                  #67.9
        jl        ..B1.43       # Prob 10%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.12:                        # Preds ..B1.11
                                # Execution count [4.50e+00]
        movq      %r8, %r15                                     #56.43
        imulq     %rcx, %r15                                    #56.43
        addq      %r10, %r15                                    #37.5
        movq      %r15, %r12                                    #67.9
        andq      $63, %r12                                     #67.9
        testl     $3, %r12d                                     #67.9
        je        ..B1.14       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        xorl      %r12d, %r12d                                  #67.9
        jmp       ..B1.16       # Prob 100%                     #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.14:                        # Preds ..B1.12
                                # Execution count [2.25e+00]
        testl     %r12d, %r12d                                  #67.9
        je        ..B1.16       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.15:                        # Preds ..B1.14
                                # Execution count [2.50e+01]
        negl      %r12d                                         #67.9
        addl      $64, %r12d                                    #67.9
        shrl      $2, %r12d                                     #67.9
        cmpl      %r12d, %r11d                                  #67.9
        cmovl     %r11d, %r12d                                  #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.16:                        # Preds ..B1.13 ..B1.15 ..B1.14
                                # Execution count [5.00e+00]
        movl      %r11d, %r14d                                  #67.9
        subl      %r12d, %r14d                                  #67.9
        andl      $7, %r14d                                     #67.9
        negl      %r14d                                         #67.9
        addl      %r11d, %r14d                                  #67.9
        cmpl      $1, %r12d                                     #67.9
        jb        ..B1.24       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r15 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        vmovdqa   %ymm15, %ymm3                                 #67.9
        xorl      %r13d, %r13d                                  #67.9
        vpbroadcastd %r12d, %ymm2                               #67.9
        vbroadcastsd %xmm6, %zmm1                               #58.23
        vbroadcastsd %xmm7, %zmm0                               #59.23
        vbroadcastsd %xmm12, %zmm4                              #60.23
        movslq    %r12d, %rbx                                   #67.9
        movq      %r9, -80(%rsp)                                #67.9[spill]
        movq      %rdx, -72(%rsp)                               #67.9[spill]
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.18:                        # Preds ..B1.22 ..B1.17
                                # Execution count [2.50e+01]
        vpcmpgtd  %ymm3, %ymm2, %k3                             #67.9
        vmovdqu32 (%r15,%r13,4), %ymm17{%k3}{z}                 #68.21
        kmovw     %k3, %r9d                                     #67.9
        vpaddd    %ymm17, %ymm17, %ymm18                        #69.36
        vpaddd    %ymm18, %ymm17, %ymm17                        #69.36
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r9d r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 ymm17 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 k3
..B1.21:                        # Preds ..B1.18
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #69.36
        kmovw     %k3, %k2                                      #69.36
        vpxord    %zmm18, %zmm18, %zmm18                        #69.36
        vpxord    %zmm19, %zmm19, %zmm19                        #69.36
        vpxord    %zmm20, %zmm20, %zmm20                        #69.36
        vgatherdpd 16(%rdi,%ymm17,8), %zmm18{%k1}               #69.36
        vgatherdpd 8(%rdi,%ymm17,8), %zmm19{%k2}                #69.36
        vgatherdpd (%rdi,%ymm17,8), %zmm20{%k3}                 #69.36
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r9d r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 zmm18 zmm19 zmm20
..B1.22:                        # Preds ..B1.21
                                # Execution count [2.50e+01]
        addq      $8, %r13                                      #67.9
        vpaddd    %ymm16, %ymm3, %ymm3                          #67.9
        vsubpd    %zmm18, %zmm4, %zmm29                         #71.36
        vsubpd    %zmm19, %zmm0, %zmm27                         #70.36
        vsubpd    %zmm20, %zmm1, %zmm26                         #69.36
        vmulpd    %zmm27, %zmm27, %zmm25                        #72.49
        vfmadd231pd %zmm26, %zmm26, %zmm25                      #72.49
        vfmadd231pd %zmm29, %zmm29, %zmm25                      #72.63
        vrcp14pd  %zmm25, %zmm24                                #75.38
        vcmppd    $1, %zmm14, %zmm25, %k2                       #74.22
        vfpclasspd $30, %zmm24, %k0                             #75.38
        kmovw     %k2, %edx                                     #74.22
        knotw     %k0, %k1                                      #75.38
        vmovaps   %zmm25, %zmm17                                #75.38
        andl      %edx, %r9d                                    #74.22
        vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm24, %zmm17 #75.38
        kmovw     %r9d, %k3                                     #78.17
        vmulpd    %zmm17, %zmm17, %zmm18                        #75.38
        vfmadd213pd %zmm24, %zmm17, %zmm24{%k1}                 #75.38
        vfmadd213pd %zmm24, %zmm18, %zmm24{%k1}                 #75.38
        vmulpd    %zmm13, %zmm24, %zmm19                        #76.38
        vmulpd    %zmm10, %zmm24, %zmm21                        #77.54
        vmulpd    %zmm19, %zmm24, %zmm22                        #76.44
        vmulpd    %zmm22, %zmm24, %zmm20                        #76.50
        vfmsub213pd %zmm5, %zmm22, %zmm24                       #77.54
        vmulpd    %zmm21, %zmm20, %zmm23                        #77.61
        vmulpd    %zmm24, %zmm23, %zmm28                        #77.67
        vfmadd231pd %zmm26, %zmm28, %zmm9{%k3}                  #78.17
        vfmadd231pd %zmm27, %zmm28, %zmm8{%k3}                  #79.17
        vfmadd231pd %zmm29, %zmm28, %zmm11{%k3}                 #80.17
        cmpq      %rbx, %r13                                    #67.9
        jb        ..B1.18       # Prob 82%                      #67.9
                                # LOE rax rcx rbx rbp rsi rdi r8 r10 r13 r15 r11d r12d r14d xmm6 xmm7 xmm12 ymm2 ymm3 ymm15 ymm16 zmm0 zmm1 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.23:                        # Preds ..B1.22
                                # Execution count [4.50e+00]
        movq      -80(%rsp), %r9                                #[spill]
        movq      -72(%rsp), %rdx                               #[spill]
        cmpl      %r12d, %r11d                                  #67.9
        je        ..B1.38       # Prob 10%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.24:                        # Preds ..B1.23 ..B1.16 ..B1.43
                                # Execution count [2.50e+01]
        lea       8(%r12), %ebx                                 #67.9
        cmpl      %ebx, %r14d                                   #67.9
        jl        ..B1.32       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
        movl    $111,%ebx       #IACA/OSACA START MARKER
        .byte   100,103,144     #IACA/OSACA START MARKER
..B1.25:                        # Preds ..B1.24
                                # Execution count [4.50e+00]
        movq      %r8, %r13                                     #56.43
        imulq     %rcx, %r13                                    #56.43
        vbroadcastsd %xmm6, %zmm2                               #58.23
        vbroadcastsd %xmm7, %zmm1                               #59.23
        vbroadcastsd %xmm12, %zmm0                              #60.23
        movslq    %r12d, %rbx                                   #67.9
        addq      %r10, %r13                                    #37.5
        movq      %rax, -64(%rsp)                               #37.5[spill]
        movq      %r8, -56(%rsp)                                #37.5[spill]
        movq      %r10, -48(%rsp)                               #37.5[spill]
        movq      %rsi, -40(%rsp)                               #37.5[spill]
        movq      %rcx, -32(%rsp)                               #37.5[spill]
        movq      %r9, -80(%rsp)                                #37.5[spill]
        movq      %rdx, -72(%rsp)                               #37.5[spill]
                                # LOE rbx rbp rdi r13 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.26:                        # Preds ..B1.30 ..B1.25
                                # Execution count [2.50e+01]
        vmovdqu   (%r13,%rbx,4), %ymm3                          #68.21
        vpaddd    %ymm3, %ymm3, %ymm4                           #69.36
        vpaddd    %ymm4, %ymm3, %ymm3                           #69.36
        movl      (%r13,%rbx,4), %r10d                          #68.21
        movl      4(%r13,%rbx,4), %r9d                          #68.21
        movl      8(%r13,%rbx,4), %r8d                          #68.21
        movl      12(%r13,%rbx,4), %esi                         #68.21
        lea       (%r10,%r10,2), %r10d                          #69.36
        movl      16(%r13,%rbx,4), %ecx                         #68.21
        lea       (%r9,%r9,2), %r9d                             #69.36
        movl      20(%r13,%rbx,4), %edx                         #68.21
        lea       (%r8,%r8,2), %r8d                             #69.36
        movl      24(%r13,%rbx,4), %eax                         #68.21
        lea       (%rsi,%rsi,2), %esi                           #69.36
        movl      28(%r13,%rbx,4), %r15d                        #68.21
        lea       (%rcx,%rcx,2), %ecx                           #69.36
        lea       (%rdx,%rdx,2), %edx                           #69.36
        lea       (%rax,%rax,2), %eax                           #69.36
        lea       (%r15,%r15,2), %r15d                          #69.36
                                # LOE rbx rbp rdi r13 eax edx ecx esi r8d r9d r10d r11d r12d r14d r15d xmm6 xmm7 xmm12 ymm3 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.29:                        # Preds ..B1.26
                                # Execution count [1.25e+01]
        vpcmpeqb  %xmm0, %xmm0, %k1                             #69.36
        vpcmpeqb  %xmm0, %xmm0, %k2                             #69.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #69.36
        vpxord    %zmm4, %zmm4, %zmm4                           #69.36
        vpxord    %zmm17, %zmm17, %zmm17                        #69.36
        vpxord    %zmm18, %zmm18, %zmm18                        #69.36
        vgatherdpd 16(%rdi,%ymm3,8), %zmm4{%k1}                 #69.36
        vgatherdpd 8(%rdi,%ymm3,8), %zmm17{%k2}                 #69.36
        vgatherdpd (%rdi,%ymm3,8), %zmm18{%k3}                  #69.36
                                # LOE rbx rbp rdi r13 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 zmm17 zmm18
..B1.30:                        # Preds ..B1.29
                                # Execution count [2.50e+01]
        addl      $8, %r12d                                     #67.9
        addq      $8, %rbx                                      #67.9
        vsubpd    %zmm4, %zmm0, %zmm26                          #71.36
        vsubpd    %zmm17, %zmm1, %zmm24                         #70.36
        vsubpd    %zmm18, %zmm2, %zmm23                         #69.36
        vmulpd    %zmm24, %zmm24, %zmm3                         #72.49
        vfmadd231pd %zmm23, %zmm23, %zmm3                       #72.49
        vfmadd231pd %zmm26, %zmm26, %zmm3                       #72.63
        vrcp14pd  %zmm3, %zmm22                                 #75.38
        vcmppd    $1, %zmm14, %zmm3, %k2                        #74.22
        vfpclasspd $30, %zmm22, %k0                             #75.38
        vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm22, %zmm3 #75.38
        knotw     %k0, %k1                                      #75.38
        vmulpd    %zmm3, %zmm3, %zmm4                           #75.38
        vfmadd213pd %zmm22, %zmm3, %zmm22{%k1}                  #75.38
        vfmadd213pd %zmm22, %zmm4, %zmm22{%k1}                  #75.38
        vmulpd    %zmm13, %zmm22, %zmm17                        #76.38
        vmulpd    %zmm10, %zmm22, %zmm19                        #77.54
        vmulpd    %zmm17, %zmm22, %zmm20                        #76.44
        vmulpd    %zmm20, %zmm22, %zmm18                        #76.50
        vfmsub213pd %zmm5, %zmm20, %zmm22                       #77.54
        vmulpd    %zmm19, %zmm18, %zmm21                        #77.61
        vmulpd    %zmm22, %zmm21, %zmm25                        #77.67
        vfmadd231pd %zmm23, %zmm25, %zmm9{%k2}                  #78.17
        vfmadd231pd %zmm24, %zmm25, %zmm8{%k2}                  #79.17
        vfmadd231pd %zmm26, %zmm25, %zmm11{%k2}                 #80.17
        cmpl      %r14d, %r12d                                  #67.9
        jb        ..B1.26       # Prob 82%                      #67.9
                                # LOE rbx rbp rdi r13 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm0 zmm1 zmm2 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
        movl    $222,%ebx       #IACA/OSACA END MARKER
        .byte   100,103,144     #IACA/OSACA END MARKER
..B1.31:                        # Preds ..B1.30
                                # Execution count [4.50e+00]
        movq      -64(%rsp), %rax                               #[spill]
        movq      -56(%rsp), %r8                                #[spill]
        movq      -48(%rsp), %r10                               #[spill]
        movq      -40(%rsp), %rsi                               #[spill]
        movq      -32(%rsp), %rcx                               #[spill]
        movq      -80(%rsp), %r9                                #[spill]
        movq      -72(%rsp), %rdx                               #[spill]
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.32:                        # Preds ..B1.31 ..B1.24 ..B1.44
                                # Execution count [5.00e+00]
        lea       1(%r14), %ebx                                 #67.9
        cmpl      %r11d, %ebx                                   #67.9
        ja        ..B1.38       # Prob 50%                      #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.33:                        # Preds ..B1.32
                                # Execution count [2.50e+01]
        imulq     %r8, %rcx                                     #56.43
        vbroadcastsd %xmm6, %zmm4                               #58.23
        subl      %r14d, %r11d                                  #67.9
        addq      %r10, %rcx                                    #37.5
        vpbroadcastd %r11d, %ymm0                               #67.9
        vpcmpgtd  %ymm15, %ymm0, %k3                            #67.9
        movslq    %r14d, %r14                                   #67.9
        kmovw     %k3, %ebx                                     #67.9
        vmovdqu32 (%rcx,%r14,4), %ymm1{%k3}{z}                  #68.21
        vpaddd    %ymm1, %ymm1, %ymm2                           #69.36
        vpaddd    %ymm2, %ymm1, %ymm0                           #69.36
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 ebx xmm7 xmm12 ymm0 ymm15 ymm16 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14 k3
..B1.36:                        # Preds ..B1.33
                                # Execution count [1.25e+01]
        kmovw     %k3, %k1                                      #69.36
        kmovw     %k3, %k2                                      #69.36
        vpxord    %zmm1, %zmm1, %zmm1                           #69.36
        vpxord    %zmm2, %zmm2, %zmm2                           #69.36
        vpxord    %zmm3, %zmm3, %zmm3                           #69.36
        vgatherdpd 16(%rdi,%ymm0,8), %zmm1{%k1}                 #69.36
        vgatherdpd 8(%rdi,%ymm0,8), %zmm2{%k2}                  #69.36
        vgatherdpd (%rdi,%ymm0,8), %zmm3{%k3}                   #69.36
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 ebx xmm7 xmm12 ymm15 ymm16 zmm1 zmm2 zmm3 zmm4 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.37:                        # Preds ..B1.36
                                # Execution count [2.50e+01]
        vbroadcastsd %xmm7, %zmm7                               #59.23
        vbroadcastsd %xmm12, %zmm12                             #60.23
        vsubpd    %zmm1, %zmm12, %zmm23                         #71.36
        vsubpd    %zmm2, %zmm7, %zmm21                          #70.36
        vsubpd    %zmm3, %zmm4, %zmm20                          #69.36
        vmulpd    %zmm21, %zmm21, %zmm19                        #72.49
        vfmadd231pd %zmm20, %zmm20, %zmm19                      #72.49
        vfmadd231pd %zmm23, %zmm23, %zmm19                      #72.63
        vrcp14pd  %zmm19, %zmm18                                #75.38
        vcmppd    $1, %zmm14, %zmm19, %k2                       #74.22
        vfpclasspd $30, %zmm18, %k0                             #75.38
        kmovw     %k2, %ecx                                     #74.22
        knotw     %k0, %k1                                      #75.38
        vmovaps   %zmm19, %zmm0                                 #75.38
        andl      %ecx, %ebx                                    #74.22
        vfnmadd213pd .L_2il0floatpacket.9(%rip){1to8}, %zmm18, %zmm0 #75.38
        kmovw     %ebx, %k3                                     #78.17
        vmulpd    %zmm0, %zmm0, %zmm1                           #75.38
        vfmadd213pd %zmm18, %zmm0, %zmm18{%k1}                  #75.38
        vfmadd213pd %zmm18, %zmm1, %zmm18{%k1}                  #75.38
        vmulpd    %zmm13, %zmm18, %zmm2                         #76.38
        vmulpd    %zmm10, %zmm18, %zmm4                         #77.54
        vmulpd    %zmm2, %zmm18, %zmm6                          #76.44
        vmulpd    %zmm6, %zmm18, %zmm3                          #76.50
        vfmsub213pd %zmm5, %zmm6, %zmm18                        #77.54
        vmulpd    %zmm4, %zmm3, %zmm17                          #77.61
        vmulpd    %zmm18, %zmm17, %zmm22                        #77.67
        vfmadd231pd %zmm20, %zmm22, %zmm9{%k3}                  #78.17
        vfmadd231pd %zmm21, %zmm22, %zmm8{%k3}                  #79.17
        vfmadd231pd %zmm23, %zmm22, %zmm11{%k3}                 #80.17
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.38:                        # Preds ..B1.23 ..B1.37 ..B1.32
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.10(%rip), %zmm19           #63.22
        vpermd    %zmm11, %zmm19, %zmm0                         #63.22
        vpermd    %zmm8, %zmm19, %zmm6                          #62.22
        vpermd    %zmm9, %zmm19, %zmm20                         #61.22
        vaddpd    %zmm11, %zmm0, %zmm11                         #63.22
        vaddpd    %zmm8, %zmm6, %zmm8                           #62.22
        vaddpd    %zmm9, %zmm20, %zmm9                          #61.22
        vpermpd   $78, %zmm11, %zmm1                            #63.22
        vpermpd   $78, %zmm8, %zmm7                             #62.22
        vpermpd   $78, %zmm9, %zmm21                            #61.22
        vaddpd    %zmm1, %zmm11, %zmm2                          #63.22
        vaddpd    %zmm7, %zmm8, %zmm12                          #62.22
        vaddpd    %zmm21, %zmm9, %zmm22                         #61.22
        vpermpd   $177, %zmm2, %zmm3                            #63.22
        vpermpd   $177, %zmm12, %zmm17                          #62.22
        vpermpd   $177, %zmm22, %zmm23                          #61.22
        vaddpd    %zmm3, %zmm2, %zmm4                           #63.22
        vaddpd    %zmm17, %zmm12, %zmm18                        #62.22
        vaddpd    %zmm23, %zmm22, %zmm24                        #61.22
                                # LOE rax rdx rbp rsi rdi r8 r9 r10 xmm4 xmm18 xmm24 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.39:                        # Preds ..B1.38 ..B1.9
                                # Execution count [5.00e+00]
        movq      -8(%rsp), %rcx                                #84.9[spill]
        addq      $24, %rax                                     #55.5
        vaddsd    (%rcx,%rsi,8), %xmm24, %xmm0                  #84.9
        vmovsd    %xmm0, (%rcx,%rsi,8)                          #84.9
        movslq    %esi, %rcx                                    #55.32
        vaddsd    (%rdx,%rsi,8), %xmm18, %xmm1                  #85.9
        vmovsd    %xmm1, (%rdx,%rsi,8)                          #85.9
        incq      %rcx                                          #55.32
        vaddsd    (%r9,%rsi,8), %xmm4, %xmm2                    #86.9
        vmovsd    %xmm2, (%r9,%rsi,8)                           #86.9
        incq      %rsi                                          #55.5
        cmpq      -24(%rsp), %rsi                               #55.5[spill]
        jb        ..B1.9        # Prob 82%                      #55.5
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 ymm15 ymm16 zmm5 zmm10 zmm13 zmm14
..B1.40:                        # Preds ..B1.39
                                # Execution count [9.00e-01]
        movq      -88(%rsp), %r14                               #[spill]
	.cfi_restore 14
        movq      -96(%rsp), %r15                               #[spill]
	.cfi_restore 15
        movq      -104(%rsp), %rbx                              #[spill]
	.cfi_restore 3
                                # LOE rbx rbp r14 r15
..B1.42:                        # Preds ..B1.1 ..B1.40
                                # Execution count [1.00e+00]
        vzeroupper                                              #93.12
        vxorpd    %xmm0, %xmm0, %xmm0                           #93.12
	.cfi_restore 13
        popq      %r13                                          #93.12
	.cfi_def_cfa_offset 16
	.cfi_restore 12
        popq      %r12                                          #93.12
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
        movl      %r11d, %r14d                                  #67.9
        xorl      %r12d, %r12d                                  #67.9
        andl      $-8, %r14d                                    #67.9
        jmp       ..B1.24       # Prob 100%                     #67.9
                                # LOE rax rdx rcx rbp rsi rdi r8 r9 r10 r11d r12d r14d xmm6 xmm7 xmm12 ymm15 ymm16 zmm5 zmm8 zmm9 zmm10 zmm11 zmm13 zmm14
..B1.44:                        # Preds ..B1.10
                                # Execution count [4.50e-01]: Infreq
        xorl      %r14d, %r14d                                  #67.9
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
