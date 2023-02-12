# mark_description "Intel(R) C Intel(R) 64 Compiler Classic for applications running on Intel(R) 64, Version 2021.6.0 Build 2022";
# mark_description "0226_000000";
# mark_description "-I/apps/likwid/5.2.2/include -I././lammps/includes -I././common/includes -S -std=c11 -pedantic-errors -D_GNU";
# mark_description "_SOURCE -DLIKWID_PERFMON -DAOS -DPRECISION=1 -DCOMPUTE_STATS -DVECTOR_WIDTH=16 -D__ISA_AVX512__ -DENABLE_OMP";
# mark_description "_SIMD -DALIGNMENT=64 -restrict -Ofast -xCORE-AVX512 -qopt-zmm-usage=high -o build-lammps-ICC-AVX512-SP/force";
# mark_description "_lj.s";
	.file "force_lj.c"
	.text
..TXTST0:
.L_2__routine_start_computeForceLJFullNeigh_plain_c_0:
# -- Begin  computeForceLJFullNeigh_plain_c
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJFullNeigh_plain_c
# --- computeForceLJFullNeigh_plain_c(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJFullNeigh_plain_c:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B1.1:                         # Preds ..B1.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJFullNeigh_plain_c.1:
..L2:
                                                          #21.104
        pushq     %rbp                                          #21.104
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #21.104
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #21.104
        pushq     %r13                                          #21.104
        pushq     %r14                                          #21.104
        pushq     %r15                                          #21.104
        pushq     %rbx                                          #21.104
        subq      $96, %rsp                                     #21.104
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r13                                    #21.104
        vmovss    108(%rdi), %xmm0                              #25.27
        movq      %rcx, %r14                                    #21.104
        vmovss    48(%rdi), %xmm1                               #26.23
        movq      %rdx, %rbx                                    #21.104
        vmovss    40(%rdi), %xmm2                               #27.24
        movl      4(%r13), %r15d                                #22.18
        vmovss    %xmm0, 32(%rsp)                               #25.27[spill]
        vmovss    %xmm1, 16(%rsp)                               #26.23[spill]
        vmovss    %xmm2, 24(%rsp)                               #27.24[spill]
        testl     %r15d, %r15d                                  #33.24
        jle       ..B1.27       # Prob 50%                      #33.24
                                # LOE rbx r12 r13 r14 r15d
..B1.2:                         # Preds ..B1.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #34.9
        lea       (%r15,%r15,2), %esi                           #22.18
        cmpl      $24, %esi                                     #33.5
        jle       ..B1.34       # Prob 0%                       #33.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.3:                         # Preds ..B1.2
                                # Execution count [1.00e+00]
        movslq    %r15d, %r15                                   #33.5
        xorl      %esi, %esi                                    #33.5
        lea       (%r15,%r15,2), %rdx                           #33.5
        shlq      $2, %rdx                                      #33.5
        call      __intel_skx_avx512_memset                     #33.5
                                # LOE rbx r12 r13 r14 r15
..B1.4:                         # Preds ..B1.3 ..B1.46 ..B1.39
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #38.16
        vzeroupper                                              #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.13:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.14:
                                # LOE rbx r12 r13 r14 r15 xmm0
..B1.43:                        # Preds ..B1.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 40(%rsp)                               #38.16[spill]
                                # LOE rbx r12 r13 r14 r15
..B1.5:                         # Preds ..B1.43
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.16:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.17:
                                # LOE rbx r12 r13 r14 r15
..B1.6:                         # Preds ..B1.5
                                # Execution count [9.00e-01]
        vmovss    32(%rsp), %xmm13                              #25.45[spill]
        xorl      %esi, %esi                                    #45.15
        vmovss    24(%rsp), %xmm0                               #77.42[spill]
        xorl      %edi, %edi                                    #45.5
        vmulss    %xmm13, %xmm13, %xmm14                        #25.45
        xorl      %eax, %eax                                    #45.5
        vmulss    .L_2il0floatpacket.3(%rip), %xmm0, %xmm1      #77.42
        vmovups   .L_2il0floatpacket.0(%rip), %zmm16            #59.9
        vmovups   .L_2il0floatpacket.1(%rip), %zmm15            #59.9
        vmovups   .L_2il0floatpacket.4(%rip), %zmm6             #77.55
        vbroadcastss %xmm14, %zmm14                             #25.25
        vbroadcastss 16(%rsp), %zmm13                           #26.21[spill]
        vbroadcastss %xmm1, %zmm12                              #77.42
        movq      24(%rbx), %r11                                #47.25
        movq      64(%r13), %r10                                #89.9
        movq      16(%rbx), %r9                                 #46.19
        movslq    8(%rbx), %r8                                  #46.43
        shlq      $2, %r8                                       #23.5
        movq      16(%r13), %rbx                                #48.25
        movq      (%r14), %rdx                                  #93.9
        movq      8(%r14), %rcx                                 #94.9
        movq      %r10, 48(%rsp)                                #45.5[spill]
        movq      %r11, 56(%rsp)                                #45.5[spill]
        movq      %r15, 64(%rsp)                                #45.5[spill]
        movq      %r14, (%rsp)                                  #45.5[spill]
        movq      %r12, 8(%rsp)                                 #45.5[spill]
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 zmm6 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.7:                         # Preds ..B1.25 ..B1.6
                                # Execution count [5.00e+00]
        movq      56(%rsp), %r10                                #47.25[spill]
        vxorps    %xmm30, %xmm30, %xmm30                        #51.22
        vmovaps   %xmm30, %xmm21                                #52.22
        movl      (%r10,%rdi,4), %r13d                          #47.25
        vmovaps   %xmm21, %xmm0                                 #53.22
        vmovss    (%rax,%rbx), %xmm11                           #48.25
        vmovss    4(%rax,%rbx), %xmm7                           #49.25
        vmovss    8(%rax,%rbx), %xmm8                           #50.25
        testl     %r13d, %r13d                                  #59.28
        jle       ..B1.25       # Prob 50%                      #59.28
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm0 xmm7 xmm8 xmm11 xmm21 xmm30 zmm6 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.8:                         # Preds ..B1.7
                                # Execution count [4.50e+00]
        vpxord    %zmm10, %zmm10, %zmm10                        #51.22
        vmovaps   %zmm10, %zmm9                                 #52.22
        vmovaps   %zmm9, %zmm5                                  #53.22
        cmpl      $16, %r13d                                    #59.9
        jl        ..B1.33       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.9:                         # Preds ..B1.8
                                # Execution count [4.50e+00]
        cmpl      $2400, %r13d                                  #59.9
        jl        ..B1.32       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.10:                        # Preds ..B1.9
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #46.43
        imulq     %rsi, %r10                                    #46.43
        addq      %r9, %r10                                     #23.5
        movq      %r10, %r12                                    #59.9
        andq      $63, %r12                                     #59.9
        testl     $3, %r12d                                     #59.9
        je        ..B1.12       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.11:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        xorl      %r12d, %r12d                                  #59.9
        jmp       ..B1.14       # Prob 100%                     #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.12:                        # Preds ..B1.10
                                # Execution count [2.25e+00]
        testl     %r12d, %r12d                                  #59.9
        je        ..B1.14       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.13:                        # Preds ..B1.12
                                # Execution count [2.50e+01]
        negl      %r12d                                         #59.9
        addl      $64, %r12d                                    #59.9
        shrl      $2, %r12d                                     #59.9
        cmpl      %r12d, %r13d                                  #59.9
        cmovl     %r13d, %r12d                                  #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.14:                        # Preds ..B1.11 ..B1.13 ..B1.12
                                # Execution count [5.00e+00]
        movl      %r13d, %r11d                                  #59.9
        subl      %r12d, %r11d                                  #59.9
        andl      $15, %r11d                                    #59.9
        negl      %r11d                                         #59.9
        addl      %r13d, %r11d                                  #59.9
        cmpl      $1, %r12d                                     #59.9
        jb        ..B1.18       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.15:                        # Preds ..B1.14
                                # Execution count [4.50e+00]
        vmovaps   %zmm16, %zmm4                                 #59.9
        xorl      %r15d, %r15d                                  #59.9
        vpbroadcastd %r12d, %zmm3                               #59.9
        vbroadcastss %xmm11, %zmm2                              #48.23
        vbroadcastss %xmm7, %zmm1                               #49.23
        vbroadcastss %xmm8, %zmm0                               #50.23
        movslq    %r12d, %r14                                   #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm7 xmm8 xmm11 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.16:                        # Preds ..B1.16 ..B1.15
                                # Execution count [2.50e+01]
        vpcmpgtd  %zmm4, %zmm3, %k5                             #59.9
        vpaddd    %zmm15, %zmm4, %zmm4                          #59.9
        vmovdqu32 (%r10,%r15,4), %zmm17{%k5}{z}                 #60.21
        vpaddd    %zmm17, %zmm17, %zmm18                        #61.36
        addq      $16, %r15                                     #59.9
        vpaddd    %zmm18, %zmm17, %zmm19                        #61.36
        kmovw     %k5, %k2                                      #61.36
        kmovw     %k5, %k3                                      #61.36
        kmovw     %k5, %k1                                      #61.36
        vpxord    %zmm21, %zmm21, %zmm21                        #61.36
        vpxord    %zmm20, %zmm20, %zmm20                        #61.36
        vpxord    %zmm22, %zmm22, %zmm22                        #61.36
        vgatherdps 4(%rbx,%zmm19,4), %zmm21{%k2}                #61.36
        vgatherdps (%rbx,%zmm19,4), %zmm20{%k3}                 #61.36
        vgatherdps 8(%rbx,%zmm19,4), %zmm22{%k1}                #61.36
        vsubps    %zmm21, %zmm1, %zmm17                         #62.36
        vsubps    %zmm20, %zmm2, %zmm31                         #61.36
        vsubps    %zmm22, %zmm0, %zmm18                         #63.36
        vmulps    %zmm17, %zmm17, %zmm30                        #64.49
        vfmadd231ps %zmm31, %zmm31, %zmm30                      #64.49
        vfmadd231ps %zmm18, %zmm18, %zmm30                      #64.63
        vrcp14ps  %zmm30, %zmm29                                #75.39
        vcmpps    $1, %zmm14, %zmm30, %k6{%k5}                  #74.22
        #vfpclassps $30, %zmm29, %k0                             #75.39
        #vmovaps   %zmm30, %zmm23                                #75.39
        #vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm29, %zmm23 #75.39
        #knotw     %k0, %k4                                      #75.39
        #vfmadd213ps %zmm29, %zmm23, %zmm29{%k4}                 #75.39
        vmulps    %zmm13, %zmm29, %zmm24                        #76.38
        vmulps    %zmm12, %zmm29, %zmm26                        #77.55
        vmulps    %zmm24, %zmm29, %zmm27                        #76.44
        vmulps    %zmm27, %zmm29, %zmm25                        #76.50
        vfmsub213ps %zmm6, %zmm27, %zmm29                       #77.55
        vmulps    %zmm26, %zmm25, %zmm28                        #77.64
        vmulps    %zmm29, %zmm28, %zmm23                        #77.70
        vfmadd231ps %zmm31, %zmm23, %zmm10{%k6}                 #78.17
        vfmadd231ps %zmm17, %zmm23, %zmm9{%k6}                  #79.17
        vfmadd231ps %zmm18, %zmm23, %zmm5{%k6}                  #80.17
        cmpq      %r14, %r15                                    #59.9
        jb        ..B1.16       # Prob 82%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r15 r11d r12d r13d xmm7 xmm8 xmm11 zmm0 zmm1 zmm2 zmm3 zmm4 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.17:                        # Preds ..B1.16
                                # Execution count [4.50e+00]
        cmpl      %r12d, %r13d                                  #59.9
        je        ..B1.24       # Prob 10%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.18:                        # Preds ..B1.17 ..B1.14 ..B1.32
                                # Execution count [2.50e+01]
        lea       16(%r12), %r10d                               #59.9
        cmpl      %r10d, %r11d                                  #59.9
        jl        ..B1.22       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.19:                        # Preds ..B1.18
                                # Execution count [4.50e+00]
        movq      %r8, %r10                                     #46.43
        imulq     %rsi, %r10                                    #46.43
        vbroadcastss %xmm11, %zmm2                              #48.23
        vbroadcastss %xmm7, %zmm1                               #49.23
        vbroadcastss %xmm8, %zmm0                               #50.23
        movslq    %r12d, %r14                                   #59.9
        addq      %r9, %r10                                     #23.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm7 xmm8 xmm11 zmm0 zmm1 zmm2 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.20:                        # Preds ..B1.20 ..B1.19
                                # Execution count [2.50e+01]
        vmovups   (%r10,%r14,4), %zmm3                          #60.21
        addl      $16, %r12d                                    #59.9
        vpcmpeqb  %xmm0, %xmm0, %k2                             #61.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #61.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #61.36
        vpaddd    %zmm3, %zmm3, %zmm4                           #61.36
        vpaddd    %zmm4, %zmm3, %zmm17                          #61.36
        addq      $16, %r14                                     #59.9
        vpxord    %zmm19, %zmm19, %zmm19                        #61.36
        vpxord    %zmm18, %zmm18, %zmm18                        #61.36
        vpxord    %zmm20, %zmm20, %zmm20                        #61.36
        vgatherdps 4(%rbx,%zmm17,4), %zmm19{%k2}                #61.36
        vgatherdps (%rbx,%zmm17,4), %zmm18{%k3}                 #61.36
        vgatherdps 8(%rbx,%zmm17,4), %zmm20{%k1}                #61.36
        vsubps    %zmm19, %zmm1, %zmm29                         #62.36
        vsubps    %zmm18, %zmm2, %zmm28                         #61.36
        vsubps    %zmm20, %zmm0, %zmm31                         #63.36
        vmulps    %zmm29, %zmm29, %zmm21                        #64.49
        vfmadd231ps %zmm28, %zmm28, %zmm21                      #64.49
        vfmadd231ps %zmm31, %zmm31, %zmm21                      #64.63
        vrcp14ps  %zmm21, %zmm27                                #75.39
        vcmpps    $1, %zmm14, %zmm21, %k5                       #74.22
        #vfpclassps $30, %zmm27, %k0                             #75.39
        #vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm27, %zmm21 #75.39
        #knotw     %k0, %k4                                      #75.39
        #vfmadd213ps %zmm27, %zmm21, %zmm27{%k4}                 #75.39
        vmulps    %zmm13, %zmm27, %zmm22                        #76.38
        vmulps    %zmm12, %zmm27, %zmm24                        #77.55
        vmulps    %zmm22, %zmm27, %zmm25                        #76.44
        vmulps    %zmm25, %zmm27, %zmm23                        #76.50
        vfmsub213ps %zmm6, %zmm25, %zmm27                       #77.55
        vmulps    %zmm24, %zmm23, %zmm26                        #77.64
        vmulps    %zmm27, %zmm26, %zmm30                        #77.70
        vfmadd231ps %zmm28, %zmm30, %zmm10{%k5}                 #78.17
        vfmadd231ps %zmm29, %zmm30, %zmm9{%k5}                  #79.17
        vfmadd231ps %zmm31, %zmm30, %zmm5{%k5}                  #80.17
        cmpl      %r11d, %r12d                                  #59.9
        jb        ..B1.20       # Prob 82%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r14 r11d r12d r13d xmm7 xmm8 xmm11 zmm0 zmm1 zmm2 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.22:                        # Preds ..B1.20 ..B1.18 ..B1.33
                                # Execution count [5.00e+00]
        lea       1(%r11), %r10d                                #59.9
        cmpl      %r13d, %r10d                                  #59.9
        ja        ..B1.24       # Prob 50%                      #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.23:                        # Preds ..B1.22
                                # Execution count [2.50e+01]
        imulq     %r8, %rsi                                     #46.43
        vbroadcastss %xmm8, %zmm17                              #50.23
        vbroadcastss %xmm7, %zmm4                               #49.23
        vbroadcastss %xmm11, %zmm2                              #48.23
        movl      %r13d, %r10d                                  #59.9
        addq      %r9, %rsi                                     #23.5
        subl      %r11d, %r10d                                  #59.9
        vpbroadcastd %r10d, %zmm8                               #59.9
        vpcmpgtd  %zmm16, %zmm8, %k5                            #59.9
        movslq    %r11d, %r11                                   #59.9
        kmovw     %k5, %k2                                      #61.36
        kmovw     %k5, %k3                                      #61.36
        kmovw     %k5, %k1                                      #61.36
        vmovdqu32 (%rsi,%r11,4), %zmm7{%k5}{z}                  #60.21
        vpaddd    %zmm7, %zmm7, %zmm0                           #61.36
        vpaddd    %zmm0, %zmm7, %zmm1                           #61.36
        vpxord    %zmm11, %zmm11, %zmm11                        #61.36
        vpxord    %zmm3, %zmm3, %zmm3                           #61.36
        vpxord    %zmm18, %zmm18, %zmm18                        #61.36
        vgatherdps 4(%rbx,%zmm1,4), %zmm11{%k2}                 #61.36
        vgatherdps (%rbx,%zmm1,4), %zmm3{%k3}                   #61.36
        vgatherdps 8(%rbx,%zmm1,4), %zmm18{%k1}                 #61.36
        vsubps    %zmm11, %zmm4, %zmm28                         #62.36
        vsubps    %zmm3, %zmm2, %zmm27                          #61.36
        vsubps    %zmm18, %zmm17, %zmm30                        #63.36
        vmulps    %zmm28, %zmm28, %zmm26                        #64.49
        vfmadd231ps %zmm27, %zmm27, %zmm26                      #64.49
        vfmadd231ps %zmm30, %zmm30, %zmm26                      #64.63
        vrcp14ps  %zmm26, %zmm25                                #75.39
        vcmpps    $1, %zmm14, %zmm26, %k6{%k5}                  #74.22
        #vfpclassps $30, %zmm25, %k0                             #75.39
        #vmovaps   %zmm26, %zmm19                                #75.39
        #vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm25, %zmm19 #75.39
        #knotw     %k0, %k4                                      #75.39
        #vfmadd213ps %zmm25, %zmm19, %zmm25{%k4}                 #75.39
        vmulps    %zmm13, %zmm25, %zmm20                        #76.38
        vmulps    %zmm12, %zmm25, %zmm22                        #77.55
        vmulps    %zmm20, %zmm25, %zmm23                        #76.44
        vmulps    %zmm23, %zmm25, %zmm21                        #76.50
        vfmsub213ps %zmm6, %zmm23, %zmm25                       #77.55
        vmulps    %zmm22, %zmm21, %zmm24                        #77.64
        vmulps    %zmm25, %zmm24, %zmm29                        #77.70
        vfmadd231ps %zmm27, %zmm29, %zmm10{%k6}                 #78.17
        vfmadd231ps %zmm28, %zmm29, %zmm9{%k6}                  #79.17
        vfmadd231ps %zmm30, %zmm29, %zmm5{%k6}                  #80.17
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.24:                        # Preds ..B1.17 ..B1.23 ..B1.22
                                # Execution count [4.50e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm22            #53.22
        vmovups   .L_2il0floatpacket.7(%rip), %zmm24            #53.22
        vpermd    %zmm5, %zmm22, %zmm0                          #53.22
        vpermd    %zmm9, %zmm22, %zmm8                          #52.22
        vpermd    %zmm10, %zmm22, %zmm23                        #51.22
        vaddps    %zmm5, %zmm0, %zmm1                           #53.22
        vaddps    %zmm9, %zmm8, %zmm11                          #52.22
        vaddps    %zmm10, %zmm23, %zmm25                        #51.22
        vpermd    %zmm1, %zmm24, %zmm5                          #53.22
        vpermd    %zmm11, %zmm24, %zmm9                         #52.22
        vpermd    %zmm25, %zmm24, %zmm10                        #51.22
        vaddps    %zmm1, %zmm5, %zmm2                           #53.22
        vaddps    %zmm11, %zmm9, %zmm17                         #52.22
        vaddps    %zmm25, %zmm10, %zmm26                        #51.22
        vpshufd   $78, %zmm2, %zmm3                             #53.22
        vpshufd   $78, %zmm17, %zmm18                           #52.22
        vpshufd   $78, %zmm26, %zmm27                           #51.22
        vaddps    %zmm3, %zmm2, %zmm4                           #53.22
        vaddps    %zmm18, %zmm17, %zmm19                        #52.22
        vaddps    %zmm27, %zmm26, %zmm28                        #51.22
        vpshufd   $177, %zmm4, %zmm7                            #53.22
        vpshufd   $177, %zmm19, %zmm20                          #52.22
        vpshufd   $177, %zmm28, %zmm29                          #51.22
        vaddps    %zmm7, %zmm4, %zmm0                           #53.22
        vaddps    %zmm20, %zmm19, %zmm21                        #52.22
        vaddps    %zmm29, %zmm28, %zmm30                        #51.22
                                # LOE rax rdx rcx rbx rdi r8 r9 r13d xmm0 xmm21 xmm30 zmm6 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.25:                        # Preds ..B1.24 ..B1.7
                                # Execution count [5.00e+00]
        movslq    %r13d, %r13                                   #93.9
        movq      48(%rsp), %rsi                                #89.9[spill]
        lea       15(%r13), %r10d                               #94.9
        sarl      $3, %r10d                                     #94.9
        addq      %r13, %rdx                                    #93.9
        shrl      $28, %r10d                                    #94.9
        vaddss    (%rax,%rsi), %xmm30, %xmm1                    #89.9
        vaddss    4(%rax,%rsi), %xmm21, %xmm2                   #90.9
        vaddss    8(%rax,%rsi), %xmm0, %xmm0                    #91.9
        vmovss    %xmm1, (%rax,%rsi)                            #89.9
        lea       15(%r10,%r13), %r11d                          #94.9
        sarl      $4, %r11d                                     #94.9
        vmovss    %xmm2, 4(%rax,%rsi)                           #90.9
        vmovss    %xmm0, 8(%rax,%rsi)                           #91.9
        addq      $12, %rax                                     #45.5
        movslq    %r11d, %r11                                   #94.9
        movslq    %edi, %rsi                                    #45.32
        incq      %rdi                                          #45.5
        addq      %r11, %rcx                                    #94.9
        incq      %rsi                                          #45.32
        cmpq      64(%rsp), %rdi                                #45.5[spill]
        jb        ..B1.7        # Prob 82%                      #45.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 zmm6 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.26:                        # Preds ..B1.25
                                # Execution count [9.00e-01]
        movq      (%rsp), %r14                                  #[spill]
        movq      8(%rsp), %r12                                 #[spill]
	.cfi_restore 12
        movq      %rdx, (%r14)                                  #93.9
        movq      %rcx, 8(%r14)                                 #94.9
        jmp       ..B1.29       # Prob 100%                     #94.9
                                # LOE r12
..B1.27:                        # Preds ..B1.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.33:
#       getTimeStamp()
        call      getTimeStamp                                  #38.16
..___tag_value_computeForceLJFullNeigh_plain_c.34:
                                # LOE r12 xmm0
..B1.44:                        # Preds ..B1.27
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 40(%rsp)                               #38.16[spill]
                                # LOE r12
..B1.28:                        # Preds ..B1.44
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.0, %edi                         #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.36:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #42.5
..___tag_value_computeForceLJFullNeigh_plain_c.37:
                                # LOE r12
..B1.29:                        # Preds ..B1.26 ..B1.28
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.0, %edi                         #97.5
        vzeroupper                                              #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.38:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #97.5
..___tag_value_computeForceLJFullNeigh_plain_c.39:
                                # LOE r12
..B1.30:                        # Preds ..B1.29
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #100.16
..___tag_value_computeForceLJFullNeigh_plain_c.40:
#       getTimeStamp()
        call      getTimeStamp                                  #100.16
..___tag_value_computeForceLJFullNeigh_plain_c.41:
                                # LOE r12 xmm0
..B1.31:                        # Preds ..B1.30
                                # Execution count [1.00e+00]
        vsubsd    40(%rsp), %xmm0, %xmm0                        #101.14[spill]
        addq      $96, %rsp                                     #101.14
	.cfi_restore 3
        popq      %rbx                                          #101.14
	.cfi_restore 15
        popq      %r15                                          #101.14
	.cfi_restore 14
        popq      %r14                                          #101.14
	.cfi_restore 13
        popq      %r13                                          #101.14
        movq      %rbp, %rsp                                    #101.14
        popq      %rbp                                          #101.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #101.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0x88, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B1.32:                        # Preds ..B1.9
                                # Execution count [4.50e-01]: Infreq
        movl      %r13d, %r11d                                  #59.9
        xorl      %r12d, %r12d                                  #59.9
        andl      $-16, %r11d                                   #59.9
        jmp       ..B1.18       # Prob 100%                     #59.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r12d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.33:                        # Preds ..B1.8
                                # Execution count [4.50e-01]: Infreq
        xorl      %r11d, %r11d                                  #59.9
        jmp       ..B1.22       # Prob 100%                     #59.9
	.cfi_restore 12
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d r13d xmm7 xmm8 xmm11 zmm5 zmm6 zmm9 zmm10 zmm12 zmm13 zmm14 zmm15 zmm16
..B1.34:                        # Preds ..B1.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $16, %esi                                     #33.5
        jl        ..B1.40       # Prob 10%                      #33.5
                                # LOE rbx rdi r12 r13 r14 esi r15d
..B1.35:                        # Preds ..B1.34
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #33.5
        xorl      %ecx, %ecx                                    #33.5
        andl      $-16, %eax                                    #33.5
        movslq    %eax, %rdx                                    #33.5
        vpxord    %zmm0, %zmm0, %zmm0                           #34.22
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.36:                        # Preds ..B1.36 ..B1.35
                                # Execution count [5.56e+00]: Infreq
        vmovups   %zmm0, (%rdi,%rcx,4)                          #34.9
        addq      $16, %rcx                                     #33.5
        cmpq      %rdx, %rcx                                    #33.5
        jb        ..B1.36       # Prob 82%                      #33.5
                                # LOE rdx rcx rbx rdi r12 r13 r14 eax esi r15d zmm0
..B1.38:                        # Preds ..B1.36 ..B1.40
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #33.5
        cmpl      %esi, %edx                                    #33.5
        ja        ..B1.46       # Prob 50%                      #33.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.39:                        # Preds ..B1.38
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #33.5
        vpbroadcastd %esi, %zmm0                                #33.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %zmm0, %k1        #33.5
        movslq    %eax, %rax                                    #33.5
        movslq    %r15d, %r15                                   #33.5
        vpxord    %zmm1, %zmm1, %zmm1                           #34.22
        vmovups   %zmm1, (%rdi,%rax,4){%k1}                     #34.9
        jmp       ..B1.4        # Prob 100%                     #34.9
                                # LOE rbx r12 r13 r14 r15
..B1.40:                        # Preds ..B1.34
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #33.5
        jmp       ..B1.38       # Prob 100%                     #33.5
                                # LOE rbx rdi r12 r13 r14 eax esi r15d
..B1.46:                        # Preds ..B1.38
                                # Execution count [5.56e-01]: Infreq
        movslq    %r15d, %r15                                   #33.5
        jmp       ..B1.4        # Prob 100%                     #33.5
        .align    16,0x90
                                # LOE rbx r12 r13 r14 r15
	.cfi_endproc
# mark_end;
	.type	computeForceLJFullNeigh_plain_c,@function
	.size	computeForceLJFullNeigh_plain_c,.-computeForceLJFullNeigh_plain_c
..LNcomputeForceLJFullNeigh_plain_c.0:
	.data
# -- End  computeForceLJFullNeigh_plain_c
	.text
.L_2__routine_start_computeForceLJHalfNeigh_1:
# -- Begin  computeForceLJHalfNeigh
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJHalfNeigh
# --- computeForceLJHalfNeigh(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJHalfNeigh:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B2.1:                         # Preds ..B2.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJHalfNeigh.58:
..L59:
                                                         #104.96
        pushq     %rbp                                          #104.96
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #104.96
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #104.96
        pushq     %r12                                          #104.96
        pushq     %r13                                          #104.96
        pushq     %r14                                          #104.96
        pushq     %r15                                          #104.96
        pushq     %rbx                                          #104.96
        subq      $88, %rsp                                     #104.96
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
        movq      %rsi, %r13                                    #104.96
        vmovss    108(%rdi), %xmm0                              #108.27
        movq      %rcx, %r14                                    #104.96
        vmovss    48(%rdi), %xmm1                               #109.23
        movq      %rdx, %r12                                    #104.96
        vmovss    40(%rdi), %xmm2                               #110.24
        movl      4(%r13), %ebx                                 #105.18
        vmovss    %xmm0, 32(%rsp)                               #108.27[spill]
        vmovss    %xmm1, 16(%rsp)                               #109.23[spill]
        vmovss    %xmm2, 24(%rsp)                               #110.24[spill]
        testl     %ebx, %ebx                                    #113.24
        jle       ..B2.28       # Prob 50%                      #113.24
                                # LOE r12 r13 r14 ebx
..B2.2:                         # Preds ..B2.1
                                # Execution count [5.00e-03]
        movq      64(%r13), %rdi                                #114.9
        lea       (%rbx,%rbx,2), %esi                           #105.18
        cmpl      $24, %esi                                     #113.5
        jle       ..B2.35       # Prob 0%                       #113.5
                                # LOE rdi r12 r13 r14 ebx esi
..B2.3:                         # Preds ..B2.2
                                # Execution count [1.00e+00]
        movslq    %ebx, %r15                                    #113.5
        xorl      %esi, %esi                                    #113.5
        lea       (%r15,%r15,2), %rdx                           #113.5
        shlq      $2, %rdx                                      #113.5
        call      __intel_skx_avx512_memset                     #113.5
                                # LOE r12 r13 r14 r15 ebx
..B2.4:                         # Preds ..B2.3 ..B2.47 ..B2.40
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #119.16
        vzeroupper                                              #119.16
..___tag_value_computeForceLJHalfNeigh.71:
#       getTimeStamp()
        call      getTimeStamp                                  #119.16
..___tag_value_computeForceLJHalfNeigh.72:
                                # LOE r12 r13 r14 r15 ebx xmm0
..B2.44:                        # Preds ..B2.4
                                # Execution count [1.00e+00]
        vmovsd    %xmm0, 8(%rsp)                                #119.16[spill]
                                # LOE r12 r13 r14 r15 ebx
..B2.5:                         # Preds ..B2.44
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #123.5
..___tag_value_computeForceLJHalfNeigh.74:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #123.5
..___tag_value_computeForceLJHalfNeigh.75:
                                # LOE r12 r13 r14 r15 ebx
..B2.6:                         # Preds ..B2.5
                                # Execution count [9.00e-01]
        vxorpd    %xmm0, %xmm0, %xmm0                           #162.67
        xorl      %r10d, %r10d                                  #126.15
        vcvtss2sd 24(%rsp), %xmm0, %xmm0                        #162.67[spill]
        vmovups   .L_2il0floatpacket.0(%rip), %zmm27            #144.9
        vmovups   .L_2il0floatpacket.1(%rip), %zmm26            #144.9
        vmovups   .L_2il0floatpacket.8(%rip), %zmm25            #147.36
        vmovups   .L_2il0floatpacket.9(%rip), %zmm24            #148.36
        vmovss    32(%rsp), %xmm22                              #108.45[spill]
        vmulss    %xmm22, %xmm22, %xmm23                        #108.45
        vmulsd    .L_2il0floatpacket.10(%rip), %xmm0, %xmm1     #162.41
        vmovups   .L_2il0floatpacket.11(%rip), %zmm21           #162.54
        vpbroadcastd %ebx, %zmm19                               #105.18
        vbroadcastss %xmm23, %zmm23                             #108.25
        vbroadcastss 16(%rsp), %zmm22                           #109.21[spill]
        vbroadcastsd %xmm1, %zmm20                              #162.41
        movq      24(%r12), %r11                                #128.25
        xorl      %r9d, %r9d                                    #126.5
        movslq    8(%r12), %rdi                                 #127.43
        xorl      %eax, %eax                                    #126.5
        movq      16(%r12), %r8                                 #127.19
        shlq      $2, %rdi                                      #106.5
        movq      16(%r13), %rsi                                #129.25
        movq      64(%r13), %rdx                                #169.21
        movq      (%r14), %rcx                                  #180.9
        movq      8(%r14), %rbx                                 #181.9
        movq      %r11, 40(%rsp)                                #126.5[spill]
        movq      %r15, 48(%rsp)                                #126.5[spill]
        movq      %r14, (%rsp)                                  #126.5[spill]
        vpxord    %zmm28, %zmm28, %zmm28                        #126.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28
..B2.7:                         # Preds ..B2.26 ..B2.6
                                # Execution count [5.00e+00]
        movq      40(%rsp), %r11                                #128.25[spill]
        vxorps    %xmm3, %xmm3, %xmm3                           #132.22
        vmovaps   %xmm3, %xmm30                                 #133.22
        movl      (%r11,%r9,4), %r11d                           #128.25
        vmovaps   %xmm30, %xmm1                                 #134.22
        vmovss    (%rax,%rsi), %xmm15                           #129.25
        vmovss    4(%rax,%rsi), %xmm17                          #130.25
        vmovss    8(%rax,%rsi), %xmm16                          #131.25
        testl     %r11d, %r11d                                  #144.9
        jle       ..B2.26       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm1 xmm3 xmm15 xmm16 xmm17 xmm30 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28
..B2.8:                         # Preds ..B2.7
                                # Execution count [2.50e+00]
        jbe       ..B2.26       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm1 xmm3 xmm15 xmm16 xmm17 xmm30 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28
..B2.9:                         # Preds ..B2.8
                                # Execution count [2.25e+00]
        vmovaps   %zmm28, %zmm29                                #132.22
        vmovaps   %zmm29, %zmm30                                #133.22
        vmovaps   %zmm30, %zmm18                                #134.22
        cmpl      $16, %r11d                                    #144.9
        jb        ..B2.34       # Prob 10%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.10:                        # Preds ..B2.9
                                # Execution count [2.25e+00]
        cmpl      $2400, %r11d                                  #144.9
        jb        ..B2.33       # Prob 10%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.11:                        # Preds ..B2.10
                                # Execution count [2.25e+00]
        movq      %rdi, %r15                                    #127.43
        imulq     %r10, %r15                                    #127.43
        addq      %r8, %r15                                     #106.5
        movq      %r15, %r12                                    #144.9
        andq      $63, %r12                                     #144.9
        testl     $3, %r12d                                     #144.9
        je        ..B2.13       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.12:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        movl      %r11d, %r14d                                  #144.9
        xorl      %r12d, %r12d                                  #144.9
        andl      $15, %r14d                                    #144.9
        negl      %r14d                                         #144.9
        addl      %r11d, %r14d                                  #144.9
        jmp       ..B2.19       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.13:                        # Preds ..B2.11
                                # Execution count [1.12e+00]
        testl     %r12d, %r12d                                  #144.9
        je        ..B2.18       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.14:                        # Preds ..B2.13
                                # Execution count [1.25e+01]
        negl      %r12d                                         #144.9
        movl      %r11d, %r14d                                  #144.9
        addl      $64, %r12d                                    #144.9
        shrl      $2, %r12d                                     #144.9
        cmpl      %r12d, %r11d                                  #144.9
        cmovb     %r11d, %r12d                                  #144.9
        subl      %r12d, %r14d                                  #144.9
        andl      $15, %r14d                                    #144.9
        negl      %r14d                                         #144.9
        addl      %r11d, %r14d                                  #144.9
        cmpl      $1, %r12d                                     #144.9
        jb        ..B2.19       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r15 r11d r12d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.15:                        # Preds ..B2.14
                                # Execution count [2.25e+00]
        vpbroadcastd %r12d, %zmm13                              #144.9
        xorl      %r13d, %r13d                                  #144.9
        vbroadcastss %xmm15, %zmm12                             #129.23
        vbroadcastss %xmm17, %zmm11                             #130.23
        vbroadcastss %xmm16, %zmm3                              #131.23
        movslq    %r12d, %r12                                   #144.9
        movq      %r10, 16(%rsp)                                #144.9[spill]
        vmovaps   %zmm27, %zmm14                                #144.9
        movq      %r12, %r10                                    #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm15 xmm16 xmm17 zmm3 zmm11 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.16:                        # Preds ..B2.16 ..B2.15
                                # Execution count [1.25e+01]
        vpcmpud   $1, %zmm13, %zmm14, %k5                       #144.9
        vpaddd    %zmm26, %zmm14, %zmm14                        #144.9
        vmovdqu32 (%r15,%r13,4), %zmm1{%k5}{z}                  #145.21
        vpaddd    %zmm1, %zmm1, %zmm10                          #146.36
        addq      $16, %r13                                     #144.9
        vpaddd    %zmm10, %zmm1, %zmm5                          #146.36
        kmovw     %k5, %k3                                      #146.36
        kmovw     %k5, %k4                                      #146.36
        kmovw     %k5, %k2                                      #146.36
        vpaddd    %zmm25, %zmm5, %zmm7                          #147.36
        vpaddd    %zmm24, %zmm5, %zmm10                         #148.36
        vpxord    %zmm8, %zmm8, %zmm8                           #146.36
        vpxord    %zmm9, %zmm9, %zmm9                           #146.36
        vpxord    %zmm4, %zmm4, %zmm4                           #146.36
        vgatherdps 4(%rsi,%zmm5,4), %zmm8{%k3}                  #146.36
        vgatherdps (%rsi,%zmm5,4), %zmm9{%k4}                   #146.36
        vgatherdps 8(%rsi,%zmm5,4), %zmm4{%k2}                  #146.36
        vsubps    %zmm8, %zmm11, %zmm8                          #147.36
        vsubps    %zmm9, %zmm12, %zmm6                          #146.36
        vsubps    %zmm4, %zmm3, %zmm9                           #148.36
        vmulps    %zmm8, %zmm8, %zmm31                          #149.49
        vfmadd231ps %zmm6, %zmm6, %zmm31                        #149.49
        vfmadd231ps %zmm9, %zmm9, %zmm31                        #149.63
        vrcp14ps  %zmm31, %zmm2                                 #160.38
        vcmpps    $1, %zmm23, %zmm31, %k7{%k5}                  #159.22
        vfpclassps $30, %zmm2, %k0                              #160.38
        vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm2, %zmm31 #160.38
        vpcmpgtd  %zmm1, %zmm19, %k1{%k7}                       #168.24
        knotw     %k0, %k6                                      #160.38
        vfmadd213ps %zmm2, %zmm31, %zmm2{%k6}                   #160.38
        vmulps    %zmm22, %zmm2, %zmm0                          #161.38
        vcvtps2pd %ymm2, %zmm31                                 #162.61
        vmulps    %zmm0, %zmm2, %zmm1                           #161.44
        vmulpd    %zmm31, %zmm20, %zmm31                        #162.54
        vmulps    %zmm1, %zmm2, %zmm0                           #161.50
        vextractf64x4 $1, %zmm2, %ymm2                          #162.61
        kmovw     %k1, %k2                                      #169.21
        kmovw     %k1, %k3                                      #169.21
        kmovw     %k1, %k4                                      #170.21
        kmovw     %k1, %k5                                      #170.21
        kmovw     %k1, %k6                                      #171.21
        vcvtps2pd %ymm2, %zmm4                                  #162.61
        vmulpd    %zmm4, %zmm20, %zmm1                          #162.54
        vcvtps2pd %ymm0, %zmm4                                  #162.41
        vextractf64x4 $1, %zmm0, %ymm0                          #162.41
        vcvtps2pd %ymm0, %zmm2                                  #162.41
        vmulpd    %zmm4, %zmm31, %zmm0                          #162.61
        vmulpd    %zmm2, %zmm1, %zmm31                          #162.61
        vsubpd    %zmm21, %zmm4, %zmm1                          #162.54
        vsubpd    %zmm21, %zmm2, %zmm2                          #162.54
        vmulpd    %zmm1, %zmm0, %zmm4                           #162.67
        vmulpd    %zmm2, %zmm31, %zmm31                         #162.67
        vcvtpd2ps %zmm4, %ymm0                                  #162.67
        vcvtpd2ps %zmm31, %ymm31                                #162.67
        vmovaps   %zmm28, %zmm1                                 #169.21
        vgatherdps (%rdx,%zmm5,4), %zmm1{%k2}                   #169.21
        vinsertf64x4 $1, %ymm31, %zmm0, %zmm2                   #162.67
        vfmadd231ps %zmm6, %zmm2, %zmm29{%k7}                   #163.17
        vfnmadd213ps %zmm1, %zmm2, %zmm6                        #169.21
        vfmadd231ps %zmm8, %zmm2, %zmm30{%k7}                   #164.17
        vfmadd231ps %zmm9, %zmm2, %zmm18{%k7}                   #165.17
        vscatterdps %zmm6, (%rdx,%zmm5,4){%k3}                  #169.21
        vmovaps   %zmm28, %zmm5                                 #170.21
        vmovaps   %zmm28, %zmm6                                 #171.21
        vgatherdps (%rdx,%zmm7,4), %zmm5{%k4}                   #170.21
        vfnmadd213ps %zmm5, %zmm2, %zmm8                        #170.21
        vscatterdps %zmm8, (%rdx,%zmm7,4){%k5}                  #170.21
        vgatherdps (%rdx,%zmm10,4), %zmm6{%k6}                  #171.21
        vfnmadd213ps %zmm6, %zmm2, %zmm9                        #171.21
        vscatterdps %zmm9, (%rdx,%zmm10,4){%k1}                 #171.21
        cmpq      %r10, %r13                                    #144.9
        jb        ..B2.16       # Prob 82%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm15 xmm16 xmm17 zmm3 zmm11 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.17:                        # Preds ..B2.16
                                # Execution count [2.25e+00]
        movq      16(%rsp), %r10                                #[spill]
        cmpl      %r12d, %r11d                                  #144.9
        je        ..B2.25       # Prob 10%                      #144.9
        jmp       ..B2.19       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.18:                        # Preds ..B2.13
                                # Execution count [5.62e-01]
        movl      %r11d, %r14d                                  #144.9
        andl      $15, %r14d                                    #144.9
        negl      %r14d                                         #144.9
        addl      %r11d, %r14d                                  #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.19:                        # Preds ..B2.12 ..B2.18 ..B2.17 ..B2.14 ..B2.33
                                #      
                                # Execution count [1.25e+01]
        lea       16(%r12), %r13d                               #144.9
        cmpl      %r13d, %r14d                                  #144.9
        jb        ..B2.23       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.20:                        # Preds ..B2.19
                                # Execution count [2.25e+00]
        movq      %rdi, %r13                                    #127.43
        imulq     %r10, %r13                                    #127.43
        vbroadcastss %xmm15, %zmm14                             #129.23
        vbroadcastss %xmm17, %zmm13                             #130.23
        vbroadcastss %xmm16, %zmm12                             #131.23
        movslq    %r12d, %r15                                   #144.9
        addq      %r8, %r13                                     #106.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm15 xmm16 xmm17 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.21:                        # Preds ..B2.21 ..B2.20
                                # Execution count [1.25e+01]
        vmovups   (%r13,%r15,4), %zmm5                          #145.21
        addl      $16, %r12d                                    #144.9
        vpaddd    %zmm5, %zmm5, %zmm31                          #146.36
        addq      $16, %r15                                     #144.9
        vpaddd    %zmm31, %zmm5, %zmm11                         #146.36
        vpaddd    %zmm11, %zmm25, %zmm10                        #147.36
        vpxord    %zmm0, %zmm0, %zmm0                           #146.36
        vpcmpeqb  %xmm0, %xmm0, %k1                             #146.36
        vgatherdps 8(%rsi,%zmm11,4), %zmm0{%k1}                 #146.36
        vpcmpeqb  %xmm0, %xmm0, %k2                             #146.36
        vpcmpeqb  %xmm0, %xmm0, %k3                             #146.36
        vpxord    %zmm6, %zmm6, %zmm6                           #146.36
        vpxord    %zmm8, %zmm8, %zmm8                           #146.36
        vgatherdps 4(%rsi,%zmm11,4), %zmm6{%k2}                 #146.36
        vgatherdps (%rsi,%zmm11,4), %zmm8{%k3}                  #146.36
        vsubps    %zmm6, %zmm13, %zmm7                          #147.36
        vsubps    %zmm8, %zmm14, %zmm9                          #146.36
        vsubps    %zmm0, %zmm12, %zmm6                          #148.36
        vpaddd    %zmm11, %zmm24, %zmm8                         #148.36
        vmulps    %zmm7, %zmm7, %zmm2                           #149.49
        vfmadd231ps %zmm9, %zmm9, %zmm2                         #149.49
        vfmadd231ps %zmm6, %zmm6, %zmm2                         #149.63
        vrcp14ps  %zmm2, %zmm0                                  #160.38
        vcmpps    $1, %zmm23, %zmm2, %k5                        #159.22
        vfpclassps $30, %zmm0, %k0                              #160.38
        vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm0, %zmm2 #160.38
        vpcmpgtd  %zmm5, %zmm19, %k2{%k5}                       #168.24
        knotw     %k0, %k4                                      #160.38
        vfmadd213ps %zmm0, %zmm2, %zmm0{%k4}                    #160.38
        vmulps    %zmm22, %zmm0, %zmm1                          #161.38
        vcvtps2pd %ymm0, %zmm31                                 #162.61
        vextractf64x4 $1, %zmm0, %ymm5                          #162.61
        vmulps    %zmm1, %zmm0, %zmm3                           #161.44
        vmulps    %zmm3, %zmm0, %zmm4                           #161.50
        vmulpd    %zmm31, %zmm20, %zmm3                         #162.54
        vcvtps2pd %ymm4, %zmm2                                  #162.41
        vextractf64x4 $1, %zmm4, %ymm4                          #162.41
        vmulpd    %zmm2, %zmm3, %zmm3                           #162.61
        vsubpd    %zmm21, %zmm2, %zmm2                          #162.54
        kmovw     %k2, %k6                                      #169.21
        kmovw     %k2, %k7                                      #169.21
        kmovw     %k2, %k1                                      #171.21
        vcvtps2pd %ymm5, %zmm0                                  #162.61
        vmulpd    %zmm2, %zmm3, %zmm5                           #162.67
        vmulpd    %zmm0, %zmm20, %zmm1                          #162.54
        vcvtps2pd %ymm4, %zmm0                                  #162.41
        vmulpd    %zmm0, %zmm1, %zmm1                           #162.61
        vsubpd    %zmm21, %zmm0, %zmm0                          #162.54
        vmulpd    %zmm0, %zmm1, %zmm31                          #162.67
        vcvtpd2ps %zmm5, %ymm0                                  #162.67
        vcvtpd2ps %zmm31, %ymm31                                #162.67
        vmovaps   %zmm28, %zmm1                                 #169.21
        vgatherdps (%rdx,%zmm11,4), %zmm1{%k6}                  #169.21
        kmovw     %k2, %k6                                      #170.21
        vinsertf64x4 $1, %ymm31, %zmm0, %zmm2                   #162.67
        vfmadd231ps %zmm9, %zmm2, %zmm29{%k5}                   #163.17
        vfnmadd213ps %zmm1, %zmm2, %zmm9                        #169.21
        vfmadd231ps %zmm7, %zmm2, %zmm30{%k5}                   #164.17
        vfmadd231ps %zmm6, %zmm2, %zmm18{%k5}                   #165.17
        vscatterdps %zmm9, (%rdx,%zmm11,4){%k7}                 #169.21
        vmovaps   %zmm28, %zmm9                                 #170.21
        kmovw     %k2, %k5                                      #170.21
        vgatherdps (%rdx,%zmm10,4), %zmm9{%k5}                  #170.21
        vfnmadd213ps %zmm9, %zmm2, %zmm7                        #170.21
        vscatterdps %zmm7, (%rdx,%zmm10,4){%k6}                 #170.21
        vmovaps   %zmm28, %zmm7                                 #171.21
        vgatherdps (%rdx,%zmm8,4), %zmm7{%k1}                   #171.21
        vfnmadd213ps %zmm7, %zmm2, %zmm6                        #171.21
        vscatterdps %zmm6, (%rdx,%zmm8,4){%k2}                  #171.21
        cmpl      %r14d, %r12d                                  #144.9
        jb        ..B2.21       # Prob 82%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r13 r15 r11d r12d r14d xmm15 xmm16 xmm17 zmm12 zmm13 zmm14 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.23:                        # Preds ..B2.21 ..B2.19 ..B2.34
                                # Execution count [2.50e+00]
        lea       1(%r14), %r12d                                #144.9
        cmpl      %r11d, %r12d                                  #144.9
        ja        ..B2.25       # Prob 50%                      #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.24:                        # Preds ..B2.23
                                # Execution count [1.25e+01]
        imulq     %rdi, %r10                                    #127.43
        vbroadcastss %xmm17, %zmm10                             #130.23
        vbroadcastss %xmm15, %zmm8                              #129.23
        vbroadcastss %xmm16, %zmm12                             #131.23
        movl      %r11d, %r12d                                  #144.9
        addq      %r8, %r10                                     #106.5
        subl      %r14d, %r12d                                  #144.9
        vpbroadcastd %r12d, %zmm6                               #144.9
        vpcmpud   $1, %zmm6, %zmm27, %k5                        #144.9
        movslq    %r14d, %r14                                   #144.9
        kmovw     %k5, %k2                                      #146.36
        kmovw     %k5, %k3                                      #146.36
        kmovw     %k5, %k1                                      #146.36
        vmovdqu32 (%r10,%r14,4), %zmm5{%k5}{z}                  #145.21
        vpaddd    %zmm5, %zmm5, %zmm7                           #146.36
        vpaddd    %zmm7, %zmm5, %zmm4                           #146.36
        vpaddd    %zmm4, %zmm25, %zmm3                          #147.36
        vpaddd    %zmm4, %zmm24, %zmm1                          #148.36
        vpxord    %zmm11, %zmm11, %zmm11                        #146.36
        vpxord    %zmm9, %zmm9, %zmm9                           #146.36
        vpxord    %zmm13, %zmm13, %zmm13                        #146.36
        vgatherdps 4(%rsi,%zmm4,4), %zmm11{%k2}                 #146.36
        vgatherdps (%rsi,%zmm4,4), %zmm9{%k3}                   #146.36
        vgatherdps 8(%rsi,%zmm4,4), %zmm13{%k1}                 #146.36
        vsubps    %zmm11, %zmm10, %zmm0                         #147.36
        vsubps    %zmm9, %zmm8, %zmm2                           #146.36
        vsubps    %zmm13, %zmm12, %zmm16                        #148.36
        vmulps    %zmm0, %zmm0, %zmm17                          #149.49
        vfmadd231ps %zmm2, %zmm2, %zmm17                        #149.49
        vfmadd231ps %zmm16, %zmm16, %zmm17                      #149.63
        vrcp14ps  %zmm17, %zmm6                                 #160.38
        vcmpps    $1, %zmm23, %zmm17, %k6{%k5}                  #159.22
        vfpclassps $30, %zmm6, %k0                              #160.38
        vpcmpgtd  %zmm5, %zmm19, %k5{%k6}                       #168.24
        knotw     %k0, %k4                                      #160.38
        vmovaps   %zmm17, %zmm14                                #160.38
        vfnmadd213ps .L_2il0floatpacket.5(%rip){1to16}, %zmm6, %zmm14 #160.38
        vfmadd213ps %zmm6, %zmm14, %zmm6{%k4}                   #160.38
        vmulps    %zmm22, %zmm6, %zmm15                         #161.38
        vcvtps2pd %ymm6, %zmm8                                  #162.61
        vextractf64x4 $1, %zmm6, %ymm7                          #162.61
        vmulps    %zmm15, %zmm6, %zmm31                         #161.44
        vmulpd    %zmm8, %zmm20, %zmm12                         #162.54
        vmulps    %zmm31, %zmm6, %zmm10                         #161.50
        vmovaps   %zmm28, %zmm5                                 #169.21
        kmovw     %k5, %k7                                      #169.21
        vextractf64x4 $1, %zmm10, %ymm11                        #162.41
        vcvtps2pd %ymm10, %zmm14                                #162.41
        vgatherdps (%rdx,%zmm4,4), %zmm5{%k7}                   #169.21
        vmulpd    %zmm14, %zmm12, %zmm31                        #162.61
        vsubpd    %zmm21, %zmm14, %zmm14                        #162.54
        vmulpd    %zmm14, %zmm31, %zmm8                         #162.67
        kmovw     %k5, %k1                                      #169.21
        kmovw     %k5, %k2                                      #170.21
        kmovw     %k5, %k3                                      #170.21
        kmovw     %k5, %k4                                      #171.21
        vcvtps2pd %ymm7, %zmm9                                  #162.61
        vmulpd    %zmm9, %zmm20, %zmm13                         #162.54
        vcvtps2pd %ymm11, %zmm15                                #162.41
        vcvtpd2ps %zmm8, %ymm11                                 #162.67
        vmulpd    %zmm15, %zmm13, %zmm6                         #162.61
        vsubpd    %zmm21, %zmm15, %zmm7                         #162.54
        vmulpd    %zmm7, %zmm6, %zmm9                           #162.67
        vcvtpd2ps %zmm9, %ymm10                                 #162.67
        vinsertf64x4 $1, %ymm10, %zmm11, %zmm12                 #162.67
        vfmadd231ps %zmm2, %zmm12, %zmm29{%k6}                  #163.17
        vfnmadd213ps %zmm5, %zmm12, %zmm2                       #169.21
        vfmadd231ps %zmm0, %zmm12, %zmm30{%k6}                  #164.17
        vfmadd231ps %zmm16, %zmm12, %zmm18{%k6}                 #165.17
        vscatterdps %zmm2, (%rdx,%zmm4,4){%k1}                  #169.21
        vmovaps   %zmm28, %zmm2                                 #170.21
        vgatherdps (%rdx,%zmm3,4), %zmm2{%k2}                   #170.21
        vfnmadd213ps %zmm2, %zmm12, %zmm0                       #170.21
        vscatterdps %zmm0, (%rdx,%zmm3,4){%k3}                  #170.21
        vmovaps   %zmm28, %zmm0                                 #171.21
        vgatherdps (%rdx,%zmm1,4), %zmm0{%k4}                   #171.21
        vfnmadd213ps %zmm0, %zmm12, %zmm16                      #171.21
        vscatterdps %zmm16, (%rdx,%zmm1,4){%k5}                 #171.21
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.25:                        # Preds ..B2.17 ..B2.24 ..B2.23
                                # Execution count [2.25e+00]
        vmovups   .L_2il0floatpacket.6(%rip), %zmm0             #134.22
        vpermd    %zmm18, %zmm0, %zmm1                          #134.22
        vpermd    %zmm30, %zmm0, %zmm8                          #133.22
        vpermd    %zmm29, %zmm0, %zmm15                         #132.22
        vaddps    %zmm18, %zmm1, %zmm3                          #134.22
        vaddps    %zmm30, %zmm8, %zmm10                         #133.22
        vaddps    %zmm29, %zmm15, %zmm17                        #132.22
        vmovups   .L_2il0floatpacket.7(%rip), %zmm18            #134.22
        vpermd    %zmm3, %zmm18, %zmm2                          #134.22
        vpermd    %zmm10, %zmm18, %zmm9                         #133.22
        vpermd    %zmm17, %zmm18, %zmm16                        #132.22
        vaddps    %zmm3, %zmm2, %zmm4                           #134.22
        vaddps    %zmm10, %zmm9, %zmm11                         #133.22
        vaddps    %zmm17, %zmm16, %zmm29                        #132.22
        vpshufd   $78, %zmm4, %zmm5                             #134.22
        vpshufd   $78, %zmm11, %zmm12                           #133.22
        vpshufd   $78, %zmm29, %zmm31                           #132.22
        vaddps    %zmm5, %zmm4, %zmm6                           #134.22
        vaddps    %zmm12, %zmm11, %zmm13                        #133.22
        vaddps    %zmm31, %zmm29, %zmm0                         #132.22
        vpshufd   $177, %zmm6, %zmm7                            #134.22
        vpshufd   $177, %zmm13, %zmm14                          #133.22
        vpshufd   $177, %zmm0, %zmm2                            #132.22
        vaddps    %zmm7, %zmm6, %zmm1                           #134.22
        vaddps    %zmm14, %zmm13, %zmm30                        #133.22
        vaddps    %zmm2, %zmm0, %zmm3                           #132.22
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r11d xmm1 xmm3 xmm30 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28
..B2.26:                        # Preds ..B2.25 ..B2.8 ..B2.7
                                # Execution count [5.00e+00]
        movslq    %r11d, %r11                                   #180.9
        vaddss    (%rax,%rdx), %xmm3, %xmm0                     #176.9
        vaddss    4(%rax,%rdx), %xmm30, %xmm2                   #177.9
        vaddss    8(%rax,%rdx), %xmm1, %xmm1                    #178.9
        vmovss    %xmm0, (%rax,%rdx)                            #176.9
        lea       15(%r11), %r10d                               #181.9
        sarl      $3, %r10d                                     #181.9
        addq      %r11, %rcx                                    #180.9
        shrl      $28, %r10d                                    #181.9
        vmovss    %xmm2, 4(%rax,%rdx)                           #177.9
        vmovss    %xmm1, 8(%rax,%rdx)                           #178.9
        addq      $12, %rax                                     #126.5
        lea       15(%r10,%r11), %r12d                          #181.9
        movslq    %r9d, %r10                                    #126.32
        sarl      $4, %r12d                                     #181.9
        incq      %r9                                           #126.5
        movslq    %r12d, %r12                                   #181.9
        incq      %r10                                          #126.32
        addq      %r12, %rbx                                    #181.9
        cmpq      48(%rsp), %r9                                 #126.5[spill]
        jb        ..B2.7        # Prob 82%                      #126.5
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28
..B2.27:                        # Preds ..B2.26
                                # Execution count [9.00e-01]
        movq      (%rsp), %r14                                  #[spill]
        movq      %rcx, (%r14)                                  #180.9
        movq      %rbx, 8(%r14)                                 #181.9
        jmp       ..B2.30       # Prob 100%                     #181.9
                                # LOE
..B2.28:                        # Preds ..B2.1
                                # Execution count [5.00e-01]
        xorl      %eax, %eax                                    #119.16
..___tag_value_computeForceLJHalfNeigh.87:
#       getTimeStamp()
        call      getTimeStamp                                  #119.16
..___tag_value_computeForceLJHalfNeigh.88:
                                # LOE xmm0
..B2.45:                        # Preds ..B2.28
                                # Execution count [5.00e-01]
        vmovsd    %xmm0, 8(%rsp)                                #119.16[spill]
                                # LOE
..B2.29:                        # Preds ..B2.45
                                # Execution count [5.00e-01]
        movl      $.L_2__STRING.1, %edi                         #123.5
..___tag_value_computeForceLJHalfNeigh.90:
#       likwid_markerStartRegion(const char *)
        call      likwid_markerStartRegion                      #123.5
..___tag_value_computeForceLJHalfNeigh.91:
                                # LOE
..B2.30:                        # Preds ..B2.27 ..B2.29
                                # Execution count [1.00e+00]
        movl      $.L_2__STRING.1, %edi                         #184.5
        vzeroupper                                              #184.5
..___tag_value_computeForceLJHalfNeigh.92:
#       likwid_markerStopRegion(const char *)
        call      likwid_markerStopRegion                       #184.5
..___tag_value_computeForceLJHalfNeigh.93:
                                # LOE
..B2.31:                        # Preds ..B2.30
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #187.16
..___tag_value_computeForceLJHalfNeigh.94:
#       getTimeStamp()
        call      getTimeStamp                                  #187.16
..___tag_value_computeForceLJHalfNeigh.95:
                                # LOE xmm0
..B2.32:                        # Preds ..B2.31
                                # Execution count [1.00e+00]
        vsubsd    8(%rsp), %xmm0, %xmm0                         #188.14[spill]
        addq      $88, %rsp                                     #188.14
	.cfi_restore 3
        popq      %rbx                                          #188.14
	.cfi_restore 15
        popq      %r15                                          #188.14
	.cfi_restore 14
        popq      %r14                                          #188.14
	.cfi_restore 13
        popq      %r13                                          #188.14
	.cfi_restore 12
        popq      %r12                                          #188.14
        movq      %rbp, %rsp                                    #188.14
        popq      %rbp                                          #188.14
	.cfi_def_cfa 7, 8
	.cfi_restore 6
        ret                                                     #188.14
	.cfi_def_cfa 6, 16
	.cfi_escape 0x10, 0x03, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xd8, 0xff, 0xff, 0xff, 0x22
	.cfi_offset 6, -16
	.cfi_escape 0x10, 0x0c, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0d, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xf0, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0e, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe8, 0xff, 0xff, 0xff, 0x22
	.cfi_escape 0x10, 0x0f, 0x0e, 0x38, 0x1c, 0x0d, 0xc0, 0xff, 0xff, 0xff, 0x1a, 0x0d, 0xe0, 0xff, 0xff, 0xff, 0x22
                                # LOE
..B2.33:                        # Preds ..B2.10
                                # Execution count [2.25e-01]: Infreq
        movl      %r11d, %r14d                                  #144.9
        xorl      %r12d, %r12d                                  #144.9
        andl      $-16, %r14d                                   #144.9
        jmp       ..B2.19       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r12d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.34:                        # Preds ..B2.9
                                # Execution count [2.25e-01]: Infreq
        xorl      %r14d, %r14d                                  #144.9
        jmp       ..B2.23       # Prob 100%                     #144.9
                                # LOE rax rdx rcx rbx rsi rdi r8 r9 r10 r11d r14d xmm15 xmm16 xmm17 zmm18 zmm19 zmm20 zmm21 zmm22 zmm23 zmm24 zmm25 zmm26 zmm27 zmm28 zmm29 zmm30
..B2.35:                        # Preds ..B2.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $16, %esi                                     #113.5
        jl        ..B2.41       # Prob 10%                      #113.5
                                # LOE rdi r12 r13 r14 ebx esi
..B2.36:                        # Preds ..B2.35
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #113.5
        xorl      %ecx, %ecx                                    #113.5
        andl      $-16, %eax                                    #113.5
        movslq    %eax, %rdx                                    #113.5
        vpxord    %zmm0, %zmm0, %zmm0                           #113.5
                                # LOE rdx rcx rdi r12 r13 r14 eax ebx esi zmm0
..B2.37:                        # Preds ..B2.37 ..B2.36
                                # Execution count [5.56e+00]: Infreq
        vmovups   %zmm0, (%rdi,%rcx,4)                          #114.9
        addq      $16, %rcx                                     #113.5
        cmpq      %rdx, %rcx                                    #113.5
        jb        ..B2.37       # Prob 82%                      #113.5
                                # LOE rdx rcx rdi r12 r13 r14 eax ebx esi zmm0
..B2.39:                        # Preds ..B2.37 ..B2.41
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #113.5
        cmpl      %esi, %edx                                    #113.5
        ja        ..B2.47       # Prob 50%                      #113.5
                                # LOE rdi r12 r13 r14 eax ebx esi
..B2.40:                        # Preds ..B2.39
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #113.5
        vpbroadcastd %esi, %zmm0                                #113.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %zmm0, %k1        #113.5
        movslq    %eax, %rax                                    #113.5
        movslq    %ebx, %r15                                    #113.5
        vpxord    %zmm1, %zmm1, %zmm1                           #114.9
        vmovups   %zmm1, (%rdi,%rax,4){%k1}                     #114.9
        jmp       ..B2.4        # Prob 100%                     #114.9
                                # LOE r12 r13 r14 r15 ebx
..B2.41:                        # Preds ..B2.35
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #113.5
        jmp       ..B2.39       # Prob 100%                     #113.5
                                # LOE rdi r12 r13 r14 eax ebx esi
..B2.47:                        # Preds ..B2.39
                                # Execution count [5.56e-01]: Infreq
        movslq    %ebx, %r15                                    #113.5
        jmp       ..B2.4        # Prob 100%                     #113.5
        .align    16,0x90
                                # LOE r12 r13 r14 r15 ebx
	.cfi_endproc
# mark_end;
	.type	computeForceLJHalfNeigh,@function
	.size	computeForceLJHalfNeigh,.-computeForceLJHalfNeigh
..LNcomputeForceLJHalfNeigh.1:
	.data
# -- End  computeForceLJHalfNeigh
	.text
.L_2__routine_start_computeForceLJFullNeigh_simd_2:
# -- Begin  computeForceLJFullNeigh_simd
	.text
# mark_begin;
       .align    16,0x90
	.globl computeForceLJFullNeigh_simd
# --- computeForceLJFullNeigh_simd(Parameter *, Atom *, Neighbor *, Stats *)
computeForceLJFullNeigh_simd:
# parameter 1: %rdi
# parameter 2: %rsi
# parameter 3: %rdx
# parameter 4: %rcx
..B3.1:                         # Preds ..B3.0
                                # Execution count [1.00e+00]
	.cfi_startproc
..___tag_value_computeForceLJFullNeigh_simd.112:
..L113:
                                                        #191.101
        pushq     %rbp                                          #191.101
	.cfi_def_cfa_offset 16
        movq      %rsp, %rbp                                    #191.101
	.cfi_def_cfa 6, 16
	.cfi_offset 6, -16
        andq      $-64, %rsp                                    #191.101
        movl      4(%rsi), %eax                                 #192.18
        testl     %eax, %eax                                    #198.24
        jle       ..B3.4        # Prob 50%                      #198.24
                                # LOE rbx rsi r12 r13 r14 r15 eax
..B3.2:                         # Preds ..B3.1
                                # Execution count [5.00e-03]
        movq      64(%rsi), %rdi                                #199.9
        lea       (%rax,%rax,2), %esi                           #192.18
        cmpl      $24, %esi                                     #198.5
        jle       ..B3.7        # Prob 0%                       #198.5
                                # LOE rbx rdi r12 r13 r14 r15 eax esi
..B3.3:                         # Preds ..B3.2
                                # Execution count [1.00e+00]
        movslq    %eax, %rax                                    #198.5
        xorl      %esi, %esi                                    #198.5
        lea       (%rax,%rax,2), %rdx                           #198.5
        shlq      $2, %rdx                                      #198.5
        call      __intel_skx_avx512_memset                     #198.5
                                # LOE rbx r12 r13 r14 r15
..B3.4:                         # Preds ..B3.11 ..B3.1 ..B3.3 ..B3.12
                                # Execution count [1.00e+00]
        xorl      %eax, %eax                                    #204.16
        vzeroupper                                              #204.16
..___tag_value_computeForceLJFullNeigh_simd.117:
#       getTimeStamp()
        call      getTimeStamp                                  #204.16
..___tag_value_computeForceLJFullNeigh_simd.118:
                                # LOE
..B3.5:                         # Preds ..B3.4
                                # Execution count [1.00e+00]
        movl      $il0_peep_printf_format_0, %edi               #207.5
        movq      stderr(%rip), %rsi                            #207.5
        call      fputs                                         #207.5
                                # LOE
..B3.6:                         # Preds ..B3.5
                                # Execution count [1.00e+00]
        movl      $-1, %edi                                     #208.5
#       exit(int)
        call      exit                                          #208.5
                                # LOE
..B3.7:                         # Preds ..B3.2
                                # Execution count [1.00e+00]: Infreq
        cmpl      $16, %esi                                     #198.5
        jl        ..B3.13       # Prob 10%                      #198.5
                                # LOE rbx rdi r12 r13 r14 r15 esi
..B3.8:                         # Preds ..B3.7
                                # Execution count [1.00e+00]: Infreq
        movl      %esi, %eax                                    #198.5
        xorl      %ecx, %ecx                                    #198.5
        andl      $-16, %eax                                    #198.5
        movslq    %eax, %rdx                                    #198.5
        vpxord    %zmm0, %zmm0, %zmm0                           #199.22
                                # LOE rdx rcx rbx rdi r12 r13 r14 r15 eax esi zmm0
..B3.9:                         # Preds ..B3.9 ..B3.8
                                # Execution count [5.56e+00]: Infreq
        vmovups   %zmm0, (%rdi,%rcx,4)                          #199.9
        addq      $16, %rcx                                     #198.5
        cmpq      %rdx, %rcx                                    #198.5
        jb        ..B3.9        # Prob 82%                      #198.5
                                # LOE rdx rcx rbx rdi r12 r13 r14 r15 eax esi zmm0
..B3.11:                        # Preds ..B3.9 ..B3.13
                                # Execution count [1.11e+00]: Infreq
        lea       1(%rax), %edx                                 #198.5
        cmpl      %esi, %edx                                    #198.5
        ja        ..B3.4        # Prob 50%                      #198.5
                                # LOE rbx rdi r12 r13 r14 r15 eax esi
..B3.12:                        # Preds ..B3.11
                                # Execution count [5.56e+00]: Infreq
        subl      %eax, %esi                                    #198.5
        vpbroadcastd %esi, %zmm0                                #198.5
        vpcmpgtd  .L_2il0floatpacket.0(%rip), %zmm0, %k1        #198.5
        movslq    %eax, %rax                                    #198.5
        vpxord    %zmm1, %zmm1, %zmm1                           #199.22
        vmovups   %zmm1, (%rdi,%rax,4){%k1}                     #199.9
        jmp       ..B3.4        # Prob 100%                     #199.9
                                # LOE rbx r12 r13 r14 r15
..B3.13:                        # Preds ..B3.7
                                # Execution count [1.00e-01]: Infreq
        xorl      %eax, %eax                                    #198.5
        jmp       ..B3.11       # Prob 100%                     #198.5
        .align    16,0x90
                                # LOE rbx rdi r12 r13 r14 r15 eax esi
	.cfi_endproc
# mark_end;
	.type	computeForceLJFullNeigh_simd,@function
	.size	computeForceLJFullNeigh_simd,.-computeForceLJFullNeigh_simd
..LNcomputeForceLJFullNeigh_simd.2:
	.section .rodata.str1.32, "aMS",@progbits,1
	.align 32
	.align 32
il0_peep_printf_format_0:
	.long	1869771333
	.long	1394621042
	.long	541347145
	.long	1852990827
	.long	1847618661
	.long	1763734639
	.long	1701605485
	.long	1953391981
	.long	1713398885
	.long	1931506287
	.long	1768121712
	.long	1684367718
	.long	1936615712
	.long	1668641396
	.long	1852795252
	.long	1952805664
	.word	33
	.data
# -- End  computeForceLJFullNeigh_simd
	.section .rodata, "a"
	.align 64
	.align 64
.L_2il0floatpacket.0:
	.long	0x00000000,0x00000001,0x00000002,0x00000003,0x00000004,0x00000005,0x00000006,0x00000007,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.0,@object
	.size	.L_2il0floatpacket.0,64
	.align 64
.L_2il0floatpacket.1:
	.long	0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010,0x00000010
	.type	.L_2il0floatpacket.1,@object
	.size	.L_2il0floatpacket.1,64
	.align 64
.L_2il0floatpacket.2:
	.long	0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000,0x3f800000
	.type	.L_2il0floatpacket.2,@object
	.size	.L_2il0floatpacket.2,64
	.align 64
.L_2il0floatpacket.4:
	.long	0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000,0x3f000000
	.type	.L_2il0floatpacket.4,@object
	.size	.L_2il0floatpacket.4,64
	.align 64
.L_2il0floatpacket.6:
	.long	0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f,0x00000008,0x00000009,0x0000000a,0x0000000b,0x0000000c,0x0000000d,0x0000000e,0x0000000f
	.type	.L_2il0floatpacket.6,@object
	.size	.L_2il0floatpacket.6,64
	.align 64
.L_2il0floatpacket.7:
	.long	0x00000004,0x00000005,0x00000006,0x00000007,0x00000004,0x00000005,0x00000006,0x00000007,0x00000004,0x00000005,0x00000006,0x00000007,0x00000004,0x00000005,0x00000006,0x00000007
	.type	.L_2il0floatpacket.7,@object
	.size	.L_2il0floatpacket.7,64
	.align 64
.L_2il0floatpacket.8:
	.long	0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001,0x00000001
	.type	.L_2il0floatpacket.8,@object
	.size	.L_2il0floatpacket.8,64
	.align 64
.L_2il0floatpacket.9:
	.long	0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002,0x00000002
	.type	.L_2il0floatpacket.9,@object
	.size	.L_2il0floatpacket.9,64
	.align 64
.L_2il0floatpacket.11:
	.long	0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000,0x00000000,0x3fe00000
	.type	.L_2il0floatpacket.11,@object
	.size	.L_2il0floatpacket.11,64
	.align 8
.L_2il0floatpacket.10:
	.long	0x00000000,0x40480000
	.type	.L_2il0floatpacket.10,@object
	.size	.L_2il0floatpacket.10,8
	.align 4
.L_2il0floatpacket.3:
	.long	0x42400000
	.type	.L_2il0floatpacket.3,@object
	.size	.L_2il0floatpacket.3,4
	.align 4
.L_2il0floatpacket.5:
	.long	0x3f800000
	.type	.L_2il0floatpacket.5,@object
	.size	.L_2il0floatpacket.5,4
	.section .rodata.str1.4, "aMS",@progbits,1
	.align 4
	.align 4
.L_2__STRING.0:
	.long	1668444006
	.word	101
	.type	.L_2__STRING.0,@object
	.size	.L_2__STRING.0,6
	.space 2, 0x00 	# pad
	.align 4
.L_2__STRING.1:
	.long	1668444006
	.long	759843941
	.long	1718378856
	.long	1734960494
	.word	104
	.type	.L_2__STRING.1,@object
	.size	.L_2__STRING.1,18
	.data
	.section .note.GNU-stack, ""
# End
